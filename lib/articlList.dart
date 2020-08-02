import 'package:gtuc_covid19/article.dart';

import 'mot/textdemot.dart';

class ArticleList{
  List<Article> article=[];

  ArticleList(){
    article.add(new Article(menuName1, menuDescrip1, menuContent1, menuRef1,menuPhoto1));
    article.add(new Article(menuName2, menuDescrip2, menuContent2, menuRef2,menuPhoto2));
    article.add(new Article(menuName3, menuDescrip3, menuContent3, menuRef3,menuPhoto3));
    article.add(new Article(menuName4, menuDescrip4, menuContent4, menuRef4,menuPhoto4));
    article.add(new Article(menuName5, menuDescrip5, menuContent5, menuRef5,menuPhoto5));

  }
}