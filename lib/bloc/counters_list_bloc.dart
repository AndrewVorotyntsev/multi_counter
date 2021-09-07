import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_counter/db/DBHelper.dart';
import 'package:multi_counter/db/HiveDBHelper.dart';

import 'events/counters_list_events.dart';

//TODO: Про блоки в целом - думаю тут пойдет сделать один блок. Единый для всей логики работы со счетчиком.
class CountersListBloc extends Bloc<CountersListEvent, List<int>> {
  CountersListBloc() : super([]);

  @override
  Stream<List<int>> mapEventToState(CountersListEvent event) async* {
    DBHelper dbHelper = HiveDBHelper(); //и у тебя тут (и аналогично в другом блоке) потенциально баг при расширении : 
    // у тебя два разных экземпляра хелпера в блоках. Если вдруг будешь что-то зранить в нем - баг искать будешь долго. )

    if (event is AddNewCounterEvent) {
      dbHelper.addNewCounter();
      yield dbHelper.getListCounters();
    } else if (event is GetCountersEvent) {
      yield dbHelper.getListCounters();
    } else if (event is DeleteCounterEvent) {
      dbHelper.deleteCounter(event.index);
      yield dbHelper.getListCounters();
    }
  }
}
