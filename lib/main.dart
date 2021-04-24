import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Stopwatch watch = new Stopwatch();
  Timer timer;
  String elapsedtime = "00:00:00";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stopwatch"),
      ),
      body: Center(
        child: new Container(
          padding: EdgeInsets.all(20.0),
          width: 400.0,
          height: 200.0,
          child: Column(
            children: [
              Text("$elapsedtime"),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    child: Icon(
                      Icons.play_arrow,
                      size: 50.0,
                    ),
                    onPressed: startwatch,
                  ),
                  SizedBox(
                    width: 20.1,
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.red,
                    child: Icon(
                      Icons.stop,
                      size: 50.0,
                    ),
                    onPressed: stopwatch,
                  ),
                  SizedBox(
                    width: 20.1,
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.refresh,
                      size: 50.0,
                    ),
                    onPressed: restartwatch,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  setTime() {
    var times = watch.elapsedMilliseconds;
    setState(() {
      elapsedtime = transform(times);
    });
  }

  transform(int millisec) {
    int hundreds = (millisec / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int min = (seconds / 60).truncate();

    String minstr = (min % 60).toString().padLeft(2, '0');
    String sec = (seconds % 60).toString().padLeft(2, '0');
    String hund = (hundreds % 100).toString().padLeft(2, '0');

    return "$minstr:$sec:$hund";
  }

  updateTime(Timer timer) {
    setState(() {
      elapsedtime = transform(watch.elapsedMilliseconds);
    });
  }

  startwatch() {
    watch.start();
    timer = new Timer.periodic(new Duration(milliseconds: 100), updateTime);
  }

  stopwatch() {
    watch.stop();
    setTime();
  }

  restartwatch() {
    watch.reset();
    setTime();
  }
}
