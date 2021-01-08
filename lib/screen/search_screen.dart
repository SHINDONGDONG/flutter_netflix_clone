import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_netflix_clone/model/model_movie.dart';
import 'package:flutter_netflix_clone/screen/detail_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _filter = TextEditingController(); //검색화면에서 사용할 텍스트 에딧위젯을 컨트롤하는 위젯임
  FocusNode focusNode = FocusNode();  //텍스트 에딧위젯에 현재 커서가 있는지 없는지에 대한 상태를 가지고있을 위젯임
  String _searchText = "";          //서치 검색어를 담을 변수

  _SearchScreenState() {
    _filter.addListener(() {                 //Listener 특정상황을 모니터링하다가 해당상황이 발생하면 동장하는 일종의 함수
      setState(() {
        _searchText = _filter.text;         //텍스트 에딧위젯을 컨트롤하고 있는 filter가 상태변화를 감지하여 searchText를 filter.text로 매칭시켜주는 코드
      });
    });
  }

  _buildBody(BuildContext context) {                    //Widget _buildBody를 만들어주고 빌드 컨텍스트를 인자로 받는다
    return StreamBuilder<QuerySnapshot>(                 //스트림 빌더를 통해서 (쿼리 ) 
      stream: Firestore.instance.collection('movie').snapshots(),   //firestore에 instance.collection (movie)테이블의. 스트링값
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.documents);            //스냅샷 데이터가 있다면 실제 빌드리스트를 가지고옴 밑에서설명
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {       //_buildList를 만듦 List<DocumentSnapshot>함수를 만듬
    List<DocumentSnapshot> searchResult = [];                                   //빈 List<DocumentSnapshot> searchresult를 선언
    for (DocumentSnapshot d in snapshot) {                                  //가지고온 snapshot이 _searchText를 포함하고 있다면
      if (d.data().toString().contains(_searchText)) {                       //searchResult에 add해준다.
        searchResult.add(d);
      }
    }
    return Expanded(
      child: GridView.count(
        crossAxisCount: 3,                 //한줄에 3칸이 나오도록
        childAspectRatio: 1 / 1.5,       //1/1.5 비율로 맞춰주기
        padding: EdgeInsets.all(3),
        children: searchResult                //searchResult 리스트를 기반으로 그리드뷰를 생성 각 그리드뷰에
            .map((data) => _buildListItem(    //들어갈 요소들은 _buildListItem을 통해 각 movie별로 다룸.
                  context,
                  data,
                ))
            .toList(),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final movie = Movie.fromSnapshot(data);
    return InkWell(                                                  //클릭할 수 있도록 Inkwell로 리턴
      child: Image.network(movie.poster),                           //Movie.fromSnapshot으로 가져온 데이터(쿼리)로 movie.poster 불러옴
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute<Null>(         //탭을 하면 팝업창으로 이동할 수 있도록 설정
            fullscreenDialog: true,                                //전체화면으로
            builder: (BuildContext context) {
              return DetailScreen(                                  //리턴을 detailScreen으로 이동시켜준다
                movie: movie,
              );
            }));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(padding: EdgeInsets.all(12)),
          Container(
            color: Colors.black,
            padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: TextField(
                    focusNode: focusNode,
                    style: TextStyle(fontSize: 15),
                    autofocus: false,
                    controller: _filter,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white12,
                      prefixIcon: Icon(                          //prifix 앞쪽 아이콘
                        Icons.search,
                        color: Colors.white60,
                        size: 20,
                      ),
                      suffixIcon: focusNode                       //suffixIcon 뒤쪽 아이콘
                              .hasFocus         //서픽스 아이콘쪽에 포커스가 감지된다면 캔슬아이콘을 ! 누르면 _filter.clear()로 비워준다
                          ? IconButton(
                              icon: Icon(
                                Icons.cancel,
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  _filter.clear();
                                  _searchText = "";
                                });
                              },
                            )
                          : Container(),
                      hintText: '검색',                  //투명하게 힌트텍스트가 나온다.
                      labelStyle: TextStyle(color: Colors.white),  //힌트텍스트의 스타일
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ),
                focusNode.hasFocus                     //검색이 눌려져있으면 취소버튼을 만들고 아니면 flex0d으로 없애버림
                    ? Expanded(
                        child: FlatButton(
                          child: Text('취소',style: TextStyle(fontSize: 12),),
                          onPressed: () {
                            setState(() {
                              _filter.clear();
                              _searchText = "";
                              focusNode.unfocus();       //취소를 눌렀을 때 빈상태로 돌아간다.
                            });
                          },
                        ),
                      )
                    : Expanded(
                        flex: 0,
                        child: Container(),
                      ),
              ],
            ),
          ),
          _buildBody(context), //빌드 바디를 호출하여 검색이 가능하게
        ],
      ),
    );
  }
}
