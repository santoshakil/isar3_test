import 'package:isar/isar.dart';

part 'model.g.dart';

@Collection()
class Teacher {
  Id? id;
  int tid = DateTime.now().millisecondsSinceEpoch;
  @Index()
  String? name;
  @Backlink(to: 'teacher')
  final students = IsarLinks<Student>();

  Teacher(this.name);
}

@Collection()
class Student {
  Id? id;
  @Index()
  String? name;
  @Index()
  int? get teacherID => teacher.value?.tid;

  final teacher = IsarLink<Teacher>();

  Student(this.name);
}
