import 'package:flutter/material.dart';
import 'package:gtuc_covid19/chatfoder/seeMessage.dart';
import '../custom_drawer.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  var id,email,role,username,backgroundImageUrl,profileImageUrl;
  String messageText;
  var timestamp=FieldValue.serverTimestamp();
  saverole(String newrole) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
setState(() {
  preferences.setString("role", newrole);
  preferences.commit();
});

  }
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getString("id");
      email = preferences.getString("email");
      role = preferences.getString("role");
      username = preferences.getString("username");
      backgroundImageUrl = preferences.getString("backgroundImageUrl");
      profileImageUrl = preferences.getString("profileImageUrl");
    });

    //getCurrentUser();

  }
  @override
  void initState() {
    super.initState();
    setState(() {
      getPref();
      getPreffromConstant();
      getPref();
      getPreffromConstant();
      getPrefRequest();
    });

  }
  String newString;
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", 0);
      preferences.setString("role", null);
      preferences.setString("email", null);
      preferences.setString("username", null);

      preferences.setInt("valueRqst", null);
      preferences.setString("emailRqst", null);
      preferences.setString("fullnameRqst", null);
      preferences.setString("jobRqst", null);
      preferences.setString("functionRqst", null);
      preferences.setString("phonRqst", null);
      preferences.setString("purpRqst", null);
      preferences.setString("statusRqst", null);
      preferences.commit();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                signOut();
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
          Text('⚡️Chat with us',
          ),
SizedBox(
  width: 15,
),IconButton(
          icon: Icon(Icons.visibility),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SeeMessage()),
            );
          }),

          ]),
        backgroundColor: Colors.lightBlueAccent,
      ),
      drawer: CustomDrawer(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      if(messageText.toString()=='null' || messageText.toString().isEmpty){
                        callToast("Please enter a text");
                      }else{
                        messageTextController.clear();
                        _firestore.collection('messages').add({
                          'text': messageText,
                          'sender': email,
                          'timestamp':timestamp,
                          'username': username,
                          'userrole': role,

                        });
                      }

                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').orderBy('timestamp').snapshots(),
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
          final messageText = message.data['text'];
          final messageSender = message.data['sender'];
          final messageUsername = message.data['username'];
          final messageUserrole = message.data['userrole'];

          final currentUser = email;

          final messageBubble = MessageBubble(
            sender: messageSender,
            usernamesender: messageUsername,
            text: messageText,
            isMe: currentUser == messageSender,
              ifadmin:messageUserrole=="user",
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
  MessageBubble({this.sender,this.usernamesender, this.text, this.isMe,this.ifadmin});

  final String sender;
  final String usernamesender;
  final String text;
  final bool isMe;
  final bool ifadmin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            usernamesender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
            elevation: 5.0,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: ifadmin? Colors.transparent:Colors.red,width: 1.0,style: BorderStyle.solid)
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    color: isMe ? Colors.white : Colors.black54,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
