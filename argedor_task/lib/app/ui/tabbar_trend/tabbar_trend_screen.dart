import 'package:argedor_task/app/ui/widgets/trend_text_group.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TabbarTrendScreen extends StatefulWidget {
  const TabbarTrendScreen({
    super.key,
  });

  @override
  State<TabbarTrendScreen> createState() => _TabbarTrendScreenState();
}

class _TabbarTrendScreenState extends State<TabbarTrendScreen> {
  String selectedAverageValue = 'Global average';
  String selectedTimeValue = '1M';
  List<FlSpot> chartData = [
    const FlSpot(0, 1),
    const FlSpot(1, 3),
    const FlSpot(2, 10),
    const FlSpot(3, 7),
    const FlSpot(4, 12),
    const FlSpot(5, 13),
    const FlSpot(6, 17),
    const FlSpot(7, 15),
    const FlSpot(8, 20),
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 20,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(width: 0.2, color: Colors.white),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Icon(Icons.star),
                              VerticalDivider(
                                color: Colors.white,
                                thickness: 0.2,
                                width: 16.0,
                              ),
                              Icon(Icons.favorite),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  DropdownButton<String>(
                    underline: Container(),
                    value: selectedTimeValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedTimeValue = newValue!;
                      });
                    },
                    items: <String>['1M', '10M', '30M'].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('1H'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('1D'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('1W'),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.6,
            child: Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              height: 300,
              child: LineChart(
                LineChartData(borderData: FlBorderData(show: false), lineBarsData: [
                  LineChartBarData(spots: chartData),
                ]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: '5,350.26 ',
                              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.red),
                            ),
                            TextSpan(
                              text: 'EUR',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: '= 6,111.34 USD -5.27%',
                          style: TextStyle(color: Theme.of(context).hintColor),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: DropdownButton<String>(
                        underline: Container(),
                        value: selectedAverageValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedAverageValue = newValue!;
                          });
                        },
                        items: <String>['Global average', 'Option 2', 'Option 3', 'Option 4']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const TrendTextGroup()
        ],
      ),
    );
  }
}

