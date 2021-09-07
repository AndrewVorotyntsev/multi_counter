import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_counter/bloc/counter_bloc.dart';
import 'package:multi_counter/bloc/counters_list_bloc.dart';
import 'package:multi_counter/bloc/events/counters_list_events.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
        body: BlocBuilder<CountersListBloc, List<int>>(
          builder: (context, List<int> list) {
            if (list.isEmpty)
              return Center(
                child: Text("Добавьте счетчик"),
              );
            else {
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  int? res = list.elementAt(index);
                  return Dismissible(
                    key: UniqueKey(),
                    //key: ValueKey<int>(index), //TODO: не оставляйте комментарии без указания причин
                    child: ListTile(
                      title: Text("$res"),
                      onTap: () {
                        //TODO: создание MaterialPage - лучше в отдельный класс.
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
                      context.read<CountersListBloc>().add(DeleteCounterEvent(index));
                  },
                  );
                },
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              context.read<CountersListBloc>().add(AddNewCounterEvent()),
          tooltip: 'Add counter',
          child: Icon(Icons.add_circle_outline),
        ));
  }
}
