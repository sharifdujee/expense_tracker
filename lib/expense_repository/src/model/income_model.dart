import 'package:expense_tracker/expense_repository/expense_repository.dart';

class Income {
  String incomeId;
  DateTime date;
  double totalIncome;

  Income(
      {required this.incomeId, required this.date, required this.totalIncome});

  static final empty =
      Income(incomeId: '', date: DateTime.now(), totalIncome: 0);

  IncomeEntity toEntity() {
    return IncomeEntity(
        incomeId: incomeId, date: date, totalIncome: totalIncome);
  }

  static Income fromEntity(IncomeEntity entity) {
    return Income(
        incomeId: entity.incomeId,
        date: entity.date,
        totalIncome: entity.totalIncome);
  }
}
