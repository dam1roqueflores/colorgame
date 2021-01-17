import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:flutter/services.dart';
//
bool jugando=false;
//main
void main() {
  runApp(RandomColors());
}

// RamdomColors
class RandomColors extends StatefulWidget {
  @override
  _RandomColors createState() => _RandomColors();
}

//
class _RandomColors extends State<RandomColors> {
  int points = 0;
  String randomName;
  Color randomColor;
  var colorNames = ['azul', 'verde', 'naranja', 'rosa', 'rojo', 'amarillo'];
  var colorHex = [
    Color(0xFF0000FF),
    Color(0xFF00FF00),
    Color(0xFFFF914D),
    Color(0xFFFF66C4),
    Color(0xFFFF0000),
    Color(0xFFFBC512)
  ];

  // estado inicial
  @override
  void initState() {
    super.initState();
    getRandomColor();
    getRandomName();
    timer();
  }

  //Temporizador
  void timer() {
      Timer.periodic(Duration(milliseconds: 1500), (timer) {
        // si hemos pulsado el botón play
        if (jugando) {
            getRandomColor();
            getRandomName();
        }
        // refrescamos el estado de la pantalla
        setState(() {});
      }
      );
  }

// Widget Scaffold
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
      Scaffold(
        backgroundColor: Colors.white,
        body: new Stack(
          children: <Widget> [
            new Container(
              decoration:new BoxDecoration(
                image: new DecorationImage(
                   image: new AssetImage("assets/fondo.jpg"),
                    fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // contenedor de puntos
                Container (
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  height: 100,
                  width: 300,
                  constraints: BoxConstraints(
                    minWidth: 200,
                    maxWidth: 500,
                    minHeight: 50,
                    maxHeight: 100,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    border:Border.all(width: 5,),
                    borderRadius: BorderRadius.circular(12),
                    gradient: RadialGradient(
                      radius: 0.7,
                      colors: [Colors.white10,Colors.blueAccent]
                    )
                  ),
                  child: Text('Puntos: $points',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Roboto",
                        fontSize: 30,
                        color: Colors.black,
                    ),
                  ),
                ),

                // para detectar los gesture en el cuadrado
                Center(
                  child: GestureDetector(
                    onTap: () {
                      onGiftTap(randomName, randomColor);
                    },

                    //contenedor del color
                    child: Column(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            boxShadow: [
                              new BoxShadow(
                                color: randomColor,
                                offset: new Offset(10.0, 10.0),
                              ),
                            ],
                            color: randomColor,
                            gradient:LinearGradient(
                              colors: [Colors.white,randomColor],
                            ),
                            border:Border.all(width: 5,),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        // texto del color
                        Text(
                          randomName,
                          style: TextStyle(
                              color: randomColor,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),

                // contenedor de los botones
                Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  height: 100,
                  width: 300,
                  constraints: BoxConstraints(
                    minWidth: 200,
                    maxWidth: 500,
                    minHeight: 50,
                    maxHeight: 100,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    border:Border.all(width: 10,),
                    borderRadius: BorderRadius.circular(12),
                    gradient: SweepGradient (
                      center: FractionalOffset.center,
                      startAngle: 0.0,
                      endAngle: pi * 2,
                      colors: const <Color>[
                        Color(0xFF4285F4), // blue
                        Color(0xFF34A853), // green
                        Color(0xFFFBBC05), // yellow
                        Color(0xFFEA4335), // red
                        Color(0xFF4285F4), // blue again to seamlessly transition to the start
                      ],
                      stops: const <double>[0.0, 0.25, 0.5, 0.75, 1.0],
                    )
                  ),
                  child: Row(
                    children: [
                      Align(
                        child:
                        ElevatedButton.icon(
                          label: Text('Start',),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            textStyle: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                            ),
                          ),
                          icon: Icon(Icons.play_arrow),
                          onPressed: () {jugando=true;},
                        ),
                      ),
                      Container(
                        width: 4,
                        height: 7,
                        //color: Colors.green,
                      ),
                      Align(
                        child:
                        ElevatedButton.icon(
                          label: Text('Stop',),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            textStyle: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                            ),
                          ),
                          icon: Icon(Icons.stop),
                          onPressed: () {jugando=false;},
                        ),
                      ),
                      Container(
                        width: 4,
                        height: 7,
                        //color: Colors.green,
                      ),
                      Align(
                        child:
                        ElevatedButton.icon(
                          label: Text('Exit',),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.indigo[900],
                            textStyle: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          icon: Icon(Icons.exit_to_app_rounded),
                          onPressed: () {
                            jugando=false;
                            SystemNavigator.pop();
                            },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // obtiene un color aleatorio
  void getRandomColor() {
    Random random = new Random();
    int randomNumber = random.nextInt(5);
    randomColor = colorHex[randomNumber];
  }

  // obtiene un nombre aleatorio
  void getRandomName() {
    Random random = new Random();
    int randomNumber = random.nextInt(5);
    randomName = colorNames[randomNumber];
  }
  // pasa de hex a color
  String hexToStringConverter(Color hexColor) {
    if (hexColor == Color(0xFF0000FF)) {
      return 'azul';
    } else if (hexColor == Color(0xFF00FF00)) {
      return 'verde';
    } else if (hexColor == Color(0xFFFF914D)) {
      return 'naranja';
    } else if (hexColor == Color(0xFFFF66C4)) {
      return 'rosa';

    } else if (hexColor == Color(0xFFFF0000)) {
      return 'rojo';
    } else {
      return 'amarillo';
    }
  }

  // comprueba que el color del cuadrado y el texto coinciden.
  void onGiftTap(String name, Color color) {
    var colorToString = hexToStringConverter(color);
    print(colorToString);
    print(name);
    if (name == colorToString) {
      points++;
    } else {
      points--;
    }
    setState(() {});
  }
}

