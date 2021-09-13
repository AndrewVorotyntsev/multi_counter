import 'package:hive/hive.dart';

part 'counter_model.g.dart';

@HiveType(typeId: 0)
class CounterModel extends HiveObject {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late int count;
}
