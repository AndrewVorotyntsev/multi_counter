abstract class CountersListEvent {}

class GetCountersEvent extends CountersListEvent {}

class AddNewCounterEvent extends CountersListEvent {
  String name;
  int count;
  AddNewCounterEvent(this.name, this.count);
}

class DeleteCounterEvent extends CountersListEvent {
  int index;

  DeleteCounterEvent(this.index);
}
