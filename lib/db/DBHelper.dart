import 'package:multi_counter/model/CounterData.dart';

abstract class DBHelper {
  void addNewCounter(String name) ;

  List<CounterData> getListCounters();

  void changeCounterValue(int index, int change);

  CounterData getCounter(int index);

  void deleteCounter(int index);
}
