import 'package:flutter/material.dart';
import 'package:dailymedicaltrivia2/ui/CareerGUI.dart';
import 'package:dailymedicaltrivia2/ui/CareerPath.dart';
import 'package:dailymedicaltrivia2/bloc/User/UserBloc.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class CareerPage extends StatefulWidget {
  @override
  _CareerPageState createState() => _CareerPageState();
}

class _CareerPageState extends State<CareerPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<UserState>(
          stream: BlocProvider.of<UserBloc>(context).stateStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('An error occurred'));
            } else if (!snapshot.hasData) {
              return Center(child: Text(''));
            } else {
              if (snapshot.data.levels.length == 0) {
                return Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: const Color.fromRGBO(94, 148, 184, 1),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                );
              } else {
                UserBloc bloc = BlocProvider.of<UserBloc>(context);
                return Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                          color: const Color.fromRGBO(171, 202, 223, 1.0)),
                    ),
                    CareerPath(levels: snapshot.data.levels),
                    CareerGUI(),
                  ],
                );
              }
            }
          }),
    );
  }
}
