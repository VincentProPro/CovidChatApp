import 'package:flutter/material.dart';
import '../custom_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gtuc_covid19/chatfoder/constants.dart';


import '../varialbe.dart';

final _firestore = Firestore.instance;
String timesent,msrole,msuser,mscontent;
class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text("DashBoard"),),
      drawer: CustomDrawer(),

      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[

                  Container(
                    height: screenSize.height / 9,
                    child: Center(
                      child: Card(
                          elevation: 10,

                          child: Container(
                              height: screenSize.height / 9,
                              width: screenSize.width - 20,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Admin Platform",
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  style: TextStyle(fontSize: 22),),
                              ))),
                    ),
                  )
                ],),

              Container(
                width: screenSize.width,
                height: screenSize.height / 5,


                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: <Widget>[
                          SizedBox(width: 10,),
                          //SizedBox(width: 10,),

                          Text("View New Request :", style: TextStyle(fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),),
                          SizedBox(height: 10,),
                          RaisedButton(
                            child: Text("click Me!"),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ViewNewReqst(),
                                ),
                              );
                            },
                          )
                        ],),
                    ),
                  ),
                ),
              ),
              Container(
                width: screenSize.width,
                height: screenSize.height / 5,


                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: <Widget>[
                          SizedBox(width: 10,),
                          //SizedBox(width: 10,),

                          Text("View All Requests", style: TextStyle(fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),),
                          SizedBox(height: 10,),
                          RaisedButton(
                            child: Text("click Me!"),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ViewAllReqst(),
                                ),
                              );
                            },
                          )

                        ],),
                    ),
                  ),
                ),
              ),
              Container(
                width: screenSize.width,
                height: screenSize.height / 5,


                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: <Widget>[
                          SizedBox(width: 10,),
                          //SizedBox(width: 10,),

                          Text("View All Roles", style: TextStyle(fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),),
                          SizedBox(height: 10,),
                          RaisedButton(
                            child: Text("click Me!"),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ViewRole(),
                                ),
                              );
                            },
                          )

                        ],),
                    ),
                  ),
                ),
              ),


            ],
          )
        ],
      ),
    );
  }
}
class ViewNewReqst extends StatefulWidget {
  @override
  _ViewNewReqstState createState() => _ViewNewReqstState();
}

class _ViewNewReqstState extends State<ViewNewReqst> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: null,

        title: Row(children: <Widget>[
          Text("View New Request"),
          Expanded(
            child: SizedBox(
              width: 10,
            ),
          ),
          GestureDetector(child: Icon(Icons.arrow_back,size: 35,),onTap: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => Dashboard(),
              ),
            );
          },)

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
      stream: _firestore.collection('request').where('status',isEqualTo: "Pending").snapshots(),
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
          final mesemail = message.data['email'];
          final messfullnm = message.data['fullname'].toString();
          final messfunction = message.data['function'];
          final messjob = message.data['job'];
          final messphon = message.data['phone'];
          final messprpos = message.data['purpose'];
          final messstate = message.data['status'];


          final currentUser = email;

          final messageBubble = MessageBubble(
               mesemail,
              messfunction,
              messfullnm,
              messprpos,
            messstate,
            messphon,
            messjob

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

class MessageBubble extends StatefulWidget {
  rejectfunction()async{

  }
  acceptfunction()async{

  }
  final String memail,mfuncton,mfullname,mpurpose,mstatus,mphone,mjob;
  MessageBubble(this.memail, this.mfuncton, this.mfullname, this.mpurpose,
      this.mstatus, this.mphone, this.mjob);

  @override
  _MessageBubbleState createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
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
                          Text("Request from: "+widget.memail),

                        ],
                        ),
                        Row(children: <Widget>[
                          Text("Fullname: "),
                          SizedBox(width: 15,),

                          Text(widget.mfullname),
                        ],
                        ),
                        Row(children: <Widget>[
                          Text("user job: "),
                          SizedBox(width: 15,),

                          Text(widget.mjob),
                        ],
                        ),
                        Row(children: <Widget>[
                          Text("user request for this role:"),
                          SizedBox(width: 15,),

                          Text(widget.mfuncton),
                        ],
                        ),
                        Text("user purpose "),

                        Container(child: Text(widget.mpurpose,softWrap:true,style: TextStyle(fontSize: 19,fontWeight: FontWeight.w400,fontStyle: FontStyle.italic),)),
                        Container(
                         // width: screenDimen.width/2,

                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RaisedButton(child: Text("Accept"),
                              onPressed: (){

                              },),

                              RaisedButton(
                                child: Text("Reject"),
                              onPressed: (){

                              },),
                            ],),
                        )

                      ],),
                  ),),),
            ),
          ),
        ],
      ),
    );
  }
}


