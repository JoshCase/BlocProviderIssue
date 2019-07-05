import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:dailymedicaltrivia2/bloc/user/UserBloc.dart';
import 'package:dailymedicaltrivia2/model/Level.dart';
import 'package:dailymedicaltrivia2/ui/dialogs/StartLevelDialog.dart';

class CareerPath extends StatefulWidget {
  final List<Level> levels;

  CareerPath({
    @required this.levels,
  });

  @override
  _CareerPathState createState() => _CareerPathState();
}

class _CareerPathState extends State<CareerPath> {
  List<PathChunk> _chunks;

  @override
  Widget build(BuildContext context) {
    UserBloc bloc = BlocProvider.of<UserBloc>(context);
    _chunks = _createChunks(widget.levels);
    return ListView.builder(
        physics: ClampingScrollPhysics(),
        reverse: true,
        itemCount: _chunks.length,
        itemBuilder: (context, i) {
          return _chunks[i];
        });
  }

  List<PathChunk> _createChunks(List<Level> _levels) {
    int _levelsPerChunk = 32;
    int _indexOffset = 0;
    int _deepestCompletedIndex = _indexOfDeepestCompletedLevel();
    _chunks = [];
    while (_levels.length > 0) {
      if (_levels.length > _levelsPerChunk) {
        _chunks.add(PathChunk(
          deepestCompletedIndex: _deepestCompletedIndex,
          indexOffset: _indexOffset,
          levels: _levels.sublist(0, _levelsPerChunk),
        ));
        _levels = _levels.sublist(_levelsPerChunk + 1);
        _indexOffset = _indexOffset + _levelsPerChunk;
      } else {
        _chunks.add(PathChunk(
          deepestCompletedIndex: _deepestCompletedIndex,
          indexOffset: _indexOffset,
          levels: _levels.sublist(0),
        ));
        _levels = [];
      }
    }
    return _chunks;
  }

  int _indexOfDeepestCompletedLevel() {
    int _index = 0;
    widget.levels.forEach((level) {
      if (level.isComplete | level.isMastered) {
        _index++;
      }
    });
    return _index;
  }
}

class PathChunk extends StatelessWidget {
  final double _chunkHeight = 600;
  final int deepestCompletedIndex;
  final int indexOffset;
  final int lineOfSight = 3;
  final List<Level> levels;

  final List<LevelHubLocation> _hubLocations = [
    LevelHubLocation(45, 4),
    LevelHubLocation(70, 3.5),
    LevelHubLocation(90, 6),
    LevelHubLocation(87, 19),
    LevelHubLocation(67, 20),
    LevelHubLocation(47, 18),
    LevelHubLocation(24, 18),
    LevelHubLocation(4, 26),
    LevelHubLocation(17, 37),
    LevelHubLocation(39, 35),
    LevelHubLocation(60, 33),
    LevelHubLocation(84, 34),
    LevelHubLocation(100, 44),
    LevelHubLocation(88, 52),
    LevelHubLocation(67, 49),
    LevelHubLocation(46, 47),
    LevelHubLocation(27, 53),
    LevelHubLocation(47, 60),
    LevelHubLocation(72, 58),
    LevelHubLocation(95, 62),
    LevelHubLocation(88, 75),
    LevelHubLocation(63, 73),
    LevelHubLocation(32, 68),
    LevelHubLocation(8, 71),
    LevelHubLocation(4, 85),
    LevelHubLocation(26, 88),
    LevelHubLocation(48, 86),
    LevelHubLocation(70, 83),
    LevelHubLocation(70, 83),
    LevelHubLocation(95, 83),
    LevelHubLocation(92, 96),
    LevelHubLocation(72, 95),
    LevelHubLocation(50, 95),
    LevelHubLocation(35, 100),
  ];

