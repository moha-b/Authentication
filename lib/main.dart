import 'package:authentication/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/exam_questions_cubit.dart';
import 'exam_questions_model.dart';

void main() {
  DioHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BottomSheet Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showQuestions(context);
          },
          child: const Text('Show BottomSheet'),
        ),
      ),
    );
  }

  void showQuestions(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext _) {
        return CustomBottomSheet();
      },
    );
  }
}

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  late ExamQuestionsCubit _examQuestionsCubit;
  List<Data> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _examQuestionsCubit = ExamQuestionsCubit();
  }

  @override
  void dispose() {
    _examQuestionsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _examQuestionsCubit..getExamQuestions(),
      child: _buildBottomSheetContent(),
    );
  }

  Widget _buildBottomSheetContent() {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "All Questions ",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff030712),
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              )
            ],
          ),
          Container(
            height: 48,
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (query) => _searchQuestions(query),
                    decoration: const InputDecoration(
                      hintText: 'Search for question',
                      prefixIcon: Icon(Icons.search),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      prefixIconColor: Color(0xff9CA3AF),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(color: Color(0xffE5E7EB)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(color: Color(0xffE5E7EB)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {},
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(
                        color: Color(0xffE5E7EB),
                      ),
                    ),
                  ),
                  icon: const Icon(
                    Icons.sort_rounded,
                    color: Color(0xff9CA3AF),
                  ),
                )
              ],
            ),
          ),
          BlocBuilder<ExamQuestionsCubit, ExamQuestionsState>(
            builder: (context, state) {
              if (state is ExamQuestionsSuccess) {
                return _buildQuestionList();
              } else if (state is ExamQuestionsLoading) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Center(child: Text("Something went wrong"));
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionList() {
    return Expanded(
      child: ListView.separated(
        itemCount: _searchResults.isNotEmpty
            ? _searchResults.length
            : _examQuestionsCubit.model?.data?.length ?? 0,
        padding: const EdgeInsets.only(bottom: 16),
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          final questions = _searchResults.isNotEmpty
              ? _searchResults
              : _examQuestionsCubit.model?.data ?? [];
          return ReviewQuestions(list: questions, index: index);
        },
      ),
    );
  }

  void _searchQuestions(String query) {
    setState(() {
      if (query.isEmpty) {
        _searchResults.clear();
      } else {
        // Filter questions based on the search query
        _searchResults = _examQuestionsCubit.model?.data!
                .where((question) =>
                    question.title!.toLowerCase().contains(query.toLowerCase()))
                .toList() ??
            [];
      }
    });
  }
}

class ReviewQuestions extends StatelessWidget {
  const ReviewQuestions({
    super.key,
    required this.list,
    required this.index,
  });

  final List<Data>? list;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 34,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xffF3F4FF),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text((index + 1).toString(),
                    style: const TextStyle(color: Color(0xff0225FF))),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Color(0xff0225FF),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(list![index].title!),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Questions extends StatelessWidget {
  const Questions({
    super.key,
    required this.list,
    required this.index,
  });

  final List<Data>? list;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 34,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xffF3F4FF),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text((index + 1).toString(),
                    style: const TextStyle(color: Color(0xff0225FF))),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Color(0xff0225FF),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(list![index].title!),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: list![index].studentAnswer.toString() == 'right'
                            ? Colors.green
                            : Colors.redAccent,
                        size: 8,
                      ),
                      const SizedBox(width: 5),
                      Text(list![index].studentAnswer.toString()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
