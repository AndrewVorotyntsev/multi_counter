import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_counter/bloc/counter_bloc.dart';
import 'package:multi_counter/bloc/events/counter_event.dart';
import 'package:multi_counter/model/CounterData.dart';

class CounterPage extends StatefulWidget {
  final int index;
  
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
    return BlocBuilder<CounterBloc, List<CounterData>>(
        builder: (context, List<CounterData> list) {
          CounterData data = list.elementAt(index);
          return Scaffold(
            appBar: AppBar(
              title: Text("Counter"),
            ),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child:
                        Text('${data.name}', style: TextStyle(fontSize: 40)),
                      ),
                      Center(
                        child:
                        Text('${data.count}', style: TextStyle(fontSize: 30)),
                      ),
                    ])),
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
                        onPressed: () {
                          context
                              .read<CounterBloc>()
                              .add(ChangeValueEvent(index, 1));
                        },
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
                            onPressed: () {
                              context
                                  .read<CounterBloc>()
                                  .add(ChangeValueEvent(index, -1));
                            },
                            child: Icon(Icons.remove),
                          ),
                        ))),
              ],
            ),
          );
        });
  }

  _createDialog(BuildContext context, int sign) {

    //BuildContext c = context;

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
                hintText: 'Не изменять',
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
                  context
                      .read<CounterBloc>()
                      .add(ChangeValueEvent(index, sign * int.parse(countController.text)));
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
