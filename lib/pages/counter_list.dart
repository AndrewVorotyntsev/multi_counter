import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_counter/bloc/counter_bloc.dart';
import 'package:multi_counter/bloc/counters_list_bloc.dart';
import 'package:multi_counter/bloc/events/counters_list_events.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_counter/model/CounterData.dart';

import 'counter_page.dart';

class CounterListPage extends StatefulWidget {
  @override
  _CounterListPageState createState() => _CounterListPageState();
}

class _CounterListPageState extends State<CounterListPage> {
  @override
  void dispose() async {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Сounters"),
        ),
        body: BlocBuilder<CountersListBloc, List<CounterData>>(
          builder: (context, List<CounterData> list) {
            if (list.isEmpty)
              return Center(
                child: Text("Добавьте счетчик"),
              );
            else {
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  CounterData? res = list.elementAt(index);
                  return Dismissible(
                    key: UniqueKey(),
                    //key: ValueKey<int>(index),
                    child: ListTile(
                      // Text("${res.name} ${res.name.isEmpty : } : ${res.count}"),
                      title: Text((() {
                        if (res.name.isEmpty) {
                          return "${res.count}";
                        } else {
                          return "${res.name} : ${res.count}";
                        }
                      })()),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                create: (BuildContext context) =>
                                    CounterBloc(res),
                                child: CounterPage(index: index))));
                      },
                    ),
                    background: Container(
                      color: Colors.grey[200],
                    ),
                    onDismissed: (DismissDirection direction) {
                      context
                          .read<CountersListBloc>()
                          .add(DeleteCounterEvent(index));
                    },
                  );
                },
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => createDialog(context),
          tooltip: 'Add counter',
          child: Icon(Icons.add_circle_outline),
        ));
  }

  createDialog(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Название"),
            content: TextField(
              decoration :
              InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Без названия',
              ),
              controller: controller,
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
                      .read<CountersListBloc>()
                      .add(AddNewCounterEvent(controller.text));
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
