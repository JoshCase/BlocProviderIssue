import 'package:dailymedicaltrivia2/model/Question.dart';

class Level {
  final bool isComplete;
  final String iconAlias;
  final String iconPath;
  final String id;
  final bool isMastered;
  final String name;
  final int orderInSequence;
  final int passMark;
  final List<Question> questions;
  final int questionTimeLimit;
  final int totalTimeLimit;

  Level({
    this.iconAlias = '',
    this.isComplete = false,
    this.id = 'testID',
    this.isMastered = false,
    this.name = 'LevelName',
    this.orderInSequence = 0,
    this.passMark = 1,
    this.questions = const [],
    this.questionTimeLimit = 0,
    this.totalTimeLimit = 0,
  }) : this.iconPath = _getIconPathFromIconAlias(iconAlias);

  Level.fromJson(json)
      : this.isComplete = false,
        this.isMastered = false,
        assert(json['icon-alias'] != null),
        this.iconAlias = json['icon-alias'],
        this.iconPath = _getIconPathFromIconAlias(json['icon-alias']),
        assert(json['id'] != null),
        this.id = json['id'],
        assert(json['name'] != null),
        this.name = json['name'],
        assert(json['order-in-sequence'] != null),
        this.orderInSequence = json['order-in-sequence'],
        assert(json['pass-mark'] != null),
        this.passMark = json['pass-mark'],
        this.questions = _loadQuestionsFromJson(json),
        assert(json['question-time-limit'] != null),
        this.questionTimeLimit = json['question-time-limit'],
        assert(json['total-time-limit'] != null),
        this.totalTimeLimit = json['total-time-limit'];

  static List<Question> _loadQuestionsFromJson(json) {
    assert(json['questions'] != null);
    List<Question> _levels = [];
    json['questions'].forEach((q) {
      _levels.add(Question.fromJson(q));
    });
    return _levels;
  }

  static String _getIconPathFromIconAlias(String _iconAlias) {
    List<Map<String, String>> _knownIconPaths = knownIconPaths();
    String _iconPath = 'assets/levelicons/default.png';
    _knownIconPaths.forEach((path) {
      if (path.containsKey(_iconAlias)) {
        _iconPath = path[_iconAlias];
      }
    });
    return _iconPath;
  }

  static List<Map<String, String>> knownIconPaths() {
    return [
      {'Anaesthetics': 'assets/levelicons/anaesthetics.png'},
      {'Cardiology': 'assets/levelicons/cardiology.png'},
      {'Dermatology': 'assets/levelicons/dermatology.png'},
      {'Endocrinology': 'assets/levelicons/endocrinology.png'},
      {'Gastroenterology': 'assets/levelicons/gastroenterology.png'},
      {'Haematology': 'assets/levelicons/haematology.png'},
      {'InfectiousDisease': 'assets/levelicons/infectiousdisease.png'},
      {'Nephrology': 'assets/levelicons/nephrology.png'},
      {'Neurology': 'assets/levelicons/neurology.png'},
      {'Obstetrics': 'assets/levelicons/obstetrics.png'},
      {'Ophthalmology': 'assets/levelicons/ophthalmology.png'},
      {'Orthopaedics': 'assets/levelicons/orthopaedics.png'},
      {'Paediatrics': 'assets/levelicons/paediatrics.png'},
      {'Psychiatry': 'assets/levelicons/psychiatry.png'},
      {'ReproductiveMedicine': 'assets/levelicons/reproductivemedicine.png'},
      {'Respiratory': 'assets/levelicons/respiratory.png'},
    ];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> _map = {};
    _map['id'] = this.id;
    _map['icon_alias'] = this.iconAlias;
    _map['is_complete'] = this.isComplete ? 1 : 0;
    _map['is_mastered'] = this.isMastered ? 1 : 0;
    _map['name'] = this.name;
    _map['order_in_sequence'] = this.orderInSequence;
    _map['pass_mark'] = this.passMark;
    _map['question_time_limit'] = this.questionTimeLimit;
    _map['total_time_limit'] = this.totalTimeLimit;
    return _map;
  }

}
