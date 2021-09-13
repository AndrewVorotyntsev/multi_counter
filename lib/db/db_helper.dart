import 'package:multi_counter/model/counter_data.dart';

abstract class DBHelper {
  void addNewCounter(String name, int count);

  List<CounterData> getListCounters();

  void changeCounterValue(int index, int change);

  CounterData getCounter(int index);

  void deleteCounter(int index);
}
