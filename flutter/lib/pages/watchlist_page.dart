import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'dart:convert' as convert;

String symbol = 'MSFT';
String apikey = 'QV0FGYM21GJG9GQ5';

// void _getStock() async {
//   var stock = await http.get('https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=MSFT&interval=5min&apikey=QV0FGYM21GJG9GQ5'));
//   return stock;

// }
class WatchListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WatchListState();
  }
}

class _WatchListState extends State<WatchListPage> {
  Widget build(BuildContext context) {
    return new Container(child: new Text("WatchList"));
  }
}
