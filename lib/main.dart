import 'package:flutter/material.dart';
import 'package:dailymedicaltrivia2/ui/pages/PrePlayPage.dart';
import 'package:dailymedicaltrivia2/ui/pages/CareerPage.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:dailymedicaltrivia2/data/UserRepository.dart';
import 'package:dailymedicaltrivia2/data/AppDatabaseProvider.dart';
import 'package:dailymedicaltrivia2/data/database/AppDatabase.dart';
import 'package:dailymedicaltrivia2/data/DMTAPIProvider.dart';
import 'package:dailymedicaltrivia2/data/LocalJsonProvider.dart';
import 'package:dailymedicaltrivia2/bloc/User/UserBloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserBloc userBloc;

  _MyAppState() {
    UserRepository _userRepository = UserRepository(
      apiProvider: DMTAPIProvider(),
      dbProvider: AppDatabaseProvider(database: AppDatabase('data.db')),
      jsonProvider: LocalJsonProvider(),
    );
    userBloc = UserBloc(repository: _userRepository);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      bloc: userBloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => PrePlayPage(),
          '/career': (context) => CareerPage(),
        },
        title: 'Daily Medical Trivia',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          highlightColor: Colors.white,
          fontFamily: 'Montserrat',
        ),
      ),
    );
  }
}
