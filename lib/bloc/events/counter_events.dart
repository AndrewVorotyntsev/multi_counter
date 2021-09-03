abstract class CounterEvent {}

class ChangeValueEvent extends CounterEvent {
  int index;
  int change;
  ChangeValueEvent(this.index, this.change);
}
