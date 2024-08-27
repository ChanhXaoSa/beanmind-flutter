import 'dart:convert';

import 'package:beanmind_flutter/models/login_model.dart';
import 'package:beanmind_flutter/models/user_model.dart';
import 'package:beanmind_flutter/utils/api_endpoint.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:beanmind_flutter/firebase/references.dart';
import 'package:beanmind_flutter/screens/screens.dart'
    show AppIntroductionScreen, HomeScreen, LoginScreen;
import 'package:beanmind_flutter/utils/utils.dart';
import 'package:beanmind_flutter/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  var user = <UserModel>[].obs;
  var loginModel = Rxn<LoginModel>();

  @override
  void onReady() {
    // initAuth();
    super.onReady();
  }

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // late FirebaseAuth _auth;
  // final _user = Rxn<User>();
  // late Stream<User?> _authStateChanges;

  Future<void> login(String email, String password) async {
    try {
      final loginResponse = await http.post(
        Uri.parse('$newBaseApiUrl/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'ngrok-skip-browser-warning': 'true',
        },
        body: jsonEncode(<String, String>{
          'username': email,
          'email' : '',
          'password': password,
        }),
      );
      if (loginResponse.statusCode == 200) {
        final loginModel = LoginModel.fromJson(json.decode(loginResponse.body));

        if (loginModel.success) {
          String accessToken = loginModel.data!.accessToken;

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('accessToken', accessToken);

          final userResponse = await http.get(
            Uri.parse('$newBaseApiUrl/auth/info'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=utf-8',
              'ngrok-skip-browser-warning': 'true',
              'Authorization': 'Bearer $accessToken',
            },
          );

          if (userResponse.statusCode == 200) {
            final userModel =
                UserModel.fromJson(json.decode(userResponse.body));
            if (userModel.success == true) {
              if([userModel].first.data!.studentId == '00000000-0000-0000-0000-000000000000') {
                showSnackBar('Error', 'Tài khoản của bạn không được phép truy cập vào hệ thống này');
              } else {
                user.value = [userModel];
                await _saveUserSession(userModel);
                navigateToHome();
                showSuccessSnackBar('Thông báo', 'Đăng nhập thành công');
              }
            } else {
              // throw Exception(userModel.message);
              showSnackBar('Lỗi', userModel.message!);
            }
          } else {
            // throw Exception('Failed to load user info');
            showSnackBar('Lỗi', 'Tải thông tin người dùng thất bại');
          }
        } else {
          // throw Exception('Login failed: ${loginModel.message}');
          showSnackBar('Lỗi', 'Sai tên đăng nhập hoặc mật khẩu, vui lòng thử lại');
        }
      } else {
        // throw Exception('Failed to login');
        showSnackBar('Lỗi', 'Đăng nhập thất bại');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      showSnackBar('Lỗi', 'Lỗi hệ thống: Truy cập máy chủ thất bại, vui lòng thử lại');
      // throw e;
    }
  }

  void showSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFFFC6B6B),
      colorText: Colors.white,
    );
  }

  void showSuccessSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF89E573),
      colorText: Colors.white,
    );
  }

  Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  Future<void> _saveUserSession(UserModel userModel) async {
    final prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(userModel.toJson());
    await prefs.setString('user_model', userJson);
  }

  Future<UserModel?> _getUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user_model');
    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      return UserModel.fromJson(userMap);
    }
    return null;
  }

  Future<void> initAuth() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // bool? hasSeenIntroduction = prefs.getBool('hasSeenIntroduction');

    await Future.delayed(const Duration(seconds: 2)); // waiting in splash
    // _auth = FirebaseAuth.instance;
    // _authStateChanges = _auth.authStateChanges();
    // _authStateChanges.listen((User? user) {
    //   _user.value = user;
    //   // if(user == null) {
    //   //   navigateToLogin();
    //   // } else {
    //   //   navigateToHome();
    //   // }
    // });
    UserModel? sessionUser = await _getUserSession();
    if (sessionUser != null) {
      user.value = [sessionUser];
      if (Get.currentRoute == '/') {
        navigateToHome();
      }
    } else {
      if (Get.currentRoute != LoginScreen.routeName) {
        navigateToLogin();
      }
    }
    // if (sessionUser != null) {
    //   user.value = [sessionUser];
    //   navigateToHome();
    // } else {
    //   navigateToLogin();
    // }
    // navigateToIntroduction();
    // if (hasSeenIntroduction == null || !hasSeenIntroduction) {
    //   navigateToIntroduction();
    //   prefs.setBool('hasSeenIntroduction', true);
    // }
  }

  // Future<void> siginInWithGoogle() async {
  //   final GoogleSignIn _googleSignIn = GoogleSignIn(
  //     clientId:
  //         '505548876025-5ts10r3vh4ou7e3rv8589bei4uq6d8vo.apps.googleusercontent.com',
  //   );
  //
  //   try {
  //     GoogleSignInAccount? account = await _googleSignIn.signIn();
  //     if (account != null) {
  //       final _gAuthentication = await account.authentication;
  //       final _credential = GoogleAuthProvider.credential(
  //           idToken: _gAuthentication.idToken,
  //           accessToken: _gAuthentication.accessToken);
  //       await _auth.signInWithCredential(_credential);
  //       await saveUser(account);
  //       navigateToHome();
  //     }
  //   } on Exception catch (error) {
  //     AppLogger.e(error);
  //   }
  // }

  Future<void> signOut() async {
    AppLogger.d("Sign out");
    try {
      // await _auth.signOut();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_model');
      user.value = [];
      navigateToLogin();
    } on FirebaseAuthException catch (e) {
      AppLogger.e(e);
    }
  }

  Future<void> saveUser(GoogleSignInAccount account) async {
    userFR.doc(account.email).set({
      "email": account.email,
      "name": account.displayName,
      "profilepic": account.photoUrl
    });
  }

  User? getUser() {
    return null;

    // _user.value = _auth.currentUser;
    // return _user.value;
  }

  Future<UserModel?> getUserLocal() async {
    // _user.value = _auth.currentUser;
    // return _user.value;
    UserModel? sessionUser = await _getUserSession();
    if (sessionUser != null) {
      user.value = [sessionUser];
      return sessionUser;
    }
    return null;
  }

  String getEnrollmentId(String courseId) {
    if (user.value.first.data?.enrollments == null) return '';
    for (var enrollment in user.value.first.data!.enrollments!) {
      if (enrollment.courseId == courseId) {
        return enrollment.id!;
      }
    }
    return '';
  }
  bool isLogedIn() {
    // return _auth.currentUser != null;
    return false;
  }

  void navigateToHome() {
    Get.offAllNamed(HomeScreen.routeName);
  }

  void navigateToLogin() {
    Get.toNamed(LoginScreen.routeName);
  }

  void navigateToIntroduction() {
    Get.offAllNamed(AppIntroductionScreen.routeName);
  }

  void showLoginAlertDialog() {
    Get.dialog(
      Dialogs.quizStartDialog(onTap: () {
        Get.back();
        navigateToLogin();
      }),
      barrierDismissible: false,
    );
  }
}
