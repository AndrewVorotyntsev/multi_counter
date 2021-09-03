abstract class CountersListEvent {}

class GetCountersEvent extends CountersListEvent {}

class AddNewCounterEvent extends CountersListEvent {}

class DeleteCounterEvent extends CountersListEvent {
  int index;

  DeleteCounterEvent(this.index);
}
