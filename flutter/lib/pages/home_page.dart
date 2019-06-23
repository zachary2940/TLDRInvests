import 'package:flutter/material.dart';
import 'package:tldrinvests/services/authentication.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:flutter/material.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:url_launcher/url_launcher.dart';

import './watchlist_page.dart' as watchlist_page;
import './portfolio_page.dart' as portfolio_page;
import './tldr_page.dart' as tldr_page;

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.onSignedOut})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final List<MyTabs> _tabs = [
    new MyTabs(title: "Watch List"),
    new MyTabs(title: "Portfolio"),
    new MyTabs(title: "TLDR")
  ];

  MyTabs handler;
  TabController controller;

  // FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  // void fcmSubscribe() {
  //   _firebaseMessaging.subscribeToTopic('all');
  // }
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 3, initialIndex: 1);
    handler = _tabs[1];
    controller.addListener(handleSelected);
    // _firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) {
    //     print('on message $message');
    //   },
    //   onResume: (Map<String, dynamic> message) {
    //     print('on resume $message');
    //   },
    //   onLaunch: (Map<String, dynamic> message) {
    //     print('on launch $message');
    //   },
    // );
    // _firebaseMessaging.requestNotificationPermissions(
    //     const IosNotificationSettings(sound: true, badge: true, alert: true));
    // _firebaseMessaging.getToken().then((token) {
    //   print(token);
    // });
    //   var initializationSettingsAndroid = new AndroidInitializationSettings('@mipmap/ic_launcher');
    //   var initializationSettingsIOS = new IOSInitializationSettings();
    //   var initializationSettings = new InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);

    //   flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    //   flutterLocalNotificationsPlugin.initialize(initializationSettings, selectNotification: onSelectNotification);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void handleSelected() {
    setState(() {
      handler = _tabs[controller.index];
    });
  }

  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // fcmSubscribe();
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('TLDRInvests'),
          actions: <Widget>[
            new FlatButton(
                child: new Text('Logout',
                    style: new TextStyle(fontSize: 17.0, color: Colors.white)),
                onPressed: _signOut)
          ],
        ),
        bottomNavigationBar: new Material(
            color: Colors.white,
            child: new TabBar(
                controller: controller,
                tabs: <Tab>[
                  new Tab(icon: new Icon(Icons.track_changes)),
                  new Tab(icon: new Icon(Icons.home)),
                  new Tab(icon: new Icon(Icons.short_text))
                ],
                indicatorColor: Colors.blue,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey)),
        body: Container(
          child: new TabBarView(controller: controller, children: <Widget>[
            new watchlist_page.WatchListPage(),
            new portfolio_page.PortfolioPage(),
            new tldr_page.TLDRPage()
          ]),
        ));
  }
}

//   Future onSelectNotification(String payload) async {
//     showDialog(
//       context: context,
//       builder: (_) {
//         return new AlertDialog(
//           title: Text("PayLoad"),
//           content: Text("Payload : $payload"),
//         );
//       },
//     );
//   }
// }

class MyTabs {
  final String title;
  MyTabs({this.title});
}
