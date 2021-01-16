import 'package:BMI/components/constant.dart';
import 'package:flutter/material.dart';
import 'input_page.dart';
import '../components/bottom_button.dart';

class Resultpage extends StatelessWidget {
  Resultpage(
      {@required this.bmiResult,
      @required this.bmiResulttext,
      this.bmiOpinion});
  final String bmiResult;
  final String bmiResulttext;
  final String bmiOpinion;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('BMI Calculator'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(15.0),
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Your Result',
                  style: titleResultpage,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: RepeatCard(
                colour: inactiveColour,
                cardchild: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      bmiResulttext,
                      style: resulttextstyle,
                    ),
                    Text(
                      bmiResult,
                      style: bMItextstyle,
                    ),
                    Text(
                      bmiOpinion,
                      textAlign: TextAlign.center,
                      style: bMIbodytextstyle,
                    ),
                  ],
                ),
              ),
            ),
            BottomButton(
                buttonTitle: 'Re-Calculate',
                onTap: () {
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
