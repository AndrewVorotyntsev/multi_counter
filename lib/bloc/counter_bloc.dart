import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_counter/db/db_helper.dart';
import 'package:multi_counter/model/counter_data.dart';

import 'events/counter_event.dart';

class CounterBloc extends Bloc<CounterEvent, List<CounterData>> {
  DBHelper dbHelper;

  CounterBloc(this.dbHelper) : super([]);

  @override
  Stream<List<CounterData>> mapEventToState(CounterEvent event) async* {
    if (event is AddNewCounterEvent) {
      dbHelper.addNewCounter(event.name, event.count);
      yield dbHelper.getListCounters();
    } else if (event is GetCountersEvent) {
      yield dbHelper.getListCounters();
    } else if (event is DeleteCounterEvent) {
      dbHelper.deleteCounter(event.index);
      yield dbHelper.getListCounters();
    } else if (event is ChangeValueEvent) {
      dbHelper.changeCounterValue(event.index, event.change);
      yield dbHelper.getListCounters();
    }
  }
}
