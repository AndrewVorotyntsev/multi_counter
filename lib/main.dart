import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_counter/pages/counter_list.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'bloc/counters_list_bloc.dart';
import 'bloc/events/counters_list_events.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("counter");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => CountersListBloc()..add(GetCountersEvent()),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: CounterListPage(),
        ));
  }
}
