import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:beanmind_flutter/controllers/auth_controller.dart';
import 'package:beanmind_flutter/firebase/references.dart';
import 'package:beanmind_flutter/models/models.dart' show ItemModel;
import 'package:beanmind_flutter/screens/screens.dart' show QuizeScreen;
import 'package:beanmind_flutter/services/firebase/firebasestorage_service.dart';
import 'package:beanmind_flutter/utils/logger.dart';

class GameShoppingController extends GetxController {
  @override
  void onReady() {
    getallItem();
    super.onReady();
  }

  final allItem = <ItemModel>[].obs;
  final allItemImages = <String>[].obs;

  Future<void> getallItem() async {
    try {
      QuerySnapshot<Map<String, dynamic>> data = await gameItemFR.get();
      final itemList =
          data.docs.map((item) => ItemModel.fromSnapshot(item)).toList();
      allItem.assignAll(itemList);

      for (var item in itemList) {
        final imageUrl =
            await Get.find<FireBaseStorageService>().getImage(item.imageUrl);
        item.imageUrl = imageUrl;
      }
      allItem.assignAll(itemList);
    } catch (e) {
      AppLogger.e(e);
    }
  }

  void navigatoQuestions({required ItemModel item, bool isTryAgain = false}) {
    AuthController _authController = Get.find();

    if (_authController.isLogedIn()) {
      if (isTryAgain) {
        Get.back();
        Get.offNamed(QuizeScreen.routeName,
            arguments: item, preventDuplicates: false);
      } else {
        Get.toNamed(QuizeScreen.routeName, arguments: item);
      }
    } else {
      _authController.showLoginAlertDialog();
    }
  }
}
