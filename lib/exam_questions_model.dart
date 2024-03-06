class ExamQuestionsModel {
  List<Data>? data;

  ExamQuestionsModel({this.data});

  factory ExamQuestionsModel.fromJson(Map<String, dynamic> json) {
    return ExamQuestionsModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Data {
  int? id;
  String? title;
  String? titleAr;
  String? type;
  Illustration? illustration;
  Attachment? attachment;
  int? multiple;
  List<Option>? options;
  dynamic answeredCorrect;
  dynamic isFlagged;
  dynamic studentAnswer;
  List<Answer>? answers;

  Data({
    this.id,
    this.title,
    this.titleAr,
    this.type,
    this.illustration,
    this.attachment,
    this.multiple,
    this.options,
    this.answeredCorrect,
    this.isFlagged,
    this.studentAnswer,
    this.answers,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'] as int?,
      title: json['title'] as String?,
      titleAr: json['title_ar'] as String?,
      type: json['type'] as String?,
      illustration: json['illistraton'] != null
          ? Illustration.fromJson(json['illistraton'] as Map<String, dynamic>)
          : null,
      attachment: json['attachment'] != null
          ? Attachment.fromJson(json['attachment'] as Map<String, dynamic>)
          : null,
      multiple: json['multiple'] as int?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList(),
      answeredCorrect: json['answered_correct'],
      isFlagged: json['is_flagged'],
      studentAnswer: json['student_answer'],
      answers: (json['answers'] as List<dynamic>?)
          ?.map((e) => Answer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Illustration {
  String? text;

  Illustration({this.text});

  factory Illustration.fromJson(Map<String, dynamic> json) {
    return Illustration(
      text: json['text'] as String?,
    );
  }
}

class Attachment {
  String? type;
  String? url;

  Attachment({this.type, this.url});

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      type: json['type'] as String?,
      url: json['url'] as String?,
    );
  }
}

class Option {
  String? key;
  String? title;
  String? titleAr;
  int? isCorrect;
  int? isSelected;
  dynamic attachment;

  Option({
    this.key,
    this.title,
    this.titleAr,
    this.isCorrect,
    this.isSelected,
    this.attachment,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      key: json['key'] as String?,
      title: json['title'] as String?,
      titleAr: json['title_ar'] as String?,
      isCorrect: json['is_correct'] as int?,
      isSelected: json['is_selected'] as int?,
      attachment: json['attachment'],
    );
  }
}

class Answer {
  int? index;
  String? key;
  String? answer;
  String? answerAr;

  Answer({this.index, this.key, this.answer, this.answerAr});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      index: json['index'] as int?,
      key: json['key'] as String?,
      answer: json['answer'] as String?,
      answerAr: json['answer_ar'] as String?,
    );
  }
}
