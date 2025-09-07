import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pay_pilot/core/app/app_routes.dart';
import 'package:pay_pilot/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot/core/utils/helpers/amount_helper.dart';
import 'package:pay_pilot/features/reports/presentation/cubit/reports_cubit.dart';
import 'package:pay_pilot/features/reports/presentation/widgets/add_report_dialog_box.dart';

class ReportsScreen extends StatefulWidget {
  static const routeName = '/reports';

  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  void initState() {
    super.initState();

    context.read<ReportsCubit>().loadReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      body: BlocBuilder<ReportsCubit, ReportsState>(
        builder: (context, state) {
          final reports = state.reports;
          final isLoading =
              state.reportsStatus == ReportsStatus.loading ||
              state.reportsStatus == ReportsStatus.initial;

          if (isLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (reports.isEmpty) {
            return const Center(child: Text('No reports found.'));
          }

          return ListView.separated(
            itemCount: reports.length,
            padding: const EdgeInsets.all(18),
            separatorBuilder: (context, index) => Gap(3),
            itemBuilder: (context, index) {
              return InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  context.pushNamed(
                    AppRoutes.reportDetailsScreen,
                    pathParameters: {
                      AppArguments.reportDetails: reports[index].id.toString(),
                    },
                  );
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                reports[index].title,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),

                            Text(
                              AmountHelper.integerToFormattedPrice(
                                reports[index].totalBalance,
                              ),
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                DateFormat.yMMM().format(reports[index].date),
                                textAlign: TextAlign.left,
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),

                            Text(
                              'V ${reports[index].version}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
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
              return AddReportDialogBox(
                innerContext: context,
                onPressedSubmit: (report) {
                  context.read<ReportsCubit>().addReport(report);
                },
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
