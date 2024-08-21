// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:quiz_app/view/quiz_screen/dummydb.dart';

class OptionsCard extends StatelessWidget {
  const OptionsCard(
      {super.key,
      required this.questionIntex,
      required this.optionindex,
      this.onOptionsTap,
      required this.bordercolor});
  final int optionindex;
  final int questionIntex;
  final void Function()? onOptionsTap;
  final Color bordercolor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: onOptionsTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: bordercolor, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              children: [
                Text(
                  Dummydb.datalist[questionIntex]["options"][optionindex],
                  style: TextStyle(color: Colors.white),
                ),
                Spacer(),
                CircleAvatar(
                  radius: 8,
                  child: CircleAvatar(
                    radius: 7,
                    backgroundColor: Colors.black,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
