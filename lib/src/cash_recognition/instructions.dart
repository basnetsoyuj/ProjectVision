import 'package:project_vision/src/object_recognition/instructions.dart' as object_recognition;

// Instructions and their corresponding audio feedbacks
const instructions = [
  [
    "Getting started",
    "This is the cash recognition component of Project Vision. In order to use it, please press anywhere on the camera screen."
  ],
  [
    "Audio Feedback",
    "After pressing on the screen, you will receive an audio feedback of the detected currency."
  ],
  [
    "History Feature",
    "Project Vision also stores the scanned currency amount in the history tab at the top right corner of the screen."
  ],
  [
    "Placement of Notes",
    "In order to maximize the accuracy of the model, please place the currency notes at around 15 centimeters from the camera."
  ],
  [
    "Additional Information",
    "Please try different orientation of notes if you get error indications. Email soyuj@nyu.edu to contact developers."
  ],
];

class InstructionPage extends object_recognition.InstructionPage {
  @override
  object_recognition.InstructionPageState createState() => object_recognition.InstructionPageState(instructions);
}
