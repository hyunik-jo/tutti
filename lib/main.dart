import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutti/data/join_or_login.dart';
import 'package:tutti/screens/login_page.dart';
import 'package:tutti/screens/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Splash());
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return ChangeNotifierProvider<JoinOrLogin>.value(
                value: JoinOrLogin(), 
                child: LoginPage());
          } else {
            return MainPage(email: snapshot.data.email);
          }
        });
  }
}

// class FirstPage extends StatefulWidget {
//   @override
//   _FirstPageState createState() => _FirstPageState();
// }

// class _FirstPageState extends State<FirstPage> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Tutti',
//         theme: ThemeData(
//             brightness: Brightness.dark,
//             primarySwatch: Colors.green,
//             canvasColor: Color.fromARGB(255, 38, 65, 5),
//             fontFamily: 'KGTenThousandReasons'),
//         home: Scaffold(
//           floatingActionButton: RaisedButton(
//               child: Text('Press to Continue'),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => LoginPage()),
//                 );
//               }),
//           body: Center(
//             child: Text('Tutti',
//                 style: TextStyle(fontSize: 75, fontFamily: 'eraser')),
//           ),
//         )
//         );
//   }
// }
