import 'package:isar/isar.dart';

part 'model.g.dart';

@Collection()
class Teacher {
  Id? id;
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
  final teacher = IsarLinks<Teacher>();

  Student(this.name);
}
