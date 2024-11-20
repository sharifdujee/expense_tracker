import 'package:hive/hive.dart';

import 'model/add_data.dart';


int totals = 0;

final box = Hive.box<Add_data>('data');

int total() {
  /// fetch value from Hive
  var totalBalance = box.values.toList();
  List a = [0, 0];
  for (var i = 0; i < totalBalance.length; i++) {
    a.add(totalBalance[i].IN == 'Income'
        ? int.parse(totalBalance[i].amount)
        : int.parse(totalBalance[i].amount) * -1);
  }
  totals = a.reduce((value, element) => value + element);
  return totals;
}
/// income calculation
int income() {
  var totalIncome = box.values.toList();
  List a = [0, 0];
  for (var i = 0; i < totalIncome.length; i++) {
    a.add(totalIncome[i].IN == 'Income' ? int.parse(totalIncome[i].amount) : 0);
  }
  totals = a.reduce((value, element) => value + element);
  return totals;
}
 /// expense calculation
int expenses() {
  var totalExpense = box.values.toList();
  List a = [0, 0];
  for (var i = 0; i < totalExpense.length; i++) {
    a.add(totalExpense[i].IN == 'Income' ? 0 : int.parse(totalExpense[i].amount) * -1);
  }
  totals = a.reduce((value, element) => value + element);
  return totals;
}
 /// daily income or expense
List<Add_data> today() {
  List<Add_data> a = [];
  var dailyData = box.values.toList();
  DateTime date =  DateTime.now();
  for (var i = 0; i < dailyData.length; i++) {
    if (dailyData[i].datetime.day == date.day) {
      a.add(dailyData[i]);
    }
  }
  return a;
}
 /// weekly income or expense
List<Add_data> week() {
  List<Add_data> a = [];
  DateTime date =  DateTime.now();
  var weeklyData = box.values.toList();
  for (var i = 0; i < weeklyData.length; i++) {
    if (date.day - 7 <= weeklyData[i].datetime.day &&
        weeklyData[i].datetime.day <= date.day) {
      a.add(weeklyData[i]);
    }
  }
  return a;
}
 /// monthly income or expense
List<Add_data> month() {
  List<Add_data> a = [];
  var monthlyData = box.values.toList();
  DateTime date =  DateTime.now();
  for (var i = 0; i < monthlyData.length; i++) {
    if (monthlyData[i].datetime.month == date.month) {
      a.add(monthlyData[i]);
    }
  }
  return a;
}
/// yearly income or expense
List<Add_data> year() {
  List<Add_data> a = [];
  var yearlyData = box.values.toList();
  DateTime date =  DateTime.now();
  for (var i = 0; i < yearlyData.length; i++) {
    if (yearlyData[i].datetime.year == date.year) {
      a.add(yearlyData[i]);
    }
  }
  return a;
}

/// chart data

int totalChart(List<Add_data> totalData) {
  List a = [0, 0];

  for (var i = 0; i < totalData.length; i++) {
    a.add(totalData[i].IN == 'Income'
        ? int.parse(totalData[i].amount)
        : int.parse(totalData[i].amount) * -1);
  }
  totals = a.reduce((value, element) => value + element);
  return totals;
}

/// time

List time(List<Add_data> totalTime, bool hour) {
  List<Add_data> a = [];
  List total = [];
  int counter = 0;
  for (var singleTime = 0; singleTime < totalTime.length; singleTime++) {
    for (var i = singleTime; i < totalTime.length; i++) {
      if (hour) {
        if (totalTime[i].datetime.hour == totalTime[singleTime].datetime.hour) {
          a.add(totalTime[i]);
          counter = i;
        }
      } else {
        if (totalTime[i].datetime.day == totalTime[singleTime].datetime.day) {
          a.add(totalTime[i]);
          counter = i;
        }
      }
    }
    total.add(totalChart(a));
    a.clear();
    singleTime = counter;
  }

  return total;
}