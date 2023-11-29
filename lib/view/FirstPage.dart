import 'package:flutter/material.dart';
import 'package:serasisehat/model/bmi.dart';
import 'package:serasisehat/view/SecondPage.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints){
          if (constraints.maxWidth <= 600) {
            return MobilePage();
          }else if (constraints.maxWidth <= 800) {
            return TabletDesktopPage(gridCount: 3);
          } else if (constraints.maxWidth <= 1100){
            return TabletDesktopPage(gridCount: 4);
          } else {
            return TabletDesktopPage(gridCount: 6);
          }
        }
    );
  }
}

//Mobile Layout
class MobilePage extends StatefulWidget {
  const MobilePage({Key? key}) : super(key: key);

  @override
  State<MobilePage> createState() => _MobilePageState();
}

class _MobilePageState extends State<MobilePage> {

  BMI bmiData = BMIList.last;
  bool sttsberat      = true;
  double selisihBerat = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
            child: Column(
              children: [
                Center(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: Color(0xFF16172E),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Icon(Icons.calculate_outlined)),
                                SizedBox(width: 8),
                                Text(
                                  'BMI/IMT',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                            decoration: BoxDecoration(
                                color: Color(0xFF16172E),
                                border: Border.all(
                                    color: Color(0xFF16172E)
                                ),
                                borderRadius: BorderRadius.vertical(top: Radius.circular(8))
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Hasil', style: Theme.of(context).textTheme.labelLarge),
                                Icon(
                                  Icons.monitor_heart_outlined,
                                  color: _getColorByProgress(bmiData.hasilBMI),
                                )
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFF16172E), width: 4),
                                borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
                                color: Color(0xFF202137)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Column(
                                children: [
                                  Center(child: Text(bmiData.hasilBMI.toStringAsFixed(1), style: Theme.of(context).textTheme.headlineLarge)),
                                  Center(child: Text('${_gethasilcondition(bmiData.hasilBMI)}', style: TextStyle(color: Color(0xFF858D9C))))
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: bmiData.hasilBMI/40.00,
                              minHeight: 16,
                              backgroundColor: Color(0xFFF4F6FA),
                              valueColor: AlwaysStoppedAnimation<Color>(_getColorByProgress(bmiData.hasilBMI)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: Column(
                              children: [
                                Text('Weight (kg)', style: Theme.of(context).textTheme.labelLarge),
                                SizedBox(height: 24),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 20,
                                        backgroundColor: Color(0xFFF4F6FA),
                                        valueColor: AlwaysStoppedAnimation<Color>(_getColorByProgress(bmiData.hasilBMI)),
                                        value: bmiData.beratBadan/150,
                                      ),
                                    ),
                                    Text(bmiData.beratBadan.toStringAsFixed(1), style: Theme.of(context).textTheme.titleLarge,),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )),
                    Expanded(
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: Column(
                              children: [
                                Text('Height (Cm)', style: Theme.of(context).textTheme.labelLarge),
                                SizedBox(height: 24),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 20,
                                        backgroundColor: Color(0xFFF4F6FA),
                                        valueColor: AlwaysStoppedAnimation<Color>(_getColorByProgress(bmiData.hasilBMI)),
                                        value: bmiData.tinggiBadan/220,
                                      ),
                                    ),
                                    Text(bmiData.tinggiBadan.toStringAsFixed(1), style: Theme.of(context).textTheme.titleLarge,),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
                SizedBox(height: 24),
                Center(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: Color(0xFF16172E),
                                      borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Icon(Icons.history_outlined)),
                              SizedBox(width: 8),
                              Text('Riwayat', style: Theme.of(context).textTheme.titleLarge)
                            ],
                          ),
                          SizedBox(height: 16),
                          Container(
                            height: 200,
                            child: ListView.separated(
                              separatorBuilder: (context, index) {return Divider();},
                              itemCount: BMIList.length,
                              itemBuilder: (context, index) {
                                //data reversed
                                final BMI bmi = BMIList.reversed.toList()[index];

                                //selisih and status functions
                                if(index < BMIList.length - 1){
                                  double beratBadanSebelum = BMIList.reversed.toList()[index + 1].beratBadan;
                                  selisihBerat = bmi.beratBadan - beratBadanSebelum;
                                  sttsberat = bmi.beratBadan > beratBadanSebelum;
                                } else {
                                  sttsberat = true;
                                  selisihBerat = 0.0;
                                }

                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xFF16172E),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 4),
                                                child: Text('${bmi.tglCek.day}/${bmi.tglCek.month}/${bmi.tglCek.year}', style: Theme.of(context).textTheme.bodySmall,),
                                              ),
                                              SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Icon(
                                                      sttsberat ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                                                      color: sttsberat ? Colors.blue : Colors.red),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    selisihBerat.abs().toStringAsFixed(1),
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16,
                                                        color: sttsberat ? Colors.blue : Colors.red
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(bmi.beratBadan.toStringAsFixed(1), style: Theme.of(context).textTheme.titleLarge),
                                              Text(' kg', style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12
                                              ))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },

                            ),
                          )

                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final updatedBMIList = await Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return SecondPage();
            },
          ));

          // Check if the BMI list is updated
          if (updatedBMIList != null) {
            setState(() {
              BMIList = updatedBMIList;
              bmiData = BMIList.last;
            });
          }
        },
        child: Icon(Icons.add)
      ),
    );
  }
}

//Tablet Desktop Layout
class TabletDesktopPage extends StatefulWidget {
  final int gridCount;
  const TabletDesktopPage({Key? key, required this.gridCount}) : super(key: key);

