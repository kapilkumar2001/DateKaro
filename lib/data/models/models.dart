import 'dart:convert';

// Dummy file

class User {
  final String name;
  final int dd;
  final int mm;
  final int yy;
  final String gender;
  final int age;
  User({
    required this.name,
    required this.dd,
    required this.mm,
    required this.yy,
    required this.gender,
    required this.age,
  });

  User copyWith({
    String? name,
    int? dd,
    int? mm,
    int? yy,
    String? gender,
    int? age,
  }) {
    return User(
      name: name ?? this.name,
      dd: dd ?? this.dd,
      mm: mm ?? this.mm,
      yy: yy ?? this.yy,
      gender: gender ?? this.gender,
      age: age ?? this.age,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dd': dd,
      'mm': mm,
      'yy': yy,
      'gender': gender,
      'age': age,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      dd: map['dd'],
      mm: map['mm'],
      yy: map['yy'],
      gender: map['gender'],
      age: map['age'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(name: $name, dd: $dd, mm: $mm, yy: $yy, gender: $gender, age: $age)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is User &&
      other.name == name &&
      other.dd == dd &&
      other.mm == mm &&
      other.yy == yy &&
      other.gender == gender &&
      other.age == age;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      dd.hashCode ^
      mm.hashCode ^
      yy.hashCode ^
      gender.hashCode ^
      age.hashCode;
  }
}
