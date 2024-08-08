import 'dart:convert';

import 'package:beanmind_flutter/controllers/auth_controller.dart';
import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:beanmind_flutter/firebase/references.dart';
import 'package:beanmind_flutter/models/user_model.dart';
import 'package:beanmind_flutter/utils/api_endpoint.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<void> saveGameResults(String gameId, int points, int timeRecord) async {
  String user = Get.find<AuthController>().user.value!.first.data!.id!;

  final apiUrl = "${newBaseApiUrl}/game-histories";
  final body = jsonEncode({
    "gameId": gameId,
    "applicationUserId": user,
    "point": points,
    "duration": timeRecord,
  });

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'ngrok-skip-browser-warning': 'true',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      // Handle successful response
      print("Game results saved successfully.");
    } else {
      // Handle error response
      throw Exception(
          'Failed to save game results. Status code: ${response.statusCode}');
    }
  } catch (e) {
    // Handle exception
    print("Error saving game results: $e");
  }
}
