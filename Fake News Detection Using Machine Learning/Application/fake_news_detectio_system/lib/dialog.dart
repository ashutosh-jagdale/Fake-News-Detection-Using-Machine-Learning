
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/services/google_sign_in.dart';
import 'constants.dart';

class CustomDialogBox extends StatefulWidget {

  final String title, descriptions, text;
  final Image img;

  const CustomDialogBox({Key key, this.title, this.descriptions, this.text, this.img}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 60,top: Constants.avatarRadius
              + Constants.padding, right: 60,bottom: Constants.padding
          ),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(color: Colors.black,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(user.displayName ,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600, color: Colors.black),),
              SizedBox(height: 15,),
              Text(user.email,style: TextStyle(fontSize: 14, color:Colors.black),textAlign: TextAlign.center,),
              SizedBox(height: 22,),
              // Align(
              //   alignment: Alignment.bottomRight,
              //   child: ElevatedButton(
              //
              //       onPressed: (){
              //         final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
              //         provider.logout();
              //       },
              //       child: Text('Logout',style: TextStyle(fontSize: 18, color: Colors.redAccent),)),
              // ),
            ],
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                child: Image.asset("assets/splash-image.png")
            ),
          ),
        ),
      ],
    );
  }
}