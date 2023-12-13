import 'package:argedor_task/app/ui/tabbar_trend/tabbar_trend_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
          const TabBar(
            tabs: [
              Tab(text: 'Trend'),
              Tab(text: 'Technicals'),
              Tab(text: 'Transaction'),
            ],
          ),
          Expanded(
            child: Container(
                decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.black, width: 1))),
                child: const TabBarView(children: <Widget>[
                  TabbarTrendScreen(),
                  Center(
                      child: Text(
                    'Technicals Screen',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  )),
                  Center(
                    child: Text('Transaction Screen', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  ),
                ])),
          )
        ]));
  }
}
