import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot/core/l10n/generated/l10n.dart';
import 'package:pay_pilot/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot/core/utils/extensions/empty_text.dart';
import 'package:pay_pilot/core/utils/extensions/format_date_to_persian_calendar.dart';
import 'package:pay_pilot/features/guest_details/presentation/cubit/guests_details_cubit.dart';

class GuestDetailsScreen extends StatefulWidget {
  static const routeName = '/guests-details/id:${AppArguments.guestDetails}';

  final String guestID;
  const GuestDetailsScreen({super.key, required this.guestID});

  @override
  State<GuestDetailsScreen> createState() => _GuestDetailsScreenState();
}

class _GuestDetailsScreenState extends State<GuestDetailsScreen> {
  @override
  void initState() {
    super.initState();

    context.read<GuestsDetailsCubit>().loadGuestDetails(
      int.parse(widget.guestID),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.current.guestDetails_appBarTitle)),
      body: BlocBuilder<GuestsDetailsCubit, GuestsDetailsState>(
        builder: (context, state) {
          if (state.guestsStatus is GuestSuccess) {
            final guestDetail = (state.guestsStatus as GuestSuccess).guest;

            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              children: [
                Text(
                  guestDetail.name,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Gap(8),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: S.current.contentTitle_phone,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      TextSpan(
                        text: guestDetail.phone ?? '-',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                ),
                Gap(5),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: S.current.contentTitle_telegram,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      TextSpan(
                        text: guestDetail.telegramID ?? '-',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                ),
                Gap(5),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: S.current.contentTitle_instagram,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      TextSpan(
                        text: guestDetail.instagramID ?? '-',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                ),
                Gap(5),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: S.current.contentTitle_birthday,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      TextSpan(
                        text: guestDetail.birthday == null
                            ? '-'
                            : guestDetail
                                  .birthday!
                                  .formattedToJalali_yearMonthDay,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                ),
                Gap(5),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: S.current.contentTitle_description,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      TextSpan(
                        text: guestDetail.description.defaultEmptyText(),
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
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
