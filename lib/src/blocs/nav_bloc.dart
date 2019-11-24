import 'package:frideos_core/frideos_core.dart';

import '../models/models.dart';

const refreshTime = 100;

class NavBloc {
  NavBloc({this.stopwatchStream, this.tabController});

  // STREAMS
  final StreamedValue<AppTab> tabController;

  final StreamedTransformed<String, String> stopwatchStream;
  String timer;

  void dispose() {
    tabController.dispose();
  }
}
