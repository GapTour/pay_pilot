import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/utils/helpers/amount_helper.dart';
import 'package:pay_pilot/features/incomes/presentation/cubit/incomes_cubit.dart';
import 'package:pay_pilot/locator.dart';

class SelectingIncomes extends StatefulWidget {
  final List<Income> selectedIncomes;
  final ({int month, int year})? selectedDate;
  final Function(Income income, ({int month, int year}) selectedDate) onPressed;
  const SelectingIncomes({
    super.key,
    required this.selectedIncomes,
    required this.selectedDate,
    required this.onPressed,
  });

  @override
  State<SelectingIncomes> createState() => _SelectingIncomesState();
}

class _SelectingIncomesState extends State<SelectingIncomes> {
  late int selectedYear;
  late int selectedMonth;

  final FixedExtentScrollController monthController =
      FixedExtentScrollController();
  final FixedExtentScrollController yearController =
      FixedExtentScrollController();

  bool isSortingMonth = false;

  final Map<int, String> months = {
    DateTime.january: 'January',
    DateTime.february: 'February',
    DateTime.march: 'March',
    DateTime.april: 'April',
    DateTime.may: 'May',
    DateTime.june: 'June',
    DateTime.july: 'July',
    DateTime.august: 'August',
    DateTime.september: 'September',
    DateTime.october: 'October',
    DateTime.november: 'November',
    DateTime.december: 'December',
  };

  final List<int> years = List.generate(5, (index) => index + 2024);

  List<Income> sortedIncome(List<Income> allIncomes) {
    if (allIncomes.isEmpty) return [];
    return allIncomes.where((element) {
      return element.date.month == (selectedMonth) &&
          element.date.year == (selectedYear);
    }).toList();
  }

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    selectedMonth = widget.selectedDate?.month ?? now.month;
    selectedYear = widget.selectedDate?.year ?? now.year;

    SchedulerBinding.instance.addPostFrameCallback((_) {
      monthController.animateToItem(
        selectedMonth - 1,
        duration: Duration(milliseconds: 850),
        curve: Curves.linear,
      );
      yearController.animateToItem(
        selectedYear - 2024,
        duration: Duration(milliseconds: 850),
        curve: Curves.linear,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IncomesCubit(locator()),
      child: Builder(
        builder: (context) {
          return Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 3.0, top: 4),
                  child: Stack(
                    children: [
                      Positioned(
                        right: 12,
                        left: 12,
                        top: 18,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: SizedBox(height: 30),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: SizedBox(
                              height: 65,
                              child: ListWheelScrollView(
                                itemExtent: 25,
                                perspective: 0.01,
                                diameterRatio: 2,
                                physics: FixedExtentScrollPhysics(),
                                controller: monthController,
                                onSelectedItemChanged: (value) {
                                  selectedMonth = value + 1;
                                  setState(() {});
                                },
                                children: months.entries.map((e) {
                                  return Text(e.value);
                                }).toList(),
                              ),
                            ),
                          ),
                          Flexible(
                            child: SizedBox(
                              height: 65,
                              child: ListWheelScrollView(
                                itemExtent: 25,
                                perspective: 0.01,
                                diameterRatio: 2,
                                physics: FixedExtentScrollPhysics(),
                                controller: yearController,
                                children: years.map((e) {
                                  return Text(e.toString());
                                }).toList(),
                                onSelectedItemChanged: (value) {
                                  selectedYear = value + 2024;
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              BlocBuilder<IncomesCubit, IncomesState>(
                builder: (context, state) {
                  final incomes = sortedIncome(state.incomes);

                  final isLoading =
                      state.incomesStatus == IncomesStatus.loading ||
                      state.incomesStatus == IncomesStatus.initial;

                  if (state.incomesStatus == IncomesStatus.initial) {
                    context.read<IncomesCubit>().loadIncomes();
                  }

                  if (isLoading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }

                  if (incomes.isEmpty) {
                    return Center(
                      child: Text(
                        'No income found on ${months[selectedMonth]}, $selectedYear',
                      ),
                    );
                  }

                  return Expanded(
                    child: ListView.separated(
                      itemCount: incomes.length,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      separatorBuilder: (context, index) => Gap(3),
                      itemBuilder: (context, index) {
                        final isSelected = widget.selectedIncomes.any(
                          (element) => element.id == incomes[index].id,
                        );

                        return Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Checkbox.adaptive(
                                    value: isSelected,
                                    onChanged: (value) {
                                      widget.onPressed.call(incomes[index], (
                                        month: selectedMonth,
                                        year: selectedYear,
                                      ));
                                    },
                                  ),
                                  Expanded(
                                    child: Text(
                                      incomes[index].title,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 45.0,
                                  bottom: 8,
                                  right: 18,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        AmountHelper.integerToFormattedPrice(
                                          incomes[index].amount,
                                        ),
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    Text(
                                      DateFormat.MMMEd().format(
                                        incomes[index].date,
                                      ),
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
