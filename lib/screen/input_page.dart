import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/constant.dart';
import '../components/bottom_button.dart';
import '../components/round_icon_button.dart';
import 'package:BMI/calculator_brain.dart';
import 'result_page.dart';

enum Gender {
  male,
  female,
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Color maleCardColor = inactiveColour;
  Color femaleCardColor = inactiveColour;
  Gender selectedgender;
  int height = 180;
  int weight = 50;
  int age = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: RepeatCard(
                      onPress: () {
                        setState(() {
                          selectedgender = Gender.male;
                        });
                      },
                      colour: selectedgender == Gender.male
                          ? activeColour
                          : inactiveColour,
                      cardchild:
                          Iconinput(icon: FontAwesomeIcons.mars, label: 'MALE'),
                    ),
                  ),
                  Expanded(
                    child: RepeatCard(
                      onPress: () {
                        setState(() {
                          selectedgender = Gender.female;
                        });
                      },
                      colour: selectedgender == Gender.female
                          ? activeColour
                          : inactiveColour,
                      cardchild: Iconinput(
                          icon: FontAwesomeIcons.venus, label: 'FEMALE'),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: RepeatCard(
                colour: inputpagebuttonclr,
                cardchild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'HEIGHT',
                      style: labelstyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          height.toString(),
                          style: nUmberstyle,
                        ),
                        Text(
                          'cm',
                          style: labelstyle,
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        inactiveTrackColor: Color(0xFF8D8E98),
                        activeTrackColor: Colors.white,
                        thumbColor: Color(0xFFEB1555),
                        overlayColor: Color(0x29EB1555),
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 15.0),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 30.0),
                      ),
                      child: Slider(
                        value: height.toDouble(),
                        min: 120.0,
                        max: 220.0,
                        activeColor: Colors.red.shade600,
                        inactiveColor: Colors.grey.shade200,
                        onChanged: (double newVALue) {
                          setState(() {
                            height = newVALue.round();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: RepeatCard(
                      colour: inputpagebuttonclr,
                      cardchild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'WEIGHT',
                            style: labelstyle,
                          ),
                          Text(
                            weight.toString(),
                            style: nUmberstyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onTapp: () {
                                  setState(() {
                                    --weight;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onTapp: () {
                                  setState(() {
                                    ++weight;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: RepeatCard(
                      colour: inputpagebuttonclr,
                      cardchild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'AGE',
                            style: labelstyle,
                          ),
                          Text(
                            age.toString(),
                            style: nUmberstyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onTapp: () {
                                  setState(() {
                                    --age;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onTapp: () {
                                  setState(() {
                                    ++age;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BottomButton(
              buttonTitle: 'Calculate',
              onTap: () {
                CalculatorBrain calc =
                    CalculatorBrain(height: height, weight: weight);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Resultpage(
                      bmiResult: calc.calculateBMI(),
                      bmiResulttext: calc.getResult(),
                      bmiOpinion: calc.getOpinion(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Iconinput extends StatelessWidget {
  Iconinput({@required this.icon, @required this.label});
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 80.0,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          label,
          style: labelstyle,
        )
      ],
    );
  }
}

class RepeatCard extends StatelessWidget {
  RepeatCard({@required this.colour, this.cardchild, this.onPress});

  final Color colour;
  final Widget cardchild;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: cardchild,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
