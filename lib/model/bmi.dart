import 'package:serasisehat/model/tubuh.dart';

class BMI extends Tubuh{
  double hasilBMI;
  DateTime tglCek;

  BMI({
    required this.hasilBMI,
    required this.tglCek,
    required double beratBadan,
    required double tinggiBadan,
  }) : super(
          beratBadan: beratBadan,
          tinggiBadan: tinggiBadan
        );
}

var BMIList = [

  BMI(
      hasilBMI: 25.5,
      tglCek: DateTime.now(),
      beratBadan: 70.0,
      tinggiBadan: 175
  ),
  BMI(
      hasilBMI: 20.5,
      tglCek: DateTime.now(),
      beratBadan: 60.0,
      tinggiBadan: 175
  ),
  BMI(
      hasilBMI: 23.5,
      tglCek: DateTime.now(),
      beratBadan: 65.5,
      tinggiBadan: 175
  ),
  BMI(
      hasilBMI: 24.5,
      tglCek: DateTime.now(),
      beratBadan: 65.9,
      tinggiBadan: 175,
  ),

];