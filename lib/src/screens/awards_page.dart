
import 'package:animal_farm/src/models/award.dart';
import 'package:animal_farm/src/widgets/bottomnav_widget.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:frideos/frideos.dart';

import '../models/appstate.dart';

class AwardsPage extends StatelessWidget {

  AwardsPage({this.backgroundColor});
  final FlareControls _controls = FlareControls();
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);
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
                                    crossAxisCount: 3,
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
                                          child:  (award != null
                                                ?
                                            FlareActor('assets/images/badge/' +
                                                award.image+'.flr',
                                                alignment:Alignment.center,
                                                fit:BoxFit.contain,
                                                controller: _controls,
                                                animation: award.image,
                                                color: Colors.lime,
                                                isPaused:false
                                            )  :
                                          CircleAvatar(
                                              backgroundColor:
                                              Colors.white.withOpacity(0),
                                              backgroundImage:
                                          AssetImage(
                                                    'assets/images/badge/medal.png')
                                          )
                                          )
                                        )
                                          );}
                                        )
                                      );
                                    }),
                                  ))
                                );
  }
}
