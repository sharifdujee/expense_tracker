import 'package:expense_tracker/expense_repository/expense_repository.dart';
import 'package:expense_tracker/screen/add_expense/blocs/create_expense/create_expense_bloc.dart';
import 'package:expense_tracker/screen/add_expense/blocs/get_categorybloc/get_category_bloc.dart';
import 'package:expense_tracker/screen/home/views/widget/category_creation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime selectDate = DateTime.now();
  late MyExpense expense;
  bool isLoading = false;

  @override
  void initState() {
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    expense = MyExpense.empty;
    expense.expenseId = const Uuid().v1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateExpenseBloc, CreateExpenseState>(
      listener: (context, state) {
        if (state is CreateExpenseSuccess) {
          Navigator.pop(context, expense);
        } else if (state is CreateExpenseLoading) {
          setState(() {
            isLoading = true;
          });
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
          body: BlocBuilder<GetCategoryBloc, GetCategoryState>(
            builder: (context, state) {
              if (state is GetCategorySuccess) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Add Expenses',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: expenseController,
                              decoration: InputDecoration(
                      
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: const Icon(
                                    FontAwesomeIcons.bangladeshiTakaSign,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(30))),
                            ),
                          ),
                          const SizedBox(height: 32),
                          TextFormField(
                            readOnly: true,
                            onTap: () {},
                            controller: categoryController,
                            decoration: InputDecoration(
                              hintText: 'Category',
                              filled: true,
                              fillColor: expense.category == MyCategory.empty
                                  ? Colors.white
                                  : Color(expense.category.color),
                              prefixIcon: expense.category == MyCategory.empty
                                  ? const Icon(
                                      FontAwesomeIcons.list,
                                      size: 16,
                                      color: Colors.grey,
                                    )
                                  : Image.asset(
                                      'assets/${expense.category.icon}.png',
                                      scale: 4,
                                    ),
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  var newCategory =
                                      await getCategoryCreation(context);
                                  //print(newCategory);
                                  setState(() {
                                    state.categories.insert(0, newCategory);
                                  });
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.plus,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(12),
                              ),
                            ),
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                itemCount: state.categories.length,
                                itemBuilder: (context, int i) {
                                  return Card(
                                    child: ListTile(
                                      onTap: () {
                                        setState(() {
                                          expense.category = state.categories[i];
                                          categoryController.text =
                                              expense.category.name;
                                        });
                                      },
                                      leading: Image.asset(
                                        'assets/${state.categories[i].icon}.png',
                                        scale: 4,
                                      ),
                                      title: Text(state.categories[i].name),
                                      tileColor: Color(state.categories[i].color),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: dateController,
                            textAlignVertical: TextAlignVertical.center,
                            readOnly: true,
                            onTap: () async {
                              DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: expense.date,
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
                                  expense.date = newDate;
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
                          ),
                          const SizedBox(height: 32),
                      
                          /// save expense button
                          SizedBox(
                            width: double.infinity,
                            height: kToolbarHeight,
                            child: isLoading
                                ? const Center(child:  CircularProgressIndicator())
                                : TextButton(
                                    onPressed: () {
                                      setState(() {
                                        expense.amount =
                                            int.parse(expenseController.text);
                                      });
                                      context
                                          .read<CreateExpenseBloc>()
                                          .add(CreateExpense(expense));
                                    },
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12))),
                                    child: const Text(
                                      'Save',
                                      style: TextStyle(
                                          fontSize: 22, color: Colors.white),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
