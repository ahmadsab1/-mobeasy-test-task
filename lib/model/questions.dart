class Question1 {
  late String question11;
  late String answer;

  Question1();

  Question1.fromMap(Map<String, dynamic>? map) {
    if (map != null) {
      question11 = map['question1-1'] ?? '';
      answer = map['answer'] ?? '';
    } else {
      // Handle the case where map is null, e.g., provide default values or throw an error.
      throw Exception('Failed to create Note from Map');
    }
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['question1-1'] = question11;
    map['answer'] = answer;

    return map;
  }
}
