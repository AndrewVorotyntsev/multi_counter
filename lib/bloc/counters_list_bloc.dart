import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_counter/db/DBHelper.dart';
import 'package:multi_counter/db/HiveDBHelper.dart';

import 'events/counters_list_events.dart';

class CountersListBloc extends Bloc<CountersListEvent, List<int>> {

  CountersListBloc() : super([]);

  @override
  Stream<List<int>> mapEventToState(CountersListEvent event) async* {

    DBHelper dbHelper = HiveDBHelper();

    if (event is AddNewCounterEvent) {
      dbHelper.addNewCounter();
      yield dbHelper.getListCounters();
    }

    else if (event is GetCountersEvent) {
      yield dbHelper.getListCounters();
    }

  }

}