  @override
  State<TabletDesktopPage> createState() => _TabletDesktopPageState();
}

class _TabletDesktopPageState extends State<TabletDesktopPage> {

  BMI bmiData = BMIList.last;
  bool sttsberat      = true;
  double selisihBerat = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Column(
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            color: Color(0xFF16172E),
                                            borderRadius: BorderRadius.circular(8)),
                                        child: Icon(Icons.calculate_outlined)),
                                    SizedBox(width: 8),
                                    Text(
                                      'BMI/IMT',
                                      style: Theme.of(context).textTheme.titleLarge,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 16),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                                decoration: BoxDecoration(
                                    color: Color(0xFF16172E),
                                    border: Border.all(
                                        color: Color(0xFF16172E)
                                    ),
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(8))
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Hasil', style: Theme.of(context).textTheme.labelLarge),
                                    Icon(
                                      Icons.monitor_heart_outlined,
                                      color: _getColorByProgress(bmiData.hasilBMI),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xFF16172E), width: 4),
                                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
                                    color: Color(0xFF202137)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  child: Column(
                                    children: [
                                      Center(child: Text(bmiData.hasilBMI.toStringAsFixed(1), style: Theme.of(context).textTheme.headlineLarge)),
                                      Center(child: Text('${_gethasilcondition(bmiData.hasilBMI)}', style: TextStyle(color: Color(0xFF858D9C))))
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: bmiData.hasilBMI/40.00,
                                  minHeight: 16,
                                  backgroundColor: Color(0xFFF4F6FA),
                                  valueColor: AlwaysStoppedAnimation<Color>(_getColorByProgress(bmiData.hasilBMI)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 63),
                          child: Column(
                            children: [
                              Text('Weight (kg)', style: Theme.of(context).textTheme.labelLarge),
                              SizedBox(height: 24),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 20,
                                      backgroundColor: Color(0xFFF4F6FA),
                                      valueColor: AlwaysStoppedAnimation<Color>(_getColorByProgress(bmiData.hasilBMI)),
                                      value: bmiData.beratBadan/150,
                                    ),
                                  ),
                                  Text(bmiData.beratBadan.toStringAsFixed(1), style: Theme.of(context).textTheme.titleLarge,),
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
                          padding: EdgeInsets.symmetric(vertical: 63),
                          child: Column(
                            children: [
                              Text('Height (Cm)', style: Theme.of(context).textTheme.labelLarge),
                              SizedBox(height: 24),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 20,
                                      backgroundColor: Color(0xFFF4F6FA),
                                      valueColor: AlwaysStoppedAnimation<Color>(_getColorByProgress(bmiData.hasilBMI)),
                                      value: bmiData.tinggiBadan/220,
                                    ),
                                  ),
                                  Text(bmiData.tinggiBadan.toStringAsFixed(1), style: Theme.of(context).textTheme.titleLarge,),
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
                Center(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: Color(0xFF16172E),
                                      borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Icon(Icons.history_outlined)),
                              SizedBox(width: 8),
                              Text('Riwayat', style: Theme.of(context).textTheme.titleLarge)
                            ],
                          ),
                          SizedBox(height: 16),
                          Container(
                            height: 200,
                            child: GridView.count(
                              crossAxisCount: widget.gridCount,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              children: BMIList.map((index){
                                //data reversed
                                final BMI bmi = BMIList.reversed.toList()[BMIList.indexOf(index)];

                                //selisih and status functions
                                if(BMIList.indexOf(index) < BMIList.length - 1){
                                  double beratBadanSebelum = BMIList.reversed.toList()[BMIList.indexOf(index) + 1].beratBadan;
                                  selisihBerat = bmi.beratBadan - beratBadanSebelum;
                                  sttsberat = bmi.beratBadan > beratBadanSebelum;
                                } else {
                                  sttsberat = true;
                                  selisihBerat = 0.0;
                                }

                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xFF16172E),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 4),
                                                    child: Text('${bmi.tglCek.day}/${bmi.tglCek.month}/${bmi.tglCek.year}', style: Theme.of(context).textTheme.bodySmall,),
                                                  ),
                                                  SizedBox(height: 4),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                          sttsberat ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                                                          color: sttsberat ? Colors.blue : Colors.red),
                                                      SizedBox(width: 4),
                                                      Text(
                                                        selisihBerat.abs().toStringAsFixed(1),
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 16,
                                                            color: sttsberat ? Colors.blue : Colors.red
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Text(bmi.beratBadan.toStringAsFixed(1), style: Theme.of(context).textTheme.headlineLarge),
                                                      Text(' kg', style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12
                                                      ))
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          )

                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final updatedBMIList = await Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return SecondPage();
            },
          ));

          // Check if the BMI list is updated
          if (updatedBMIList != null) {
            setState(() {
              BMIList = updatedBMIList;
              bmiData = BMIList.last;
            });
          }
        },
        child: Icon(Icons.add),
        mini: true,
      ),
    );
  }
}

//get Color Progress functions
Color _getColorByProgress(double progress) {
  if (progress < 18.50) {
    return Colors.red;
  } else if (progress < 25.00) {
    return Colors.blue;
  } else if (progress < 30.00) {
    return Colors.orange;
  } else {
    return Colors.red;
  }
}

//get condition functions
String _gethasilcondition(double nilai) {
  String clasification;

  if (nilai < 18.50) {
    clasification = 'Under Weight';
    return clasification;
  } else if (nilai < 25.00) {
    clasification = 'Normal';
    return clasification;
  } else if (nilai < 30.00) {
    clasification = 'OverWeight';
    return clasification;
  } else {
    clasification = 'Obesitas';
    return clasification;
  }
}