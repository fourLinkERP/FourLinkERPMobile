import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'resources/designChart.dart';


class Charts extends StatefulWidget {
  const Charts({Key? key}) : super(key: key);

  @override
  State<Charts> createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  List<Color> gradientColors = [
    //AppColors.contentColorCyan,
    AppColors.contentColorYellow,
    AppColors.contentColorGreen,
    AppColors.contentColorPurple,
    AppColors.contentColorBlue,
    AppColors.itemsBackground,
  ];

  bool showAvg = false;
  late int showingTooltip = 0;



  BarChartGroupData generateGroupData(int x, int y) {
    return BarChartGroupData(
      x: x,
      showingTooltipIndicators: showingTooltip == x ? [0] : [],
      barRods: [
        BarChartRodData(
            fromY: 0,
            toY: y.toDouble(),
            color: AppColors.contentColorPurple,
            width: 18,
          borderRadius: const BorderRadius.all(
              Radius.circular(2.0)
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    showingTooltip = -1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ListTile(
          leading: Image.asset('assets/images/logowhite2.png', scale: 3),
          title: Text(
            'Bar Chart'.tr(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: const Color.fromRGBO(144, 16, 46, 1),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
          //  Expanded(
              AspectRatio(
                aspectRatio: 1.70,
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 18,
                    left: 12,
                    top: 10,
                    bottom: 10,
                  ),
                  child: LineChart(
                    showAvg ? avgData() : mainData(),

                  ),
                ),
              ),
            //),
            const Center(
              child: Text("Pie Chart", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              height: 200, // Set the desired height for the pie chart
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: PieChart(
                  PieChartData(
                    sections: List.generate(
                      5, // Number of sections in the pie chart
                          (index) => PieChartSectionData(
                        color: gradientColors[index % Colors.accents.length],
                        //value: 1.0, // Change this to the value for each section
                        //title: 'value $index', // Change this to the title for each section
                        radius: 45, // Adjust the radius for better visibility
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 250,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: AspectRatio(
                    aspectRatio: 2,
                    child: BarChart(
                      BarChartData(
                        barGroups: [
                          generateGroupData(1, 10),
                          generateGroupData(2, 18),
                          generateGroupData(3, 6),
                          generateGroupData(4, 8),
                          generateGroupData(5, 15),
                        ],
                        barTouchData: BarTouchData(
                            enabled: true,
                            handleBuiltInTouches: false,
                            touchCallback: (event, response) {
                              if (response != null && response.spot != null && event is FlTapUpEvent) {
                                setState(() {
                                  final x = response.spot!.touchedBarGroup.x;
                                  final isShowing = showingTooltip == x;
                                  if (isShowing) {
                                    showingTooltip = -1;
                                  } else {
                                    showingTooltip = x;
                                  }
                                });
                              }
                            },
                            mouseCursorResolver: (event, response) {
                              return response == null || response.spot == null
                                  ? MouseCursor.defer
                                  : SystemMouseCursors.click;
                            }
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              height: 300,
              child: BarChart(
                BarChartData(
                  groupsSpace: 12,
                  barGroups: getBarGroups(),
                  // titlesData: FlTitlesData(
                  //   leftTitles: SideTitles(
                  //     showTitles: true,
                  //     interval: 10,
                  //   ),
                  //   bottomTitles: SideTitles(
                  //     showTitles: true,
                  //     getTextStyles: (value) => const TextStyle(
                  //       color: Colors.black,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //     margin: 16,
                  //   ),
                  // ),
                  borderData: FlBorderData(
                    show: false,
                    border: Border.all(
                      color: const Color(0xff37434d),
                      width: 1,
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    checkToShowHorizontalLine: (value) => value % 10 == 0,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      //fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    Widget text;
    switch (value.toInt()) {
      case 2: text = const Text('22:00', style: style);  break;
      case 5: text = const Text('23:00', style: style);  break;
      case 8: text = const Text('Nov', style: style);  break;
      case 11: text = const Text('24:00', style: style);  break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(axisSide: meta.axisSide, child: text,);
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle( fontSize: 15,);
    String text;
    switch (value.toInt()) {
      case 1: text = '30';  break;
      case 3: text = '60';  break;
      case 5: text = '90';  break;
      default:
        return Container();
    }
    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: const FlGridData(
        show: true,
         drawVerticalLine: true,
         drawHorizontalLine: true,
         horizontalInterval: 2,
         verticalInterval: 2,
        // getDrawingHorizontalLine: (value) {
        //   return const FlLine(
        //     color: AppColors.mainGridLineColor,
        //     strokeWidth: 1,
        //   );
        // },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          top: BorderSide.none,
          //right: BorderSide.none,

        )
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          color: AppColors.contentColorPurple,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: false,
            color: AppColors.contentColorCyan,
          ),
        ),
        LineChartBarData(
          spots: const [
            FlSpot(0, 1),
            FlSpot(2.6, 3),
            FlSpot(4.9, 2),
            FlSpot(6.8, 4.5),
            FlSpot(8, 1),
            FlSpot(9.5, 2.5),
            FlSpot(11, 3.5),
          ],
          isCurved: true,
          color: AppColors.contentColorBlue,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: false,
            color: AppColors.contentColorBlue,
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),

        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2)!.withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2)!.withOpacity(0.1),
              ],
            ),

          ),
        ),
      ],
    );
  }
  List<BarChartGroupData> getBarGroups() {
    List<double> bar1Data = [15, 25, 40, 30, 45];
    List<double> bar2Data = [20, 35, 15, 25, 50];

    List<BarChartGroupData> barGroups = [];

    for (int x = 0; x < bar1Data.length; x++) {
      barGroups.add(
        BarChartGroupData(
          x: x,
          barRods: [
            BarChartRodData(
              toY: bar1Data[x],
              width: 8,
              color: Colors.blue,
              borderRadius: const BorderRadius.all(Radius.circular(2)),
            ),
            BarChartRodData(
              toY: bar2Data[x],
              width: 8,
              color: Colors.yellow,
              borderRadius: const BorderRadius.all(Radius.circular(2)),
            ),
            BarChartRodData(
              toY: bar1Data[x],
              width: 8,
              color: Colors.purple,
              borderRadius: const BorderRadius.all(Radius.circular(2)),
            ),
            BarChartRodData(
              toY: bar2Data[x],
              width: 8,
              color: Colors.green,
              borderRadius: const BorderRadius.all(Radius.circular(2)),
            ),
          ],
          showingTooltipIndicators: showingTooltip == x ? [0] : [],
        ),
      );
    }
    return barGroups;
  }
}
