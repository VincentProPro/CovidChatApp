import 'package:flutter/material.dart';
import 'package:gtuc_covid19/chatfoder/constants.dart';
import 'package:gtuc_covid19/chatfoder/profile_screen.dart';
import 'package:gtuc_covid19/models/request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../custom_drawer.dart';
import '../varialbe.dart';

final _firestore = Firestore.instance;
String timesent,msrole,msuser,mscontent;

class SeeMessage extends StatefulWidget {
  @override
  _SeeMessageState createState() => _SeeMessageState();
}

class _SeeMessageState extends State<SeeMessage> {
  FirebaseUser loggedInUser;


  @override
  void initState() {
    getPreffromConstant();
  }

  @override
  Widget build(BuildContext context) {

    final Size screenSize = MediaQuery.of(context).size;
    screenDimen=screenSize;

    return Scaffold(
      appBar: AppBar(
        leading: null,

        title: Row(children: <Widget>[
          Text("View Advisor's messages"),
          SizedBox(
            width: 10,
          ),

        ]),
        backgroundColor: Colors.lightBlueAccent,
      ),
      drawer: CustomDrawer(),
      body: SafeArea(
        child:
          Container(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                MessagesStream(),
              ],
            ),
          ),

      ),
    );
  }



}
class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').where('userrole',isEqualTo: "advisor").orderBy('timestamp',descending: true).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data.documents.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
//String timecvrt=message.data['timestamp'].toString();
//int timec=int.parse(timecvrt);
          final messagemscontent = message.data['text'];
          final messagetimesent = message.data['timestamp'].toString();
          final messagemsuser = message.data['username'];
          final messagemsrole = message.data['userrole'];

          final currentUser = email;

          final messageBubble = MessageBubble(
            msuser: messagemsuser,
            msrole: messagemsrole,
            mscontent: messagemscontent,
            timesent: messagetimesent,
          );

          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.timesent,this.msrole, this.msuser, this.mscontent});
  final String timesent,msrole,msuser,mscontent;





  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: screenDimen.width,

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                //height: screenDimen.height / 5,
                padding: const EdgeInsets.all(8.0),

                child:
                Card(
                  elevation: 10,
                  child:
                  Container(
                    padding: const EdgeInsets.all(15.0),

                    child: Column(
                      children: <Widget>[
                        Row(children: <Widget>[
                          Text("message:"),

                        ],
                        ),
                        Row(children: <Widget>[
                          Text("username:"),
                          SizedBox(width: 15,),

                          Text(msuser),
                        ],
                        ),
                        Row(children: <Widget>[
                          Text("user role:"),
                          SizedBox(width: 15,),

                          Text(msrole),
                        ],
                        ),
                        Container(child: Text(mscontent,softWrap:true,style: TextStyle(fontSize: 19,fontWeight: FontWeight.w400,fontStyle: FontStyle.italic),)),

                      ],),
                  ),),),
            ),
          ),
        ],
      ),
    );
  }
}

