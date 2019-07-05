import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:dailymedicaltrivia2/data/UserRepository.dart';
import 'package:dailymedicaltrivia2/model/Level.dart';
import 'UserEvent.dart';
export 'UserEvent.dart';
import 'UserState.dart';
export 'UserState.dart';

class UserBloc extends Bloc {
  final UserRepository repository;

  List<Level> levels = [];
  final _stateController = BehaviorSubject.seeded(
    UserState(
      levels: [],
    ),
  );
  final _eventController = StreamController<UserEvent>();

  UserBloc({@required this.repository}) {
    repository.levelStream
        .listen((list) {
          this.levels = list;
          _pushUserState();
    }, onDone: () {}, onError: (error) {});
    _listenToEventStream();
  }

  Sink get eventSink => _eventController.sink;
  Stream get stateStream => _stateController.stream;

  void _listenToEventStream() {
    _eventController.stream.listen((event) {
      print('User event received!');
    });
  }

  void _pushUserState() {
    UserState _userState = UserState(levels: this.levels);
    _stateController.sink.add(_userState);
  }

  dispose() async {
    _eventController.close();
    _stateController.close();
  }
}
