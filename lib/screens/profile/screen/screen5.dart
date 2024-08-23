import 'dart:convert';

import 'package:beanmind_flutter/controllers/auth_controller.dart';
import 'package:beanmind_flutter/models/game_history_model.dart';
import 'package:beanmind_flutter/utils/api_endpoint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Screen5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: GameHistoryListScreen(),
    );
  }
}

enum LoadingStatus { loading, completed, error }

class GameHistoryListScreen extends StatefulWidget {
  @override
  _GameHistoryListScreenState createState() => _GameHistoryListScreenState();
}

class _GameHistoryListScreenState extends State<GameHistoryListScreen> {
  List<GameHistoryItem> gameHistoryItems = [];
  List<GameHistoryItem> filteredGameHistoryItems = [];
  LoadingStatus loadingStatus = LoadingStatus.loading;
  String user = Get.find<AuthController>().user.value!.first.data!.id!;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchGameHistory();
    searchController.addListener(_filterGameHistory);
  }

  Future<void> fetchGameHistory() async {
    setState(() {
      loadingStatus = LoadingStatus.loading;
    });
    try {
      final response = await http.get(
        Uri.parse('$newBaseApiUrl/game-histories?ApplicationUserId=$user'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          'ngrok-skip-browser-warning': 'true',
        },
      );

      if (response.statusCode == 200) {
        final body = response.body;
        final decoded = jsonDecode(body);

        if (decoded is Map<String, dynamic> &&
            decoded['data'] is Map<String, dynamic>) {
          final gameHistoryResponse =
              GameHistoryResponse.fromJson(decoded['data']);
          setState(() {
            gameHistoryItems = gameHistoryResponse.items
                .map((gameHistory) =>
                    GameHistoryItem.fromGameHistory(gameHistory))
                .toList();
            filteredGameHistoryItems = gameHistoryItems;
            loadingStatus = LoadingStatus.completed;
          });
        } else {
          throw Exception('Unexpected JSON format');
        }
      } else {
        setState(() {
          loadingStatus = LoadingStatus.error;
        });
        throw Exception('Failed to load game history');
      }
    } catch (e) {
      setState(() {
        loadingStatus = LoadingStatus.error;
      });
      print(e);
    }
  }

  void _filterGameHistory() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredGameHistoryItems = gameHistoryItems.where((item) {
        return item.gameName.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "TRÒ CHƠI ĐÃ CHƠI",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Search bar
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "Tìm kiếm",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: loadingStatus == LoadingStatus.loading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: filteredGameHistoryItems.length,
                      itemBuilder: (context, index) {
                        return GameHistoryCard(
                            gameHistoryItem: filteredGameHistoryItems[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class GameHistoryCard extends StatelessWidget {
  final GameHistoryItem gameHistoryItem;

  GameHistoryCard({required this.gameHistoryItem});

  @override
  Widget build(BuildContext context) {
    // Chuyển chuỗi playDate thành đối tượng DateTime
    DateTime parsedDate = DateTime.parse(gameHistoryItem.playDate);

    // Format lại ngày theo định dạng mong muốn
    String formattedDate = DateFormat('dd/MM/yyyy, HH:mm').format(parsedDate);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              gameHistoryItem.imageUrl,
              width: 200,
              height: 120,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    gameHistoryItem.gameName,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text('Điểm: ${gameHistoryItem.score}',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(width: 20),
                      Text('Thời gian: ${gameHistoryItem.playTime} giây',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Text(
                    'Ngày chơi: $formattedDate', // Sử dụng ngày đã được format
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GameHistoryItem {
  final String imageUrl;
  final String gameName;
  final int score;
  final int playTime;
  final String playDate;

  GameHistoryItem({
    required this.imageUrl,
    required this.gameName,
    required this.score,
    required this.playTime,
    required this.playDate,
  });

  factory GameHistoryItem.fromGameHistory(GameHistory gameHistory) {
    return GameHistoryItem(
      imageUrl: gameHistory.game.imageUrl,
      gameName: gameHistory.game.title,
      score: gameHistory.point,
      playTime: gameHistory.duration,
      playDate: gameHistory.playDate,
    );
  }
}
