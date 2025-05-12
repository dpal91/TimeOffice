import 'package:flutter/material.dart';
import 'package:timeoffice/ModelPages/History/Pages/TabViews/DetailedView.dart';
import 'package:timeoffice/ModelPages/History/Pages/TabViews/SummeryView.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("History")),
      body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              TabBar(tabs: [
                Tab(child: Text("Summery")),
                Tab(child: Text("Check In")),
              ]),
              Expanded(
                  child: TabBarView(
                children: [
                  SummaryView(),
                  DetailedView(),
                ],
              ))
            ],
          )),
    );
  }
}
