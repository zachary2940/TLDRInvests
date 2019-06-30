import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tldrinvests/bloc/authentication_bloc/bloc.dart';

import './watchlist_page.dart' as watchlist_page;
import './portfolio_page.dart' as portfolio_page;
import './tldr_page.dart' as tldr_page;
import './http_test.dart' as test;

class HomeScreen extends StatefulWidget {
  final String name;

  HomeScreen({Key key, @required this.name}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final List<MyTabs> _tabs = [
    new MyTabs(title: "Watch List"),
    new MyTabs(title: "Portfolio"),
    new MyTabs(title: "TLDR"),
    new MyTabs(title: "test")
  ];

  MyTabs handler;
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 4, initialIndex: 1);
    handler = _tabs[1];
    controller.addListener(handleSelected);
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

  @override
  Widget build(BuildContext context) {
    // fcmSubscribe();
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('TLDRInvests'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).dispatch(
                  LoggedOut(),
                );
              },
            )
          ],
        ),
        bottomNavigationBar: new Material(
            color: Colors.white,
            child: new TabBar(
                controller: controller,
                tabs: <Tab>[
                  new Tab(icon: new Icon(Icons.track_changes)),
                  new Tab(icon: new Icon(Icons.home)),
                  new Tab(icon: new Icon(Icons.short_text)),
                  new Tab(icon: new Icon(Icons.threesixty))
                ],
                indicatorColor: Colors.blue,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey)),
        body: Container(
          child: new TabBarView(controller: controller, children: <Widget>[
            new watchlist_page.WatchListPage(),
            new portfolio_page.PortfolioPage(),
            new tldr_page.TLDRPage(),
            new test.MyApp()
          ]),
        ));
  }
}

class MyTabs {
  final String title;
  MyTabs({this.title});
}
