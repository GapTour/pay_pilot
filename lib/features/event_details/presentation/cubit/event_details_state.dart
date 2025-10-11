// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'event_details_cubit.dart';

enum EventDetailsPage {
  transactions,
  members,
  report;

  bool get isTransactions => this == transactions;
  bool get isMembers => this == members;
  bool get isReport => this == report;
}

enum EventTabsStatus {
  initial,
  loading,
  loaded;

  bool get isInit => this == initial;
  bool get isLoading => this == loading || this == initial;
  bool get isLoaded => this == loaded;
}

class EventDetailsState extends Equatable {
  final EventDetailsPage currentPage;
  final EventDetailStatus eventDetailStatus;
  final EventTabsStatus eventTabsStatus;
  final List<Member> members;
  final Map<int, double> addedMembers;
  final List<TransactionModel> transactions;
  final List<MemberRatioModel> memberRatios;
  final List<BalanceModel> membersBalance;
  const EventDetailsState({
    required this.currentPage,
    required this.eventDetailStatus,
    required this.eventTabsStatus,
    required this.members,
    required this.addedMembers,
    required this.transactions,
    required this.memberRatios,
    required this.membersBalance,
  });

  @override
  List<Object> get props => [
    currentPage,
    eventDetailStatus,
    members,
    addedMembers,
    transactions,
    memberRatios,
    membersBalance,
    eventTabsStatus,
  ];

  EventDetailsState copyWith({
    EventDetailsPage? currentPage,
    EventDetailStatus? eventDetailStatus,
    EventTabsStatus? eventTabsStatus,
    List<Member>? members,
    Map<int, double>? addedMembers,
    List<TransactionModel>? transactions,
    List<MemberRatioModel>? memberRatios,
    List<BalanceModel>? membersBalance,
  }) {
    return EventDetailsState(
      currentPage: currentPage ?? this.currentPage,
      eventDetailStatus: eventDetailStatus ?? this.eventDetailStatus,
      eventTabsStatus: eventTabsStatus ?? this.eventTabsStatus,
      members: members ?? this.members,
      addedMembers: addedMembers ?? this.addedMembers,
      transactions: transactions ?? this.transactions,
      memberRatios: memberRatios ?? this.memberRatios,
      membersBalance: membersBalance ?? this.membersBalance,
    );
  }
}
