// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'incomes_cubit.dart';

enum IncomesStatus { initial, loading, success, failure }

class IncomesState extends Equatable {
  final IncomesStatus incomesStatus;
  final List<Income> incomes;
  const IncomesState({required this.incomesStatus, required this.incomes});

  @override
  List<Object> get props => [incomesStatus, incomes];

  IncomesState copyWith({IncomesStatus? incomesStatus, List<Income>? incomes}) {
    return IncomesState(
      incomesStatus: incomesStatus ?? this.incomesStatus,
      incomes: incomes ?? this.incomes,
    );
  }
}
