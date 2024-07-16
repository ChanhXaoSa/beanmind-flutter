import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

final fi = FirebaseFirestore.instance;

//FR - firestore reference

final userFR = fi.collection('users');
final quizePaperFR = fi.collection('quizpapers');
final leaderBoardFR = fi.collection('leaderboard');
final gameItemFR = fi.collection('itemstore');
final gameFR = fi.collection('games');

DocumentReference recentQuizesData(
        {required String userId, required String paperId}) =>
    userFR.doc(userId).collection('myrecent_quizes').doc(paperId);

DocumentReference recentGamesData(
        {required String userId, required String paperId}) =>
    userFR.doc(userId).collection('myrecent_games').doc(paperId);

CollectionReference<Map<String, dynamic>> recentQuizes(
        {required String userId}) =>
    userFR.doc(userId).collection('myrecent_quizes');

CollectionReference<Map<String, dynamic>> recentGames(
        {required String userId}) =>
    userFR.doc(userId).collection('myrecent_games');

CollectionReference<Map<String, dynamic>> getleaderBoard(
        {required String paperId}) =>
    leaderBoardFR.doc(paperId).collection('scores');

CollectionReference<Map<String, dynamic>> getleaderBoardGame(
        {required String gameId}) =>
    gameFR.doc(gameId).collection('game_scores');

DocumentReference questionsFR(
        {required String paperId, required String questionsId}) =>
    quizePaperFR.doc(paperId).collection('questions').doc(questionsId);

// game item store
CollectionReference<Map<String, dynamic>> getallItems() => gameItemFR;
DocumentReference gameItemFRDoc({required String itemId}) =>
    gameItemFR.doc(itemId);

// game store
CollectionReference<Map<String, dynamic>> getallGames() => gameFR;
DocumentReference gameFRDoc({required String gameId}) => gameFR.doc(gameId);  

//Reference get firebaseStorage => FirebaseStorage.instanceFor(bucket: 'gs://fire-base-chat-cc3e9.appspot.com').ref();
Reference get firebaseStorage => FirebaseStorage.instance.ref();
