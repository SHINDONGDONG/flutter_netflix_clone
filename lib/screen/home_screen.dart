import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_netflix_clone/model/model_movie.dart';
import 'package:flutter_netflix_clone/widget/box_slider.dart';
import 'package:flutter_netflix_clone/widget/carousel_slider.dart';
import 'package:flutter_netflix_clone/widget/cicle_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ignore: deprecated_member_use
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot> streamData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Firebase.initializeApp().whenComplete(() {
    //   print("completed");
    //   setState(() {});
    // });


    streamData = firestore.collection('movie').snapshots();  //moive의 의미는 firestroe콘솔에서 작성한 테이블명   //
  }
  Widget _fetchData(BuildContext context){                 //스트림 데이터로 부터 데이터를 추출하여 위젯으로 만드는 과정임!!
    Firebase.initializeApp();
    return StreamBuilder<QuerySnapshot>(stream:streamData,
    builder:(context,snapshot){
      if(!snapshot.hasData) return LinearProgressIndicator();
      return _buildBody(context, snapshot.data.documents);
    }
    );
  }

  Widget _buildBody (BuildContext context, List<DocumentSnapshot> snapshot){

    List<Movie> movies = snapshot.map((d)=> Movie.fromSnapshot(d)).toList();

    return ListView(                    //Listview 리턴을 받아
      children: [
        Stack(                        //스택구조로 선언 (제일 처음선언한게 밑에깔림)
          children: [
            CarouselImage(movies:movies,),  //이미지가 제일 밑에 깔림.
            TopBar()                        //탭바가 그 위에옴
          ],
        ),
        CircleSlider(movies:movies,),
        BoxSlider(movies:movies),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {

    return _fetchData(context);
  }
}


//홈화면에서만 사용되는 topbar 생성
class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('images/bbongflix_logo.png',
          fit: BoxFit.contain,
          height: 25,),
          Container(padding: EdgeInsets.only(right: 1),
            child: Text(
              'TV 프로그램',
              style: TextStyle(
                fontSize: 14
              ),
            ),
          ),
          Container(padding: EdgeInsets.only(right: 1),
            child: Text(
              '영화',
              style: TextStyle(
                fontSize: 14
              ),
            ),
          ),
          Container(padding: EdgeInsets.only(right: 1),
            child: Text(
              '내가 찜한 콘텐츠',
              style: TextStyle(
                fontSize: 14
              ),
            ),
          ),

        ],
      ),
    );
  }
}
