import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
String symbol = 'MSFT';
String apikey = 'QV0FGYM21GJG9GQ5';

Future<Post> fetchPost() async {
  final response =
      await http.get('https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=$symbol&interval=5min&apikey=$apikey');
  //https://jsonplaceholder.typicode.com/posts/1
  //https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=$symbol&interval=5min&apikey=$apikey
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    print(Post.fromJson(json.decode(response.body)));
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  // final int userId; // final means cannot be changed once assigned
  // final int id;
  // final String title;
  final String body;

  // Post({this.userId, this.id, this.title, this.body}); // normal constructor
  Post({this.body}); // normal constructor

 /*
    factory classes are used
    to create instances of subclasses (for example depending on the passed parameter
    to return a cached instance instead of a new one
    to prepare calculated values to forward them as parameters to a normal constructor so that final fields can be initialized with them. This is often used to work around limitations of what can be done in an initializer list of a normal constructor (like error handling).
 */
  factory Post.fromJson(Map<String, dynamic> json) { // factory is a static constructor, returns the same instance of the class it belongs to
    return Post(
      // userId: json['userId'],
      // id: json['id'],
      // title: json['title'],
      body: json['Time Series (5min)']['2019-06-28 16:00:00']['1. open'],
    );
  }
}

void main() => runApp(MyApp(post: fetchPost()));

class MyApp extends StatelessWidget {
  final Future<Post> post;

  MyApp({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text('Fetch Data Example'),
        // ),
        body: Center(
          child: FutureBuilder<Post>(
            future: fetchPost(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.body);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
