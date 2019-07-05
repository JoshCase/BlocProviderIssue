import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:dailymedicaltrivia2/model/Level.dart';
import 'package:dailymedicaltrivia2/ui/pages/QuizPage.dart';
import 'package:dailymedicaltrivia2/bloc/Quiz/QuizBloc.dart';
import 'package:dailymedicaltrivia2/bloc/user/UserBloc.dart';

class StartLevelDialog extends StatelessWidget {
  final int index;
  final Level level;

  StartLevelDialog({this.index, this.level});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color.fromRGBO(15, 15, 15, 0.7),
          child: GestureDetector(
            onTap: () {},
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.width * 0.9 * 1.4,
                width: MediaQuery.of(context).size.width * 0.9,
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: <Widget>[
                        Text('Level ${index + 1}',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        Text(this.level.name, style: TextStyle(fontSize: 20)),
                      ],
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(171, 202, 223, 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        image: DecorationImage(
                          image: AssetImage(this.level.iconPath),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        QuizBloc quizBloc = QuizBloc.ofLevel(
                          level: this.level,
                          userBloc: BlocProvider.of<UserBloc>(context),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) {
                            //print('StartLevelDialog: MaterialPageRoute builder called.');
                            return BlocProvider<QuizBloc>(
                              bloc: quizBloc,
                              child: QuizPage(),
                            );
                          }),
                        );
                      },
                      child: Text('Play', style: TextStyle(fontSize: 20)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
