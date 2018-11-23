import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_tuto1/news_details.dart';
import 'package:flutter_app_tuto1/technology_news.dart';
import 'package:http/http.dart' as http;
void main(){
  runApp(
    MaterialApp(
      home: MyApp() ,
      theme: ThemeData(
        primarySwatch: Colors.red
      ),
    )
  );
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {


  String baseUrl="https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fwww.voanews.com%2Fapi%2Fzyritequir";




  Future<List<Items>> getNews()async{

    return await http.get(baseUrl).then((res){

      TechnologyNews tn=TechnologyNews.fromJson(json.decode(res.body.toString()));

      return tn.items;

    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello"),
      ),
      body:FutureBuilder(builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.data==null){
          return Center(
            child: CircularProgressIndicator(),
          );
        }else{
          List<Items> items=snapshot.data;
          return PageView(
            children: items.map((i){

              return InkWell(
                onTap:(){
                  Navigator.of(context).push(MaterialPageRoute(builder:(context){
                    return NewsDetails(i);
                  }));
                },
                child: Container(
                    margin: EdgeInsets.only(top:100.0,bottom: 100.0,left: 50.0,right: 50.0),
                    child: Material(
                      elevation: 8.0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                        child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                            child: ClipRRect(
                              child: Material(
                                  child: Hero(
                                    tag: i.enclosure.link,
                                      child: Image.network(i.enclosure.link,fit: BoxFit.cover,),
                                  ),
                              elevation: 30.0,),
                              borderRadius: BorderRadius.circular(20.0),
                            )
                        ),

                        Expanded(
                          flex: 1,
                            child: Container(
                                child: Text(i.title,style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Colors.black
                                ),
                                  textAlign: TextAlign.center,
                                ),
                              alignment: Alignment.center,

                            )
                        ),
                      ],
                    )),
                ),
              );

            }).toList(),
          );



        }
      },
      future: getNews(),)
    );
  }
}












