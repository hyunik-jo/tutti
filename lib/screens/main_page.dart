// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  MainPage({this.email});
  final String email;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedPage = 0;

  final _pageOptions = [
    Text('Page1'),
    Text('Page2'),
    Text('Page3'),
    Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: _pageOptions[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedPage,
        onTap: (int index) {
          setState(() {
            _selectedPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),title: Text('Dashboard')),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), title: Text('Browse')),
          BottomNavigationBarItem(
              icon: Icon(Icons.featured_play_list), title: Text('Contacts')),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment_ind), title: Text('Profile')),
        ],
      ),
    ));
  }
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FlatButton(onPressed: (){
          FirebaseAuth.instance.signOut();
        }, child: Text('Logout')),
      )
      
    );
  }
}
