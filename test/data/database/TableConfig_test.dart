import 'package:flutter_test/flutter_test.dart';
import 'package:dailymedicaltrivia2/data/database/TableConfig.dart';

void main() {
  test('Does not throw with valid column types', (){
    ColumnConfig('example', 'BLOB');
    ColumnConfig('example', 'INTEGER');
    ColumnConfig('example', 'REAL');
    ColumnConfig('example', 'TEXT');
    ColumnConfig('example', 'TEXT PRIMARY KEY');
    expect(true, true);
  });

  test('Throws with invalid column types', (){
    expect(() => ColumnConfig('example', ' BLOB'), throwsException);
    expect(() => ColumnConfig('example', 'INTEGR'), throwsException);
    expect(() => ColumnConfig('example', 'rea l'), throwsException);
    expect(() => ColumnConfig('example', 'TXT'), throwsException);
  });
}