import 'package:hive/hive.dart';
import 'package:multi_counter/db/counter_model.dart';
import 'package:multi_counter/model/CounterData.dart';

import 'DBHelper.dart';

//Название файла поменяй) оно не оостветствует стилистике языка.
class HiveDBHelper implements DBHelper {
  @override
  void addNewCounter(String name, int count) {
    var box = Hive.box<CounterModel>("counter"); //box  можно открыть один раз и использовать после.
    CounterModel counterModel = CounterModel()
      ..name = name
      ..count = count;
    box.add(counterModel);
  }

  @override
  List<CounterData> getListCounters() {
    List<CounterData> list = [];
    var box = Hive.box<CounterModel>("counter");
    for (int index = 0; index < box.values.length; index++) {
      CounterModel? counterModel = box.getAt(index);
      CounterData counterData =
          CounterData(counterModel!.name, counterModel.count);
      list.add(counterData);
    }
    return list;
  }

  @override
  void changeCounterValue(int index, int change) {
    var box = Hive.box<CounterModel>("counter");
    CounterModel? counterModel = box.getAt(index);
    counterModel!.count = counterModel.count + change;
    counterModel.save();
  }

  @override
  CounterData getCounter(int index) {
    var box = Hive.box<CounterModel>("counter");
    CounterModel? counterModel = box.getAt(index);
    CounterData counterData = CounterData(counterModel!.name, counterModel.count);
    return counterData;
  }

  @override
  void deleteCounter(int index) {
    var box = Hive.box<CounterModel>("counter");
    box.deleteAt(index);
  }
}
