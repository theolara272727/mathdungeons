import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'geradordequestoes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int currentPageIndex = 1;
  int vidas = 3;
  int j = 0;
  int streak_counter = 0;

  void _onItemTapped(int index) {
    setState(() {
      currentPageIndex = index;
      print(index);
    });
  }

  void _onButtonPressed(int index){
    Navigator.push(context, MaterialPageRoute(builder: (context) => PaginaQuestao(index: index+1)));
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> ball_buttons = [];
    for (int i = 0; i < 50; i++) {
      ball_buttons.add(ElevatedButton(
        onPressed: (){
          _onButtonPressed(i);
        },
        style: ElevatedButton.styleFrom(
            primary: const Color.fromRGBO(69, 150, 83, 1),
            elevation: 7,
            alignment: Alignment.center,
          fixedSize: const Size(49, 49),
          shape: const CircleBorder()
        ),
        child: Text((i + 1).toString(),
            style: const TextStyle(
                fontSize: 15, color: Colors.white, fontFamily: "Mitr")),
      ));
    }

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: "Estatísticas",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Hub")
        ],
        currentIndex: currentPageIndex,
        onTap: _onItemTapped,
        iconSize: 40,
        showUnselectedLabels: false,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,

      ),
      appBar: AppBar(
          title: Text(
            "Nível",
            style: TextStyle(fontFamily: "Mitr", fontSize: 30),
          ),
          actions: <Widget>[
            for (int i = 0; i < vidas; i++)
              Icon(
                Icons.favorite,
                size: 40,
                color: Colors.red,
              ),
            //Container(
            //alignment: Alignment.center,
            //padding: EdgeInsets.all(10),
            //child: Text(
            //"Streak",
            //style: TextStyle(fontFamily: "Mitr",fontSize: 20
            //  ),
            // ),
            // ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(Icons.local_fire_department,
                    size: 40, color: Colors.orange))
          ]),
      body: <Widget>[
        Container(
          height: 10,
          width: 10,
        ), //PÁGINA DE ESTATÍSTICAS
        SingleChildScrollView(
          child: Column(
            children: [
              Stack(alignment: Alignment.center, children: <Widget>[
                Container(
                  width: 100000,
                  height: 925,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(233, 227, 227, 1),
                  ),
                ),
                Positioned(top: 114, left: 35, child: ball_buttons[0]),
                Positioned(top: 171, left: 52, child: ball_buttons[1]),
                Positioned(top: 207, left: 101, child: ball_buttons[2]),
                Positioned(top: 220, left: 164, child: ball_buttons[3]),
                Positioned(top: 231, left: 227, child: ball_buttons[4]),
                Positioned(top: 269, left: 276, child: ball_buttons[5]),
                Positioned(top: 334, left: 288, child: ball_buttons[6]),
                Positioned(top: 499, left: 290, child: ball_buttons[7]),
                Positioned(top: 766, left: 189, child: ball_buttons[17]),
                Positioned(top: 779, left: 254, child: ball_buttons[18]),
                Positioned(
                    top: 749.090087890625,
                    left: 124.5,
                    child: ball_buttons[16]),
                Positioned(top: 599.5, left: 86.5, child: ball_buttons[11]),
                Positioned(top: 584.5, left: 146.5, child: ball_buttons[10]),
                Positioned(
                    top: 633.6278686523438,
                    left: 35.56158447265625,
                    child: ball_buttons[13]),
                Positioned(
                    top: 633.6278686523438,
                    left: 35.56158447265625,
                    child: ball_buttons[12]),
                Positioned(
                    top: 741.3709716796875, left: 62, child: ball_buttons[14]),
                Positioned(
                    top: 694.3027954101562, left: 23, child: ball_buttons[13]),
                Positioned(
                    top: 576.0203857421875,
                    left: 204.5,
                    child: ball_buttons[9]),
                Positioned(
                    top: 554.2939453125, left: 262, child: ball_buttons[8]),
                Positioned(
                    top: -80,
                    child: Container(
                        width: 100000,
                        height: 183,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(181, 236, 248, 1),
                        ))),
                Positioned(
                    top: 810,
                    left: 116,
                    child: Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                  offset: Offset(0, 4),
                                  blurRadius: 4)
                            ],
                            color: Color.fromRGBO(76, 168, 235, 1),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                'Unidade 3',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontFamily: 'Mitr',
                                    fontSize: 20,
                                    letterSpacing:
                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                    fontWeight: FontWeight.normal,
                                    height: 1),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            width: 146,
                            height: 110,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/Floresta.png'),
                                  fit: BoxFit.fitHeight),
                            ))
                      ],
                    )),
                Positioned(
                    top: 385,
                    left: 142,
                    child: Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                  offset: Offset(0, 4),
                                  blurRadius: 4)
                            ],
                            color: Color.fromRGBO(76, 168, 235, 1),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const <Widget>[
                              Text(
                                'Unidade 2',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontFamily: 'Mitr',
                                    fontSize: 20,
                                    letterSpacing:
                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                    fontWeight: FontWeight.normal,
                                    height: 1),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            width: 138,
                            height: 110,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/Caverna.png'),
                                  fit: BoxFit.fitHeight),
                            ))
                      ],
                    )),
                Positioned(
                    top: 24,
                    left: 23,
                    child: Row(
                      children: [
                        Container(
                            width: 72,
                            height: 93,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/Castelo.png'),
                                  fit: BoxFit.fitHeight),
                            )),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                  offset: Offset(0, 4),
                                  blurRadius: 4)
                            ],
                            color: Color.fromRGBO(76, 168, 235, 1),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                'Unidade 1',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontFamily: 'Mitr',
                                    fontSize: 20,
                                    letterSpacing:
                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                    fontWeight: FontWeight.normal,
                                    height: 1),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ))
              ]),
            ],
          ),
        ), // PÁGINA HUB
      ][currentPageIndex],
    );
  }
}
