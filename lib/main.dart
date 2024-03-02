import 'package:flutter/material.dart';

void main() {
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
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return CustomBottomSheet();
              },
            );
          },
          child: const Text('Show BottomSheet'),
        ),
      ),
    );
  }
}

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    Key? key,
  }) : super(key: key);

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
              IconButton(onPressed: () {}, icon: const Icon(Icons.close))
            ],
          ),
          Container(
            height: 48,
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
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
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              padding: const EdgeInsets.only(bottom: 16),
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemBuilder: (BuildContext context, int index) =>
                  Question(index: index),
            ),
          ),
        ],
      ),
    );
  }
}

class Question extends StatelessWidget {
  const Question({
    super.key,
    required this.index,
  });
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
          const Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Text(
                      "Why People skills required to be an effective video editor?"),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: Colors.green,
                        size: 8,
                      ),
                      SizedBox(width: 5),
                      Text("Right"),
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
