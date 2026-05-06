import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot/core/database/tables/event_transactions.dart';
import 'package:pay_pilot/core/utils/extensions/format_date_to_persian_calendar.dart';
import 'package:pay_pilot/core/utils/helpers/amount_helper.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_details.dart';
import 'package:pay_pilot/features/reports/presentation/cubit/selecting_events_cubit.dart';
import 'package:pay_pilot/locator.dart';
import 'package:persian_calendar_widget/persian_calendar_widget.dart';

class SelectingEvents extends StatefulWidget {
  final List<ResponseEventDetails> selectedEvents;
  final ({int month, int year})? selectedDate;
  final Function(
    ResponseEventDetails event,
    ({int month, int year}) selectedDate,
  )
  onPressed;
  const SelectingEvents({
    super.key,
    required this.selectedEvents,
    required this.selectedDate,
    required this.onPressed,
  });

  @override
  State<SelectingEvents> createState() => _SelectingEventsState();
}

class _SelectingEventsState extends State<SelectingEvents> {
  late int selectedYear;
  late int selectedMonth;

  final FixedExtentScrollController monthController =
      FixedExtentScrollController();
  final FixedExtentScrollController yearController =
      FixedExtentScrollController();

  bool isSortingMonth = false;

  // final Map<int, String> months = {
  //   DateTime.january: 'January',
  //   DateTime.february: 'February',
  //   DateTime.march: 'March',
  //   DateTime.april: 'April',
  //   DateTime.may: 'May',
  //   DateTime.june: 'June',
  //   DateTime.july: 'July',
  //   DateTime.august: 'August',
  //   DateTime.september: 'September',
  //   DateTime.october: 'October',
  //   DateTime.november: 'November',
  //   DateTime.december: 'December',
  // };

  final Map<int, String> months = {
    1: 'Farvardin',
    2: 'Ordibehesht',
    3: 'Khordad',
    4: 'Tir',
    5: 'Mordad',
    6: 'Shahrivar',
    7: 'Mehr',
    8: 'Aban',
    9: 'Azar',
    10: 'Day',
    11: 'Bahman',
    12: 'Esfand',
  };

  final List<int> years = List.generate(5, (index) => index + 1403);

  List<ResponseEventDetails> sortedEvents(
    List<ResponseEventDetails> allEvents,
  ) {
    if (allEvents.isEmpty) return [];
    return allEvents.where((element) {
      final Jalali elementDate = element.date.toJalali();
      return elementDate.month == (selectedMonth) &&
          elementDate.year == (selectedYear);
    }).toList();
  }

  @override
  void initState() {
    super.initState();

    final now = DateTime.now().toJalali();
    selectedMonth = widget.selectedDate?.month ?? now.month;
    selectedYear = widget.selectedDate?.year ?? now.year;

    SchedulerBinding.instance.addPostFrameCallback((_) {
      monthController.animateToItem(
        selectedMonth - 1,
        duration: Duration(milliseconds: 850),
        curve: Curves.linear,
      );
      yearController.animateToItem(
        selectedYear - 1403,
        duration: Duration(milliseconds: 850),
        curve: Curves.linear,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SelectingEventsCubit(locator()),
      child: Builder(
        builder: (context) {
          return Column(
            children: [
              Card(
                color: kSecondaryColor,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 3.0, top: 4),
                  child: Stack(
                    children: [
                      Positioned(
                        right: 12,
                        left: 12,
                        top: 16,
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
                                  return Text(
                                    e.value,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.displayLarge,
                                  );
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
                                  return Text(
                                    e.toString(),
                                    style: Theme.of(
                                      context,
                                    ).textTheme.displayLarge,
                                  );
                                }).toList(),
                                onSelectedItemChanged: (value) {
                                  selectedYear = value + 1403;

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

              BlocBuilder<SelectingEventsCubit, SelectingEventsState>(
                builder: (context, state) {
                  final List<ResponseEventDetails> events = [];

                  final isLoading =
                      state is SelectingEventsInitial ||
                      state is SelectingEventsLoading;

                  if (state is SelectingEventsInitial) {
                    context.read<SelectingEventsCubit>().loadEvents();
                  }

                  if (isLoading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }

                  if (state is SelectingEventsSuccess) {
                    events.addAll(sortedEvents(state.events));
                  }

                  if (state is SelectingEventsSuccess && events.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Center(
                        child: Text(
                          'No events found on ${months[selectedMonth]}, $selectedYear',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    );
                  }

                  return Expanded(
                    child: ListView.separated(
                      itemCount: events.length,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      separatorBuilder: (context, index) => Gap(12),
                      itemBuilder: (context, index) {
                        final double totalExpense = events[index].transactions
                            .fold(0, (previousValue, element) {
                              if (element.transactionType ==
                                  TransactionType.income) {
                                return previousValue;
                              }
                              return previousValue + element.amount;
                            });
                        final double totalIncome = events[index].transactions
                            .fold(0, (previousValue, element) {
                              if (element.transactionType ==
                                  TransactionType.expense) {
                                return previousValue;
                              }
                              return previousValue + element.amount;
                            });
                        final isSelected = widget.selectedEvents.any(
                          (element) => element.id == events[index].id,
                        );

                        return DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: BoxBorder.all(
                              color: kPrimaryContainerColor,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Checkbox.adaptive(
                                    value: isSelected,
                                    activeColor: kSecondaryColor,
                                    onChanged: (value) {
                                      widget.onPressed.call(events[index], (
                                        month: selectedMonth,
                                        year: selectedYear,
                                      ));
                                    },
                                  ),
                                  Expanded(
                                    child: Text(
                                      events[index].title,
                                      textAlign: TextAlign.left,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.displayLarge,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 25.0,
                                  bottom: 12,
                                  right: 18,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      events[index]
                                          .date
                                          .formattedToJalali_yearMonthDayWeekDay,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.displayMedium,
                                    ),
                                    Gap(5),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Income:  ',
                                            style: Theme.of(
                                              context,
                                            ).textTheme.headlineSmall,
                                          ),
                                          TextSpan(
                                            text:
                                                AmountHelper.integerToFormattedPrice(
                                                  totalIncome,
                                                ),
                                            style: Theme.of(
                                              context,
                                            ).textTheme.displayLarge,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Expense:  ',
                                            style: Theme.of(
                                              context,
                                            ).textTheme.headlineSmall,
                                          ),
                                          TextSpan(
                                            text:
                                                AmountHelper.integerToFormattedPrice(
                                                  totalExpense,
                                                ),
                                            style: Theme.of(
                                              context,
                                            ).textTheme.displayLarge,
                                          ),
                                        ],
                                      ),
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
