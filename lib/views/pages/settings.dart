import 'package:flutter/material.dart';

double _currentValue = 0;
double _currentValue1 = 0;
double _speedcurrentValue = 0;

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.bluetooth),
          iconSize: 40,
          onPressed: () {
            // Action when the leading icon is pressed
          },
        ),
        title: Text('Settings'),
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 40, color: Colors.amberAccent),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              Text(
                "Speed",
                style: TextStyle(fontSize: 25, color: Colors.deepOrangeAccent),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Slider(
                  value: _speedcurrentValue,
                  min: 0,
                  max: 9,
                  divisions: 10,
                  onChanged: (double newValuespeed) {
                    setState(() {
                      _speedcurrentValue = newValuespeed;
                    });
                  },
                ),
              ),
              SizedBox(width: 10),
              Text(
                'Value: ${_speedcurrentValue.toStringAsFixed(0)}',
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),

          SizedBox(height: 20, width: 20),
          Container(
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(20),
            ),
            height: 250,
            width: 400,

            child: Column(
              children: [
                SizedBox(height: 20, width: 21),
                Row(
                  children: [
                    Icon(Icons.lightbulb)),
                    SizedBox(width: 8),
                    Text(
                      "LED",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "Brightness",
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.start,
                    ),
                    Container(
                      decoration: BoxDecoration(),
                      width: 250,
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
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
