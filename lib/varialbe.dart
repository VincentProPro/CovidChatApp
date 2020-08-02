import 'package:flutter/material.dart';
import 'package:gtuc_covid19/articlePage.dart';

import 'articlList.dart';
import 'article.dart';

var dateini,stockInitial,statu,typeciment,quantiteSac,prixdeventeunit,prixdeventetotal,stockfinal;
Size screenDimen;
Container mainInfo;
var widthScreen= screenDimen.width;
var heightScreen= screenDimen.height;
var borderdeco= BoxDecoration(
  border: Border(

    top: BorderSide( //                    <--- top side
      color: Colors.blue[900],
      width: 4.0,
    ),

  ),
);

List<Article> article= new ArticleList().article;
Container doContainer(Article article, BuildContext context){
  return Container(

    child: GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ArticlePage(article)),
        );
      },
      child: Container(
        child: Column(children: <Widget>[
          Container(
              height: heightScreen/7.5,
              width: widthScreen/3.5,


              decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black26, offset: Offset(0,3),blurRadius: 6.0)],
              ),
              child: ClipOval(child: Image(

                image: AssetImage(article.photo),
                fit: BoxFit.cover,
              ),)),
          Text(article.name,style:TextStyle(
              fontWeight: FontWeight.w700
          )),
          Flexible(
            child: Container(
                height: 50,
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.black26, offset: Offset(0,0),blurRadius: 0)],

                    border: Border.all(color: Color(0xFF000000),width: 1.0,style: BorderStyle.solid)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left:10,right: 10),
                  child: Align(
                      alignment:Alignment.center,
                      child: Text(article.description,softWrap:true,textAlign: TextAlign.center,)),
                )),
          ),
        ]),
      ),
    ),
  );
}
List<Article> articles=new ArticleList().article;

Container buildContainer(Article article, List<Article> articles,BuildContext context) {
  return Container(

      child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.blue[900],width: 1.0, style:BorderStyle.solid),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              )),
          child: Column(
              children: <Widget>[
                SizedBox(height:15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                          width: widthScreen-20,
                          //height: 200,
                          child: Center(child: Text(article.name,softWrap:true,style: TextStyle(fontSize: 19,fontWeight: FontWeight.w400,fontStyle: FontStyle.italic),))),
                    )
                  ],
                ),
                SizedBox(height:25),

                Container(
                  //width: widthScreen/2,
                  child: Image.asset(article.photo),),
                SizedBox(height:25),

                Container(
                    width: widthScreen/1.3,
                    child: Text(article.content,softWrap:true,style: TextStyle(fontSize: 19,fontWeight: FontWeight.w400))),
                SizedBox(height:15),
                Container(
                    padding:EdgeInsets.only(right: 5,left: 25),
                    child: Text(article.ref,softWrap:true,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w200))),
                SizedBox(height:15),

                Container(width:widthScreen,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border(

                      top: BorderSide( //                    <--- top side
                        color: Colors.blue[900],
                        width: 4.0,
                      ),
                      left: BorderSide( //                    <--- top side
                        color: Colors.blue[900],
                        width: 4.0,
                      ),
                      right: BorderSide( //                    <--- top side
                        color: Colors.blue[900],
                        width: 4.0,
                      ),

                    ),
                  ),
                  child: Center(child: Text("View Menu")),),
                Container(
                  height: heightScreen/3,
                  width: widthScreen,
                  //color: Colors.blue,
                  child: GridView.count(crossAxisCount: 2,children:List.generate(articles.length, (index){
                    Article article= articles[index];
                    return doContainer(article,context);
                  })),
                )
              ]),
        ),
      )
  );
}

