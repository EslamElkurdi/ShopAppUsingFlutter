abstract class CounterStates {}

class CounterInitialState extends CounterStates {}

class CounterPlusState extends CounterStates {}

class CounterMinusState extends CounterStates {
  int Counter = 0;

  CounterMinusState(this.Counter);
}
