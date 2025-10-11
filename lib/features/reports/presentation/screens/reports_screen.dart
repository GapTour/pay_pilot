import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pay_pilot/core/app/app_routes.dart';
import 'package:pay_pilot/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';
import 'package:pay_pilot/core/widgets/app_list.dart';
import 'package:pay_pilot/core/widgets/app_tile.dart';
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

          return AppList(
            itemCount: reports.length,
            emptyInboxMessage: 'There is no report yet!',
            itemBuilder: (context, index) {
              return AppTile(
                height: 56,
                onPreview: () {
                  context.pushNamed(
                    AppRoutes.reportDetailsScreen,
                    pathParameters: {
                      AppArguments.reportDetails: reports[index].id.toString(),
                    },
                  );
                },
                onDelete: () {
                  context.read<ReportsCubit>().deleteReport(reports[index].id);
                },
                previewButtonTitle: 'Salary\'s Report',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      reports[index].title,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Gap(3),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            DateFormat.yMMM().format(
                              reports[index].generateFor,
                            ),
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),

                        Text(
                          'V ${reports[index].version}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
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
        backgroundColor: kSecondaryColor,
        splashColor: kPrimaryColor,
        child: Icon(Icons.add),
      ),
    );
  }
}
