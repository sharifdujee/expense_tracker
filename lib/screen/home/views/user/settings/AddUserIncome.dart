import 'package:expense_tracker/expense_repository/expense_repository.dart';
import 'package:expense_tracker/screen/add_expense/blocs/income_bloc/add_income/add_income_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddYourIncome extends StatefulWidget {
  const AddYourIncome({super.key});

  @override
  State<AddYourIncome> createState() => _AddYourIncomeState();
}

class _AddYourIncomeState extends State<AddYourIncome> {
  TextEditingController dateController = TextEditingController();
  TextEditingController incomeController = TextEditingController();
  DateTime selectDate = DateTime.now();
  late Income income;
  bool isLoading = false;

  @override
  void initState() {
    income = Income.empty;
    income.incomeId = const Uuid().v1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddIncomeBloc, AddIncomeState>(
      builder: (context, state) {
        if (state is AddIncomeLoading) {
          return Scaffold(
            appBar: _buildAppBar(),
            body: const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        } else if (state is AddIncomeSuccess) {
          return Scaffold(
            appBar: _buildAppBar(),
            body: const Center(
              child: Text(
                'Income Added Successfully',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          );
        } else if (state is AddIncomeFailure) {
          return Scaffold(
            appBar: _buildAppBar(),
            body: const Center(
              child: Text(
                'Failed to Add Income',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: _buildAppBar(),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              child: Column(
                children: [
                  _buildTitle(),
                  const SizedBox(height: 24),
                  _buildIncomeInput(),
                  const SizedBox(height: 16),
                  _buildDateInput(),
                  const SizedBox(height: 24),
                  _buildSaveButton(),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Add Income',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
      backgroundColor: Colors.black,
      elevation: 3,
    );
  }

  Widget _buildTitle() {
    return const Text(
      'Enter Your Income Details',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildIncomeInput() {
    return TextFormField(
      controller: incomeController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Income Amount',
        labelStyle: const TextStyle(fontSize: 16, color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(
          FontAwesomeIcons.bangladeshiTakaSign,
          size: 16,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey, width: 0.8),
        ),
      ),
    );
  }
  /*



                            prefixIcon: const Icon(
                              FontAwesomeIcons.clock,
                              size: 16,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
   */

  Widget _buildDateInput() {
   return  TextFormField(
      controller: dateController,
      textAlignVertical: TextAlignVertical.center,
      readOnly: true,
      onTap: () async {
        DateTime? newDate = await showDatePicker(
          context: context,
          initialDate: income.date,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(
            const Duration(days: 365),
          ),
        );
        if (newDate != null) {
          setState(() {
            dateController.text =
                DateFormat('dd/MM/yyyy').format(newDate);
            //selectDate = newDate;
            income.date = newDate;
          });
        }
      },
      decoration: InputDecoration(
        hintText: 'Date',
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(
          FontAwesomeIcons.clock,
          size: 16,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading
            ? null
            : () {
          setState(() {
            income.totalIncome = double.parse(incomeController.text);
          });
          context.read<AddIncomeBloc>().add(AddIncome(income));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Save Income',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
