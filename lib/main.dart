import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_counter/db/hive_db_helper.dart';
import 'package:multi_counter/pages/counter_list.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'bloc/counter_bloc.dart';
import 'bloc/events/counter_event.dart';
import 'bloc/theme_cubit.dart';
import 'db/counter_model.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CounterModelAdapter());
  await Hive.openBox<CounterModel>("counter");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeData>(builder: (_, theme) {
        return BlocProvider(
            create: (BuildContext context) =>
                CounterBloc(HiveDBHelper())..add(GetCountersEvent()),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: theme,
              home: CounterListPage(),
            ));
      }),
    );
  }
}
