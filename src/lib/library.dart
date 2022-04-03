


import 'dart:math';

import 'package:flutter/services.dart';

class PuzzleLibrary {
  List<String> _puzzles = [];

  PuzzleLibrary() {}

  Library(String level) {
    // switch (level) {
    //   case '1':
    //     _puzzles = [
    //       'EEF3E44EB1',          'EF7CE1B44E',          'EDDBB1C66C',          'DCF7E48D72',
    //       'BF7CB4E14E',          '79F7B16CC6',          'C6FFB1E44E',          '77F5B1C66C',
    //       'FF59E1B44E',          '59FFE48D72'
    //     ];
    //     break;
    //
    //   case '2':
    //     _puzzles = [
    //       '6BFCE1B44E',          'EBE5E48D72',          'ADBEE48D72',          'F3BCB4E14E',
    //       'B69FB14EE4',          'BCF6B1C66C',          '58FFE1B44E',          '7F17B14EE4',
    //       '6DF6B1C66C',          '7EB6B44EE1'
    //     ];
    //     break;
    //
    //   case '3':
    //     _puzzles = [
    //       'F656E44EB1',          'D5ECE14EB4',          'E45FB4E14E',          'FE34E4B14E',
    //       '9E37E14EB4',          'F3B1E4728D',          '8BD7B44EE1',          '2DF6E14EB4',
    //       '7ACDE48D72',          'AE5BE48D72'
    //     ];
    //     break;
    //
    //   case '4':
    //     _puzzles = [
    //       '9DE2B4E14E',          'D2B6B1E44E',          '93E3B1C66C',          'E5A6B1C66C',
    //       '92EDB1C66C',          '6B1BE4728D',          '8F3CE4728D',          '519FE1B44E',
    //       'E21FB44EE1',          '4D57E1B44E'
    //     ];
    //     break;
    //
    //     case '5'
    //
    //
    // }









//     rootBundle.loadString('assets/level' + level + '.txt');
  }

  Future<String> load(String filename) async {
    String content = await rootBundle.loadString(filename);
    _puzzles = content.split('\n');
    return "";
  }


  bool get isReady => !_puzzles.isEmpty;


  static int _value(int v) {
    return (v & 0x03) + 1;
  }


  static String _extract(String zip) {
    int value = int.parse(zip, radix: 16);
    int mask = (value & 0x0000FFFFFF000000) >> 24;
    int zanswer = value & 0x0000000000FFFFFF;

    String answer = "";
    for (int i = 0; i < 12; ++i) {
      answer = _value(zanswer).toString() + answer;
      zanswer = zanswer >> 2;
    }

    answer = '1234' + answer;

    String question = '';
    int m = 0x8000;

    for (int i = 0; i < 16 ; ++i) {
      if ((mask & m) == 0) {
        question += '_';
      }
      else {
        question += answer[i];
      }
      m = m >> 1;
    }

    return question + '\t' + answer;
  }

  static String _disturb(String input) {
    String abcd = input.replaceAll('1', 'A').replaceAll('2', 'B').replaceAll('3', 'C').replaceAll('4', 'D');
    List<String> dist = __disturb[Random.secure().nextInt(24)];
    return abcd.replaceAll('A', dist[0]).replaceAll('B', dist[1]).replaceAll('C', dist[2]).replaceAll('D', dist[3]);
  }

  static List<List<String>> __disturb = [
    ['1','2','3','4'],    ['1','2','4','3'],    ['1','3','2','4'],    ['1','3','4','2'],    ['1','4','2','3'],    ['1','4','3','2'],
    ['2','1','3','4'],    ['2','1','4','3'],    ['2','3','1','4'],    ['2','3','4','1'],    ['2','4','1','3'],    ['2','4','3','1'],
    ['3','1','2','4'],    ['3','1','4','2'],    ['3','2','1','4'],    ['3','2','4','1'],    ['3','4','1','2'],    ['3','4','2','1'],
    ['4','1','2','3'],    ['4','1','3','2'],    ['4','2','1','3'],    ['4','2','3','1'],    ['4','3','1','2'],    ['4','3','2','1']
  ];


  String next() {
    String zip = _puzzles[Random.secure().nextInt(_puzzles.length)];
    return _disturb(_extract(zip));
  }



}