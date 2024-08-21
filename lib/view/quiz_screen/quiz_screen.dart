// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/view/quiz_screen/dummydb.dart';
import 'package:quiz_app/view/quiz_screen/widget/options_card.dart';
import 'package:quiz_app/view/result_screen/result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int questionIntex = 0;
  int? selectedAnsweIndex;

  int rightanswercount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          actions: [
            Text(
              "${questionIntex + 1} / ${Dummydb.datalist.length}",
              style: TextStyle(color: Colors.blue),
            ),
            SizedBox(
              width: 10,
            )
          ],
          backgroundColor: Colors.black,
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              //to build question section
              _buildQuestionSection(),
              SizedBox(
                height: 15,
              ),
              //to build option section
              Column(
                children: List.generate(
                    4,
                    (index) => OptionsCard(
                          questionIntex: questionIntex,
                          optionindex: index,
                          bordercolor: _getColor(index),
                          onOptionsTap: () {
                            if (selectedAnsweIndex == null) {
                              selectedAnsweIndex = index;
                              //right answer count
                              if (selectedAnsweIndex ==
                                  Dummydb.datalist[questionIntex]["answer"]) {
                                rightanswercount++;
                                print(
                                    "right answer count : ${rightanswercount}");
                              }
                              setState(() {});
                              print(index);
                            }
                          },
                        )),
              )
            ],
          ),
        )),
        bottomNavigationBar: _buildNextButton(context));
  }

  Widget? _buildNextButton(BuildContext context) {
    return Visibility(
      visible: selectedAnsweIndex != null,
      child: InkWell(
        onTap: () {
          selectedAnsweIndex = null;
          if (questionIntex < Dummydb.datalist.length - 1) {
            setState(() {
              questionIntex++;
            });
          } else {
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //   content: Text("Thanks"),
            //   backgroundColor: Colors.red,
            // ));
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ResultScreen(
                          rightanswercount: rightanswercount,
                        )));
          }
        },
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(10)),
          height: 60,
          child: Text(
            "Next",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Expanded _buildQuestionSection() {
    return Expanded(
      child: Stack(children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 10),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade800),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: Text(
                Dummydb.datalist[questionIntex]["question"],
                textAlign: TextAlign.justify,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        selectedAnsweIndex == Dummydb.datalist[questionIntex]["answer"]
            ? Lottie.asset("assets/animation/Animation - 1724137678821.json")
            : SizedBox()
      ]),
    );
  }

  Color _getColor(int index) {
    if (selectedAnsweIndex != null) {
      if (index == Dummydb.datalist[questionIntex]["answer"]) {
        return Colors.green;
      }
      if (selectedAnsweIndex == Dummydb.datalist[questionIntex]["answer"] &&
          selectedAnsweIndex == index) {
        return Colors.green;
      } else if (selectedAnsweIndex !=
              Dummydb.datalist[questionIntex]["answer"] &&
          selectedAnsweIndex == index) {
        return Colors.red;
      }
    }
    return Colors.grey;
  }
}
