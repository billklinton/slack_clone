import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:slack_clone/blocs/workspaces_bloc.dart';
import 'package:slack_clone/home_page.dart';

void main() => runApp(BlocProvider(
      child: MyApp(),
      blocs: [Bloc((i) => WorkspacesBloc())],
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Slack Clone',
        theme: ThemeData(
            primaryColorDark: Color.fromARGB(255, 43, 0, 44),
            primaryColor: Color.fromARGB(255, 63, 14, 64),
            primaryColorLight: Color.fromARGB(255, 52, 11, 51),
            accentColor: Color.fromARGB(255, 92, 50, 92),
            textTheme: TextTheme(body1: TextStyle(color: Colors.white))),
        home: HomePage());
  }
}
