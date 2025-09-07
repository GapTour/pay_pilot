import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
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

          return GridView.builder(
            itemCount: reports.length,
            padding: const EdgeInsets.all(18),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 380,
              childAspectRatio: 6,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {},
                child: Card(
                  child: Row(
                    children: [
                      Gap(15),
                      Expanded(
                        child: Text(
                          DateFormat.yM().format(reports[index].date),
                          textAlign: TextAlign.left,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),

                      Text(
                        'Version ${reports[index].version.toString()}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                      Gap(15),
                    ],
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
