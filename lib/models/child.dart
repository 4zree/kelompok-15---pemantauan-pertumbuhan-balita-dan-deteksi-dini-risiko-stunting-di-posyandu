
class Child {
  final int? id;
  final String name;
  final String gender;
  final String birthDate;
  final String createdAt;

  Child({
    this.id,
    required this.name,
    required this.gender,
    required this.birthDate,
    String? createdAt,
  }) : createdAt =
            createdAt ?? DateTime.now().toIso8601String();

  factory Child.fromMap(Map<String, dynamic> map) {
    return Child(
      id: map['id'] as int?,
      name: map['name'] as String,
      gender: map['gender'] as String,
      birthDate: map['birth_date'] as String,
      createdAt: map['created_at'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'birth_date': birthDate,
      'created_at': createdAt,
    };
  }
}
