import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_counter/bloc/counters_list_bloc.dart';
import 'package:multi_counter/bloc/events/counters_list_events.dart';

import 'package:multi_counter/bloc/counter_bloc.dart';
import 'package:multi_counter/bloc/events/counter_events.dart';

class CounterPage extends StatefulWidget {
  int index;

  CounterPage({required this.index});

  @override
  State<StatefulWidget> createState() {
    return _CounterPageState(index: index);
  }
}

class _CounterPageState extends State<CounterPage> {
  int index;

  _CounterPageState({required this.index});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( //У тебя уже есть материал апп - зачем здесь второй?
      home: Scaffold(
        appBar: AppBar(
          title: Text("Counter"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              BlocBuilder<CounterBloc, int>(
                /* state: int count */
                builder: (BuildContext context, int count) {
                  return Center(
                    child: Text('$count', style: TextStyle(fontSize: 60)),
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: FloatingActionButton(
                heroTag: "addBtn",
                //onPressed: _incrementCounter,
                onPressed: () {
                  // эти две строки я бы связал по-другому: либо объединив в один блок, либо подписав один блок на другой.
                  context.read<CounterBloc>().add(ChangeValueEvent(index, 1));
                  context.read<CountersListBloc>().add(GetCountersEvent());
                }, //context.read<CounterBloc>().add(ChangeValueEvent(index, 1)),
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: FloatingActionButton(
                heroTag: "remBtn",
                //onPressed: _decrementCounter,
                onPressed: () {
                  // и с этими так же.
                  context.read<CounterBloc>().add(ChangeValueEvent(index, -1));
                  context.read<CountersListBloc>().add(GetCountersEvent());
                },
                tooltip: 'Increment',
                child: Icon(Icons.remove),
              ),
            ),
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
