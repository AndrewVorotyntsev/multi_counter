import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_counter/db/DBHelper.dart';
import 'package:multi_counter/db/HiveDBHelper.dart';
import 'package:multi_counter/model/CounterData.dart';

import 'events/counter_event.dart';

class CounterBloc extends Bloc<CounterEvent, List<CounterData>> {
  CounterBloc() : super([]);

  @override
  Stream<List<CounterData>> mapEventToState(CounterEvent event) async* {
    DBHelper dbHelper = HiveDBHelper();

    if (event is AddNewCounterEvent) {
      dbHelper.addNewCounter(event.name, event.count);
      yield dbHelper.getListCounters();
    }
    else if (event is GetCountersEvent) {
      yield dbHelper.getListCounters();
    }
    else if (event is DeleteCounterEvent) {
      dbHelper.deleteCounter(event.index);
      yield dbHelper.getListCounters();
    }
    else if (event is ChangeValueEvent) {
      dbHelper.changeCounterValue(event.index, event.change);
      yield dbHelper.getListCounters();
    }
  }
}
