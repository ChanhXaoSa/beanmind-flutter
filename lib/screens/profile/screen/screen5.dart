import 'package:flutter/material.dart';

class Screen5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: GameHistoryList(gameHistoryItems: gameHistoryItems),
    );
  }

  final gameHistoryItems = [
    GameHistoryItem(
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/beanmind-2911.appspot.com/o/thumbnail_game_images%2Fmath_game_level_1.png?alt=media&token=5ec9aabf-a503-426c-b7db-73b5f6641ed0',
      gameName: 'Trò chơi 1',
      score: 100,
      playTime: '10:30',
    ),
    GameHistoryItem(
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/beanmind-2911.appspot.com/o/thumbnail_game_images%2Fnumber_sort.png?alt=media&token=6124bb15-ff34-47fc-a0ad-143463324dd1',
      gameName: 'Trò chơi 2',
      score: 200,
      playTime: '20:15',
    ),
    GameHistoryItem(
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/beanmind-2911.appspot.com/o/thumbnail_game_images%2Fnumber_sort.png?alt=media&token=6124bb15-ff34-47fc-a0ad-143463324dd1',
      gameName: 'Trò chơi 3',
      score: 200,
      playTime: '20:15',
    ),
    GameHistoryItem(
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/beanmind-2911.appspot.com/o/thumbnail_game_images%2Fnumber_sort.png?alt=media&token=6124bb15-ff34-47fc-a0ad-143463324dd1',
      gameName: 'Trò chơi 4',
      score: 200,
      playTime: '20:15',
    ),
    GameHistoryItem(
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/beanmind-2911.appspot.com/o/thumbnail_game_images%2Fnumber_sort.png?alt=media&token=6124bb15-ff34-47fc-a0ad-143463324dd1',
      gameName: 'Trò chơi 5',
      score: 200,
      playTime: '20:15',
    ),
    GameHistoryItem(
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/beanmind-2911.appspot.com/o/thumbnail_game_images%2Fnumber_sort.png?alt=media&token=6124bb15-ff34-47fc-a0ad-143463324dd1',
      gameName: 'Trò chơi 6',
      score: 200,
      playTime: '20:15',
    ),
    GameHistoryItem(
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/beanmind-2911.appspot.com/o/thumbnail_game_images%2Fnumber_sort.png?alt=media&token=6124bb15-ff34-47fc-a0ad-143463324dd1',
      gameName: 'Trò chơi 7',
      score: 200,
      playTime: '20:15',
    ),
    GameHistoryItem(
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/beanmind-2911.appspot.com/o/thumbnail_game_images%2Fnumber_sort.png?alt=media&token=6124bb15-ff34-47fc-a0ad-143463324dd1',
      gameName: 'Trò chơi 8',
      score: 200,
      playTime: '20:15',
    ),
    GameHistoryItem(
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/beanmind-2911.appspot.com/o/thumbnail_game_images%2Fnumber_sort.png?alt=media&token=6124bb15-ff34-47fc-a0ad-143463324dd1',
      gameName: 'Trò chơi 9',
      score: 200,
      playTime: '20:15',
    ),
    // Add more items here
  ];
}

class GameHistoryList extends StatelessWidget {
  final List<GameHistoryItem> gameHistoryItems;

  GameHistoryList({required this.gameHistoryItems});

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
                //search bar
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Tìm nội dung bạn đã học",
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
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: gameHistoryItems.length,
                itemBuilder: (context, index) {
                  return GameHistoryCard(gameHistoryItem: gameHistoryItems[index]);
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
                  Text('Điểm: ${gameHistoryItem.score}',
                      style: TextStyle(fontSize: 20)),
                  Text('Thời gian: ${gameHistoryItem.playTime}',
                      style: TextStyle(fontSize: 20)),
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
  final String playTime;

  GameHistoryItem({
    required this.imageUrl,
    required this.gameName,
    required this.score,
    required this.playTime,
  });
}
