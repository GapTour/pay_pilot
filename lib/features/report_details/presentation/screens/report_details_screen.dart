import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:pay_pilot/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot/core/utils/helpers/amount_helper.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';
import 'package:pay_pilot/core/widgets/app_list.dart';
import 'package:pay_pilot/core/widgets/app_tile.dart';
import 'package:pay_pilot/features/report_details/presentation/cubit/report_details_cubit.dart';
import 'package:pay_pilot/features/report_details/presentation/widgets/balance_banner.dart';

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

            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              children: [
                Text(
                  reportDetails.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Gap(12),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'This report generated for '),
                      TextSpan(
                        text: DateFormat.yMMMM().format(
                          reportDetails.generateFor,
                        ),
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Version ${reportDetails.version}',
                  style: TextStyle(fontSize: 14, color: kSecondaryColor),
                ),
                Gap(12),
                BalanceBanner(events: reportDetails.events),
                Gap(12),

                AppList(
                  itemCount: reportDetails.membersBalance.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  emptyInboxMessage: '',
                  itemBuilder: (context, index) {
                    return AppTile(
                      height: 70,
                      isActive: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reportDetails.membersBalance[index].member.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 18),
                          ),
                          Row(
                            children: [
                              Expanded(child: Text('Salary ')),
                              Text(
                                AmountHelper.integerToFormattedPrice(
                                  reportDetails
                                      .membersBalance[index]
                                      .totalBalance,
                                ),
                                style: const TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ],
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
