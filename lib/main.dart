import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_netflix_clone/screen/home_screen.dart';
import 'package:flutter_netflix_clone/screen/more_screen.dart';
import 'widget/bottom_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TabController controller;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BBobobon',
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.black,
          accentColor: Colors.indigo),
      home: DefaultTabController(length: 4,              //length : tap바의 길이 NavigationBar와 연동된다. (인덱스0~3부여)
            child: Scaffold(
              body: TabBarView(                         //TapBar를 클릭하면 0,1,2,3 콘테이너로 이동
                physics: NeverScrollableScrollPhysics( //사용자가 직접 손가락 모션을 통해서 스크롤하는 경우를 막게다는 의미
                ),
                children: [
                  HomeScreen(),
                  Container(
                    child: Center(
                      child: Text(
                          'Search'
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                          'save'
                      ),
                    ),
                  ),
                  MoreScreen(),
                ],
              ),
              bottomNavigationBar: Bottom(),
            ),
      ),
    );
  }
}
