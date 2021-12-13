import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_vision/src/utils/colors.dart';
import 'package:project_vision/src/utils/tts.dart';

// Instructions and their corresponding audio feedbacks
const instructions = [
  [
    "Getting started",
    "This is the object recognition component of Project Vision. In order to use it, please press anywhere on the camera screen."
  ],
  [
    "Audio Feedback",
    "After pressing on the camera screen, you will receive an audio feedback of the detected object."
  ],
  [
    "Inference With Network Connection",
    "If the device is connected to a wifi, the inferences are made on a stronger model in the cloud, so accuracy will be high."
  ],
  [
    "On Device Inference",
    "If the device is not connected to a wifi, the inferences are made offline on the device itself, so the accuracy might decrease."
  ],
  [
    "Additional Information",
    "Please try different orientation of camera if you get error indications. Email soyuj@nyu.edu to contact developers."
  ],
];

class InstructionPage extends StatefulWidget {
  @override
  InstructionPageState createState() => InstructionPageState(instructions);
}

class InstructionPageState extends State<InstructionPage> {
  final _fontSize = 20.0;
  final List<List<String>> _instructionsList;

  InstructionPageState(this._instructionsList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "INSTRUCTIONS",
              style: GoogleFonts.poppins(
                textStyle:
                const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ),
          ),
          backgroundColor: appBarBgColor,
          elevation: 15,
          centerTitle: true,
        ),
        body: getInstructionListView(),
        backgroundColor: infobgColor);
  }

  Widget getInstructionListView() {
    final TextStyle listTextStyle =
    TextStyle(fontSize: _fontSize, fontWeight: FontWeight.w600);

    return ListView.builder(
      itemCount: _instructionsList.length,
      itemBuilder: (context, index) {
        return Column(children: [
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery
                    .of(context)
                    .size
                    .width * 0.04,
                bottom: MediaQuery
                    .of(context)
                    .size
                    .width * 0.0,
                left: MediaQuery
                    .of(context)
                    .size
                    .width * 0.03,
                right: MediaQuery
                    .of(context)
                    .size
                    .width * 0.03),
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .width * 0.22,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: infoBoxColor,
                boxShadow: [
                  BoxShadow(
                    color: grey,
                    spreadRadius: 1,
                    blurRadius: 0,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery
                          .of(context)
                          .size
                          .width * 0.05),
                  child: Center(
                      child: ListTile(
                        title: Text(
                            '${index + 1}. ' + _instructionsList[index][0],
                            style: listTextStyle),
                        trailing: Icon(
                          Icons.volume_up_sharp,
                          color: iconColor,
                          size: 40,
                        ),
                        onTap: () {
                          TextToSpeech.speak(_instructionsList[index][1]);
                        },
                      ))),
            ),
          ),
        ]);
      },
    );
  }

  @override
  void dispose() {
    TextToSpeech.stop();
    super.dispose();
  }
}
