import 'package:hive/hive.dart';

import 'DBHelper.dart';

class HiveDBHelper implements DBHelper {
  @override
  void addNewCounter() {
    var box = Hive.box("counter");
    box.add(0);
  }

  @override
  List<int> getListCounters() {
    List<int> list = [];
    var box = Hive.box("counter");
    for (int index = 0; index < box.values.length; index++) {
      list.add(box.getAt(index));
    }
    print(list);
    return list;
  }

  @override
  void changeCounterValue(int index, int change) {
    var box = Hive.box("counter");
    int i = box.getAt(index) ?? 0;
    i = i + change;
    box.putAt(index, i);
  }

  @override
  int getValue(int index) {
    var box = Hive.box("counter");
    int i = box.getAt(index);
    return i;
  }

  @override
  void deleteCounter(int index) {
    var box = Hive.box("counter");
    box.deleteAt(index);
  }
}
