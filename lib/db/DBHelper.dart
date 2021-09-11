import 'package:multi_counter/model/CounterData.dart';

//Название файла поменяй) оно не оостветствует стилистике языка.
abstract class DBHelper {
  void addNewCounter(String name, int count);

  List<CounterData> getListCounters();

  void changeCounterValue(int index, int change);

  CounterData getCounter(int index);

  void deleteCounter(int index);
}
