import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'resources/designChart.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:math';


class Charts extends StatefulWidget {
   Charts({Key? key, required this.title}) : super(key: key);

  final String title;

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
  late List<ExpenseData> _chartData;
  late List<Expense2Data> _chart2Data;
  late TooltipBehavior _tooltipBehavior;
  late TooltipBehavior _tooltipBehavior2;
  late List<ChartSampleData> _chart3Data;
  late TrackballBehavior _trackballBehavior;
  late List<_ChartData> _chartBubbleData;
  late TooltipBehavior _tooltip;

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
  Timer? timer;

  @override
  void initState() {
    _chartBubbleData = <_ChartData>[
      _ChartData(1, 11, 2.5),
      _ChartData(2, 24, 2.2),
      _ChartData(3, 36, 1.5),
      _ChartData(4, 54, 1.2),
      _ChartData(5, 57, 3),
      _ChartData(6, 70, 3.8),
      _ChartData(7, 78, 1)
    ];
    _tooltip = TooltipBehavior(enable: true);
    _chartData = getChartData();
    _chart2Data = getChart2Data();
    _tooltipBehavior = TooltipBehavior(enable: true);
    _tooltipBehavior2 = TooltipBehavior(enable: true);
    showingTooltip = -1;
    _chart3Data = getChar3tData();
    _trackballBehavior = TrackballBehavior(enable: true, activationMode: ActivationMode.singleTap);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _getChartData();
    timer = Timer(const Duration(seconds: 2), () {
      setState(() {
        _getChartData();
      });
    });
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
                              return response == null || response.spot == null ? MouseCursor.defer : SystemMouseCursors.click;
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
            const SizedBox(height: 20),
            SizedBox(
              height: 350,
              child: SfCartesianChart(
                title: ChartTitle(
                    text: 'Monthly expenses of a family \n (in U.S. Dollars) \n'),
                legend: const Legend(isVisible: true),
                tooltipBehavior: _tooltipBehavior,
                series: <ChartSeries>[
                  StackedAreaSeries<ExpenseData, String>(
                      dataSource: _chartData,
                      xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
                      yValueMapper: (ExpenseData exp, _) => exp.father,
                      name: 'Father',
                      markerSettings: const MarkerSettings(
                        isVisible: false,
                      )),
                  StackedAreaSeries<ExpenseData, String>(
                      dataSource: _chartData,
                      xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
                      yValueMapper: (ExpenseData exp, _) => exp.mother,
                      name: 'Mother',
                      markerSettings: const MarkerSettings(
                        isVisible: false,
                      )),
                  StackedAreaSeries<ExpenseData, String>(
                      dataSource: _chartData,
                      xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
                      yValueMapper: (ExpenseData exp, _) => exp.son,
                      name: 'Son',
                      markerSettings: const MarkerSettings(
                        isVisible: false,
                      )),
                  StackedAreaSeries<ExpenseData, String>(
                      dataSource: _chartData,
                      xValueMapper: (ExpenseData exp, _) => exp.expenseCategory,
                      yValueMapper: (ExpenseData exp, _) => exp.daughter,
                      name: 'Daughter',
                      markerSettings: const MarkerSettings(
                        isVisible: false,
                      )),
                ],
                primaryXAxis: CategoryAxis(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 300,
              child: SfCartesianChart(
                title: ChartTitle(
                    text: 'Monthly expenses of a business \n (in U.S. Dollars) \n'),
                legend: const Legend(isVisible: true),
                tooltipBehavior: _tooltipBehavior2,
                series: <ChartSeries>[
                  StackedBarSeries<Expense2Data, String>(
                      dataSource: _chart2Data,
                      xValueMapper: (Expense2Data exp, _) => exp.expenseCategory2,
                      yValueMapper: (Expense2Data exp, _) => exp.company,
                      name: 'company',
                      markerSettings: const MarkerSettings(
                        isVisible: false,
                      )),
                  StackedBarSeries<Expense2Data, String>(
                      dataSource: _chart2Data,
                      xValueMapper: (Expense2Data exp, _) => exp.expenseCategory2,
                      yValueMapper: (Expense2Data exp, _) => exp.employee,
                      name: 'employee',
                      markerSettings: const MarkerSettings(
                        isVisible: false,
                      )),
                  StackedBarSeries<Expense2Data, String>(
                      dataSource: _chart2Data,
                      xValueMapper: (Expense2Data exp, _) => exp.expenseCategory2,
                      yValueMapper: (Expense2Data exp, _) => exp.manager,
                      name: 'manager',
                      markerSettings: const MarkerSettings(
                        isVisible: false,
                      ),
                  ),
                  StackedBarSeries<Expense2Data, String>(
                      dataSource: _chart2Data,
                      xValueMapper: (Expense2Data exp, _) => exp.expenseCategory2,
                      yValueMapper: (Expense2Data exp, _) => exp.secretary,
                      name: 'secretary',
                      markerSettings: const MarkerSettings(
                        isVisible: false,
                      )),
                ],
                primaryXAxis: CategoryAxis(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 300,
              child: SfCartesianChart(
                title: ChartTitle(text: 'APL - 2024'),
                legend: const Legend(isVisible: true),
                trackballBehavior: _trackballBehavior,
                series: <CandleSeries>[
                  CandleSeries<ChartSampleData, DateTime>(
                      dataSource: _chart3Data,
                      name: 'APL',
                      xValueMapper: (ChartSampleData sales, _) => sales.x,
                      lowValueMapper: (ChartSampleData sales, _) => sales.low,
                      highValueMapper: (ChartSampleData sales, _) => sales.high,
                      openValueMapper: (ChartSampleData sales, _) => sales.open,
                      closeValueMapper: (ChartSampleData sales, _) => sales.close)
                ],
                primaryXAxis: DateTimeAxis(
                    dateFormat: DateFormat.MMM(),
                    majorGridLines: const MajorGridLines(width: 0)),
                primaryYAxis: NumericAxis(
                    minimum: 70,
                    maximum: 130,
                    interval: 10,
                    numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),
              )),
            const SizedBox(height: 30),
            const Center(
              child: Text("Bubble Chart", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 300,
              child: SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  primaryXAxis:
                   CategoryAxis(majorGridLines: const MajorGridLines(width: 0)),
                  primaryYAxis: NumericAxis(
                      majorTickLines: const MajorTickLines(color: Colors.transparent),
                      axisLine: const AxisLine(width: 0),
                      minimum: 0,
                      maximum: 100),
                  series: _getDefaultBubbleSeries()),
            )
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
  List<ExpenseData> getChartData() {
    final List<ExpenseData> chartData = [
      ExpenseData('Food', 55, 40, 45, 48),
      ExpenseData('Transport', 33, 45, 54, 28),
      ExpenseData('Medical', 43, 23, 20, 34),
      ExpenseData('Clothes', 32, 54, 23, 54),
      ExpenseData('Books', 56, 18, 43, 55),
      ExpenseData('Others', 23, 54, 33, 56),
    ];
    return chartData;
  }
  List<Expense2Data> getChart2Data() {
    final List<Expense2Data> chart2Data = [
      Expense2Data('Food', 55, 40, 45, 48),
      Expense2Data('Transport', 33, 45, 54, 28),
      Expense2Data('Medical', 43, 23, 20, 34),
      Expense2Data('Clothes', 32, 54, 23, 54),
      Expense2Data('Books', 56, 18, 43, 55),
      Expense2Data('Others', 23, 54, 33, 56),
    ];
    return chart2Data;
  }
  List<ChartSampleData> getChar3tData() {
    return <ChartSampleData>[
      ChartSampleData(
          x: DateTime(2024, 01, 11),
          open: 98.97,
          high: 101.19,
          low: 95.36,
          close: 97.13),
      ChartSampleData(
          x: DateTime(2024, 01, 18),
          open: 98.41,
          high: 101.46,
          low: 93.42,
          close: 101.42
      ),
      ChartSampleData(
          x: DateTime(2023, 01, 25),
          open: 101.52,
          high: 101.53,
          low: 92.39,
          close: 97.34),
      ChartSampleData(
          x: DateTime(2023, 02, 01),
          open: 96.47,
          high: 97.33,
          low: 93.69,
          close: 94.02),
      ChartSampleData(
          x: DateTime(2023, 02, 08),
          open: 93.13,
          high: 96.35,
          low: 92.59,
          close: 93.99),
      ChartSampleData(
          x: DateTime(2023, 02, 15),
          open: 91.02,
          high: 94.89,
          low: 90.61,
          close: 92.04),
      ChartSampleData(
          x: DateTime(2023, 02, 22),
          open: 96.31,
          high: 98.0237,
          low: 98.0237,
          close: 96.31),
      ChartSampleData(
          x: DateTime(2023, 02, 29),
          open: 99.86,
          high: 106.75,
          low: 99.65,
          close: 106.01),
      ChartSampleData(
          x: DateTime(2023, 03, 07),
          open: 102.39,
          high: 102.83,
          low: 100.15,
          close: 102.26),
      ChartSampleData(
          x: DateTime(2023, 03, 14),
          open: 101.91,
          high: 106.5,
          low: 101.78,
          close: 105.92),
      ChartSampleData(
          x: DateTime(2023, 03, 21),
          open: 105.93,
          high: 107.65,
          low: 104.89,
          close: 105.67),
      ChartSampleData(
          x: DateTime(2023, 03, 28),
          open: 106,
          high: 110.42,
          low: 104.88,
          close: 109.99),
      ChartSampleData(
          x: DateTime(2023, 04, 04),
          open: 110.42,
          high: 112.19,
          low: 108.121,
          close: 108.66),
      ChartSampleData(
          x: DateTime(2023, 04, 11),
          open: 108.97,
          high: 112.39,
          low: 108.66,
          close: 109.85),
      ChartSampleData(
          x: DateTime(2023, 04, 18),
          open: 108.89,
          high: 108.95,
          low: 104.62,
          close: 105.68),
      ChartSampleData(
          x: DateTime(2023, 04, 25),
          open: 105,
          high: 105.65,
          low: 92.51,
          close: 93.74),
      ChartSampleData(
          x: DateTime(2023, 05, 02),
          open: 93.965,
          high: 95.9,
          low: 91.85,
          close: 92.72),
      ChartSampleData(
          x: DateTime(2023, 05, 09),
          open: 93,
          high: 93.77,
          low: 89.47,
          close: 90.52),
      ChartSampleData(
          x: DateTime(2023, 05, 16),
          open: 92.39,
          high: 95.43,
          low: 91.65,
          close: 95.22),
      ChartSampleData(
          x: DateTime(2023, 05, 23),
          open: 95.87,
          high: 100.73,
          low: 95.67,
          close: 100.35),
      ChartSampleData(
          x: DateTime(2023, 05, 30),
          open: 99.6,
          high: 100.4,
          low: 96.63,
          close: 97.92),
      ChartSampleData(
          x: DateTime(2023, 06, 06),
          open: 97.99,
          high: 101.89,
          low: 97.55,
          close: 98.83),
      ChartSampleData(
          x: DateTime(2023, 06, 13),
          open: 98.69,
          high: 99.12,
          low: 95.3,
          close: 95.33),
      ChartSampleData(
          x: DateTime(2023, 06, 20),
          open: 96,
          high: 96.89,
          low: 92.65,
          close: 93.4),
      ChartSampleData(
          x: DateTime(2023, 06, 27),
          open: 93,
          high: 96.465,
          low: 91.5,
          close: 95.89),
      ChartSampleData(
          x: DateTime(2023, 07, 04),
          open: 95.39,
          high: 96.89,
          low: 94.37,
          close: 96.68),
      ChartSampleData(
          x: DateTime(2023, 07, 11),
          open: 96.75,
          high: 99.3,
          low: 96.73,
          close: 98.78),
      ChartSampleData(
          x: DateTime(2023, 07, 18),
          open: 98.7,
          high: 101,
          low: 98.31,
          close: 98.66),
      ChartSampleData(
          x: DateTime(2023, 07, 25),
          open: 98.25,
          high: 104.55,
          low: 96.42,
          close: 104.21),
      ChartSampleData(
          x: DateTime(2023, 08, 01),
          open: 104.41,
          high: 107.65,
          low: 104,
          close: 107.48),
      ChartSampleData(
          x: DateTime(2023, 08, 08),
          open: 107.52,
          high: 108.94,
          low: 107.16,
          close: 108.18),
      ChartSampleData(
          x: DateTime(2023, 08, 15),
          open: 108.14,
          high: 110.23,
          low: 108.08,
          close: 109.36),
      ChartSampleData(
          x: DateTime(2023, 08, 22),
          open: 108.86,
          high: 109.32,
          low: 106.31,
          close: 106.94),
      ChartSampleData(
          x: DateTime(2023, 08, 29),
          open: 106.62,
          high: 108,
          low: 105.5,
          close: 107.73),
      ChartSampleData(
          x: DateTime(2023, 09, 05),
          open: 107.9,
          high: 108.76,
          low: 103.13,
          close: 103.13),
      ChartSampleData(
          x: DateTime(2023, 09, 12),
          open: 102.65,
          high: 116.13,
          low: 102.53,
          close: 114.92),
      ChartSampleData(
          x: DateTime(2023, 09, 19),
          open: 115.19,
          high: 116.18,
          low: 111.55,
          close: 112.71),
      ChartSampleData(
          x: DateTime(2023, 09, 26),
          open: 111.64,
          high: 114.64,
          low: 111.55,
          close: 113.05),
      ChartSampleData(
          x: DateTime(2023, 10, 03),
          open: 112.71,
          high: 114.56,
          low: 112.28,
          close: 114.06),
      ChartSampleData(
          x: DateTime(2023, 10, 10),
          open: 115.02,
          high: 118.69,
          low: 114.72,
          close: 117.63),
      ChartSampleData(
          x: DateTime(2023, 10, 17),
          open: 117.33,
          high: 118.21,
          low: 113.8,
          close: 116.6),
      ChartSampleData(
          x: DateTime(2023, 10, 24),
          open: 117.1,
          high: 118.36,
          low: 113.31,
          close: 113.72),
      ChartSampleData(
          x: DateTime(2023, 10, 31),
          open: 113.65,
          high: 114.23,
          low: 108.11,
          close: 108.84),
      ChartSampleData(
          x: DateTime(2023, 11, 07),
          open: 110.08,
          high: 111.72,
          low: 105.83,
          close: 108.43),
      ChartSampleData(
          x: DateTime(2023, 11, 14),
          open: 107.71,
          high: 110.54,
          low: 104.08,
          close: 110.06),
      ChartSampleData(
          x: DateTime(2023, 11, 21),
          open: 114.12,
          high: 115.42,
          low: 115.42,
          close: 114.12),
      ChartSampleData(
          x: DateTime(2023, 11, 28),
          open: 111.43,
          high: 112.465,
          low: 108.85,
          close: 109.9),
      ChartSampleData(
          x: DateTime(2023, 12, 05),
          open: 110,
          high: 114.7,
          low: 108.25,
          close: 113.95),
      ChartSampleData(
          x: DateTime(2023, 12, 12),
          open: 113.29,
          high: 116.73,
          low: 112.49,
          close: 115.97),
      ChartSampleData(
          x: DateTime(2023, 12, 19),
          open: 115.8,
          high: 117.5,
          low: 115.59,
          close: 116.52),
      ChartSampleData(
          x: DateTime(2023, 12, 26),
          open: 116.52,
          high: 118.0166,
          low: 115.43,
          close: 115.82),
    ];
  }
  List<BubbleSeries<_ChartData, num>> _getDefaultBubbleSeries() {
    return <BubbleSeries<_ChartData, num>>[
      BubbleSeries<_ChartData, num>(
          dataSource: _chartBubbleData,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y,
          sizeValueMapper: (_ChartData sales, _) => sales.size)
    ];
  }
  @override
  void dispose() {
    timer!.cancel();
    _chartBubbleData.clear();
    super.dispose();
  }

  // To get the random data and return to the chart data source.
  int _getRandomInt(int min, int max) {
    final Random random = Random();
    return min + random.nextInt(max - min);
  }

  void _getChartData() {
    final Random randomValue = Random();
    _chartBubbleData = <_ChartData>[];
    for (int i = 1; i <= 10; i++) {
      _chartBubbleData!.add(
          _ChartData(i, _getRandomInt(15, 90), randomValue.nextDouble() * 0.9));
    }
    timer?.cancel();
  }
}
class ExpenseData {
  ExpenseData(
      this.expenseCategory, this.father, this.mother, this.son, this.daughter);
  final String expenseCategory;
  final num father;
  final num mother;
  final num son;
  final num daughter;
}
class Expense2Data {
  Expense2Data(
      this.expenseCategory2, this.company, this.employee, this.manager, this.secretary);
  final String expenseCategory2;
  final num company;
  final num employee;
  final num manager;
  final num secretary;
}
class ChartSampleData {
  ChartSampleData({
    this.x,
    this.open,
    this.close,
    this.low,
    this.high,
  });

  final DateTime? x;
  final num? open;
  final num? close;
  final num? low;
  final num? high;
}
class _ChartData {
  _ChartData(this.x, this.y, this.size);
  final int x;
  final int y;
  final double size;
}