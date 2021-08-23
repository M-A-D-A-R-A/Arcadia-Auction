import 'package:arcadia/provider/auth.dart';
import 'package:arcadia/provider/player.dart';
import 'package:arcadia/provider/players.dart';
import 'package:arcadia/screens/Auction/auction_resell_player.dart';
import 'package:arcadia/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auction_player.dart';

class AuctionHome extends StatefulWidget {
  static const routeName = '/auction-home';
  @override
  _AuctionHomeState createState() => _AuctionHomeState();
}

class _AuctionHomeState extends State<AuctionHome> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<Players>(context).fetchAndSetPlayers();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.deepPurpleAccent,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () async {
                await Provider.of<Auth>(context, listen: false).signOut();
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                  return SignInScreen();
                }), (route) => false);
              },
              icon: Icon(Icons.arrow_forward),
              label: Text('Sign Out'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Player? nextPlayer =
                    Provider.of<Players>(context, listen: false).getNextPlayer;
                if (nextPlayer != null) {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return AuctionPlayer();
                  // }));

                  Navigator.of(context).pushNamed(
                    AuctionPlayer.routeName,
                    arguments: nextPlayer,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('No Players available, try reselling!!'),
                    ),
                  );
                }
              },
              icon: Icon(Icons.arrow_forward),
              label: Text('Start Auction'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Player? nextPlayer =
                    Provider.of<Players>(context, listen: false)
                        .getNextResellPlayer;
                if (nextPlayer != null) {
                  Navigator.of(context).pushNamed(
                    AuctionPlayerResell.routeName,
                    arguments: nextPlayer,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('All Players reselled or sold'),
                    ),
                  );
                }
              },
              icon: Icon(Icons.arrow_forward),
              label: Text('Resell'),
            ),
          ],
        ),
      ),
    );
  }
}
