import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:beanmind_flutter/controllers/auth_controller.dart';
import 'package:beanmind_flutter/firebase/references.dart';
import 'package:beanmind_flutter/models/models.dart' show ItemModel;
import 'package:beanmind_flutter/screens/screens.dart' show QuizeScreen;
import 'package:beanmind_flutter/services/firebase/firebasestorage_service.dart';
import 'package:beanmind_flutter/utils/logger.dart';

import '../../game/class/drag_and_drop/shopping.dart';

class GameShoppingController extends GetxController {
  @override
  void onReady() {
    getallItem();
    super.onReady();
  }

  final allItem = <ItemModel>[];
  final allItemImages = <String>[];

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

  // Method to filter or manipulate items
  List<ItemModel> getProductsForLowerPanel() {
    // Example filter: return first 10 items
    return allItem.take(20).toList();
  }

  void navigatoQuestions({required Product item, bool isTryAgain = false}) {
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

