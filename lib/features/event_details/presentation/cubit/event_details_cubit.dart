import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay_pilot/core/data/models/balance_model.dart';
import 'package:pay_pilot/core/data/models/event_details_model.dart';
import 'package:pay_pilot/core/data/models/member_ratio_model.dart';
import 'package:pay_pilot/core/data/models/transaction_model.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/features/event_details/data/models/event_ratio_edit_form.dart';
import 'package:pay_pilot/features/event_details/data/models/event_ratio_form.dart';
import 'package:pay_pilot/features/event_details/data/transaction_edit_form.dart';
import 'package:pay_pilot/features/event_details/data/transaction_form.dart';
import 'package:pay_pilot/features/event_details/repository/event_details_repository.dart';

part 'event_details_state.dart';
part 'status/event_detail_status.dart';

class EventDetailsCubit extends Cubit<EventDetailsState> {
  final EventDetailsRepository _repository;
  EventDetailsCubit(this._repository)
    : super(
        EventDetailsState(
          currentPage: EventDetailsPage.transactions,
          eventTabsStatus: EventTabsStatus.initial,
          eventDetailStatus: EventDetailInitial(),
          addedMembers: {},
          members: [],
          memberRatios: [],
          membersBalance: [],
          transactions: [],
        ),
      );

  void changePage(EventDetailsPage page) {
    emit(state.copyWith(currentPage: page));
  }

  void loadTransactions(int id) async {
    emit(
      state.copyWith(
        eventTabsStatus: EventTabsStatus.loading,
        eventDetailStatus: EventDetailLoading(),
      ),
    );

    try {
      final eventDetails = await _repository.getEvent(id);
      final members = await _repository.getAllMembers();
      final Map<int, double> addedMembers = {};
      eventDetails.memberRatios.fold<Map<int, double>>({}, (
        previousValue,
        element,
      ) {
        if (!previousValue.containsKey(element.member.id)) {
          addedMembers[element.member.id] = element.ratio;
        }
        return previousValue;
      });

      emit(
        state.copyWith(
          eventDetailStatus: EventDetailSuccess(eventDetails),
          eventTabsStatus: EventTabsStatus.loaded,
          addedMembers: addedMembers,
          memberRatios: eventDetails.memberRatios,
          members: members,
          membersBalance: eventDetails.membersBalance,
          transactions: eventDetails.transactions,
        ),
      );
    } catch (_) {
      emit(state.copyWith(eventDetailStatus: EventDetailFailure()));
    }
  }

  void insertTransaction(TransactionForm transaction) async {
    emit(state.copyWith(eventTabsStatus: EventTabsStatus.loading));

    final List<TransactionModel> transactions = [];
    final int transactionID = await _repository.insertTransaction(transaction);

    transactions
      ..add(
        TransactionModel(
          id: transactionID,
          description: transaction.description,
          amount: transaction.amount,
          transactionType: transaction.transactionType,
          date: transaction.date,
        ),
      )
      ..addAll(state.transactions);

    transactions.sort((a, b) => b.date.compareTo(a.date));

    emit(
      state.copyWith(
        eventTabsStatus: EventTabsStatus.loaded,
        transactions: transactions,
      ),
    );
  }

  void insertRatio(EventRatioForm eventRatio) async {
    emit(state.copyWith(eventTabsStatus: EventTabsStatus.loading));

    final int ratioID = await _repository.insertRatio(eventRatio);

    final eventRatios = <MemberRatioModel>[];
    eventRatios
      ..addAll(state.memberRatios)
      ..add(
        MemberRatioModel(
          id: ratioID,
          member: eventRatio.member,
          ratio: eventRatio.ratio,
        ),
      );
    eventRatios.sort((a, b) => b.ratio.compareTo(a.ratio));

    final lastAddedMember = <int, double>{};
    lastAddedMember.addAll(state.addedMembers);
    lastAddedMember[eventRatio.member.id] = eventRatio.ratio;

    emit(
      state.copyWith(
        eventTabsStatus: EventTabsStatus.loaded,
        addedMembers: lastAddedMember,
        memberRatios: eventRatios,
      ),
    );
  }

  void updateRatio(EventRatioEditForm eventRatio) async {
    emit(state.copyWith(eventTabsStatus: EventTabsStatus.loading));

    await _repository.updateEventRatio(eventRatio);

    final List<MemberRatioModel> eventRatios = [];
    eventRatios
      ..addAll(state.memberRatios)
      ..removeWhere((element) => element.id == eventRatio.id)
      ..add(
        MemberRatioModel(
          id: eventRatio.id,
          member: eventRatio.member,
          ratio: eventRatio.ratio,
        ),
      );

    eventRatios.sort((a, b) => b.ratio.compareTo(a.ratio));

    emit(
      state.copyWith(
        eventTabsStatus: EventTabsStatus.loaded,
        memberRatios: eventRatios,
      ),
    );
  }

  void deleteRatio(int ratioID) async {
    emit(state.copyWith(eventTabsStatus: EventTabsStatus.loading));

    await _repository.deleteEventRatio(ratioID);

    final int memberID = state.memberRatios
        .firstWhere((element) => element.id == ratioID)
        .member
        .id;
    final lastAddedMember = <int, double>{};
    lastAddedMember
      ..addAll(state.addedMembers)
      ..removeWhere((key, value) => key == memberID);

    final List<MemberRatioModel> eventRatios = [];
    eventRatios
      ..addAll(state.memberRatios)
      ..removeWhere((element) => element.id == ratioID);

    eventRatios.sort((a, b) => b.ratio.compareTo(a.ratio));

    emit(
      state.copyWith(
        eventTabsStatus: EventTabsStatus.loaded,
        addedMembers: lastAddedMember,
        memberRatios: eventRatios,
      ),
    );
  }

  void updateTransaction(TransactionEditForm transaction) async {
    emit(state.copyWith(eventTabsStatus: EventTabsStatus.loading));

    await _repository.updateTransaction(transaction);

    final List<TransactionModel> transactions = [];
    transactions
      ..addAll(state.transactions)
      ..removeWhere((element) => element.id == transaction.id)
      ..add(
        TransactionModel(
          id: transaction.id,
          description: transaction.description,
          amount: transaction.amount,
          transactionType: transaction.transactionType,
          date: transaction.date,
        ),
      );

    transactions.sort((a, b) => b.date.compareTo(a.date));

    emit(
      state.copyWith(
        eventTabsStatus: EventTabsStatus.loaded,
        transactions: transactions,
      ),
    );
  }

  void deleteTransaction(int transactionID) async {
    emit(state.copyWith(eventTabsStatus: EventTabsStatus.loading));

    await _repository.deleteTransaction(transactionID);

    final List<TransactionModel> transactions = [];
    transactions
      ..addAll(state.transactions)
      ..removeWhere((element) => element.id == transactionID);

    transactions.sort((a, b) => b.date.compareTo(a.date));

    emit(
      state.copyWith(
        eventTabsStatus: EventTabsStatus.loaded,
        transactions: transactions,
      ),
    );
  }
}
