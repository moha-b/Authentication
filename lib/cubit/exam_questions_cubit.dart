import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../dio_helper.dart';
import '../exam_questions_model.dart';

part 'exam_questions_state.dart';

class ExamQuestionsCubit extends Cubit<ExamQuestionsState> {
  ExamQuestionsCubit() : super(ExamQuestionsInitial());
  ExamQuestionsModel? model;

  void getExamQuestions() async {
    try {
      var result = await DioHelper.getData(
        url: '/examQuestions',
        token: 'Bearer 17|laAM4n9VKAtZbWzMZPpT8rpprwEMLGVkkOzEqith',
        query: {'exam_id': '23'},
      );
      print(result.data);
      model = ExamQuestionsModel.fromJson(result.data);
      emit(ExamQuestionsSuccess(model!));
    } catch (e) {
      print(e.toString());
      emit(ExamQuestionsError());
    }
  }

  void search(String query) {
    if (query.isEmpty) {
      emit(ExamQuestionsInitial());
    } else {
      // Filter questions based on the search query
      final searchResults = model?.data!
          .where((question) =>
              question.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(ExamQuestionSearchResultsState(searchResults!));
    }
  }
}
