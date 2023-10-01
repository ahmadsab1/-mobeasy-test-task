class UserAnswer {
  late String user;
  late String answer1;
  late String answer2;
  late String answer3;

  UserAnswer();

  UserAnswer.fromMap(Map<String, dynamic>? map) {
    if (map != null) {
      user = map['user'] ?? '';
      answer1 = map['answer1'] ?? '';
      answer2 = map['answer2'] ?? '';
      answer3 = map['answer3'] ?? '';
    } else {
      // Handle the case where map is null, e.g., provide default values or throw an error.
      throw Exception('Failed to create Note from Map');
    }
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['user'] = user;
    map['answer1'] = answer1;
    map['answer2'] = answer2;
    map['answer3'] = answer3;

    return map;
  }
}
