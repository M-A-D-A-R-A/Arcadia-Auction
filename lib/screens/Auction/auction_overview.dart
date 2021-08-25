import 'package:arcadia/screens/Auction/auction_details.dart';
import 'package:arcadia/screens/Auction/auction_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuctionOverview extends StatefulWidget {
  static const routeName = '\auction-overview';
  @override
  _AuctionOverviewState createState() => _AuctionOverviewState();
}

class _AuctionOverviewState extends State<AuctionOverview> {
  int _currentIndex = 0;
  List<BottomNavigationBarItem> _item = [
    BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        label: "Home",
        backgroundColor: Colors.black),
    BottomNavigationBarItem(
        icon: Icon(Icons.query_stats_outlined),
        label: "Status",
        backgroundColor: Colors.black),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.person),
        label: "Profile",
        backgroundColor: Colors.black),
  ];

  static List<Widget> _tabs = <Widget>[
    AuctionHome(),
    AuctionDetails(),
    Center(
      child: Text('profile'),
    )
  ];

  void _onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      bottomNavigationBar: Material(
        elevation: 100,
        child: Container(
          height: 60,
          width: 600,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            child: BottomNavigationBar(
              items: _item,
              type: BottomNavigationBarType.shifting,
              currentIndex: _currentIndex,
              // selectedItemColor: Colors.white38,
              unselectedItemColor: Colors.white38,
              onTap: _onTapped,
              // backgroundColor: Colors.white38,
            ),
          ),
        ),
      ),
      body: _tabs[_currentIndex],
    );
  }
}
