import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_counter/bloc/counters_list_bloc.dart';
import 'package:multi_counter/bloc/events/counters_list_events.dart';

import 'package:multi_counter/bloc/counter_bloc.dart';
import 'package:multi_counter/bloc/events/counter_events.dart';
import 'package:multi_counter/model/CounterData.dart';

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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Counter"),
        ),
        body: BlocBuilder<CounterBloc, CounterData>(
          /* state: int count */
          builder: (BuildContext context, CounterData count) {
            return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child:
                        Text('${count.name}', style: TextStyle(fontSize: 40)),
                  ),
                  Center(
                    child:
                        Text('${count.count}', style: TextStyle(fontSize: 30)),
                  ),
                ]));
          },
        ),
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: GestureDetector(
                onLongPress: () {
                  _createDialog(context, 1);
                },
                child: InkWell(
                  splashColor: Colors.blue,
                  child: FloatingActionButton(
                    heroTag: "addBtn",
                    //onPressed: _incrementCounter,
                    onPressed: () {
                      context
                          .read<CounterBloc>()
                          .add(ChangeValueEvent(index, 1));
                      context.read<CountersListBloc>().add(GetCountersEvent());
                    }, //context.read<CounterBloc>().add(ChangeValueEvent(index, 1)),
                    //tooltip: 'Increment',
                    child: Icon(Icons.add),
                  ),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: GestureDetector(
                    onLongPress: () {
                      _createDialog(context, -1);
                    },
                    child: InkWell(
                      splashColor: Colors.blue,
                      child: FloatingActionButton(
                        heroTag: "remBtn",
                        //onPressed: _decrementCounter,
                        onPressed: () {
                          context
                              .read<CounterBloc>()
                              .add(ChangeValueEvent(index, -1));
                          context
                              .read<CountersListBloc>()
                              .add(GetCountersEvent());
                        },
                        child: Icon(Icons.remove),
                      ),
                    ))),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _createDialog(BuildContext context, int sign) {

    BuildContext c = context;

    // context
    //     .read<CounterBloc>()
    //     .add(ChangeValueEvent(index, 100 * sign));

    TextEditingController countController = TextEditingController();
    countController.text = "${1}";

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text((() {
              if (sign == 1) {
                return "Увеличить счет";
              } else {
                return "Уменьшить счет";
              }
            })()),
            content: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "",
                border: OutlineInputBorder(),
                hintText: 'Не увеличивать',
              ),
              controller: countController,
            ),
            actions: <Widget>[
              MaterialButton(
                child: Text("Назад"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              MaterialButton(
                child: Text("Ок"),
                onPressed: () {
                  c
                      .read<CounterBloc>()
                      .add(ChangeValueEvent(index, int.parse(countController.text) * sign));
                  c
                      .read<CountersListBloc>()
                      .add(GetCountersEvent());
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
