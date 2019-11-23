import 'dart:convert';
import 'dart:ui' as prefix0;

import 'package:animal_farm/src/models/award.dart';
import 'package:animal_farm/src/widgets/bottomnav_widget.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:frideos/frideos.dart';
import 'package:geopattern_flutter/geopattern_flutter.dart';
import 'package:geopattern_flutter/patterns/triangles.dart';

import '../models/appstate.dart';

class AwardsPage extends StatelessWidget {

  AwardsPage({this.backgroundColor});

  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);
    final hash = sha1.convert(utf8.encode("1")).toString();
    final pattern = Triangles.fromHash(hash);
    appState.loadAwards();

    return Scaffold(
        bottomNavigationBar: BottomNavWidget(selectedIndex: 2),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          ),
          title: Text('Awards'),
        ),
        backgroundColor: backgroundColor,
        // drawer: DrawerWidget(),
        body: FadeInWidget(
            duration: 20,
            child: Container(
                child: CustomPaint(
                    size: Size(MediaQuery.of(context).size.width,
                        MediaQuery.of(context).size.height),
                    painter: FullPainter(
                        pattern: pattern,
                        background: Theme.of(context).backgroundColor),
                    child: new BackdropFilter(
                        filter: new prefix0.ImageFilter.blur(
                            sigmaX: 5.0, sigmaY: 0.0),
                        child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: ValueBuilder<List<Award>>(
                                streamed: appState.awardsStream,
                                noDataChild: const CircularProgressIndicator(),
                                builder: (context, snapshot) {
                                  return GridView.count(
                                    // Create a grid with 2 columns. If you change the scrollDirection to
                                    // horizontal, this produces 2 rows.
                                    crossAxisCount: 2,
                                    // Generate 100 widgets that display their index in the List.
                                    children: List.generate(15, (index) {
                                      Award award;
                                      if (index < snapshot.data.length) {
                                        award = snapshot.data[index];
                                      }

                                      return Container(
                                        margin: const EdgeInsets.all(10.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            if (award != null) {
                                              appState.awardInfo(
                                                  award, context);
                                            }
                                          },
                                          child: CircleAvatar(
                                            backgroundColor:
                                                Colors.white.withOpacity(0),
                                            backgroundImage: (award != null
                                                ? AssetImage(
                                                    'assets/images/badge/' +
                                                        award.image)
                                                : AssetImage(
                                                    'assets/images/badge/medal.png')),
                                          ),
                                        ),
                                      );
                                    }),
                                  );
                                })))))));
  }
}
