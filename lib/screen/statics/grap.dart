import 'package:money_app/db_function/filteration_db.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:money_app/db_function/chart_db.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graphs extends StatefulWidget {
  const Graphs({Key? key}) : super(key: key);

  @override
  State<Graphs> createState() => _GraphsState();
}

class _GraphsState extends State<Graphs> with TickerProviderStateMixin {
  List<ChartDatas> dataExpense = chartLogic(expenseNotifier.value);
  List<ChartDatas> dataIncome = chartLogic(incomeNotifier.value);
  List<ChartDatas> overview = chartLogic(overviewNotifier.value);
  List<ChartDatas> yesterday = chartLogic(yesterdayNotifier.value);
  List<ChartDatas> today = chartLogic(todayNotifier.value);
  List<ChartDatas> month = chartLogic(lastMonthNotifier.value);
  List<ChartDatas> week = chartLogic(lastWeekNotifier.value);
  List<ChartDatas> todayIncome = chartLogic(incomeTodayNotifier.value);
  List<ChartDatas> incomeYesterday = chartLogic(incomeYesterdayNotifier.value);
  List<ChartDatas> incomeweek = chartLogic(incomeLastWeekNotifier.value);
  List<ChartDatas> incomemonth = chartLogic(incomeLastMonthNotifier.value);
  List<ChartDatas> todayExpense = chartLogic(expenseTodayNotifier.value);
  List<ChartDatas> expenseYesterday =
      chartLogic(expenseYesterdayNotifier.value);
  List<ChartDatas> expenseweek = chartLogic(expenseLastWeekNotifier.value);
  List<ChartDatas> expensemonth = chartLogic(expenseLastMonthNotifier.value);
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    filterFunction();
    chartdivertFunctionExpense();
    chartdivertFunctionIncome();
    super.initState();
  }

  String categoryId2 = 'All';
  int touchIndex = 1;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        title: const Text(
          'Transaction Statistics',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.039,
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 24,
            ),
            child: Material(
              shadowColor: const Color.fromARGB(255, 187, 251, 247),
              borderRadius: BorderRadius.circular(18),
              elevation: 10,
              child: Container(
                height: height * 0.0657,
                width: width * 0.83,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Colors.greenAccent, Colors.lightGreen],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton<String>(
                        underline: const Divider(
                          color: Colors.transparent,
                        ),
                        value: categoryId2,
                        items: <String>[
                          'All',
                          'Today',
                          'Yesterday',
                          'This week',
                          'month',
                        ]
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            categoryId2 = value.toString();
                          });
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          TabBar(
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide.none,
            ),
            controller: tabController,
            labelColor: const Color.fromARGB(255, 27, 88, 83),
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(
                text: 'Overview',
              ),
              Tab(
                text: 'Income',
              ),
              Tab(
                text: 'Expense',
              ),
            ],
          ),
          SizedBox(
            height: height * 0.0263,
          ),
          SizedBox(
            width: double.maxFinite,
            height: height * 0.526,
            child: TabBarView(
              controller: tabController,
              children: [
                Padding(
                  padding: const EdgeInsets.all(
                    16,
                  ),
                  child: chartdivertFunctionOverview().isEmpty
                      ? Center(
                          child: Lottie.asset(
                            'lib/assets/image/lotties/89237-graph.json',
                            width: width * 0.9,
                            height: height * 0.4,
                          ),
                        )
                      : SfCircularChart(
                          legend: Legend(
                            isVisible: true,
                            overflowMode: LegendItemOverflowMode.wrap,
                            position: LegendPosition.bottom,
                          ),
                          series: <CircularSeries>[
                            PieSeries<ChartDatas, String>(
                              dataLabelSettings: const DataLabelSettings(
                                isVisible: true,
                                connectorLineSettings: ConnectorLineSettings(
                                    type: ConnectorType.curve),
                                overflowMode: OverflowMode.shift,
                                showZeroValue: false,
                                labelPosition: ChartDataLabelPosition.outside,
                              ),
                              dataSource: chartdivertFunctionOverview(),
                              xValueMapper: (ChartDatas data, _) =>
                                  data.category,
                              yValueMapper: (ChartDatas data, _) => data.amount,
                              explode: true,
                            )
                          ],
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(
                    16,
                  ),
                  child: chartdivertFunctionIncome().isEmpty
                      ? Center(
                          child: Lottie.asset(
                            'lib/assets/image/lotties/89237-graph.json',
                            width: width * 0.9,
                            height: height * 0.4,
                          ),
                        )
                      : SfCircularChart(
                          legend: Legend(
                            isVisible: true,
                            overflowMode: LegendItemOverflowMode.wrap,
                            position: LegendPosition.bottom,
                          ),
                          series: <CircularSeries>[
                            PieSeries<ChartDatas, String>(
                              dataLabelSettings: const DataLabelSettings(
                                isVisible: true,
                                connectorLineSettings: ConnectorLineSettings(
                                    type: ConnectorType.curve),
                                overflowMode: OverflowMode.shift,
                                showZeroValue: false,
                                labelPosition: ChartDataLabelPosition.outside,
                              ),
                              dataSource: chartdivertFunctionIncome(),
                              xValueMapper: (ChartDatas data, _) =>
                                  data.category,
                              yValueMapper: (ChartDatas data, _) => data.amount,
                              explode: true,
                            )
                          ],
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(
                    16,
                  ),
                  child: chartdivertFunctionExpense().isEmpty
                      ? Center(
                          child: Lottie.asset(
                            'lib/assets/image/lotties/89237-graph.json',
                            width: width * 0.9,
                            height: height * 0.4,
                          ),
                        )
                      : SfCircularChart(
                          legend: Legend(
                            isVisible: true,
                            overflowMode: LegendItemOverflowMode.wrap,
                            position: LegendPosition.bottom,
                          ),
                          series: <CircularSeries>[
                            PieSeries<ChartDatas, String>(
                              dataLabelSettings: const DataLabelSettings(
                                isVisible: true,
                                connectorLineSettings: ConnectorLineSettings(
                                    type: ConnectorType.curve),
                                overflowMode: OverflowMode.shift,
                                showZeroValue: false,
                                labelPosition: ChartDataLabelPosition.outside,
                              ),
                              dataSource: chartdivertFunctionExpense(),
                              xValueMapper: (ChartDatas data, _) =>
                                  data.category,
                              yValueMapper: (ChartDatas data, _) => data.amount,
                              explode: true,
                            )
                          ],
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  chartdivertFunctionOverview() {
    if (categoryId2 == 'All') {
      return overview;
    }
    if (categoryId2 == 'Today') {
      return today;
    }
    if (categoryId2 == 'Yesterday') {
      return yesterday;
    }
    if (categoryId2 == 'This week') {
      return week;
    }
    if (categoryId2 == 'month') {
      return month;
    }
  }

  chartdivertFunctionIncome() {
    if (categoryId2 == 'All') {
      return dataIncome;
    }
    if (categoryId2 == 'Today') {
      return todayIncome;
    }
    if (categoryId2 == 'Yesterday') {
      return incomeYesterday;
    }
    if (categoryId2 == 'This week') {
      return incomeweek;
    }
    if (categoryId2 == 'month') {
      return incomemonth;
    }
  }

  chartdivertFunctionExpense() {
    if (categoryId2 == 'All') {
      return dataExpense;
    }
    if (categoryId2 == 'Today') {
      return todayExpense;
    }
    if (categoryId2 == 'Yesterday') {
      return expenseYesterday;
    }
    if (categoryId2 == 'This week') {
      return expenseweek;
    }
    if (categoryId2 == 'month') {
      return expensemonth;
    }
  }
}
