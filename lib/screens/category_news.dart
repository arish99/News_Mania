import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_mania/helper/news.dart';
import 'package:news_mania/model/article_model.dart';

import 'article_view.dart';

class CategoryNews extends StatefulWidget {
  var newsCategory;
  CategoryNews({@required this.newsCategory});
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  bool _loading = true;
  List<ArticleModel> categoryArticles = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategorieNews();
  }

  getCategorieNews() async {
    CategoryClass categoryClass = CategoryClass();
    await categoryClass.getCategoryNews(widget.newsCategory);
    categoryArticles = categoryClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'News',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Mania',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              )
            ],
          ),
          actions: [
            Opacity(
              opacity: 0.0,
              child: Container(
                child: Icon(Icons.save),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
              ),
            )
          ],
        ),
        body: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: categoryArticles.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return BlogTile(
                        imgUrl: categoryArticles[index].urltoImage,
                        title: categoryArticles[index].title,
                        desc: categoryArticles[index].description,
                        url: categoryArticles[index].url);
                  },
                ),
              ));
  }
}

class BlogTile extends StatelessWidget {
  final imgUrl, title, desc, url;
  BlogTile(
      {@required this.imgUrl,
      @required this.title,
      @required this.desc,
      @required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      blogUrl: url,
                    )));
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
        child: Container(
          margin: EdgeInsets.only(bottom: 16.0),
          child: Column(
            children: [
              ClipRRect(
                child: CachedNetworkImage(imageUrl: imgUrl),
                borderRadius: BorderRadius.circular(6.0),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                title,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                desc,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
