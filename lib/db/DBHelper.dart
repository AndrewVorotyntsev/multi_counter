abstract class DBHelper {

  void addNewCounter();

  List<int> getListCounters();

  void changeCounterValue(int index, int change);

  int getValue(int index);

}