import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/icon_content.dart';
import '../components/reusable_card.dart';
import '../constants.dart';
import 'package:bmi_calculator/screen/results_page.dart';
import '../components/bottom_button.dart';
import 'package:bmi_calculator/components/round_icon_button.dart';
import 'package:bmi_calculator/calculator_brain.dart';

enum Gender{  //ENUM
  male,
  female
}


class InputPage extends StatefulWidget {
  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  late Gender selectedGender;

  void initState() {
    selectedGender = Gender.male;
    super.initState();
  }

  void inState() {
    selectedGender = Gender.female;
    super.initState();
  }

  int height = 180;
  int weight = 60;
  int age = 10;

  // Color maleCardColor=inactiveCardColour;
  // Color femaleCardColor=inactiveCardColour;
  // void updateColor(Gender selectedGender)  //ENUM
  // {
  //   if(selectedGender==Gender.male) {   //ENUM
  //     if (maleCardColor == inactiveCardColour) {
  //       maleCardColor = activeCardColour;
  //       femaleCardColor=inactiveCardColour;
  //     }
  //     else {
  //       maleCardColor = inactiveCardColour;
  //     }
  //   }
  //   if(selectedGender==Gender.female) {   //ENUM
  //     if (femaleCardColor == inactiveCardColour) {
  //       femaleCardColor = activeCardColour;
  //       maleCardColor=inactiveCardColour;
  //     }
  //     else {
  //       femaleCardColor = inactiveCardColour;
  //     }
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
        centerTitle: true,
        backgroundColor: Color(0xFF0A0E21),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
                children: [
                  Expanded(
                    child: ReusableCard(
                      onPress: () {
                        setState(() {
                          selectedGender = Gender.male;
                        });
                      },
                      colour: selectedGender == Gender.male ? kActiveCardColour : kInactiveCardColour, //TERNARY OPERATOR
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.mars,
                        label: 'MALE',
                      ),
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                        onPress: () {
                          setState(() {
                            selectedGender = Gender.male;
                          });
                        },
                        colour: selectedGender == Gender.female ? kActiveCardColour : kInactiveCardColour, //TERNARY OPERATOR
                        cardChild: IconContent(
                          icon: FontAwesomeIcons.venus,
                          label: 'FEMALE',
                        )
                    ),
                  ),
                ]
            ),
          ),
          Expanded(
            child: ReusableCard(
              onPress: () {
                setState(() {
                  selectedGender = Gender.male;
                });
              },colour: kActiveCardColour,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('HEIGHT', style: labelTextStyle
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                          height.toString(),
                          style: kNumberTextStyle
                      ),
                      Text('cm', style: labelTextStyle
                      ),
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.white,
                        thumbColor: Color(0xFFEB1555),
                        overlayColor: Color(0x29EB1555),
                        thumbShape:
                        RoundSliderThumbShape(enabledThumbRadius: 15.0),
                        overlayShape:
                        RoundSliderOverlayShape(overlayRadius: 30.0)
                    ),
                    child: Slider(
                        value: height.toDouble(),
                        min: 120.0,
                        max: 220.0,
                        inactiveColor: Color(0xFF8D8E98),
                        onChanged: (double newValue) {
                          setState(() {
                            height = newValue.round();
                          });
                        }
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ReusableCard(
                      onPress: () {
                        setState(() {
                          selectedGender = Gender.male;
                        });
                      },colour: kActiveCardColour,
                      cardChild: Column(
                        children: [
                          Text('WEIGHT', style: labelTextStyle,),
                          Text(weight.toString(), style: kNumberTextStyle,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundIconButton(
                                  icon: FontAwesomeIcons.minus,
                                  onPressed: () {
                                    setState(() {
                                      weight--;
                                    });
                                  }
                              ),
                              SizedBox(width: 10.0),
                              RoundIconButton(
                                  icon: FontAwesomeIcons.plus,
                                  onPressed: () {
                                    setState(() {
                                      weight++;
                                    });
                                  }
                              ),
                            ],
                          )
                        ],
                      )
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                      onPress: () {
                        setState(() {
                          selectedGender = Gender.male;
                        });
                      },colour: kActiveCardColour,
                      cardChild: Column(
                        children: [
                          Text('AGE', style: labelTextStyle,),
                          Text(age.toString(), style: kNumberTextStyle,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundIconButton(
                                  icon: FontAwesomeIcons.minus,
                                  onPressed: () {
                                    setState(() {
                                      age--;
                                    });
                                  }
                              ),
                              SizedBox(width: 10.0),
                              RoundIconButton(
                                  icon: FontAwesomeIcons.plus,
                                  onPressed: () {
                                    setState(() {
                                      age++;
                                    });
                                  }
                              ),
                            ],
                          )
                        ],
                      )
                  ),
                ),
              ],
            ),
          ),


          BottomButton(
            onTap: () {
              CalculatorBrain calc=CalculatorBrain(height: height, weight: weight);
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context)=> ResultsPage(
                    bmiResult: calc.calculateBMI(),
                    resultText: calc.getResult(),
                    interpretation: calc.getInterpretation(),
                  )
                  )
              );
            },
            buttonTitle: 'CALCULATE',
          )
        ],
      ),
    );
  }
}






