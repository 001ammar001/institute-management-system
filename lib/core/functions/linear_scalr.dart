class ScaleLinear {
  ScaleLinear({
    required this.domainMin,
    required this.domainMax,
    required this.rangeMin,
    required this.rangeMax,
  })  : targetRange = rangeMax - rangeMin,
        domainRange = domainMax - domainMin;

  final num targetRange;
  final num domainRange;
  final num domainMin;
  final num domainMax;
  final num rangeMin;
  final num rangeMax;

  double calc(num value) {
    return (value - domainMin) * targetRange / domainRange + rangeMin;
  }

  double invert(num value) {
    return (value - rangeMin) * domainRange / targetRange + domainMin;
  }

  String numString(num value) {
    int counter = 0;
    List<String> letter = ["", "k", "m", "b", "T"];
    while (value >= 1000) {
      counter += 1;
      value /= 1000;
    }
    return "$value${letter[counter]}";
  }
}
