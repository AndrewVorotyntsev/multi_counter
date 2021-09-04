import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_counter/db/DBHelper.dart';
import 'package:multi_counter/db/HiveDBHelper.dart';
import 'package:multi_counter/model/CounterData.dart';

import 'events/counters_list_events.dart';

class CountersListBloc extends Bloc<CountersListEvent, List<CounterData>> {
  CountersListBloc() : super([]);

  @override
  Stream<List<CounterData>> mapEventToState(CountersListEvent event) async* {
    DBHelper dbHelper = HiveDBHelper();

    if (event is AddNewCounterEvent) {
      dbHelper.addNewCounter(event.name);
      yield dbHelper.getListCounters();
    } else if (event is GetCountersEvent) {
      yield dbHelper.getListCounters();
    } else if (event is DeleteCounterEvent) {
      dbHelper.deleteCounter(event.index);
      yield dbHelper.getListCounters();
    }
  }
}
