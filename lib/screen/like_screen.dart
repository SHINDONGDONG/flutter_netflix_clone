// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_netflix_clone/model/model_movie.dart';
// import 'package:flutter_netflix_clone/screen/detail_screen.dart';
//
// class LikeScreen extends StatefulWidget {
//   _LikeScreenState createState() => _LikeScreenState();
// }
//
// class _LikeScreenState extends State<LikeScreen> {
//
//   Widget _buildBody(BuildContext context) {               //body빌드를 감쌀 buildBody 위젯을 만듬
//     return StreamBuilder<QuerySnapshot>(                  //return Stream빌더로 쿼리를 불러옴
//       stream: Firestore.instance                         //스트림은 firestore.instance.collection(무비(테이블명)).
//           .collection('movie')
//           .where('like', isEqualTo: true)               //where 조건문 'like' 가 isEuqalTo true 이라면 .스냅샷을 불러옴
//           .snapshots(),                                  //.snapshot을 통해 그것의 데이터를 가져옴
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return LinearProgressIndicator();   //스냅샷 데이터가 없다면 뺑글이 리턴
//         return _buildList(context, snapshot.data.documents);        //있다면 빌드리스트를 호출
//       },
//     );
//   }
//
//   Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
//     return Expanded(
//         child: GridView.count(
//       crossAxisCount: 3,
//       childAspectRatio: 1 / 1.5,
//       padding: EdgeInsets.all(3),
//       children: snapshot.map((data) => _buildListItem(context, data)).toList()),
//     );
//   }
//
//   Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
//     final movie = Movie.fromSnapshot(data);
//     return InkWell(
//       child: Image.network(movie.poster),
//       onTap: () {
//         Navigator.of(context).push(MaterialPageRoute<Null>(
//             fullscreenDialog: true,
//             builder: (BuildContext context) {
//               return DetailScreen(
//                 movie: movie,
//               );
//             }));
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.fromLTRB(20, 27, 20, 7),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Image.asset(
//                   'images/bbongflix_logo.png',
//                   fit: BoxFit.contain,
//                   height: 25,
//                 ),
//                 Container(
//                   padding: EdgeInsets.only(left: 30.0),
//                   child: Text(
//                     '내가 찜한 콘텐츠',
//                     style: TextStyle(fontSize: 14),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           _buildBody(context)
//         ],
//       ),
//     );
//   }
// }
//
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_netflix_clone/model/model_movie.dart';
import 'package:flutter_netflix_clone/screen/detail_screen.dart';

class LikeScreen extends StatefulWidget {
  _LikeScreenState createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('movie')
          .where('like', isEqualTo: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return Expanded(
      child: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 1 / 1.5,
          padding: EdgeInsets.all(3),
          children:
          snapshot.map((data) => _buildListItem(context, data)).toList()),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final movie = Movie.fromSnapshot(data);
    return InkWell(
      child: Image.network(movie.poster),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute<Null>(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return DetailScreen(movie: movie);
            }));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(20, 27, 20, 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  'images/bbongflix_logo.png',
                  fit: BoxFit.contain,
                  height: 25,
                ),
                Container(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    '내가 찜한 콘텐츠',
                    style: TextStyle(fontSize: 14),
                  ),
                )
              ],
            ),
          ),
          _buildBody(context)
        ],
      ),
    );
  }
}
