import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_kanso/views/pages/connect_devices.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

double _currentValue = 0;
double _currentValue1 = 0;
double _speedcurrentValue = 0;
double _intensitycurrentValue = 0;
double _intensityvibrationcurrentValue = 0;
double _colorsNb = 0;

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.bluetooth),
          iconSize: 40,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ConnectDevices()),
            );
          },
        ),
        title: Text('Settings'),
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 40, color: Colors.amberAccent),
      ),
      body: Expanded(
        child: Container(
          decoration: BoxDecoration(color: Colors.teal[50]),
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 20, width: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                height: MediaQuery.of(context).size.height * 0.76,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.teal[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: MediaQuery.of(context).size.height * 0.22,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Column(
                        children: [
                          SizedBox(height: 20, width: 20),
                          Row(
                            children: [
                              SizedBox(height: 20, width: 21),
                              Icon(Icons.lightbulb, color: Colors.teal[800]),
                              Text(
                                " LED",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.teal[800],
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.end,
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                          Center(
                            child: Row(
                              children: [
                                SizedBox(height: 20, width: 20),
                                Text(
                                  "Brightness",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal[800],
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Expanded(
                                  child: Slider(
                                    value: _currentValue,
                                    min: 0,
                                    max: 9,
                                    divisions: 10,
                                    onChanged: (double newValue) {
                                      setState(() {
                                        _currentValue = newValue;
                                      });
                                    },
                                  ),
                                ),
                                Text(
                                  'Value: ${_currentValue.toStringAsFixed(0)}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal[800],
                                  ),
                                ),
                                SizedBox(height: 20, width: 25),
                              ],
                            ),
                          ),
                          SizedBox(height: 10, width: 15),
                          Center(
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 25,
                                  width:
                                      MediaQuery.of(context).size.width * 0.07,
                                ),
                                InkWell(
                                  splashColor: const Color.fromARGB(
                                    75,
                                    18,
                                    18,
                                    241,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _colorsNb = 0;
                                    });
                                  },
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                  width:
                                      MediaQuery.of(context).size.width * 0.04,
                                ),
                                InkWell(
                                  splashColor: CupertinoColors.placeholderText,
                                  onTap: () {
                                    setState(() {
                                      _colorsNb = 1;
                                    });
                                  },
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                  width:
                                      MediaQuery.of(context).size.width * 0.04,
                                ),
                                InkWell(
                                  splashColor: CupertinoColors.placeholderText,
                                  onTap: () {
                                    setState(() {
                                      _colorsNb = 2;
                                    });
                                  },
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                      color: Colors.tealAccent,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                  width:
                                      MediaQuery.of(context).size.width * 0.04,
                                ),
                                InkWell(
                                  splashColor: CupertinoColors.placeholderText,
                                  onTap: () {
                                    setState(() {
                                      _colorsNb = 3;
                                    });
                                  },
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                  width:
                                      MediaQuery.of(context).size.width * 0.04,
                                ),
                                InkWell(
                                  splashColor: CupertinoColors.placeholderText,
                                  onTap: () {
                                    setState(() {
                                      _colorsNb = 4;
                                    });
                                  },
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                  width:
                                      MediaQuery.of(context).size.width * 0.04,
                                ),
                                InkWell(
                                  splashColor: CupertinoColors.placeholderText,
                                  onTap: () {
                                    setState(() {
                                      _colorsNb = 5;
                                    });
                                  },
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                  width:
                                      MediaQuery.of(context).size.width * 0.04,
                                ),
                                InkWell(
                                  splashColor: CupertinoColors.placeholderText,
                                  onTap: () {
                                    setState(() {
                                      _colorsNb = 6;
                                    });
                                  },
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                  width:
                                      MediaQuery.of(context).size.width * 0.04,
                                ),
                                InkWell(
                                  splashColor: CupertinoColors.placeholderText,
                                  onTap: () {
                                    setState(() {
                                      _colorsNb = 7;
                                    });
                                  },
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                      color: Colors.pink,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                  width:
                                      MediaQuery.of(context).size.width * 0.04,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.014,
                      width: 10,
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: MediaQuery.of(context).size.height * 0.21,
                        width: MediaQuery.of(context).size.width * 0.8,

                        child: Column(
                          children: [
                            SizedBox(height: 20, width: 20),
                            Row(
                              children: [
                                SizedBox(height: 20, width: 21),
                                Icon(
                                  Icons.volume_up_outlined,
                                  color: Colors.teal[800],
                                ),
                                Text(
                                  " SOUND",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.teal[800],
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(height: 20, width: 20),
                                Text(
                                  "Intensity",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal[800],
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Expanded(
                                  child: Slider(
                                    value: _intensitycurrentValue,
                                    min: 0,
                                    max: 9,
                                    divisions: 10,
                                    onChanged: (double newValue) {
                                      setState(() {
                                        _intensitycurrentValue = newValue;
                                      });
                                    },
                                  ),
                                ),
                                Text(
                                  'Value: ${_intensitycurrentValue.toStringAsFixed(0)}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal[800],
                                  ),
                                ),
                                SizedBox(height: 20, width: 25),
                              ],
                            ),

                            Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.teal[900],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    height: 40,
                                    width: 140,
                                    child: Center(
                                      child: Text(
                                        "CLAP",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.green[100],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 18),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.teal[900],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    height: 40,
                                    width: 140,
                                    child: Center(
                                      child: Text(
                                        "Drop",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.green[100],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.014,
                      width: 10,
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: MediaQuery.of(context).size.height * 0.21,
                        width: MediaQuery.of(context).size.width * 0.8,

                        child: Column(
                          children: [
                            SizedBox(height: 20, width: 20),
                            Row(
                              children: [
                                SizedBox(height: 20, width: 21),
                                Icon(
                                  Icons.volume_up_outlined,
                                  color: Colors.teal[800],
                                ),
                                Text(
                                  " VIBRATION",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.teal[800],
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.end,
                                ),

                                SizedBox(height: 20, width: 20),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(height: 20, width: 20),
                                Text(
                                  "Intensity",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal[800],
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Expanded(
                                  child: Slider(
                                    value: _intensityvibrationcurrentValue,
                                    min: 0,
                                    max: 9,
                                    divisions: 10,
                                    onChanged: (double newValue) {
                                      setState(() {
                                        _intensityvibrationcurrentValue =
                                            newValue;
                                      });
                                    },
                                  ),
                                ),
                                Text(
                                  'Value: ${_intensityvibrationcurrentValue.toStringAsFixed(0)}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal[800],
                                  ),
                                ),
                                SizedBox(height: 20, width: 25),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    height: 40,
                                    width: 140,
                                    child: Center(
                                      child: Text(
                                        "two dots",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.green[100],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 18),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    height: 40,
                                    width: 140,
                                    child: Center(
                                      child: Text(
                                        "Twice dots",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.green[100],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
