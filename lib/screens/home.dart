import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_mania/helper/data.dart';
import 'package:news_mania/helper/news.dart';
import 'package:news_mania/model/article_model.dart';
import 'package:news_mania/model/category_model.dart';
import 'package:news_mania/screens/article_view.dart';
import 'package:news_mania/screens/category_news.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = [];
  List<ArticleModel> articles = [];
  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsObj = News();
    await newsObj.getNews();
    articles = newsObj.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: Row(
          children: [
            Text(
              'News',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Mania',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // This expanded container is for the category of news.
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      height: 70.0,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return CategoryTile(
                              imgUrl: categories[index].imageUrl,
                              categoryName: categories[index].categoryName,
                            );
                          }),
                    ),
                  ),
                  //This expanded container is for the news tile.
                  Expanded(
                    flex: 6,
                    child: Container(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: articles.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return BlogTile(
                            imgUrl: articles[index].urltoImage,
                            title: articles[index].title,
                            desc: articles[index].description,
                            url: articles[index].url,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final imgUrl, categoryName;
  CategoryTile({@required this.imgUrl, @required this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(
                      newsCategory: categoryName.toString().toLowerCase(),
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16.0),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: CachedNetworkImage(
                imageUrl: imgUrl,
                width: 120,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(6.0),
              ),
              alignment: Alignment.center,
              child: Text(
                categoryName,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
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
