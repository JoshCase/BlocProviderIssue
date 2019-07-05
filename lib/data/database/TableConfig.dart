class TableConfig {
  final String name;
  final List<ColumnConfig> cols;

  TableConfig(this.name, this.cols);
}

class ColumnConfig {
  final String name;
  final String type;

  ColumnConfig(this.name, this.type) {
    _ensureColIsValid();
  }

  void _ensureColIsValid() {
    List<String> _validColStarts = ['BLOB', 'INTEGER', 'REAL', 'TEXT'];
    bool _startsCorrectly = false;
    _validColStarts.forEach((str) {
      if (type.startsWith(str)) {
        _startsCorrectly = true;
        return;
      }
    });
    if(!_startsCorrectly) {
      throw Exception();
    }
  }
}
