import 'package:flutter/material.dart';

class Bottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,                            //탭바 컨테이너의 색상
      child: Container(
        height: 50,
        child: TabBar(                              //TapBar 위젯
          labelColor: Colors.white,                 //목록이 선택 되었을 때 색상
          unselectedLabelColor: Colors.white60,     //목록들 선택 안되었을 떄 아이콘,텍스트 색상
          indicatorColor: Colors.blue,       //선택 탭 아래에 표시되는 색상.
          tabs: [                                   //TabBar위젯 안에서 tabs 항목들
            Tab(
              icon: Icon(
                  Icons.home,
                  size: 18,
              ),
              child: Text(
                'Home',
                style: TextStyle(
                  fontSize: 9.0
                ),
              ),
            ),Tab(
              icon: Icon(
                  Icons.search,
                  size: 18,
              ),
              child: Text(
                'Search',
                style: TextStyle(
                  fontSize: 9.0
                ),
              ),
            ),Tab(
              icon: Icon(
                  Icons.save_alt,
                  size: 18,
              ),
              child: Text(
                '저장한 컨텐츠',
                style: TextStyle(
                  fontSize: 9.0
                ),
              ),
            ),
            Tab(
              icon: Icon(
                  Icons.list,
                  size: 18,
              ),
              child: Text(
                '더보기',
                style: TextStyle(
                  fontSize: 9.0
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
