import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileHandler{

  late File file;

  FileHandler(){
    createFile();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/childDetail.json');
  }

  Future<void> createFile() async {
    file = await _localFile;

    if (!await file.exists()) {
      List<Map<String, dynamic>> questionsChoices = [
        {
          'question': 'BCG',
          'choices': {'Dose-1 : 0w': false},
        },
        {
          'question': 'OPV',
          'choices': {'Dose-1 : 0w': false},
        },
        {
          'question': 'IPV',
          'choices': {
            'Dose-1 : 6w': false,
            'Dose-2 : 10w': false,
            'Dose-3 : 14w': false,
            'Dose-4 : 18m': false,
            'Dose-5 : 5y': false,
          },
        },
        {
          'question': 'Hepatitis B',
          'choices': {
            'Dose-1 : 0w': false,
            'Dose-2 : 6w': false,
            'Dose-3 : 10w': false,
            'Dose-4 : 14w': false,
          },
        },
        {
          'question': 'DPT',
          'choices': {
            'Dose-1 : 6w': false,
            'Dose-2 : 10w': false,
            'Dose-3 : 14w': false,
            'Dose-4 : 18m': false,
            'Dose-5 : 5y': false,
          },
        },
        {
          'question': 'HIB',
          'choices': {
            'Dose-1 : 6w': false,
            'Dose-2 : 10w': false,
            'Dose-3 : 14w': false,
            'Dose-4 : 16m': false,
            'Dose-5 : 4y': false,
          },
        },
        {
          'question': 'Pneumococcal',
          'choices': {
            'Dose-1 : 6w': false,
            'Dose-2 : 10w': false,
            'Dose-3 : 14w': false,
          },
        },
        {
          'question': 'Rotavirus(RV3)',
          'choices': {'Dose-1 : 6w': false, 'Dose-2 : 10w': false},
        },
        {
          'question': 'Rotavirus(RV5)',
          'choices': {
            'Dose-1 : 6w': false,
            'Dose-2 : 10w': false,
            'Dose-3 : 14w': false,
          },
        },
        {
          'question': 'MR/MMR',
          'choices': {'Dose-1 : 9m': false, 'Dose-2 : 16m': false, 'Dose-3 : 5y': false},
        },
        {
          'question': 'Varicella',
          'choices': {'Dose-1: 15m': false, 'Dose-2 : 18m': false},
        },
        {
          'question': 'Hepatitis A (live)',
          'choices': {'Dose-1: 12m': false},
        },
        {
          'question': 'Hepatitis A (Killed)',
          'choices': {'Dose-1: 12m': false, 'Dose-2 : 18m': false},
        },
        {
          'question': 'Typhoid (TCV)',
          'choices': {'Dose-1: 6m': false},
        },
        {
          'question': 'Typhoid (Typbar TCV)',
          'choices': {'Dose-1: 9m': false},
        },
        {
          'question': 'Typhoid (Polysaccharide)',
          'choices': {'Dose-1: 2y': false, 'Dose-2 : 5y': false},
        },
        {
          'question': 'HPV',
          'choices': {'Dose-1: 9y': false, 'Dose-2 : 9.5y': false},
        },
        {
          'question': 'Influenza vaccine',
          'choices': {'Dose-1: 6m': false, 'Dose-2 : 7m': false},
        },
        {
          'question': 'Japanese Encephalitis Vaccine',
          'choices': {'Dose-1: 9m': false, 'Dose-2 : 18m': false},
        },
        {
          'question': 'Meningococcal',
          'choices': {'Dose-1: 12m': false, 'Dose-2 : 15m': false},
        },
        {
          'question': 'Cholera Vaccine',
          'choices': {'Dose-1: 12m': false, 'Dose-2 : 13m': false},
        },
      ];
      print(questionsChoices);
      await file.create(recursive: true);
      await file.writeAsString(jsonEncode(questionsChoices));
    }
  }

  Future<List<Map<String, dynamic>>> readFile() async {
    try {
      file = await _localFile;
      if (await file.exists()) {
        String contents = await file.readAsString();
        List<dynamic> jsonData = jsonDecode(contents);
        if (jsonData.every((element) => element is Map<String, dynamic>)) {
          return jsonData.cast<Map<String, dynamic>>().toList();
        }
      }
      return [];
    } catch (e) {
      print('Error reading file: $e');
      return [];
    }
  }

  Future<void> storeFile(List<Map<String, dynamic>> vaccineData) async {
    await file.writeAsString(jsonEncode(vaccineData), mode: FileMode.write);
  }
}