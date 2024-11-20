import 'package:cloud_firestore/cloud_firestore.dart';

class IncomeEntity{
  String incomeId;
  DateTime date;
  double totalIncome;

  IncomeEntity({
    required this.incomeId,
    required this.date,
    required this.totalIncome,
});
  Map<String, Object> toDocument(){
    return {
      'incomeId': incomeId,
      'date': date,
      'totalIncome': totalIncome,
    };
  }

  static IncomeEntity fromDocument(Map<String, dynamic> doc){
    return IncomeEntity(
        incomeId: doc['incomeId'],
        date: (doc['date'] as Timestamp).toDate() ,
        totalIncome: doc['totalIncome']);
  }

}

