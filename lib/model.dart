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
  int? teacherID;

  final teacher = IsarLinks<Teacher>();

  void setTeacher(List<Teacher> v) {
    teacherID = v.first.tid;
    teacher.addAll(v);
  }

  Student(this.name);
}
