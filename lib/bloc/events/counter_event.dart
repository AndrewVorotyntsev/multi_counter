abstract class CounterEvent {}

class GetCountersEvent extends CounterEvent {}

class ChangeValueEvent extends CounterEvent {
  int index;
  int change;
  ChangeValueEvent(this.index, this.change);
}

class AddNewCounterEvent extends CounterEvent {
  String name;
  int count;
  AddNewCounterEvent(this.name, this.count);
}

class DeleteCounterEvent extends CounterEvent {
  int index;

  DeleteCounterEvent(this.index);
}