import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'dart:convert';
import 'package:units_converter/units_converter.dart';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math' as math;

class Questao {
  Questao(this.question, this.answer, this.unit_from, this.unit_to) {}

  num? question;
  String? answer;
  String? unit_from;
  String? unit_to;

  Questao.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    answer = json['answer'];
    unit_from = json['unit_from'];
    unit_to = json['unit_to'];
  }

  String getEnunciado() {
    return """Joazinho quer converter de $question $unit_from para $unit_to. Quantos $unit_to ele terá? (psst, a resposta é $answer)
    """;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonData = new Map<String, dynamic>();
    jsonData['question'] = this.question;
    jsonData['answer'] = this.answer;
    jsonData['unit_from'] = this.unit_from;
    jsonData['unit_to'] = this.unit_to;

    return jsonData;
  }
}

class PaginaQuestao extends StatefulWidget {
  PaginaQuestao({Key? key, required this.index}) : super(key: key);

  int index = 0;

  @override
  State<PaginaQuestao> createState() => _PaginaQuestaoState();
}

class _PaginaQuestaoState extends State<PaginaQuestao> {
  String? textoQuestao;
  late Questao questao;
  String? userAnswer;
  late TextEditingController _controller;
  int responseIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _PaginaQuestaoState() {
    //deleteFile();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/questao${widget.index}.txt');
  }

  Future<File> writeQuestion() async {
    final file = await _localFile;

    String questao = geradorDeQuestao();
    // Write the file
    return file.writeAsString(questao);
  }

  Future<String> readQuestion() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      writeQuestion();
      return readQuestion();
    }
  }

  Future<int> deleteFile() async {
    try {
      final file = await _localFile;

      await file.delete();
      return 1;
    } catch (e) {
      return 0;
    }
  }

  void fetchQuestion() async {
    String gotQuestion = await readQuestion();
    setState(() {
      textoQuestao = gotQuestion;
      questao = Questao.fromJson(json.decode(textoQuestao!));
    });
  }

  void _onSubmitted(String response, String? answer) {
    if (response == answer) {
      setState(() {
        responseIndex = 1;
        //_onRight()
      });
    } else {
      setState(() {
        responseIndex = 2;
        //_onWrong()
      });
    }
  }

  String geradorDeQuestao() {
    List<num> unidades = [
      math.pow(10, 9),
      math.pow(10, 6),
      math.pow(10, 3),
      1,
      math.pow(10, -3),
      math.pow(10, -6),
      1 / 1000000000
    ];
    List<String> stringUnits = [
      'km³',
      'hm³',
      'dam³',
      'm³',
      'dm³',
      'cm³',
      'mm³'
    ];
    int chosenFrom = math.Random().nextInt(7);
    int chosenTo = math.Random().nextInt(6);
    num from = unidades[chosenFrom];
    String unit_from = stringUnits[chosenFrom];
    List<num> n_unidades = unidades;
    List<String> n_stringUnits = stringUnits;
    n_unidades.removeAt(unidades.indexOf(from));
    n_stringUnits.removeAt(stringUnits.indexOf(unit_from));
    String unit_to = n_stringUnits[chosenTo];
    num to = n_unidades[chosenTo];
    int coefficient = (math.Random().nextInt(100) + 1);
    num question = coefficient;
    String answer = ((question * from / to).toStringAsFixed(18));

    while (answer[answer.length - 1] == '0') {
      answer = answer.substring(0, answer.length - 1);
    }
    int coefficientIndex = answer.indexOf(coefficient.toString()[0]);

    if (answer.endsWith('.') == true) {
      answer = answer.substring(0, answer.length - 1);
    } else if ((answer.length - (coefficientIndex + 1)) > 2) {
      int newCoefficient = ((int.parse(
                  answer.substring(coefficientIndex, coefficientIndex + 3))) /
              10)
          .ceil();
      answer =
          answer.substring(0, coefficientIndex) + newCoefficient.toString();
    }
    ;

    return '{"question": $question, "answer": "$answer", "unit_from": "$unit_from", "unit_to": "$unit_to"}';
  }

  @override
  Widget build(BuildContext context) {
    fetchQuestion();
    Widget questaoEnunciado = textoQuestao == null
        ? Container(
            alignment: Alignment.center,
            child: Text(
              "Carregando...",
              style: TextStyle(fontFamily: 'Mitr', fontSize: 40),
            ))
        : Container(
            padding: EdgeInsets.all(30),
            child: Text(
              questao.getEnunciado(),
              overflow: TextOverflow.clip,
              style: TextStyle(fontFamily: 'Mitr', fontSize: 15),
              textAlign: TextAlign.justify,
            ),
          );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Questão ${widget.index}",
          style: TextStyle(fontFamily: "Mitr", fontSize: 30),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromRGBO(224, 224, 224, 1), width: 10),
                  color: Color.fromRGBO(204, 204, 204, 1),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: questaoEnunciado,
            ),
            SizedBox(height: 40),
            <Widget>[
              Container(
                width: 200,
                height: 100,
                child: TextField(
                  controller: _controller,
                  onSubmitted: (String response) {
                    _onSubmitted(response, questao.answer);
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Digite sua resposta aqui'),
                ),
              ),
              const Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.celebration,
                      color: Colors.green,
                      size: 40,
                    ),
                    Text(
                      'Acertou!',
                      style: TextStyle(
                          color: Colors.green,
                          fontFamily: 'Mitr',
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.celebration,
                      color: Colors.green,
                      size: 40,
                    )
                  ],
                ),
              ),
              const Padding(
                padding: const EdgeInsets.symmetric(vertical: 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 40,
                    ),
                    Text(
                      'Errou!',
                      style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'Mitr',
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 40,
                    )
                  ],
                ),
              ),
            ][responseIndex]
          ],
        ),
      ),
    );
  }
}
