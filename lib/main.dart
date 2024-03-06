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
    return BlocProvider(
      create: (context) => ExamQuestionsCubit()..getExamQuestions(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('BottomSheet Example'),
        ),
        body: Center(
          child: BlocConsumer<ExamQuestionsCubit, ExamQuestionsState>(
            listener: (context, state) async {
              if (state is ExamQuestionsSuccess) {
                BlocProvider.value(
                  value: BlocProvider.of<ExamQuestionsCubit>(context),
                  child: await showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomBottomSheet(model: state.model);
                    },
                  ),
                );
              }
            },
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  context.read<ExamQuestionsCubit>().getExamQuestions();
                },
                child: const Text('Show BottomSheet'),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    Key? key,
    required this.model,
  }) : super(key: key);
  final ExamQuestionsModel model;

  @override
  Widget build(BuildContext context) {
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
                    onChanged: (query) =>
                        context.read<ExamQuestionsCubit>().search(query),
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
              return Expanded(
                child: ListView.separated(
                  itemCount: (state is ExamQuestionSearchResultsState)
                      ? state.searchResults.length
                      : model.data!.length,
                  padding: const EdgeInsets.only(bottom: 16),
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    final questions = (state is ExamQuestionSearchResultsState)
                        ? state.searchResults
                        : model.data;
                    return ReviewQuestions(list: questions, index: index);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
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