  PathChunk({
    @required this.deepestCompletedIndex,
    @required this.levels,
    @required this.indexOffset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _chunkHeight,
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Color.fromRGBO(94, 148, 184, 1),
          ),
          _buildLineLayer(), //Line layer
          _buildHubLayer(),
        ],
      ),
    );
  }

  Widget _buildHubLayer() {
    bool _shouldOpenThisLevel;
    bool _shouldShowThisLevel;
    List<Align> _hubAligns = [];
    for (var i = 0; i < levels.length; i++) {
      if ((i + this.indexOffset) > this.deepestCompletedIndex) {
        _shouldOpenThisLevel = false;
      } else {
        _shouldOpenThisLevel = true;
      }
      if ((i + this.indexOffset) >
          this.deepestCompletedIndex + this.lineOfSight) {
        _shouldShowThisLevel = false;
      } else {
        _shouldShowThisLevel = true;
      }
      _hubAligns.add(Align(
        alignment: _hubLocations[i].toAlignment(),
        child: LevelHub(
          index: i,
          level: levels[i],
          isOpen: _shouldOpenThisLevel,
          isVisible: _shouldShowThisLevel,
        ),
      ));
    }
    return Stack(
      children: _hubAligns,
    );
  }

  Widget _buildLineLayer() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/line.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: null /* add child content here */,
    );
  }
}

class LevelHubLocation {
  final double x;
  final double y;

  LevelHubLocation(this.x, this.y);

  Alignment toAlignment() {
    var alignX = (this.x / 50) - 1;
    var alignY = (this.y / 50) - 1;
    return Alignment(alignX, -alignY);
  }
}

class LevelHub extends StatelessWidget {
  final String iconPath;
  final bool isOpen;
  final bool isVisible;
  final Level level;
  final int lineOfSight = 3;
  final int index;

  final Color baseColor;
  final Color topColor;

  LevelHub({
    this.isOpen = false,
    this.isVisible = false,
    this.level,
    this.index,
  })  : topColor = _chooseTopColor(level, isOpen),
        baseColor = _chooseBaseColor(level, isOpen),
        iconPath = _chooseIconPath(level, isVisible);

  static Color _chooseBaseColor(Level _level, bool _isOpen) {
    Color _color = const Color.fromRGBO(138, 138, 138, 1);
    if (_isOpen) {
      _color = const Color.fromRGBO(127, 184, 223, 1);
    }
    if (_level.isComplete) {
      _color = const Color.fromRGBO(0, 173, 72, 1);
    }
    if (_level.isMastered) {
      _color = const Color.fromRGBO(251, 179, 0, 1);
    }
    return _color;
  }

  static Color _chooseTopColor(Level _level, bool _isOpen) {
    Color _color = const Color.fromRGBO(158, 158, 158, 1);
    if (_isOpen) {
      _color = const Color.fromRGBO(171, 202, 223, 1);
    }
    if (_level.isComplete) {
      _color = const Color.fromRGBO(0, 200, 83, 1);
    }
    if (_level.isMastered) {
      _color = const Color.fromRGBO(251, 199, 70, 1);
    }
    return _color;
  }

  static String _chooseIconPath(Level _level, bool _isVisible) {
    if (_isVisible) {
      return _level.iconPath;
    } else {
      return 'assets/levelicons/outofsight.png';
    }
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (this.isOpen) {
          UserBloc bloc = BlocProvider.of<UserBloc>(context);
          Navigator.of(context).push(PageRouteBuilder(
              transitionDuration: Duration(seconds: 0),
              opaque: false,
              pageBuilder: (BuildContext context, _, __) {
                return StartLevelDialog(
                  index: this.index,
                  level: this.level,
                );
              }));
        }
      },
      child: Container(
        height: 40,
        width: 40,
        foregroundDecoration: _foregroundDecoration(),
        decoration: BoxDecoration(
          color: topColor,
          boxShadow: [
            new BoxShadow(
              color: baseColor,
              offset: Offset(0, 5),
              spreadRadius: 0.5,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(20)),
          image: DecorationImage(
            image: AssetImage(iconPath),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  BoxDecoration _foregroundDecoration() {
    if (this.isOpen) {
      return BoxDecoration();
    } else {
      return BoxDecoration(
        color: Colors.grey,
        backgroundBlendMode: BlendMode.saturation,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      );
    }
  }
}
