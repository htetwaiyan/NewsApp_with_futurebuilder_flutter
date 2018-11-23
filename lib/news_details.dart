import 'package:flutter/material.dart';
import 'package:flutter_app_tuto1/technology_news.dart';


class NewsDetails extends StatelessWidget {

  final Items item;


  NewsDetails(this.item);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Details"),
      ),
      body: ListView(
        children: <Widget>[
          Hero(
            tag: item.enclosure.link,
              child: Image.network(item.enclosure.link,fit: BoxFit.cover,),
          ),
          Text(item.title,style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(item.pubDate),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(item.description),
          ),

        ],
      ),
    );
  }
}
