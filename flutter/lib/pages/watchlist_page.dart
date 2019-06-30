import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:url_launcher/url_launcher.dart';

// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String symbol = 'MSFT';
String apikey = 'QV0FGYM21GJG9GQ5';
/*
We are taking one example in which, we will add a button and a card. The card consists of one widget called Text. 
So when a user clicks on a button, it will add a new item to the list. 
So the state of the list is changed, and flutter will update its UI, and we will see the lists on the mobile screen.
*/


Future<http.Response> _getStock() {
  return http.get('https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=$symbol&interval=5min&apikey=$apikey');
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body}); // definition?

  factory Post.fromJson(Map<String, dynamic> json) { //constructor
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

Future<Post> fetchPost() async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/posts/1');

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}



class WatchListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WatchListState();
  }
}

// class _WatchListState extends State<WatchListPage> {
//   Widget build(BuildContext context) {
//     return new Container(child: new Text("WatchList"));
//   }
// }

class _WatchListState extends State<WatchListPage> {
  List<String> _products = ['Laptop']; //initialise list
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold( // scaffold is some template
        // appBar: AppBar(title: Text('First app')), //top bar
        body: Column(children: [ //body
          Container( // container within the body
              margin: EdgeInsets.all(10.0),
              child: RaisedButton( // child of container
                  onPressed: () {
                    setState(() { // will set state on press ie add pc to list
                      _products.add("lol");
                    });
                  },
                  child: Text('Hello'))),
          Row( // literally one column, can add more later
              children: _products
                  .map((element) => Card( // map creates a new iterable after calling card function on each element in _products. essentially creating a card for each element
                        child: Column( //within the card there is a column
                          children: <Widget>[
                            Text(element)
                          ],
                        ),
                      ))
                  .toList()), // creates a list from the iterable map contains 
          Row( // literally one column, can add more later
              children: _products
                  .map((element) => Card( // map creates a new iterable after calling card function on each element in _products. essentially creating a card for each element
                        child: Column( //within the card there is a column
                          children: <Widget>[
                            Text(element)
                          ],
                        ),
                      ))
                  .toList()), // creates a list from the iterable map contains 
        ]),
      ),
    );
  }
}
