import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/widgets/app_text_field.dart';
import 'package:pay_pilot/features/reports/data/report_form.dart';
import 'package:pay_pilot/features/reports/presentation/cubit/reports_cubit.dart';
import 'package:pay_pilot/features/reports/presentation/widgets/selecting_incomes.dart';
import 'package:pay_pilot/features/reports/presentation/widgets/selecting_members.dart';

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
  // late int? reportID;
  ({int month, int year})? selectedDate;
  final List<Member> selectedMembers = [];
  final List<Income> selectedIncomes = [];
  int pageIndex = 0;

  bool showIncomesWarning = false;
  bool showMembersWarning = false;
  bool isGenerating = false;

  void generateVersion(BuildContext innerContext) {
    final reports = innerContext.read<ReportsCubit>().state.reports;

    final int reportLength =
        reports.where((element) {
          return element.date.month == selectedDate!.month &&
              element.date.year == selectedDate!.year;
        }).length +
        1;

    versionController.text = reportLength.toString();
  }

  Future<({List<MemberReport> members, double totalBalance})>
  generateReport() async {
    final List<MemberReport> memberReports = [];
    final double totalIncome = selectedIncomes.fold(
      0,
      (previousValue, element) => previousValue + element.amount,
    );
    final double sumRatios = selectedMembers.fold(
      0,
      (previousValue, element) => previousValue + element.percentage,
    );

    for (var m in selectedMembers) {
      final double share = (m.percentage / sumRatios) * totalIncome;
      memberReports.add(
        MemberReport(
          id: m.id,
          name: m.name,
          percentage: m.percentage,
          amount: share,
        ),
      );
    }

    return (members: memberReports, totalBalance: totalIncome);
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
  void initState() {
    super.initState();

    // if (widget.report != null) {
    //   reportID = widget.report!.id;
    //   // titleController.text = widget.income!.title;
    //   // amountController.text = widget.income!.amount.toString();
    //   // descriptionController.text = widget.income!.description ?? '';
    //   // dateController.text = DateFormat.MMMMEEEEd().format(widget.income!.date);
    //   // selectedDate = widget.income!.date;
    // } else {
    //   // incomeID = null;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 780,
        height: 620,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text('Create new report', style: TextStyle(fontSize: 22)),
              Gap(18),
              Expanded(
                child: PageView(
                  controller: pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    SelectingIncomes(
                      selectedDate: selectedDate,
                      selectedIncomes: selectedIncomes,
                      onPressed: (income, date) {
                        selectedDate = date;
                        final isSelected = selectedIncomes.any(
                          (element) => element.id == income.id,
                        );

                        if (isSelected) {
                          selectedIncomes.remove(income);
                        } else {
                          showIncomesWarning = false;
                          selectedIncomes.add(income);
                        }

                        setState(() {});
                      },
                    ),
                    SelectingMembers(
                      selectedMembers: selectedMembers,
                      onPressed: (member) {
                        final isSelected = selectedMembers.any(
                          (element) => element.id == member.id,
                        );

                        if (isSelected) {
                          selectedMembers.remove(member);
                        } else {
                          showMembersWarning = false;
                          selectedMembers.add(member);
                        }

                        setState(() {});
                      },
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Form(
                          key: formKey,
                          child: AppTextField(
                            label: 'Title',
                            hint: 'This month salary',
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
                        Gap(12),

                        AppTextField(
                          label: 'Description (optional)',
                          controller: descriptionController,
                          minLines: 3,
                          maxLines: 4,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (showIncomesWarning)
                Text(
                  'Select income please!',
                  style: TextStyle(color: Colors.red),
                ),
              if (showMembersWarning)
                Text(
                  'Select some member please!',
                  style: TextStyle(color: Colors.red),
                ),
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
                      showMembersWarning = false;
                      pageIndex--;
                      setState(() {});
                    },
                    child: Text(pageIndex == 0 ? 'Cancel' : 'Previous'),
                  ),
                  Gap(8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: isGenerating
                          ? null
                          : () async {
                              if (pageIndex == 0 && selectedIncomes.isEmpty) {
                                showIncomesWarning = true;
                                setState(() {});
                                return;
                              }
                              if (pageIndex == 1 && selectedMembers.isEmpty) {
                                showMembersWarning = true;
                                setState(() {});
                                return;
                              }
                              if (pageIndex == 2) {
                                if (!formKey.currentState!.validate()) return;
                                isGenerating = true;
                                setState(() {});

                                await generateReport().then((value) {
                                  widget.onPressedSubmit.call(
                                    ReportForm(
                                      title: titleController.text,
                                      version: int.parse(
                                        versionController.text,
                                      ),
                                      totalBalance: value.totalBalance,
                                      description: descriptionController.text,
                                      date: DateTime(
                                        selectedDate!.year,
                                        selectedDate!.month,
                                      ),
                                      membersReport: value.members,
                                    ),
                                  );
                                });

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
                              showMembersWarning = false;
                              setState(() {});
                            },
                      child: Text(pageIndex == 2 ? 'Generate' : 'Next'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
