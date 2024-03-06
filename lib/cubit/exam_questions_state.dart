part of 'exam_questions_cubit.dart';

@immutable
abstract class ExamQuestionsState {}

class ExamQuestionsInitial extends ExamQuestionsState {}

class ExamQuestionsLoading extends ExamQuestionsState {}

class ExamQuestionsSuccess extends ExamQuestionsState {
  final ExamQuestionsModel model;

  ExamQuestionsSuccess(this.model);
}

class ExamQuestionSearchResultsState extends ExamQuestionsState {
  final List<Data> searchResults;

  ExamQuestionSearchResultsState(this.searchResults);
}

class ExamQuestionsError extends ExamQuestionsState {}
