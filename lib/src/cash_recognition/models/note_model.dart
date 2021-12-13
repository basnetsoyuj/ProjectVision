import 'package:flutter/material.dart';
import 'package:project_vision/src/utils/colors.dart';

/// Class representing a Currency Note
class Note {
  static const Map<int, String> _intToNote = {
    0: 'five',
    1: 'ten',
    2: 'twenty',
    3: 'fifty',
    4: 'hundred',
    5: 'two hundred',
    6: 'five hundred',
    7: 'thousand'
  };
  static const Map<String, int> _noteToInt = {
    'five': 0,
    'ten': 1,
    'twenty': 2,
    'fifty': 3,
    'hundred': 4,
    'two hundred': 5,
    'five hundred': 6,
    'thousand': 7
  };

  static const Map<String, int> _noteToValues = {
    'fifty': 50,
    'five': 5,
    'five hundred': 500,
    'two hundred': 200,
    'hundred': 100,
    'ten': 10,
    'thousand': 1000,
    'twenty': 20
  };

  static final Map<String, Color> noteToColor = {
    'fifty': fiftyColor,
    'five': fiveColor,
    'five hundred': fivehundredColor,
    'hundred': hundredColor,
    'ten': tenColor,
    'thousand': thousandColor,
    'twenty': twentyColor,
    'two hundred': twoHundredColor,
  };

  // information for the database where note will be saved
  static const TABLE_NAME = "notes";
  static const COLUMN_ID = "id";
  static const COLUMN_NOTE = "note";
  static const COLUMN_DATETIME = "datetime";
  int? id;
  int? note;
  int? datetimeInt;
  late DateTime datetime;
  String? label;
  int? value;

  Note({this.id, this.label, this.datetimeInt});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      COLUMN_NOTE: _noteToInt[label],
    };
    if (id != null) {
      map[COLUMN_ID] = id;
    }
    if (datetimeInt != null) {
      map[COLUMN_DATETIME] = datetimeInt;
    }
    return map;
  }

  Note.fromMap(Map<String, dynamic> map) {
    id = map[COLUMN_ID];
    note = map[COLUMN_NOTE];
    datetimeInt = map[COLUMN_DATETIME];
    datetime = DateTime.fromMicrosecondsSinceEpoch(datetimeInt!);
    label = _intToNote[note];
    value = _noteToValues[label];
  }
}
