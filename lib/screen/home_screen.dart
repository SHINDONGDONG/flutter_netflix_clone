import 'package:flutter/material.dart';
import 'package:flutter_netflix_clone/model/model_movie.dart';
import 'package:flutter_netflix_clone/widget/box_slider.dart';
import 'package:flutter_netflix_clone/widget/carousel_slider.dart';
import 'package:flutter_netflix_clone/widget/cicle_slider.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> movies = [
  Movie.fromMap({
  'title':'사랑의 불시착',
  'keyword' : '사랑/로맨스/판타지',
  'poster' : 'test_movie_1.png',
  'like' : false
    }),
  Movie.fromMap({
  'title':'사랑의 불시착',
  'keyword' : '사랑/로맨스/판타지',
  'poster' : 'test_movie_1.png',
  'like' : false
    }),
  Movie.fromMap({
  'title':'사랑의 불시착',
  'keyword' : '사랑/로맨스/판타지',
  'poster' : 'test_movie_1.png',
  'like' : false
    }),
  Movie.fromMap({
  'title':'사랑의 불시착',
  'keyword' : '사랑/로맨스/판타지',
  'poster' : 'test_movie_1.png',
  'like' : false
    }),

  ];
  @override
  Widget build(BuildContext context) {
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