class ViewAllReqst extends StatefulWidget {
  @override
  _ViewAllReqstState createState() => _ViewAllReqstState();
}

class _ViewAllReqstState extends State<ViewAllReqst> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,

        title: Row(children: <Widget>[
          Text("View All Request"),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: SizedBox(
              width: 10,
            ),
          ),
          GestureDetector(child: Icon(Icons.arrow_back,size: 35,),onTap: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => Dashboard(),
              ),
            );
          },)

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
              RequestStream(),
            ],
          ),
        ),

      ),
    );
  }
}
class RequestStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('request').orderBy('timestamp',descending: true).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data.documents.reversed;
        List<RqstBubble> rqstBubbles = [];
        for (var message in messages) {
//String timecvrt=message.data['timestamp'].toString();
//int timec=int.parse(timecvrt);
          final mesemail = message.data['email'];
          final messfullnm = message.data['fullname'].toString();
          final messfunction = message.data['function'];
          final messjob = message.data['job'];
          final messphon = message.data['phone'];
          final messprpos = message.data['purpose'];
          final messstate = message.data['status'];


          final currentUser = email;

          final rqstBubble = RqstBubble(
              mesemail,
              messfunction,
              messfullnm,
              messprpos,
              messstate,
              messphon,
              messjob,messstate

          );

          rqstBubbles.add(rqstBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: rqstBubbles,
          ),
        );
      },
    );
  }
}
class RqstBubble extends StatefulWidget {
  rejectfunction()async{

  }
  acceptfunction()async{

  }
  final String memail,mfuncton,mfullname,mpurpose,mstatus,mphone,mjob,mstate;
  RqstBubble(this.memail, this.mfuncton, this.mfullname, this.mpurpose,
      this.mstatus, this.mphone, this.mjob,this.mstate);

  @override
  _RqstBubbleState createState() => _RqstBubbleState();
}

class _RqstBubbleState extends State<RqstBubble> {
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
                          Text("Request from: "+widget.memail),

                        ],
                        ),
                        Row(children: <Widget>[
                          Text("Fullname: "),
                          SizedBox(width: 15,),

                          Text(widget.mfullname),
                        ],
                        ),
                        Row(children: <Widget>[
                          Text("user job: "),
                          SizedBox(width: 15,),

                          Text(widget.mjob),
                        ],
                        ),
                        Row(children: <Widget>[
                          Text("user request for this role:"),
                          SizedBox(width: 15,),

                          Text(widget.mfuncton),
                        ],
                        ),
                        Text("user purpose "),

                        Container(child: Text(widget.mpurpose,softWrap:true,style: TextStyle(fontSize: 19,fontWeight: FontWeight.w400,fontStyle: FontStyle.italic),)),
                        Container(
                          width: screenDimen.width/2,

                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RaisedButton(child: Text("Accept"),
                                onPressed: (){

                                },),
                              SizedBox(width: 10,),

                              RaisedButton(
                                child: Text("Reject"),
                                onPressed: (){

                                },),
                            ],),
                        )

                      ],),
                  ),),),
            ),
          ),
        ],
      ),
    );
  }
}


class ViewRole extends StatefulWidget {
  @override
  _ViewRoleState createState() => _ViewRoleState();
}

class _ViewRoleState extends State<ViewRole> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

