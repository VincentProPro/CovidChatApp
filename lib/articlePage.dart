import 'package:flutter/material.dart';
import 'package:gtuc_covid19/article.dart';
import 'package:gtuc_covid19/varialbe.dart';

import 'chatfoder/welcome_screen.dart';

class ArticlePage extends StatefulWidget {
  Article article;
  ArticlePage(this.article);
  @override
  ArticlePage_State createState() => ArticlePage_State();
}

class ArticlePage_State extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    screenDimen=screenSize;
    return Scaffold(
      appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              IconButton(icon: Icon(Icons.account_circle),  onPressed: (){
                setState(() {
//DisplayWeb
                  //User user=new User(profileImageUrl: "images/gtucLogo.png",backgroundImageUrl: "images/gtucLogo.png",username: "username",email: "emai",role: "role");
                  //User user=new User(profileImageUrl: profileImageUrl,backgroundImageUrl: backgroundImageUrl,username: username,email: email,role: role);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WelcomeScreen()),
                  );
                });


              }),
              Text("GTUC CovidApp")
            ],
          ),
        ],
      )),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[

                buildContainer(widget.article,articles,context),
                Container(
                  height: 5,
                  child:null,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
