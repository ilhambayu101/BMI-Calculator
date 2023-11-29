import 'dart:async';
import 'package:flutter/material.dart';
import 'package:serasisehat/model/bmi.dart';
import 'package:table_calendar/table_calendar.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IMTPage();
  }
}

class IMTPage extends StatefulWidget {
  const IMTPage({Key? key}) : super(key: key);

  @override
  State<IMTPage> createState() => _IMTPageState();
}

class _IMTPageState extends State<IMTPage> {

  DateTime _today = DateTime.now();
  double _weight = 0.0;
  double _height = 0.0;

  late Timer _weightIncrementTimer;
  late Timer _weightDecrementTimer;
  late Timer _heightIncrementTimer;
  late Timer _heightDecrementTimer;

  @override
  void initState() {
    super.initState();
    _weightIncrementTimer = Timer.periodic(Duration(milliseconds: 5), (timer) {});
    _weightDecrementTimer = Timer.periodic(Duration(milliseconds: 5), (timer) {});
    _heightIncrementTimer = Timer.periodic(Duration(milliseconds: 5), (timer) {});
    _heightDecrementTimer = Timer.periodic(Duration(milliseconds: 5), (timer) {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Rekam BMI/IMT'),
        backgroundColor: Color(0xFF16172E),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Center(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TableCalendar(
                          locale: 'en_US',
                          rowHeight: 32,
                          calendarBuilders: CalendarBuilders(
                            dowBuilder: (context, day) {
                              if(day.weekday == DateTime.sunday){
                                return Center(child: Text('Min', style: TextStyle(color: Colors.white)));
                              } else if(day.weekday == DateTime.monday){
                                return Center(child: Text('Sen', style: TextStyle(color: Colors.white)));
                              } else if(day.weekday == DateTime.tuesday){
                                return Center(child: Text('Sel', style: TextStyle(color: Colors.white)));
                              } else if(day.weekday == DateTime.wednesday){
                                return Center(child: Text('Rab', style: TextStyle(color: Colors.white)));
                              } else if(day.weekday == DateTime.thursday){
                                return Center(child: Text('Kam', style: TextStyle(color: Colors.white)));
                              } else if(day.weekday == DateTime.friday){
                                return Center(child: Text('Jum', style: TextStyle(color: Colors.white)));
                              } else if(day.weekday == DateTime.saturday){
                                return Center(child: Text('Sab', style: TextStyle(color: Colors.white)));
                              }
                            },
                          ),
                          headerStyle: HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: true,
                            titleTextStyle: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500)
                          ),
                          calendarStyle: CalendarStyle(
                            outsideDaysVisible: false,
                            todayDecoration: BoxDecoration(
                              color: _today == DateTime.now() ? Colors.blue : Colors.blue.withOpacity(0.5),
                              shape: BoxShape.circle
                            ),
                            selectedDecoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle
                            ),
                            defaultTextStyle: TextStyle(color: Color(0xFF858D9C)), //tgl default
                            weekendTextStyle: TextStyle(color: Color(0xFF858D9C)),
                          ),
                          selectedDayPredicate: (day) {
                            return isSameDay(_today, day);
                          },
                          onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _today = selectedDay;
                          });
                        },
                          availableGestures: AvailableGestures.all,
                          focusedDay: _today,
                          firstDay: DateTime.utc(DateTime.now().year, 1, 1),
                          lastDay: DateTime.utc(DateTime.now().year, 12, 31),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Column(
                            children: [
                              Text('Weight (kg)', style: Theme.of(context).textTheme.labelLarge),
                              SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 32),
                                child: TextField(
                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  style: Theme.of(context).textTheme.titleLarge,
                                  controller: TextEditingController(text: _weight.toStringAsFixed(1)),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xFF16172E),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32),
                                      borderSide: BorderSide.none
                                    )
                                  ),
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    setState(() {
                                      _weight = double.parse(value);
                                    });
                                  },
                                ),
                              ),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onLongPress: _startWeightDecrement,
                                    onLongPressUp: _stopWeightDecrement,
                                    child: FloatingActionButton(
                                        heroTag: "wbtndecrement",
                                        onPressed: wdecremnt,
                                        mini: true,
                                        child: Icon(Icons.remove),
                                    ),
                                  ),
                                  SizedBox(width: 18),
                                  GestureDetector(
                                    onLongPress: _startWeightIncrement,
                                    onLongPressUp: _stopWeightIncrement,
                                    child: FloatingActionButton(
                                        heroTag: "wbtnincrement",
                                        onPressed: wincremnt,
                                        mini: true,
                                        child: Icon(Icons.add),
                                    ),
                                  )
                                ],
                              )

                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Column(
                            children: [
                              Text('Height (cm)', style: Theme.of(context).textTheme.labelLarge),
                              SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 32),
                                child: TextField(
                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  style: Theme.of(context).textTheme.titleLarge,
                                  controller: TextEditingController(text: _height.toStringAsFixed(1)),
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFF16172E),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(32),
                                          borderSide: BorderSide.none
                                      )
                                  ),
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    setState(() {
                                      _height = double.parse(value);
                                    });
                                  },
                                ),
                              ),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onLongPress: _startHeightDecrement,
                                    onLongPressUp: _stopHeightDecrement,
                                    child: FloatingActionButton(
                                      heroTag: "hbtndecrement",
                                      onPressed: hdecrement,
                                      mini: true,
                                      child: Icon(Icons.remove),
                                    ),
                                  ),
                                  SizedBox(width: 24),
                                  GestureDetector(
                                    onLongPress: _startHeightIncrement,
                                    onLongPressUp: _stopHeightIncrement,
                                    child: FloatingActionButton(
                                      heroTag: "hbtnincrement",
                                      onPressed: hincremnt,
                                      mini: true,
                                      child: Icon(Icons.add),
                                    ),
                                  )
                                ],
                              )

                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: ElevatedButton(
                            onPressed: addBMIRecord,
                            style: ButtonStyle(
                                padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 16))
                            ),
                            child: Text('Submit', style: Theme.of(context).textTheme.labelLarge)
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //add BMI Data functions
  void addBMIRecord() {
    //BMI formula
    double tinggiBadan_Meter = _height / 100;
    double hasilBMI = _weight / (tinggiBadan_Meter * tinggiBadan_Meter);

    //add new BMI Data
    BMI newBMIRecord = BMI(
      hasilBMI: hasilBMI,
      tglCek: _today,
      beratBadan: _weight,
      tinggiBadan: _height
    );
    setState(() {
      BMIList.add(newBMIRecord);
    });

    //navigate back to the firstpage
    Navigator.pop(context, BMIList);
  }

  //weight increment & decrement functions
  void wincremnt(){
    setState(() {
      if (_weight < 150) {
        _weight += 0.1;
      }
    });
  }

  void wdecremnt(){
    setState(() {
      if (_weight > 0.1) {
        _weight -= 0.1;
      } else {
        _weight = 0; // Set weight to 0 to avoid negative values
      }
    });
  }

  //height increment & decrement functions
  void hincremnt(){
    setState(() {
      if(_height < 220){
        _height += 0.1;
      }
    });
  }

  void hdecrement(){
    setState(() {
      if(_height > 0.1){
        _height -= 0.1;
      } else {
        _height = 0;
      }
    });
  }

  //LongPress weight increment functions
  void _startWeightIncrement() {
    _weightIncrementTimer = Timer.periodic(Duration(milliseconds: 5), (timer) {
      if (_weight < 150) {
        setState(() {
          _weight += 0.1; // You can adjust the increment value as needed
        });
      }
    });
  }

  void _stopWeightIncrement() {
    _weightIncrementTimer.cancel();
  }

  //LongPress weight decrement functions
  void _startWeightDecrement() {
    _weightDecrementTimer = Timer.periodic(Duration(milliseconds: 5), (timer) {
      setState(() {
        if (_weight > 0.1) {
          _weight -= 0.1;
        } else {
          _weight = 0; // Set weight to 0 to avoid negative values
        }
      });

    });
  }

  void _stopWeightDecrement() {
    _weightDecrementTimer.cancel();
  }

  //LongPress height increment functions
  void _startHeightIncrement() {
    _heightIncrementTimer = Timer.periodic(Duration(milliseconds: 5), (timer) {
      if (_height < 220) {
        setState(() {
          _height += 0.1;
        });
      }
    });
  }

  void _stopHeightIncrement() {
    _heightIncrementTimer.cancel();
  }

  //LongPress height decrement functions
  void _startHeightDecrement() {
    _heightDecrementTimer = Timer.periodic(Duration(milliseconds: 5), (timer) {
      setState(() {
        if (_height > 0.1) {
          _height -= 0.1;
        } else {
          _height = 0;
        }
      });
    });
  }

  void _stopHeightDecrement() {
    _heightDecrementTimer.cancel();
  }

  @override
  void dispose() {
    _weightIncrementTimer.cancel();
    _weightDecrementTimer.cancel();
    _heightIncrementTimer.cancel();
    _heightDecrementTimer.cancel();
    super.dispose();
  }

}
