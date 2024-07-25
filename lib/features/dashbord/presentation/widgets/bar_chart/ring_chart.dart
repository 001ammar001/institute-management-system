import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';


class RingChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {
      "دورات ICDL": 20,
      "دورات انكليزي": 20,
      "دورات الأمين": 20,
      "دورات تمريض": 15,
      "دورات sf": 10,
      "  دورات تمريض  2 ": 15,
    };
//CustomCard
    return PieChart(
      dataMap: dataMap,
      chartType: ChartType.ring,
      chartValuesOptions:  ChartValuesOptions(
        showChartValuesInPercentage: true,
        showChartValueBackground: false,
        showChartValues: (MediaQuery.of(context).size.width>500)?true:false,
        showChartValuesOutside: false,
        decimalPlaces: 0,
      ),
      animationDuration: const Duration(milliseconds: 2000),
      chartLegendSpacing: 15.0,
      chartRadius: MediaQuery.of(context).size.width / 2.7,
      colorList: const [Colors.purpleAccent, Colors.orangeAccent, Colors.purple, Colors.yellow],
      legendOptions:  LegendOptions(
        showLegendsInRow: true,
        legendPosition: LegendPosition.bottom,
        showLegends: (MediaQuery.of(context).size.width>900 )?true:false,
        legendShape: BoxShape.circle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize:  MediaQuery.of(context).size.width / 100,
        ),
      ),
      emptyColor: Colors.grey,
    );
  }
}