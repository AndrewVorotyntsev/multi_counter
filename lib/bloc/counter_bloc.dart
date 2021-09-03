import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_counter/db/DBHelper.dart';
import 'package:multi_counter/db/HiveDBHelper.dart';

import 'events/counter_events.dart';

class CounterBloc extends Bloc<CounterEvent, int>{

  CounterBloc(int initialState) : super(initialState);

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {

    DBHelper dbHelper = HiveDBHelper();

    if (event is ChangeValueEvent) {
      dbHelper.changeCounterValue(event.index, event.change);
      yield dbHelper.getValue(event.index);
    }
  }

}