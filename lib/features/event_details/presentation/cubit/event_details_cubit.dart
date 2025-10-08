import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay_pilot/core/data/models/event_details_model.dart';
import 'package:pay_pilot/core/data/models/transaction_model.dart';
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
          eventDetailStatus: EventDetailInitial(),
        ),
      );

  void changePage(EventDetailsPage page) {
    emit(state.copyWith(currentPage: page));
  }

  void loadTransactions(int id, {EventDetailsModel? eventDetails}) async {
    late EventDetailsModel fetchedEventDetails;
    emit(state.copyWith(eventDetailStatus: EventDetailLoading()));

    try {
      fetchedEventDetails = eventDetails ?? await _repository.getEvent(id);
      emit(
        state.copyWith(
          eventDetailStatus: EventDetailSuccess(fetchedEventDetails),
        ),
      );
    } catch (_) {
      emit(state.copyWith(eventDetailStatus: EventDetailFailure()));
    }
  }

  void insertTransaction(TransactionForm transaction) async {
    final EventDetailsModel fetchedEventDetails =
        (state.eventDetailStatus as EventDetailSuccess).eventDetails;
    final List<TransactionModel> transactions = [];

    emit(state.copyWith(eventDetailStatus: EventDetailLoading()));
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
      ..addAll(fetchedEventDetails.transactions);

    transactions.sort((a, b) => b.date.compareTo(a.date));

    loadTransactions(
      fetchedEventDetails.id,
      eventDetails: fetchedEventDetails.copyWith(transactions: transactions),
    );
  }

  void updateTransaction(TransactionEditForm transaction) async {
    final EventDetailsModel fetchedEventDetails =
        (state.eventDetailStatus as EventDetailSuccess).eventDetails;
    final List<TransactionModel> transactions = [];

    emit(state.copyWith(eventDetailStatus: EventDetailLoading()));
    await _repository.updateTransaction(transaction);
    transactions
      ..addAll(fetchedEventDetails.transactions)
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

    loadTransactions(
      fetchedEventDetails.id,
      eventDetails: fetchedEventDetails.copyWith(transactions: transactions),
    );
  }

  void deleteTransaction(int transactionID) async {
    final EventDetailsModel fetchedEventDetails =
        (state.eventDetailStatus as EventDetailSuccess).eventDetails;
    final List<TransactionModel> transactions = [];

    emit(state.copyWith(eventDetailStatus: EventDetailLoading()));
    await _repository.deleteTransaction(transactionID);
    transactions
      ..addAll(fetchedEventDetails.transactions)
      ..removeWhere((element) => element.id == transactionID);

    transactions.sort((a, b) => b.date.compareTo(a.date));

    loadTransactions(
      fetchedEventDetails.id,
      eventDetails: fetchedEventDetails.copyWith(transactions: transactions),
    );
  }
}
