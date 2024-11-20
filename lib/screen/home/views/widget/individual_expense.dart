import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../expense_repository/src/model/expense_model.dart';

class IndividualExpense extends StatelessWidget {
  const IndividualExpense({
    super.key,
    required this.expenses,
  });

  final List<MyExpense> expenses;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, int i) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(expenses[i].category.color),
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/${expenses[i].category.icon}.png',
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                    scale: 2,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Text(
                                expenses[i].category.name,
                                style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '\$${expenses[i].amount.toString()}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                () {
                                  final now = DateTime.now();
                                  final date = expenses[i].date;

                                  // Reset the time to midnight (00:00:00) for both now and the selected date
                                  final today =
                                      DateTime(now.year, now.month, now.day);
                                  final selectedDate =
                                      DateTime(date.year, date.month, date.day);

                                  // Calculate the difference in days
                                  final difference =
                                      selectedDate.difference(today).inDays;

                                  // Check if the date is yesterday, today, or tomorrow
                                  if (difference == -1) {
                                    return 'Yesterday';
                                  } else if (difference == 0) {
                                    return 'Today';
                                  } else if (difference == 1) {
                                    return 'Tomorrow';
                                  } else {
                                    return DateFormat('MMM dd, yyyy')
                                        .format(date);
                                  }
                                }(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).colorScheme.outline,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
