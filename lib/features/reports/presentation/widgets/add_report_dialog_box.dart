import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/data/params/report_params.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/l10n/generated/l10n.dart';
import 'package:pay_pilot/core/utils/extensions/format_date_to_persian_calendar.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';
import 'package:pay_pilot/core/widgets/app_elevated_button.dart';
import 'package:pay_pilot/core/widgets/app_text_field.dart';
import 'package:pay_pilot/core/widgets/pick_date.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_details.dart';
import 'package:pay_pilot/features/reports/presentation/widgets/selecting_events.dart';
import 'package:persian_calendar_widget/persian_calendar_widget.dart';

class AddReportDialogBox extends StatefulWidget {
  final Report? report;
  final Function(ReportParams report) onPressedSubmit;
  // final BuildContext innerContext;
  const AddReportDialogBox({
    super.key,
    this.report,
    required this.onPressedSubmit,
    // required this.innerContext,
  });

  @override
  State<AddReportDialogBox> createState() => _AddReportDialogBoxState();
}

class _AddReportDialogBoxState extends State<AddReportDialogBox> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController totalAmountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final PageController pageController = PageController();
  final formKey = GlobalKey<FormState>();
  ({int month, int year})? selectedDate;
  final List<ResponseEventDetails> selectedEvents = [];
  int pageIndex = 0;
  bool showIncomesWarning = false;

  @override
  void dispose() {
    descriptionController.dispose();
    titleController.dispose();
    totalAmountController.dispose();
    dateController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 780,
        height: 620,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              Column(
                children: [
                  Text(
                    S.current.report_addReport,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Gap(18),
                  Expanded(
                    child: PageView(
                      controller: pageController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        SelectingEvents(
                          selectedDate: selectedDate,
                          selectedEvents: selectedEvents,
                          onPressed: (event, date) {
                            selectedDate = date;
                            final isSelected = selectedEvents.any(
                              (element) => element.id == event.id,
                            );

                            if (isSelected) {
                              selectedEvents.remove(event);
                            } else {
                              showIncomesWarning = false;
                              selectedEvents.add(event);
                            }

                            setState(() {});
                          },
                        ),

                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    AppTextField(
                                      label: S.current.textField_label_title,
                                      hint: S
                                          .current
                                          .textField_hint_thisMonthSalary,
                                      autoFocus: true,
                                      controller: titleController,
                                      keyboardType: TextInputType.name,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return S.current.validator_required;
                                        }
                                        return null;
                                      },
                                    ),
                                    Gap(8),
                                    AppTextField(
                                      label:
                                          S.current.textField_label_generateFor,
                                      hint: DateTime.now()
                                          .formattedToJalali_yearMonth,
                                      controller: dateController,
                                      keyboardType: TextInputType.datetime,
                                      readOnly: true,
                                      onTap: (focusNode) async {
                                        PickDate.yearAndMonth(
                                          context,
                                          initDate: Jalali(
                                            selectedDate!.year,
                                            selectedDate!.month,
                                          ).toDateTime(),
                                          onSubmit:
                                              (pickedDate, formattedDate) {
                                                selectedDate = (
                                                  month: pickedDate
                                                      .toJalali()
                                                      .month,
                                                  year: pickedDate
                                                      .toJalali()
                                                      .year,
                                                );
                                                dateController.text =
                                                    formattedDate;
                                              },
                                        );
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return S.current.validator_required;
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Gap(8),
                              AppTextField(
                                label:
                                    '${S.current.textField_label_description} ${S.current.textField_label_optional}',
                                controller: descriptionController,
                                minLines: 3,
                                maxLines: 4,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: kPrimaryColor),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (showIncomesWarning)
                          Text(
                            S.current.warning_selectEvent,
                            textAlign: TextAlign.left,
                            style: TextStyle(color: kErrorColor),
                          ),
                        Gap(5),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                if (pageIndex == 0) {
                                  context.pop();
                                  return;
                                }
                                pageController.animateToPage(
                                  pageIndex - 1,
                                  duration: Duration(milliseconds: 150),
                                  curve: Curves.bounceIn,
                                );
                                showIncomesWarning = false;
                                FocusScope.of(
                                  context,
                                ).requestFocus(FocusNode());
                                pageIndex--;
                                setState(() {});
                              },
                              child: Text(
                                pageIndex == 0
                                    ? S.current.button_title_cancel
                                    : S.current.button_title_previous,
                                style: Theme.of(
                                  context,
                                ).textTheme.displayMedium,
                              ),
                            ),
                            Gap(8),
                            Expanded(
                              child: AppElevatedButton(
                                onTap: () async {
                                  if (pageIndex == 0 &&
                                      selectedEvents.isEmpty) {
                                    showIncomesWarning = true;
                                    setState(() {});
                                    return;
                                  }
                                  if (pageIndex == 1) {
                                    if (!formKey.currentState!.validate()) {
                                      return;
                                    }

                                    widget.onPressedSubmit.call(
                                      ReportParams(
                                        title: titleController.text,
                                        description: descriptionController.text,
                                        generateFor: Jalali(
                                          selectedDate!.year,
                                          selectedDate!.month,
                                        ).toDateTime(),
                                        events: selectedEvents
                                            .map((e) => e.id)
                                            .toList(),
                                      ),
                                    );

                                    if (context.mounted) {
                                      context.pop();
                                    }
                                    return;
                                  }

                                  pageController.animateToPage(
                                    pageIndex + 1,
                                    duration: Duration(milliseconds: 150),
                                    curve: Curves.bounceIn,
                                  );
                                  pageIndex++;
                                  showIncomesWarning = false;
                                  setState(() {});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    pageIndex == 1
                                        ? S.current.button_title_generate
                                        : S.current.button_title_next,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.displayLarge,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
