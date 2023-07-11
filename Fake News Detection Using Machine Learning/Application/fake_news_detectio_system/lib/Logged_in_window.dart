import 'dart:convert';
import 'package:fake_news_detectio_system/reply_response.dart';
import 'package:fake_news_detectio_system/resultscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fake_news_detectio_system/app/services/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'dialog.dart';
final textController = TextEditingController();
final titleController = TextEditingController();
final urlController = TextEditingController();
class LoggedInWidget extends StatelessWidget {
  @override
  Widget build(context) {
    final user = FirebaseAuth.instance.currentUser;
    final Color primaryColor = Color(0xff18203d);
    final Color secondaryColor = Color(0xff232c51);
    Future<ReplyApi> x;

    return Scaffold(
      appBar: AppBar( title: Text('Fake News Detector'),
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

          IconButton(onPressed: (){final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
          provider.logout();},icon: Icon(Icons.add_to_home_screen))
        ],
        backgroundColor: primaryColor,

        elevation: 0,
      ),
      body: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        color: secondaryColor,
        child: Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 150),
                Container(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    children: [
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          icon: Icon(
                            Icons.assignment
                          ),
                            labelText: "News Title"
                        ),
                          maxLines: null
                      ),
                      SizedBox(height: 30),
                      TextField(
                        controller: textController,
                        decoration: InputDecoration(

                            hoverColor: Colors.blue.shade100,
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            icon: Icon(
                                Icons.add_comment_rounded
                            ),
                            // hintText: "Enter Text Of the News"
                          labelText: "News Article"
                        ),
                      ),
                      SizedBox(height: 30),
                      TextField(
                        controller: urlController,
                        decoration: InputDecoration(

                            hoverColor: Colors.blue.shade100,
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            icon: Icon(
                                Icons.add_link
                            ),
                            // hintText: "Enter Text Of the News"
                          labelText: "News URL"
                        ),
                      ),
                      SizedBox(height: 80),

                      MaterialButton(
                        elevation: 0,
                        minWidth: double.maxFinite,
                        height: 50,
                        onPressed: ()  {
                          x = checkNews(titleController.text, textController.text, urlController.text);
                          Navigator.push(
                              context, MaterialPageRoute(builder: (_) => ResultScreen(title: x)));
                          // Navigator.of(context).pushNamed(ResultScreen(x));
                        },
                        color: Colors.blue,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // Icon(FontAwesomeIcons.google),
                            Text('Check The News',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                          ],
                        ),
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
Future<ReplyApi>checkNews(String title, String text, String url1) async {
  var response;
  final url = "http://127.0.0.1:5000/";

  response = await http.post(Uri.parse(url),
      body: jsonEncode(<String, String>{
        'title': title,
        'text': text,
        'url' : url1,
      }));
  // print(response.body);
  if (response.statusCode == 200) {
    // String jsonStudent = ;
    // print(response);
    return ReplyApi.fromJson(jsonDecode(response.body));
  } else {
    throw Exception();
  }

  // print(response.body);
  // final url = "https://api.jsonbin.io/b/5e1219328d761771cc8b9394";
  // final response = await http.get(url);
  //
  // if(response.statusCode == 200){
  //   final jsonStudent = jsonDecode(response.body);
  //   return StudentModel.fromJson(jsonStudent);
  // }else{
  //   throw Exception();
  // }
}
// checkNews(String title) async {
//   // adb reverse tcp:2000 tcp:3000
//   final url = "http://127.0.0.1:5000/";
//   Map<String, dynamic> toJson() => {
//     'title': title,
//   };
//   var response = await http.post(Uri.parse(url),
//       body: jsonEncode(<String, String>{
//         'title': title,
//       }));
//   print(response.body);
// }
// Future<reply_api> checkNews(String title) {
//   return http.post(
//     Uri.parse('127.0.0.1:5000'),
//     body: jsonEncode(<String, String>{
//       'title': title
//     }),
//   );
// }


// TextFormField(
//   decoration: InputDecoration(
//       border: UnderlineInputBorder(),
//       labelText: 'Title'
//   ),
// ),
// TextFormField(
//   decoration: InputDecoration(
//       border: UnderlineInputBorder(),
//       labelText: 'Text'
//   ),
// ),
// Future<ReplyApi>
// Future<ReplyApi> checkNews1() async{
//   print('qqqqqq');
//     return checkNews(textController.text);
// }
// Future<ReplyApi>

