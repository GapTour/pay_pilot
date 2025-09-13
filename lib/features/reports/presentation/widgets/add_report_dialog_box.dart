import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/data/models/event_details_model.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';
import 'package:pay_pilot/core/widgets/app_elevated_button.dart';
import 'package:pay_pilot/core/widgets/app_text_field.dart';
import 'package:pay_pilot/features/reports/data/report_form.dart';
import 'package:pay_pilot/features/reports/presentation/cubit/reports_cubit.dart';
import 'package:pay_pilot/features/reports/presentation/widgets/selecting_events.dart';

class AddReportDialogBox extends StatefulWidget {
  final Report? report;
  final Function(ReportForm report) onPressedSubmit;
  final BuildContext innerContext;
  const AddReportDialogBox({
    super.key,
    this.report,
    required this.onPressedSubmit,
    required this.innerContext,
  });

  @override
  State<AddReportDialogBox> createState() => _AddReportDialogBoxState();
}

class _AddReportDialogBoxState extends State<AddReportDialogBox> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController versionController = TextEditingController();
  final TextEditingController totalAmountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final PageController pageController = PageController();
  final formKey = GlobalKey<FormState>();
  ({int month, int year})? selectedDate;
  final List<EventDetailsModel> selectedEvents = [];
  int pageIndex = 0;
  bool showIncomesWarning = false;

  void generateVersion(BuildContext innerContext) {
    final reports = innerContext.read<ReportsCubit>().state.reports;

    final int reportLength =
        reports.where((element) {
          return element.generateFor.month == selectedDate!.month &&
              element.generateFor.year == selectedDate!.year;
        }).length +
        1;

    versionController.text = reportLength.toString();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    titleController.dispose();
    versionController.dispose();
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
                  Text('Create new report', style: TextStyle(fontSize: 22)),
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
                                child: AppTextField(
                                  label: 'Title',
                                  hint: 'This month salary',
                                  autoFocus: true,
                                  controller: titleController,
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '*Required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              AppTextField(
                                label: 'Version (read only)',
                                controller: versionController,
                                readOnly: true,
                              ),

                              AppTextField(
                                label: 'Description (optional)',
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
                            'Select event please!',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.red),
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
                                pageIndex == 0 ? 'Cancel' : 'Previous',
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
                                      ReportForm(
                                        title: titleController.text,
                                        version: int.parse(
                                          versionController.text,
                                        ),
                                        description: descriptionController.text,
                                        generateFor: DateTime(
                                          selectedDate!.year,
                                          selectedDate!.month,
                                        ),
                                        events: selectedEvents,
                                      ),
                                    );

                                    if (context.mounted) {
                                      context.pop();
                                    }
                                    return;
                                  }
                                  if (pageIndex == 0) {
                                    generateVersion(widget.innerContext);
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
                                    pageIndex == 2 ? 'Generate' : 'Next',
                                    textAlign: TextAlign.center,
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
