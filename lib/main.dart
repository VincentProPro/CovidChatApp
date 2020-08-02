import 'package:flutter/material.dart';
import 'package:gtuc_covid19/article.dart';
import 'package:gtuc_covid19/articlePage.dart';
import 'package:gtuc_covid19/chatfoder/chat_screen.dart';
import 'package:gtuc_covid19/varialbe.dart';
import 'package:gtuc_covid19/widgetPacket/reportPage.dart';
import 'package:splashscreen/splashscreen.dart';


import 'chatfoder/login_screen.dart';
import 'chatfoder/registration_screen.dart';
import 'chatfoder/welcome_screen.dart';
import 'mot/textdemot.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
        debugShowCheckedModeBanner:false,
      home: new SplashScreen(
    seconds: 2,
    navigateAfterSeconds: new MyHomePage(),
    title: new Text('Welcome to GtucCovidApp',
    style: new TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20.0
    ),),
    image: new Image.asset('images/gtucLogo.png'),
    backgroundColor: Colors.white,
    styleTextUnderTheLoader: new TextStyle(),
    photoSize: 100.0,
    onClick: ()=>print("Flutter Egypt"),
    loaderColor: Colors.red
    ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;


  //ArticleList articleList=new ArticleList();
  //List<Article> articles=new ArticleList().article;

  List<Container> createcontainer() {

    List<Container>containerlist=[];
    for (Article a in articles){
      Container container=Container(
        padding: EdgeInsets.all(2),
        child: RaisedButton(
          splashColor:Colors.blue[900],
            elevation:15,
          color: Colors.lightBlueAccent,
          onPressed: (){
setState(() {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => ArticlePage(a)),
  );
});
          },
          child: Text(a.name),
        ),
      );
      containerlist.add(container);

    }

    return containerlist;
  }
Article art=new Article(menuName6, menuDescrip6, menuContent6, menuRef6,menuPhoto6);

  @override
  Widget build(BuildContext context) {
    //savePref(1, "aaaa@gmail.com","monusername", "user","images/gtucLogo.png","images/gtucLogo.png");
    //getPreffromConstant();
    final Size screenSize = MediaQuery.of(context).size;
    screenDimen=screenSize;
     //mainInfo= buildContainer(art);

    createcontainer();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Column(
            children: <Widget>[
              SizedBox(
                height:15,
              ),
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WelcomeScreen()),
                        );
                      });

                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[900],
                        shape: BoxShape.circle,

                      ),
                      child:Icon(Icons.account_circle,size: 35,color: Colors.blue,),
                    ),
                  ),
                  SizedBox(width: 15,),
                  Text("GTUC CovidApp"),


                ],
              ),

            ],
          )
        ),
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        child:Padding(
                          padding: const EdgeInsets.only(right:10,left:10),
                          child: Text("Menu >>",style: TextStyle(fontSize: 20,color: Colors.blue[900]),),
                        )
                    ),
                    Expanded(
                      child: Container(
                        width: screenSize.width/1.2,

                        child:  SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: createcontainer(),
                          ),
                        ),
                      ),
                    )
                    ,
                    SizedBox(width: 15,)
                  ],),
                buildContainer(art,articles,context),
                Container(
                  height: 5,
                  child:null,
                ),


              ],
            )
          ],
        ),
        floatingActionButton:  Container(
          width: 60,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FloatingActionButton(
                onPressed: (){
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HelpAndReport()),
                    );
                  });
                },
                tooltip: 'Get help',
                child: Icon(Icons.help,size: 35),
                heroTag: null,
              ),
              FloatingActionButton(
                heroTag: null,

                onPressed: (){
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WelcomeScreen()),
                    );
                  });
                },
                tooltip: 'Chat and release your stress',
                child: Icon(Icons.chat,size: 35),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
