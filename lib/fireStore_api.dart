import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:math';
import 'dart:core';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FireStoreAPI {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addUser(
      var displayName, var photoUrl, var userID, var token, var uid) {
    CollectionReference users = firestore.collection('users');
    users
        .doc(uid)
        .set({
          'displayName': displayName,
          'photoUrl': photoUrl,
          'userID': userID,
          'token': token,
          'uid': uid
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> addQuestion(
    var question,
    var postedBy,
  ) {
    var rand = Random(DateTime.now().millisecondsSinceEpoch.abs());
    int qID = rand.nextInt(999999999);
    CollectionReference users = firestore.collection('questions');
    users
        .doc(qID.toString())
        .set({
          'question': question,
          'postedBy': postedBy,
          'time': DateTime.now(),
          'qID': qID,
          'answer': null,
          'useful': [postedBy],
        })
        .then((value) => print("Question added"))
        .catchError((error) => print("Failed to add question: $error"));
  }

  Future getQuestionInfo(String qid) async {
    QuerySnapshot questions = await firestore
        .collection('questions')
        .where('qID', isEqualTo: qid)
        .getDocuments();
    var temp = questions.documents[0];
    print(temp);
    return temp;
  }


  Future articles(String qid) async {
    QuerySnapshot questions = await firestore
        .collection('questions')
        .where('qID', isEqualTo: qid)
        .getDocuments();
    var temp = questions.documents[0];
    print(temp);
    return temp;
  }




  Future<Map> getUserInfo(String uid) async {
    DocumentReference users = firestore.collection('users').doc(uid);
    DocumentSnapshot userInfo = await users.get();

    return userInfo.data();
  }
}
//flutter packages pub run build_runner watch — delete-conflicting-outputs

class CustomResponse {
  String qid;
  String questionText;
  String answerPreview;
  String postedBy;
  int useful;
  String photoUrl;
  int interested;

  CustomResponse(this.qid, this.questionText, this.interested, this.photoUrl,
      this.answerPreview, this.postedBy, this.useful);

  Map<String, dynamic> ToMap() {
    return {
      'qid': this.qid,
      'questionText': this.questionText,
      'interested': this.interested,
      'photoUrl': this.photoUrl,
      'answerPreview': this.answerPreview,
      'displayName': this.postedBy,
      'useful': this.useful
    };
  }
}

Future<CustomResponse> customFuture(String qid) async {
  var questionInfo = await FireStoreAPI().getQuestionInfo(qid);
  print('questionInfo');
  print(questionInfo);
  var userInfo = await FireStoreAPI().getUserInfo(questionInfo['uid']);
  print('userInfo');
  print(userInfo);
  return CustomResponse(
      questionInfo['qid'],
      questionInfo['questionText'],
      questionInfo['interested'],
      userInfo['photoUrl'],
      questionInfo['answerPreview'],
      userInfo['displayName'],
      questionInfo['useful']);
}
