import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Movie{
  final String title;
  final String keyword;
  final String poster;
  final bool like;
  final DocumentReference reference; //실제 firebase firestore에 있는 데이터 컬럼을 참조할 수 있는 링크라고 생각!!!!



  Movie.fromMap(Map<String, dynamic> map, {this.reference})    //reference를 통한 해당 데이터에 CRUD를 아주 간단히 처리가능함!!
  : title = map['title'],
    keyword = map['keyword'],
    poster = map['poster'],
    like = map['like'];

  Movie.fromSnapshot(DocumentSnapshot snapshot)         //cloud_firestore 관련
    : this.fromMap(snapshot.data(),reference: snapshot.reference);

  @override
  String toString() =>"Movie<$title:$keyword>";

}