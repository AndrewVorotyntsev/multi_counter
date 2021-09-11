import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_counter/bloc/counter_bloc.dart';
import 'package:multi_counter/bloc/events/counter_event.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_counter/theme/theme_cubit.dart';
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

  // разбей метод на отдельные виджеты, их сделай приватными в рамках файла.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: ThemeCubit.isLight ? Icon(Icons.brightness_5) : Icon(Icons.brightness_3_rounded),
              tooltip: 'Поменять тему',
              onPressed: () {
                 context.read<ThemeCubit>().toggleTheme();
              },
            ),
          ],
          title: Text("Сounters"),
        ),
        body: BlocBuilder<CounterBloc, List<CounterData>>(
          builder: (context, List<CounterData> list) {
            if (list.isEmpty)
              return Center(
                child: Text("Добавьте счетчик"),
              );
            else {
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  CounterData? res = list.elementAt(index); // давай осмысленные названия переменным. res - в данном случае непонятен.
                  return Dismissible(
                    key: UniqueKey(),
                    child: ListTile(
                      title: Text((() {
                        if (res.name.isEmpty) {
                          return "${res.count}";
                        } else {
                          return "${res.name} : ${res.count}";
                        }
                      })()),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CounterPage(index: index)));
                      },
                    ),
                    background: Container(
                      color: Colors.grey[200],
                    ),
                    onDismissed: (DismissDirection direction) {
                      context
                          .read<CounterBloc>()
                          .add(DeleteCounterEvent(index));
                    },
                  );
                },
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _createDialog(context),
          tooltip: 'Add counter',
          child: Icon(Icons.add_circle_outline),
        ));
  }

//куда пропал возвращаемый тип?
  _createDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController countController = TextEditingController();
    countController.text = "${0}";

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Новый счетчик"),
            content: FractionallySizedBox(
              heightFactor: 0.5,
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Название",
                      border: OutlineInputBorder(),
                      hintText: 'Без названия',
                    ),
                    controller: nameController,
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Счет",
                      border: OutlineInputBorder(),
                      hintText: '0',
                    ),
                    controller: countController,
                  ),
                ],
              ),
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
                      .add(AddNewCounterEvent(nameController.text.trim(), int.parse(countController.text.trim())));
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
