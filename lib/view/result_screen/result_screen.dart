// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:quiz_app/view/quiz_screen/dummydb.dart';
import 'package:quiz_app/view/quiz_screen/quiz_screen.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({
    super.key,
    required this.rightanswercount,
  });
  final int rightanswercount;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int starcount = 0;
  @override
  void initState() {
    starcount = calculatepercentage();
    calculatepercentage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    3,
                    (index) => Padding(
                          padding: EdgeInsets.only(
                              bottom: index == 1 ? 20 : 0, left: 15, right: 15),
                          child: Icon(Icons.star,
                              color: index < starcount
                                  ? Colors.amber
                                  : Colors.grey,
                              size: index == 1 ? 80 : 50),
                        )),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "congratulations",
                style: TextStyle(color: Colors.green, fontSize: 40),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "your score",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              Text(
                "${widget.rightanswercount}/${Dummydb.datalist.length}",
                style: TextStyle(color: Colors.green, fontSize: 30),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => QuizScreen()));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.replay_circle_filled_rounded,
                          color: Colors.black,
                          size: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            "Retry",
                            style: TextStyle(color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  calculatepercentage() {
    double percentage =
        (widget.rightanswercount / Dummydb.datalist.length) * 100;
    print(percentage);
    if (percentage >= 80) {
      return 3;
    } else if (percentage >= 50) {
      return 2;
    } else if (percentage >= 30) {
      return 1;
    } else {
      return 0;
    }
  }
}
