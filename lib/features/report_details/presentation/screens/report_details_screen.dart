import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot/core/l10n/generated/l10n.dart';
import 'package:pay_pilot/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot/core/utils/extensions/format_date_to_persian_calendar.dart';
import 'package:pay_pilot/core/utils/helpers/amount_helper.dart';
import 'package:pay_pilot/core/widgets/app_list.dart';
import 'package:pay_pilot/core/widgets/app_loading_state.dart';
import 'package:pay_pilot/core/widgets/app_tile.dart';
import 'package:pay_pilot/features/report_details/data/models/response_report_details.dart';
import 'package:pay_pilot/features/report_details/presentation/bloc/report_details_bloc.dart';
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

    context.read<ReportDetailsBloc>().add(
      FetchReportDetails(reportID: int.parse(widget.reportID)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.current.reportDetails_appBarTitle)),
      body: BlocBuilder<ReportDetailsBloc, ReportDetailsState>(
        buildWhen: (p, c) => p.reportDetailsStatus != c.reportDetailsStatus,
        builder: (context, state) {
          late ResponseReportDetails reportDetails;
          final isLoading =
              state.reportDetailsStatus is ReportDetailsInit ||
              state.reportDetailsStatus is ReportDetailsLoading;

          if (isLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (state.reportDetailsStatus is ReportDetailsFailure) {
            return Center(child: Text(S.current.warning_somethingWentWrong));
          }

          reportDetails =
              (state.reportDetailsStatus as ReportDetailsFetched).reportDetails;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        text: '${S.current.reportDetails_reportGeneratedFor} ',
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

                Expanded(
                  child: BlocBuilder<ReportDetailsBloc, ReportDetailsState>(
                    buildWhen: (p, c) =>
                        p.reportBalanceStatus != c.reportBalanceStatus,
                    builder: (context, state) {
                      if (state.reportBalanceStatus is ReportBalanceInit ||
                          state.reportBalanceStatus is ReportBalanceLoading) {
                        return AppLoadingState();
                      }

                      if (state.reportBalanceStatus is ReportBalanceFailure) {
                        return Center(
                          child: Text(
                            S.current.warning_calculatingSalaryGoesWrong,
                          ),
                        );
                      }

                      final membersBalance =
                          (state.reportBalanceStatus as ReportBalanceCalculated)
                              .membersBalance;

                      return AppList(
                        itemCount: membersBalance.length,
                        shrinkWrap: true,
                        // padding: EdgeInsets.zero,
                        emptyInboxMessage: '',
                        itemBuilder: (context, index) {
                          return AppTile(
                            isActive: false,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  membersBalance[index].member.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.displayLarge,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        S.current.contentTitle_salary,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.headlineSmall,
                                      ),
                                    ),
                                    Text(
                                      AmountHelper.integerToFormattedPrice(
                                        membersBalance[index].salary,
                                      ),
                                      style: Theme.of(
                                        context,
                                      ).textTheme.displayLarge,
                                    ),
                                  ],
                                ),
                                if ((membersBalance[index].expenses ?? 0) > 0)
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          S.current.contentTitle_paidExpenses,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.headlineSmall,
                                        ),
                                      ),
                                      Text(
                                        AmountHelper.integerToFormattedPrice(
                                          membersBalance[index].expenses!,
                                        ),
                                        style: Theme.of(
                                          context,
                                        ).textTheme.displayLarge,
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
                ),
                Gap(45),
              ],
            ),
          );
        },
      ),
    );
  }
}
