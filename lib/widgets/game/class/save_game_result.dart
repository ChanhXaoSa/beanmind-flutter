import 'dart:convert';

import 'package:beanmind_flutter/controllers/auth_controller.dart';
import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:beanmind_flutter/firebase/references.dart';
import 'package:beanmind_flutter/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<void> saveGameResults(String gameId, int points, int timeRecord) async {
  String user = Get.find<AuthController>().user.value!.first.data.id;

  // Calculate duration from timeRecord
  final durationInSeconds = timeRecord;
  final hours = durationInSeconds ~/ 3600;
  final minutes = (durationInSeconds % 3600) ~/ 60;

  final apiUrl =
      "https://smart-platypus-hardly.ngrok-free.app/api/v1/game-histories";
  final body = jsonEncode({
    "gameId": gameId,
    "applicationUserId": user,
    "point": points,
    "duration": {
      "hour": hours,
      "minute": minutes,
    },
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
