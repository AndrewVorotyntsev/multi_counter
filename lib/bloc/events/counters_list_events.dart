abstract class CountersListEvent {}

class GetCountersEvent extends CountersListEvent {}

class AddNewCounterEvent extends CountersListEvent {
  String name;
  AddNewCounterEvent(this.name);
}

class DeleteCounterEvent extends CountersListEvent {
  int index;

  DeleteCounterEvent(this.index);
}
