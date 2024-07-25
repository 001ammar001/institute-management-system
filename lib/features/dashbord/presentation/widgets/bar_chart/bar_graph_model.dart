import 'package:flutter/material.dart';
import 'package:institute_management_system/features/dashbord/presentation/widgets/bar_chart/graph_model.dart';

class BarGraphModel {
  String lable;
  Color color;
  List<GraphModel> graph;

  BarGraphModel(
      {required this.lable, required this.color, required this.graph});
}
