import 'package:flutter/material.dart';
import 'package:flutter_netflix_clone/model/model_movie.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_netflix_clone/screen/detail_screen.dart';

class CarouselImage extends StatefulWidget {  //해당위젯은 이미지 쇼,찜하기버튼 등이 있으므로 stateful위젯으로
  final List<Movie> movies; //홈화면에서 carouseimage로 movies를 넘겨받아야함
  CarouselImage({this.movies});  //생성자 생성
  @override
  _CarouselImageState createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  //state로 관리해줄 변수들을 선언
  List<Movie> movies;
  List<Widget> images;
  List<String> keywords;
  List<bool> likes;
  int _currentPage = 0;      //CarouseImages에서 어느 위치에 있는지 index를 저장할 변수선언
  String _currentKeyword;    //마찬가지로 그페이지에 기록되어있는 현재 keyword를 저장할 변수

  @override
  void initState() {
    super.initState();

    movies = widget.movies;
    images = movies.map((e) => Image.network(e.poster)).toList();
    keywords = movies.map((m) => m.keyword).toList();
    likes = movies.map((e) => e.like).toList();
    _currentKeyword = keywords[0]; //커런트 키워드는 키워드0으로 초기값 설정
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
          ),
          CarouselSlider(
            items: images,
            options: CarouselOptions(onPageChanged:(index,reason){
              setState(() {
                _currentPage = index;
                _currentKeyword = keywords[_currentPage];
              });
            }),),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 3),
            child: Text(_currentKeyword,
            style: TextStyle(fontSize: 11),),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Column(
                    children: [
                      likes[_currentPage]                //likes 커런트 페이지가 true면 check false면 add
                      ? IconButton(icon: Icon(Icons.check),onPressed: (){},)
                          : IconButton(icon: Icon(Icons.add),onPressed: (){},),
                      Text('내가 찜한 컨텐츠',
                      style: TextStyle(fontSize: 11),)
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: FlatButton(color: Colors.white,onPressed: (){},
                  child: Row(
                    children: [
                      Icon(Icons.play_arrow,color: Colors.black,),
                      Padding(padding: EdgeInsets.all(3)),
                      Text('재생',style: TextStyle(color: Colors.black),)
                    ],
                  ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      IconButton(icon: Icon(Icons.info), onPressed: (){
                        Navigator.of(context).push
                          (MaterialPageRoute<Null>(
                            fullscreenDialog: true,
                            builder: (BuildContext context){
                          return DetailScreen(
                            movie: movies[_currentPage],
                          );
                        }));
                      }),
                      Text('정보',style: TextStyle(fontSize: 11),)
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: makeIndicator(likes, _currentPage),
            ),
          )
        ],
      ),
    );
  }
}


List<Widget> makeIndicator(List list, int _currentPage){
  List<Widget> result =[];
  for(var i =0; i < list.length; i++){
    result.add(Container(
      width: 8,
      height: 8,
      margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 2.0),
      decoration: BoxDecoration(shape: BoxShape.circle, color: _currentPage == i
          ? Color.fromRGBO(255, 255, 255, 0.9)
          : Color.fromRGBO(255, 255, 255, 0.4)
      ),
    ));
  }
  return result;
}