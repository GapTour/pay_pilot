import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:pay_pilot/core/utils/helpers/amount_helper.dart';
import 'package:pay_pilot/features/incomes/presentation/cubit/incomes_cubit.dart';
import 'package:pay_pilot/features/incomes/presentation/widgets/add_income_dialog_box.dart';

class IncomesScreen extends StatefulWidget {
  static const routeName = '/incomes';

  const IncomesScreen({super.key});

  @override
  State<IncomesScreen> createState() => _IncomesScreenState();
}

class _IncomesScreenState extends State<IncomesScreen> {
  @override
  void initState() {
    super.initState();

    context.read<IncomesCubit>().loadIncomes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Incomes')),
      body: BlocBuilder<IncomesCubit, IncomesState>(
        builder: (context, state) {
          final incomes = state.incomes;
          final isLoading =
              state.incomesStatus == IncomesStatus.loading ||
              state.incomesStatus == IncomesStatus.initial;

          if (isLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (incomes.isEmpty) {
            return const Center(child: Text('No incomes found.'));
          }

          return GridView.builder(
            itemCount: incomes.length,
            padding: const EdgeInsets.all(18),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 380,
              childAspectRatio: 4.4,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AddIncomeDialogBox(
                        income: incomes[index],
                        onPressedSubmit: (income) {
                          context.read<IncomesCubit>().updateIncome(income);
                        },
                      );
                    },
                  );
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                incomes[index].title,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                            Text(
                              DateFormat.yMMMd().format(incomes[index].date),
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),

                        Gap(8),
                        Text(
                          AmountHelper.integerToFormattedPrice(
                            incomes[index].amount,
                          ),
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return AddIncomeDialogBox(
                onPressedSubmit: (income) {
                  context.read<IncomesCubit>().addIncome(income);
                },
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
