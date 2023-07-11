import 'package:fake_news_detectio_system/main.dart';
import 'package:fake_news_detectio_system/reply_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'app/services/google_sign_in.dart';
import 'dialog.dart';

class ResultScreen extends StatefulWidget {

  Future<ReplyApi> title;
  ResultScreen({Key key, this.title}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {

  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text('Results'),
        actions: <Widget>[
          IconButton( onPressed: (){
                showDialog(context: context,
                builder: (BuildContext context){
                return CustomDialogBox(
                title: "Custom Dialog Demo",
                descriptions: "Hii all this is a custom dialog in flutter and  you will be use in your flutter applications",
                text: "Yes",
                );});},
          icon: CircleAvatar(
            maxRadius: 25,
            backgroundImage: NetworkImage(user.photoURL),
          ),
          iconSize: 18),
          SizedBox(width: 7,),
        ],
        backgroundColor: primaryColor,

        elevation: 0,
      ),
      backgroundColor: secondaryColor,
        body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FutureBuilder<ReplyApi>(
            future: widget.title,
                builder: (context, snapshot){
                print(widget.title);
                if(snapshot.hasData){
                  final result = snapshot.data;
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("${result.finalResult}%", style: GoogleFonts.comfortaa(textStyle: TextStyle(color: Colors.lightGreen), fontStyle: FontStyle.italic,fontWeight: FontWeight.bold, fontSize: 100)),
                        Align( alignment: Alignment.center,child: Text("The given Article is : ${result.rr}", style: GoogleFonts.comfortaa(textStyle: TextStyle(color: Colors.white), fontStyle: FontStyle.italic,fontWeight: FontWeight.bold, fontSize: 30))),
                        SizedBox(height: 80),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Spam Score",style: GoogleFonts.comfortaa(textStyle: TextStyle(color: Colors.lightGreen), fontStyle: FontStyle.italic,fontWeight: FontWeight.bold, fontSize: 24), textAlign: TextAlign.start,),
                            Text("${result.spam}",style: GoogleFonts.comfortaa(textStyle: TextStyle(color: Colors.lightGreen), fontStyle: FontStyle.italic,fontWeight: FontWeight.bold, fontSize: 24))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Toxicity Score",style: GoogleFonts.comfortaa(textStyle: TextStyle(color: Colors.lightGreen), fontStyle: FontStyle.italic,fontWeight: FontWeight.bold, fontSize: 24), textAlign: TextAlign.start,),
                            Text("${result.toxicity}",style: GoogleFonts.comfortaa(textStyle: TextStyle(color: Colors.lightGreen), fontStyle: FontStyle.italic,fontWeight: FontWeight.bold, fontSize: 24))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Category",style: GoogleFonts.comfortaa(textStyle: TextStyle(color: Colors.lightGreen), fontStyle: FontStyle.italic,fontWeight: FontWeight.bold, fontSize: 24),textAlign: TextAlign.start,),
                            Text("${result.category}",style: GoogleFonts.comfortaa(textStyle: TextStyle(color: Colors.lightGreen), fontStyle: FontStyle.italic,fontWeight: FontWeight.bold, fontSize: 24))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Sentiment Score",style: GoogleFonts.comfortaa(textStyle: TextStyle(color: Colors.lightGreen), fontStyle: FontStyle.italic,fontWeight: FontWeight.bold, fontSize: 24,),textAlign: TextAlign.start,),
                            Text("${result.sentiment}",style: GoogleFonts.comfortaa(textStyle: TextStyle(color: Colors.lightGreen), fontStyle: FontStyle.italic,fontWeight: FontWeight.bold, fontSize: 24))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Stance",style: GoogleFonts.comfortaa(textStyle: TextStyle(color: Colors.lightGreen), fontStyle: FontStyle.italic,fontWeight: FontWeight.bold, fontSize: 24), textAlign: TextAlign.start,),
                            Text("${result.stance}",style: GoogleFonts.comfortaa(textStyle: TextStyle(color: Colors.lightGreen), fontStyle: FontStyle.italic,fontWeight: FontWeight.bold, fontSize: 24))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("ClickBait score",style: GoogleFonts.comfortaa(textStyle: TextStyle(color: Colors.lightGreen), fontStyle: FontStyle.italic,fontWeight: FontWeight.bold, fontSize: 24), textAlign: TextAlign.start,),
                            Text("${result.clickbait}",style: GoogleFonts.comfortaa(textStyle: TextStyle(color: Colors.lightGreen), fontStyle: FontStyle.italic,fontWeight: FontWeight.bold, fontSize: 24))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Domain Rank",style: GoogleFonts.comfortaa(textStyle: TextStyle(color: Colors.lightGreen), fontStyle: FontStyle.italic,fontWeight: FontWeight.bold, fontSize: 24), textAlign: TextAlign.start,),
                            Text("${result.domain}",style: GoogleFonts.comfortaa(textStyle: TextStyle(color: Colors.lightGreen), fontStyle: FontStyle.italic,fontWeight: FontWeight.bold, fontSize: 24))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Political Affi.",style: GoogleFonts.comfortaa(textStyle: TextStyle(color: Colors.lightGreen), fontStyle: FontStyle.italic,fontWeight: FontWeight.bold, fontSize: 24), textAlign: TextAlign.start,),
                            Text("${result.political}",style: GoogleFonts.comfortaa(textStyle: TextStyle(color: Colors.lightGreen), fontStyle: FontStyle.italic,fontWeight: FontWeight.bold, fontSize: 24))
                          ],
                        )
                      ],
                    ),
                  );
                }else if(snapshot.hasError){
                  return Text(snapshot.error.toString());
                }
                  return CircularProgressIndicator();
                },
            ),
          ],
        ),
    ),
    );
  }
}
