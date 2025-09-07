import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:pay_pilot/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot/core/utils/helpers/amount_helper.dart';
import 'package:pay_pilot/features/report_details/presentation/cubit/report_details_cubit.dart';
import 'package:pay_pilot/features/reports/data/report_form.dart';

class ReportDetailsScreen extends StatefulWidget {
  static const routeName = '/report-details/id:${AppArguments.reportDetails}';

  final String reportID;
  const ReportDetailsScreen({super.key, required this.reportID});

  @override
  State<ReportDetailsScreen> createState() => _ReportDetailsScreenState();
}

class _ReportDetailsScreenState extends State<ReportDetailsScreen> {
  @override
  void initState() {
    super.initState();

    context.read<ReportDetailsCubit>().loadReportDetails(
      int.parse(widget.reportID),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Report Details')),
      body: BlocBuilder<ReportDetailsCubit, ReportDetailsState>(
        builder: (context, state) {
          if (state is ReportDetailsSuccess) {
            final reportDetails = state.report;
            final List<dynamic> encodedMembers = jsonDecode(
              reportDetails.membersReport,
            );
            final List<MemberReport> members = encodedMembers.map((e) {
              return MemberReport.fromJson(e);
            }).toList();

            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 18),
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'This report generated for '),
                      TextSpan(
                        text: DateFormat.yMMMM().format(reportDetails.date),
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Total Balance ${AmountHelper.integerToFormattedPrice(reportDetails.totalBalance)}',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  'Version ${reportDetails.version}',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),

                Divider(),
                Gap(12),

                ListView.separated(
                  itemCount: members.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => Gap(3),
                  itemBuilder: (context, index) {
                    return Card(
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
                                    members[index].name,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                                Text(
                                  '${members[index].percentage}%',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),

                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: 'Salary  '),
                                  TextSpan(
                                    text: AmountHelper.integerToFormattedPrice(
                                      members[index].amount,
                                    ),
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }

          return const Center(child: CircularProgressIndicator.adaptive());
        },
      ),
    );
  }
}
