import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutti/data/join_or_login.dart';
import 'package:tutti/helper/login_background.dart';
import 'package:tutti/screens/forget_pw.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            color: Colors.white,
          ),
          CustomPaint(
            size: size,
            painter: LoginBackground(
                isJoin: Provider.of<JoinOrLogin>(context).isJoin),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _logoImage,
              Stack(
                children: <Widget>[
                  _inputForm(size),
                  _authButton(size),
                ],
              ),
              Container(
                height: size.height * 0.05,
              ),
              Consumer<JoinOrLogin>(
                builder: (context, joinOrLogin, child) => GestureDetector(
                  onTap: () {
                    JoinOrLogin joinOrLogin = Provider.of<JoinOrLogin>(context);
                    joinOrLogin.toggle();
                  },
                  child: Text(
                    joinOrLogin.isJoin
                        ? 'Already have an Account? Sign In!'
                        : "Don't have an Account yet? Create one!",
                    style: TextStyle(
                        color: joinOrLogin.isJoin
                            ? Colors.red
                            : Color.fromARGB(200, 38, 65, 5)),
                  ),
                ),
              ),
              Container(
                height: size.height * 0.05,
              )
            ],
          ),
        ],
      ),
    );
  }

  void _register(BuildContext context) async {
    final AuthResult result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
    final FirebaseUser user = result.user;

    if (user == null) {
      final snacBar = SnackBar(
        content: Text('Please try again later.'),
      );
      Scaffold.of(context).showSnackBar(snacBar);
    }
  }

  void _login(BuildContext context) async {
    final AuthResult result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
    final FirebaseUser user = result.user;

    if (user == null) {
      final snacBar = SnackBar(
        content: Text('Please try again later.'),
      );
      Scaffold.of(context).showSnackBar(snacBar);
    }
    // Navigator.push(context,
    //     MaterialPageRoute(builder: (context) => Mainpage(email: user.email)));
  }

  Widget get _logoImage => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 24, right: 24),
          child: FittedBox(
            fit: BoxFit.contain,
            child: CircleAvatar(
              backgroundImage: AssetImage('images/sondae.png'),
            ),
          ),
        ),
      );

  Widget _authButton(Size size) => Positioned(
        left: size.width * 0.15,
        right: size.width * 0.15,
        bottom: 0,
        child: Consumer<JoinOrLogin>(
          builder: (context, joinOrLogin, child) => RaisedButton(
              child: Text(
                joinOrLogin.isJoin ? 'Join' : 'Login',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              color: joinOrLogin.isJoin
                  ? Colors.red
                  : Color.fromARGB(255, 38, 65, 5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  joinOrLogin.isJoin ? _register(context)
                   : _login(context);
                }
              }),
        ),
      );

  Widget _inputForm(Size size) => Padding(
        padding: EdgeInsets.all(size.width * 0.03),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 12.0, right: 12, top: 12, bottom: 32),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.account_circle),
                        labelText: "Email",
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please input correct Email.';
                        }
                        return null;
                      },
                    ),
                    Container(
                      height: 8,
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.vpn_key),
                        labelText: "Password ",
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please input correct Password.';
                        }
                        return null;
                      },
                    ),
                    Container(
                      height: 8,
                    ),
                    Consumer<JoinOrLogin>(
                      builder: (context, value, child) => Opacity(
                          opacity: value.isJoin ? 0 : 1,
                          child: GestureDetector(
                            onTap: value.isJoin
                                ? null
                                : () {
                                    goToForgetPw(context);
                                  },
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(fontSize: 11),
                            ),
                          )),
                    ),
                  ],
                )),
          ),
        ),
      );

  goToForgetPw(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ForgetPw()));
  }
}
