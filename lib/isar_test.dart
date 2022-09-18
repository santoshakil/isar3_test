import 'dart:math';

import 'package:isar/isar.dart';

import 'model.dart';

late final Isar db;

void isarTest() async {
  final st = DateTime.now().millisecondsSinceEpoch;
  await Isar.initializeIsarCore(download: true);
  final iit = DateTime.now().millisecondsSinceEpoch;
  print('Initialized in ${iit - st}ms');
  db = Isar.openSync([TeacherSchema, StudentSchema], directory: 'data');
  final ot = DateTime.now().millisecondsSinceEpoch;
  db.writeTxnSync(() => db.clearSync());
  print('Opened in ${ot - iit}ms');
  _watchIsar();
  _writeTest();
  final it = DateTime.now().millisecondsSinceEpoch;
  print('Writen in ${it - ot}ms');
  // _readTest();
}

void _writeTest() {
  final teachers = List.generate(100, (i) => Teacher('${DateTime.now()}_$i'));
  final students = List.generate(
    100,
    (i) => Student('${DateTime.now()}_$i')
      ..teacher.value = teachers[Random().nextInt(99)],
  );
  db.writeTxnSync(() => db.students.putAllSync(students));
}

// void _writeTest() => db.writeTxnSync(
//       () => db.testDatas.putAllSync(
//         List.generate(
//           10000,
//           (i) => TestData(
//             id: i,
//             name: 'name $i',
//             age: i,
//             birthday: DateTime.now(),
//             isActive: i % 2 == 0,
//           ),
//         ),
//       ),
//     );

// void _readTest() {}

void _watchIsar() => db.students.watchLazy().listen((_) => print('Watched'));
