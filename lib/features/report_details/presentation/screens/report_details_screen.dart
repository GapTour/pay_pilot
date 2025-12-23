import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot/core/utils/extensions/format_date_to_persian_calendar.dart';
import 'package:pay_pilot/core/utils/helpers/amount_helper.dart';
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
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Gap(12),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'This report generated for ',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      TextSpan(
                        text: reportDetails
                            .generateFor
                            .formattedToJalali_yearMonth,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ],
                  ),
                ),
                Text(
                  'Version ${reportDetails.version}',
                  style: Theme.of(context).textTheme.displayMedium,
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
                      isActive: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reportDetails.membersBalance[index].member.name,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Salary ',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineSmall,
                                ),
                              ),
                              Text(
                                AmountHelper.integerToFormattedPrice(
                                  reportDetails
                                      .membersBalance[index]
                                      .totalBalance,
                                ),
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Gap(45),
              ],
            );
          }

          return const Center(child: CircularProgressIndicator.adaptive());
        },
      ),
    );
  }
}
