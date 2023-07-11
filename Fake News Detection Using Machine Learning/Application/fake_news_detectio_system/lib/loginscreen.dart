import 'package:fake_news_detectio_system/Logged_in_window.dart';
import 'package:fake_news_detectio_system/app/services/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:provider/provider.dart';
import 'package:loading/loading.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

FirebaseApp secondaryApp = Firebase.app('Fake News Detection');
FirebaseAuth firebaseAuth = FirebaseAuth.instanceFor(app: secondaryApp);
final GoogleSignIn googleSignIn = GoogleSignIn();

class _LoginScreenState extends State<LoginScreen> {
  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);

  final Color logoGreen = Color(0xff25bcbb);
  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      body: ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              final provider = Provider.of<GoogleSignInProvider>(context);
              if (provider.isSigningIn) {
                return buildLoading();
              } else if (snapshot.hasData) {
                return LoggedInWidget();
              } else {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sign in to FNDS and continue',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.comfortaa(
                            color: Colors.white, fontSize: 28),
                      ),
                      SizedBox(height: 20),
                      SizedBox(height: 20),
                      MaterialButton(
                        elevation: 0,
                        minWidth: double.maxFinite,
                        height: 50,
                        onPressed: () async {
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          provider.login();
                        },
                        color: Colors.blue,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(FontAwesomeIcons.google),
                            SizedBox(width: 10),
                            Text('Sign-in using Google',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                          ],
                        ),
                        textColor: Colors.white,
                      ),
                      SizedBox(height: 100),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }

  Widget buildLoading() => Stack(
        fit: StackFit.expand,
        children: [
          Center(child: Loading(indicator: BallPulseIndicator(), size: 100.0,color: Colors.pink)),
        ],
      );
}
