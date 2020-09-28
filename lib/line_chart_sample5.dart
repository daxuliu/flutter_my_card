import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

//刘旭
//20-09-07
//email:1697935859@qq.com
class LineChartSample5 extends StatelessWidget {
  final List<int> showIndexes = const []; //[0,1,2, 3,4, 5,6];//显示点下直线的索引
  final List<FlSpot> allSpots = [
    FlSpot(0, 0),
    FlSpot(1, 5),
    FlSpot(2, -10),
    FlSpot(3, 0),
    FlSpot(4, 0),
    FlSpot(5, 10),
    FlSpot(6, -5),
    FlSpot(7, 2)
  ];

//点的坐标
  @override
  Widget build(BuildContext context) {
    final lineBarsData = [
      LineChartBarData(
          showingIndicators: showIndexes,
          spots: allSpots,
          isCurved: true,
          barWidth: 2,
          //线的宽度

          shadow: const Shadow(
            blurRadius: 2,
            color: Colors.deepOrangeAccent,
          ),
          belowBarData: BarAreaData(
            show: false, //是否显示线下面的阴影
            colors: [
              const Color(0xff12c2e9).withOpacity(0.4),
              const Color(0xffc471ed).withOpacity(0.4),
              const Color(0xfff64f59).withOpacity(0.4),
              const Color(0xff12c2e9).withOpacity(0.4),
              const Color(0xffc471ed).withOpacity(0.4),
              const Color(0xfff64f59).withOpacity(0.4)
            ],
          ),
          dotData: FlDotData(show: true,),
          //是否显示点
          colors: [
            const Color(0xff12c2e9),
            const Color(0xffc471ed),
            const Color(0xfff64f59),
            const Color(0xff12c2e9).withOpacity(0.4),
            const Color(0xffc471ed).withOpacity(0.4),
            const Color(0xfff64f59).withOpacity(0.4)
          ],
          colorStops: [
            0.1,
            0.4,
            0.9
          ]),
    ];

    final LineChartBarData tooltipsOnBar = lineBarsData[0];

    return SizedBox(
      // width: 180,
    //  height: 140,

      child: Card(
          color: Colors.white, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14.0))),  //设置圆角
          child: LineChart(
        LineChartData(
          showingTooltipIndicators: showIndexes.map((index) {
            return ShowingTooltipIndicators(index, [
              LineBarSpot(
                  tooltipsOnBar, lineBarsData.indexOf(tooltipsOnBar), tooltipsOnBar.spots[index]),
            ]);
          }).toList(),
          lineTouchData: LineTouchData(
            enabled: true, //点是否可点击
            getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
              return spotIndexes.map((index) {
                return TouchedSpotIndicatorData(
                  FlLine(
                    color: Colors.pink,
                  ),
                  FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                      radius: 8, //点击后点的半径
                      color: lerpGradient(barData.colors, barData.colorStops, percent / 100),
                      strokeWidth: 2,
                      strokeColor: Colors.black,
                    ),
                  ),
                );
              }).toList();
            },
            // touchTooltipData: LineTouchTooltipData(
            //   tooltipBgColor: Colors.pink,
            //   tooltipRoundedRadius: 8,
//              getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
//                return lineBarsSpot.map((lineBarSpot) {
//                  return LineTooltipItem(
//                    lineBarSpot.y.toString(),
//                    const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                  );
//                }).toList();
//              },//点上的数字
            //   ),
          ),
          lineBarsData: lineBarsData,
          minY: -10,
          //y轴最小值
          titlesData: FlTitlesData(
            leftTitles: SideTitles(
                showTitles: true,
                getTitles: (val) {
                  if (val.abs().toInt() % 5 == 0) {
                    return val.toString();
                  } //左侧坐标数字

                }
            ),
            bottomTitles: SideTitles(
                showTitles: true,
                getTitles: (val) {
                  switch (val.toInt()) {
                    case 0:
                      return '04.00';
                    case 1:
                      return '04.01';
                    case 2:
                      return '04.02';
                    case 3:
                      return '04.03';
                    case 4:
                      return '04.05';
                    case 5:
                      return '04.06';
                    case 6:
                      return '04.07';
                    case 7 :
                      return '04.07';
                  }
                  return '';
                },
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                  fontFamily: 'Digital',
                  fontSize: 18,
                )),
          ),
          axisTitleData: FlAxisTitleData(
            // rightTitle: AxisTitle(showTitle: true, titleText: 'count'),
            // leftTitle: AxisTitle(showTitle: true, titleText: 'count'),
            topTitle:
            AxisTitle(
                showTitle: true, titleText: '心灵曲线', textAlign: TextAlign.left),

          ),
          gridData: FlGridData(show: true,),
          borderData: FlBorderData(
            show: true,
          ),
        ),
      )),
    );
  }
}

/// Lerps between a [LinearGradient] colors, based on [t]
Color lerpGradient(List<Color> colors, List<double> stops, double t) {
  if (stops == null || stops.length != colors.length) {
    stops = [];

    /// provided gradientColorStops is invalid and we calculate it here
    colors.asMap().forEach((index, color) {
      final percent = 1.0 / colors.length;
      stops.add(percent * (index + 1));
    });
  }

  for (var s = 0; s < stops.length - 1; s++) {
    final leftStop = stops[s], rightStop = stops[s + 1];
    final leftColor = colors[s], rightColor = colors[s + 1];
    if (t <= leftStop) {
      return leftColor;
    } else if (t < rightStop) {
      final sectionT = (t - leftStop) / (rightStop - leftStop);
      return Color.lerp(leftColor, rightColor, sectionT);
    }
  }
  return colors.last;
}
