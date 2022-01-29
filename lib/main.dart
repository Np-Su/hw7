import 'dart:math';

import 'package:flutter/material.dart';

import 'game.dart';

void main() {
  const app = MyApp();
  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // callback method
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     /* title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),*/
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final _controller = TextEditingController();
  late Game _game;

  HomePage({Key? key}) : super(key: key) {
    _game = Game(maxRandom: 100);
  }

  void _showOkDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var showSeven = true;

    return Scaffold(
      /*appBar: AppBar(
        title: const Text('GUESS THE NUMBER'),
      ),*/
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.purple.shade100,
                offset: Offset(5.0, 5.0),
                spreadRadius: 2.0,
                blurRadius: 5.0,
              )
            ],
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /*Row(
                children: [
                  Container(width: 50.0, height: 50.0, color: Colors.blue),
                  Expanded(
                    child: Container(
                      width: 30.0,
                      height: 50.0,
                      //color: Colors.pink,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text('FLUTTER', textAlign: TextAlign.end,),
                      ),
                      alignment: Alignment.centerRight,
                    ),
                  ),
                  //SizedBox(width: 10.0),
                ],
              ),*/
              /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: Container(color: Colors.green, width: 100.0, height: 50.0)),
                  Container(color: Colors.red, width: 50.0, height: 50.0),
                ],
              ),*/
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /*Image.asset('assets/images/guess_logo.png', width: 90.0),
                    SizedBox(width: 8.0),*/
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.https,         // รูปไอคอน
                          size: 60.0,           // ขนาดไอคอน
                          color: Colors.indigoAccent,   // สีไอคอน
                        ),
                        SizedBox(height: 20,),
                        Text(
                          'กรุณาใส่รหัสผ่าน',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.purple.shade600,
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            /*  Padding(
                padding: const EdgeInsets.all(16.0),

              ),*/
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 1; i <= 3; i++) _buildButton4(num :i),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 4; i <= 6; i++) _buildButton4(num: i),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 7; i <= 9; i++) _buildButton4(num: i),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 70,height: 70,),
                  Container(width: 70,height: 70,child: _buildButton4(num:0),),
                  Container(width: 70,height: 70,child: Icon(
                                                Icons.backspace,         // รูปไอคอน
                                                size: 30.0,           // ขนาดไอคอน
                                                color: Colors.indigoAccent,   // สีไอคอน
                                              )
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  child: Text('ลืมรหัสผ่าน'),
                  onPressed: () {
                    var input = _controller.text;
                    var guess = int.tryParse(input);

                    /*if (guess == null) {
                      _showOkDialog(context, 'ERROR',
                          'กรอกข้อมูลไม่ถูกต้อง ให้กรอกเฉพาะตัวเลขเท่านั้น');
                      return;
                    }*/

                    late String message;
                    var guessResult = _game.doGuess(guess!);
                    if (guessResult > 0) {
                      message = '$guess มากเกินไป กรุณาลองใหม่';
                    } else if (guessResult < 0) {
                      message = '$guess น้อยเกินไป กรุณาลองใหม่';
                    } else {
                      message =
                      '$guess ถูกต้องครับ 🎉\n\nคุณทายทั้งหมด ${_game.guessCount} ครั้ง';
                    }

                    _showOkDialog(context, 'RESULT', message);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton({int? num}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: OutlinedButton(
          onPressed: () {
            print('You pressed $num');
          },
          child: Text('$num')),
    );
  }
  // วงกลม
  Widget _buildButton4({int? num}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 60.0,
        height: 60.0,
        //color: Colors.green, // ห้ามกำหนด color ตรงนี้ ถ้าหากกำหนดใน BoxDecoration แล้ว
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Align(
            alignment: Alignment.center,
          child: Text(
            '$num',
            textAlign: TextAlign.center,
            style:TextStyle(fontSize: 20)
          ),
        ),
      ),
    );
  }
}