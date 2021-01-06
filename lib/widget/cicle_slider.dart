import 'package:flutter/material.dart';
import 'package:flutter_netflix_clone/model/model_movie.dart';
import 'package:flutter_netflix_clone/screen/detail_screen.dart';

class CircleSlider extends StatelessWidget {
  final List<Movie> movies;          //home_screen.dart에서 movies를 넘겨받아야함.
  CircleSlider({this.movies});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('미리보기'),
          Container(
            height:120,
            child: ListView(
              scrollDirection: Axis.horizontal,           //좌우로 스크롤이가능
              children: makeCircleImages(context, movies),
            )
          ),
        ],
      ),
    );
  }
}

List<Widget> makeCircleImages(BuildContext context, List<Movie> movies){
  List<Widget> result= [];
  for(int i=0; i<movies.length; i++){
    result.add(
      InkWell(onTap: (){                            //잉크웰으로 각 위젯들이 클릭 가능하도록만듬
        Navigator.of(context).push
          (MaterialPageRoute<Null>(
            fullscreenDialog: true,
            builder: (BuildContext context){
              return DetailScreen(
                movie: movies[i],
              );
            }));
      },
      child: Container(
        padding: EdgeInsets.only(right: 10),
        child: Align(alignment: Alignment.centerLeft,
          child: CircleAvatar(backgroundImage:NetworkImage(movies[i].poster),
          radius: 48,
          ),
        ),
      ),
      )
    );
  }
  return result;

}