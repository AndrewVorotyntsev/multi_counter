import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_counter/db/DBHelper.dart';
import 'package:multi_counter/db/HiveDBHelper.dart';
import 'package:multi_counter/model/CounterData.dart';

import 'events/counter_events.dart';

class CounterBloc extends Bloc<CounterEvent, CounterData> {
  CounterBloc(CounterData initialState) : super(initialState);

  @override
  Stream<CounterData> mapEventToState(CounterEvent event) async* {
    DBHelper dbHelper = HiveDBHelper();

    if (event is ChangeValueEvent) {
      dbHelper.changeCounterValue(event.index, event.change);
      yield dbHelper.getCounter(event.index);
    }
  }
}
