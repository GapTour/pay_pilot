import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay_pilot/core/data/models/event_details_model.dart';
import 'package:pay_pilot/features/event_transactions/data/transaction_edit_form.dart';
import 'package:pay_pilot/features/event_transactions/data/transaction_form.dart';
import 'package:pay_pilot/features/event_transactions/repository/transaction_repository.dart';

part 'event_transactions_state.dart';

class EventTransactionsCubit extends Cubit<EventTransactionsState> {
  final TransactionRepository _repository;
  EventTransactionsCubit(this._repository) : super(EventTransactionsInitial());

  void loadTransactions(int id, {EventDetailsModel? eventDetails}) async {
    late EventDetailsModel fetchedEventDetails;
    emit(EventTransactionsLoading());

    try {
      fetchedEventDetails = eventDetails ?? await _repository.getEvent(id);
      emit(EventTransactionsSuccess(fetchedEventDetails));
    } catch (_) {
      emit(EventTransactionsFailure());
    }
  }

  void insertTransaction(TransactionForm transaction) async {
    final EventDetailsModel fetchedEventDetails =
        (state as EventTransactionsSuccess).eventDetails;
    final List<Transactions> transactions = [];

    emit(EventTransactionsLoading());
    final int transactionID = await _repository.insertTransaction(transaction);
    transactions
      ..add(
        Transactions(
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
        (state as EventTransactionsSuccess).eventDetails;
    final List<Transactions> transactions = [];

    emit(EventTransactionsLoading());
    await _repository.updateTransaction(transaction);
    transactions
      ..addAll(fetchedEventDetails.transactions)
      ..removeWhere((element) => element.id == transaction.id)
      ..add(
        Transactions(
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
        (state as EventTransactionsSuccess).eventDetails;
    final List<Transactions> transactions = [];

    emit(EventTransactionsLoading());
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
