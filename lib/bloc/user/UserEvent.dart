import 'package:flutter/foundation.dart';

abstract class UserEvent {

}

class UserEventLevelComplete extends UserEvent {
  final String levelID;
  final bool wasMastered;
  UserEventLevelComplete({this.levelID, this.wasMastered});
}
