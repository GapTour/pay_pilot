import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pay_pilot/core/data/enums/transaction_status.dart';
import 'package:pay_pilot/core/data/params/event_order_params.dart';
import 'package:pay_pilot/core/data/params/event_ratio_params.dart';
import 'package:pay_pilot/core/data/params/transaction_params.dart';
import 'package:pay_pilot/core/utils/helpers/calculator_helper.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_balance.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_details.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_ratio.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_transaction.dart';
import 'package:pay_pilot/features/event_details/data/models/response_order.dart';
import 'package:pay_pilot/features/event_details/repository/event_details_repository.dart';
import 'package:pay_pilot/features/guests/data/models/response_guest.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';
import 'package:pay_pilot/features/menu/data/models/response_menu.dart';

part 'event_details_event.dart';
part 'event_details_state.dart';
part 'status/event_details_status.dart';
part 'status/event_order_status.dart';
part 'status/event_ratio_status.dart';
part 'status/event_report_status.dart';
part 'status/event_transaction_status.dart';

class EventDetailsBloc extends Bloc<EventDetailsEvent, EventDetailsState> {
  final EventDetailsRepository _repository;
  EventDetailsBloc(this._repository)
    : super(
        EventDetailsState(
          eventDetailStatus: EventDetailInitial(),
          eventTransactionStatus: EventTransactionInitial(),
          currentPage: EventDetailsPage.transactions,
          eventRatioStatus: EventRatioInitial(),
          eventOrderStatus: EventOrderInitial(),
          eventReportStatus: EventReportInitial(),
          filteredOrders: [],
        ),
      ) {
    on<LoadEventDetails>(_loadEventDetails);
    on<UpdateEventDetails>(_updateEventDetails);
    on<AddTransaction>(_addTransaction);
    on<EditTransaction>(_editTransaction);
    on<DeleteTransaction>(_deleteTransaction);
    on<AddEventRatio>(_addEventRatio);
    on<EditEventRatio>(_editEventRatio);
    on<DeleteEventRatio>(_deleteEventRatio);
    on<AddOrder>(_addOrder);
    on<EditOrder>(_editOrder);
    on<DeleteOrder>(_deleteOrder);
    on<ChangePage>(_changePage);
    on<ChangeStatesToInit>(_changeStatesToInit);
    on<LoadReportList>(_loadReportList);
    on<UpdateFilteredOrders>(_updateFilteredOrders);
    on<UpdateOrdersList>(_updateOrdersList);
    on<ChangeOrderDeliveryStatus>(_changeOrderDeliveryStatus);
  }

  void _updateFilteredOrders(
    UpdateFilteredOrders event,
    Emitter<EventDetailsState> emit,
  ) {
    emit(state.copyWith(filteredOrders: event.filteredOrders));
  }

  Future<void> _changeOrderDeliveryStatus(
    ChangeOrderDeliveryStatus event,
    Emitter<EventDetailsState> emit,
  ) async {
    emit(state.copyWith(eventOrderStatus: EventOrderLoading()));

    final dataState = await _repository.changeOrderStatus(
      event.orderID,
      event.isDelivered,
    );

    if (dataState is DataSuccess) {
      add(ChangeStatesToInit());

      if (state.eventDetailStatus is EventDetailSuccess) {
        final eventDetailStatus = state.eventDetailStatus as EventDetailSuccess;
        final eventDetailsInfo = eventDetailStatus.eventDetails;
        final index = eventDetailsInfo.orders.indexWhere(
          (order) => order.id == dataState.data!.id,
        );
        eventDetailsInfo.orders[index] = dataState.data!;
        final orders = eventDetailsInfo.orders;

        emit(
          state.copyWith(
            eventDetailStatus: EventDetailSuccess(
              eventDetailsInfo.copyWith(orders: orders),
              eventDetailStatus.members,
              eventDetailStatus.guests,
              eventDetailStatus.menuItems,
            ),
          ),
        );
      }
    }
    if (dataState is DataFailed) {
      emit(state.copyWith(eventOrderStatus: EventOrderFailure()));
    }
  }

  Future<void> _updateOrdersList(
    UpdateOrdersList event,
    Emitter<EventDetailsState> emit,
  ) async {
    emit(state.copyWith(eventOrderStatus: EventOrderLoading()));

    final dataState = await _repository.getAllOrders(event.eventID);

    if (dataState is DataSuccess) {
      add(ChangeStatesToInit());

      if (state.eventDetailStatus is EventDetailSuccess) {
        final eventDetailStatus = state.eventDetailStatus as EventDetailSuccess;
        final eventDetailsInfo = eventDetailStatus.eventDetails;
        final orders = dataState.data;

        emit(
          state.copyWith(
            eventDetailStatus: EventDetailSuccess(
              eventDetailsInfo.copyWith(orders: orders),
              eventDetailStatus.members,
              eventDetailStatus.guests,
              eventDetailStatus.menuItems,
            ),
          ),
        );
      }
    }
    if (dataState is DataFailed) {
      emit(state.copyWith(eventOrderStatus: EventOrderFailure()));
    }
  }

  void _changePage(ChangePage event, Emitter<EventDetailsState> emit) {
    emit(state.copyWith(currentPage: event.page));
  }

  void _changeStatesToInit(
    ChangeStatesToInit event,
    Emitter<EventDetailsState> emit,
  ) {
    emit(
      state.copyWith(
        eventOrderStatus: EventOrderInitial(),
        eventRatioStatus: EventRatioInitial(),
        eventTransactionStatus: EventTransactionInitial(),
        eventReportStatus: EventReportInitial(),
      ),
    );
  }

  Future<void> _loadReportList(
    LoadReportList event,
    Emitter<EventDetailsState> emit,
  ) async {
    emit(state.copyWith(eventReportStatus: EventReportLoading()));

    final members = <ResponseMember>[];

    if (state.eventDetailStatus is EventDetailSuccess) {
      final eventDetails =
          (state.eventDetailStatus as EventDetailSuccess).eventDetails;
      members.addAll((state.eventDetailStatus as EventDetailSuccess).members);

      final totalAmount = CalculatorHelper.calculateTotalAmount(
        transactions: eventDetails.transactions,
      );
      final membersBalance = await CalculatorHelper.customEventSalary(
        totalAmount: totalAmount,
        transactions: eventDetails.transactions,
        memberRatios: eventDetails.memberRatios,
        members: members,
      );

      emit(
        state.copyWith(eventReportStatus: EventReportSuccess(membersBalance)),
      );
    }

    // TODO(mahDyarZ): handle error here
  }

  void _updateEventDetails(
    UpdateEventDetails event,
    Emitter<EventDetailsState> emit,
  ) {
    final members = <ResponseMember>[];
    final guests = <ResponseGuest>[];
    final menuItems = <ResponseMenu>[];

    if (state.eventDetailStatus is EventDetailSuccess) {
      members.addAll((state.eventDetailStatus as EventDetailSuccess).members);
      guests.addAll((state.eventDetailStatus as EventDetailSuccess).guests);
      menuItems.addAll(
        (state.eventDetailStatus as EventDetailSuccess).menuItems,
      );

      emit(
        state.copyWith(
          eventDetailStatus: EventDetailSuccess(
            event.eventDetails,
            members,
            guests,
            menuItems,
          ),
        ),
      );
    }

    if (state.eventDetailStatus is! EventDetailSuccess) {
      add(LoadEventDetails(event.eventDetails.id));
    }
  }

  Future<void> _loadEventDetails(
    LoadEventDetails event,
    Emitter<EventDetailsState> emit,
  ) async {
    emit(state.copyWith(eventDetailStatus: EventDetailLoading()));
    final members = <ResponseMember>[];
    final guests = <ResponseGuest>[];
    final menuItems = <ResponseMenu>[];

    await _repository.getAllMembers().then((dataState) {
      if (dataState is DataSuccess) members.addAll(dataState.data!);
    });
    await _repository.getAllGuests().then((dataState) {
      if (dataState is DataSuccess) guests.addAll(dataState.data!);
    });
    await _repository.getAllMenuItems().then((dataState) {
      if (dataState is DataSuccess) menuItems.addAll(dataState.data!);
    });

    final dataState = await _repository.getEvent(event.eventId);

    if (dataState is DataSuccess) {
      emit(
        state.copyWith(
          eventDetailStatus: EventDetailSuccess(
            dataState.data!,
            members,
            guests,
            menuItems,
          ),
        ),
      );
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(eventDetailStatus: EventDetailFailure()));
    }
  }

  Future<void> _addTransaction(
    AddTransaction event,
    Emitter<EventDetailsState> emit,
  ) async {
    emit(state.copyWith(eventTransactionStatus: EventTransactionLoading()));

    final dataState = await _repository.insertTransaction(event.params);

    if (dataState is DataSuccess) {
      emit(
        state.copyWith(
          eventTransactionStatus: EventTransactionSuccess(dataState.data!),
        ),
      );

      add(ChangeStatesToInit());

      if (state.eventDetailStatus is EventDetailSuccess) {
        final eventDetailStatus = state.eventDetailStatus as EventDetailSuccess;
        final eventDetailsInfo = eventDetailStatus.eventDetails;
        final transactions = eventDetailsInfo.transactions
          ..add(dataState.data!);

        emit(
          state.copyWith(
            eventDetailStatus: EventDetailSuccess(
              eventDetailsInfo.copyWith(transactions: transactions),
              eventDetailStatus.members,
              eventDetailStatus.guests,
              eventDetailStatus.menuItems,
            ),
          ),
        );

        add(UpdateOrdersList(eventDetailsInfo.id));
      }
    }
    if (dataState is DataFailed) {
      emit(state.copyWith(eventTransactionStatus: EventTransactionFailure()));
    }
  }

  Future<void> _editTransaction(
    EditTransaction event,
    Emitter<EventDetailsState> emit,
  ) async {
    emit(state.copyWith(eventTransactionStatus: EventTransactionLoading()));

    final dataState = await _repository.updateTransaction(event.params);

    if (dataState is DataSuccess) {
      emit(
        state.copyWith(
          eventTransactionStatus: EventTransactionSuccess(dataState.data!),
        ),
      );

      add(ChangeStatesToInit());

      if (state.eventDetailStatus is EventDetailSuccess) {
        final eventDetailStatus = state.eventDetailStatus as EventDetailSuccess;
        final eventDetailsInfo = eventDetailStatus.eventDetails;
        final index = eventDetailsInfo.transactions.indexWhere(
          (transaction) => transaction.id == dataState.data!.id,
        );
        eventDetailsInfo.transactions[index] = dataState.data!;
        final transactions = eventDetailsInfo.transactions;

        emit(
          state.copyWith(
            eventDetailStatus: EventDetailSuccess(
              eventDetailsInfo.copyWith(transactions: transactions),
              eventDetailStatus.members,
              eventDetailStatus.guests,
              eventDetailStatus.menuItems,
            ),
          ),
        );

        add(UpdateOrdersList(eventDetailsInfo.id));
      }
    }
    if (dataState is DataFailed) {
      emit(state.copyWith(eventTransactionStatus: EventTransactionFailure()));
    }
  }

  Future<void> _deleteTransaction(
    DeleteTransaction event,
    Emitter<EventDetailsState> emit,
  ) async {
    emit(state.copyWith(eventTransactionStatus: EventTransactionLoading()));

    final dataState = await _repository.deleteTransaction(event.transactionId);

    if (dataState is DataSuccess) {
      emit(
        state.copyWith(
          eventTransactionStatus: EventTransactionSuccess(
            ResponseEventTransaction(
              id: event.transactionId,
              amount: 0,
              description: null,
              date: DateTime.now(),
              transactionType: TransactionStatus.expense,
              attachment: null,
              paidByMember: null,
              paidByGuest: null,
            ),
          ),
        ),
      );

      add(ChangeStatesToInit());

      if (state.eventDetailStatus is EventDetailSuccess) {
        final eventDetailStatus = state.eventDetailStatus as EventDetailSuccess;
        final eventDetailsInfo = eventDetailStatus.eventDetails;
        final transactions = eventDetailsInfo.transactions
          ..removeWhere((transaction) => transaction.id == event.transactionId);

        emit(
          state.copyWith(
            eventDetailStatus: EventDetailSuccess(
              eventDetailsInfo.copyWith(transactions: transactions),
              eventDetailStatus.members,
              eventDetailStatus.guests,
              eventDetailStatus.menuItems,
            ),
          ),
        );
      }
    }
    if (dataState is DataFailed) {
      emit(state.copyWith(eventTransactionStatus: EventTransactionFailure()));
    }
  }

  Future<void> _addEventRatio(
    AddEventRatio event,
    Emitter<EventDetailsState> emit,
  ) async {
    emit(state.copyWith(eventRatioStatus: EventRatioLoading()));

    final dataState = await _repository.insertRatio(event.params);

    if (dataState is DataSuccess) {
      emit(
        state.copyWith(eventRatioStatus: EventRatioSuccess(dataState.data!)),
      );

      add(ChangeStatesToInit());

      if (state.eventDetailStatus is EventDetailSuccess) {
        final eventDetailStatus = state.eventDetailStatus as EventDetailSuccess;
        final eventDetailsInfo = eventDetailStatus.eventDetails;
        final ratios = eventDetailsInfo.memberRatios..add(dataState.data!);

        emit(
          state.copyWith(
            eventDetailStatus: EventDetailSuccess(
              eventDetailsInfo.copyWith(memberRatios: ratios),
              eventDetailStatus.members,
              eventDetailStatus.guests,
              eventDetailStatus.menuItems,
            ),
          ),
        );
      }
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(eventRatioStatus: EventRatioFailure()));
    }
  }

  Future<void> _editEventRatio(
    EditEventRatio event,
    Emitter<EventDetailsState> emit,
  ) async {
    emit(state.copyWith(eventRatioStatus: EventRatioLoading()));

    final dataState = await _repository.updateEventRatio(event.params);

    if (dataState is DataSuccess) {
      emit(
        state.copyWith(eventRatioStatus: EventRatioSuccess(dataState.data!)),
      );

      add(ChangeStatesToInit());

      if (state.eventDetailStatus is EventDetailSuccess) {
        final eventDetailStatus = state.eventDetailStatus as EventDetailSuccess;
        final eventDetailsInfo = eventDetailStatus.eventDetails;
        final index = eventDetailsInfo.memberRatios.indexWhere(
          (ratio) => ratio.id == dataState.data!.id,
        );
        eventDetailsInfo.memberRatios[index] = dataState.data!;
        final ratios = eventDetailsInfo.memberRatios;

        emit(
          state.copyWith(
            eventDetailStatus: EventDetailSuccess(
              eventDetailsInfo.copyWith(memberRatios: ratios),
              eventDetailStatus.members,
              eventDetailStatus.guests,
              eventDetailStatus.menuItems,
            ),
          ),
        );
      }
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(eventRatioStatus: EventRatioFailure()));
    }
  }

  Future<void> _deleteEventRatio(
    DeleteEventRatio event,
    Emitter<EventDetailsState> emit,
  ) async {
    emit(state.copyWith(eventRatioStatus: EventRatioLoading()));

    final dataState = await _repository.deleteEventRatio(event.eventRatioId);

    if (dataState is DataSuccess) {
      emit(
        state.copyWith(
          eventRatioStatus: EventRatioSuccess(
            ResponseEventRatio(id: event.eventRatioId, memberID: 0, ratio: 0),
          ),
        ),
      );

      add(ChangeStatesToInit());

      if (state.eventDetailStatus is EventDetailSuccess) {
        final eventDetailStatus = state.eventDetailStatus as EventDetailSuccess;
        final eventDetailsInfo = eventDetailStatus.eventDetails;
        final ratios = eventDetailsInfo.memberRatios
          ..removeWhere((ratio) => ratio.id == event.eventRatioId);

        emit(
          state.copyWith(
            eventDetailStatus: EventDetailSuccess(
              eventDetailsInfo.copyWith(memberRatios: ratios),
              eventDetailStatus.members,
              eventDetailStatus.guests,
              eventDetailStatus.menuItems,
            ),
          ),
        );
      }
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(eventRatioStatus: EventRatioFailure()));
    }
  }

  Future<void> _addOrder(
    AddOrder event,
    Emitter<EventDetailsState> emit,
  ) async {
    emit(state.copyWith(eventOrderStatus: EventOrderLoading()));

    final dataState = await _repository.insertOrder(event.params);

    if (dataState is DataSuccess) {
      emit(
        state.copyWith(eventOrderStatus: EventOrderSuccess(dataState.data!)),
      );

      add(ChangeStatesToInit());

      if (state.eventDetailStatus is EventDetailSuccess) {
        final eventDetailStatus = state.eventDetailStatus as EventDetailSuccess;
        final eventDetailsInfo = eventDetailStatus.eventDetails;
        final orders = eventDetailsInfo.orders..add(dataState.data!);

        emit(
          state.copyWith(
            eventDetailStatus: EventDetailSuccess(
              eventDetailsInfo.copyWith(orders: orders),
              eventDetailStatus.members,
              eventDetailStatus.guests,
              eventDetailStatus.menuItems,
            ),
          ),
        );
      }
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(eventOrderStatus: EventOrderFailure()));
    }
  }

  Future<void> _editOrder(
    EditOrder event,
    Emitter<EventDetailsState> emit,
  ) async {
    emit(state.copyWith(eventOrderStatus: EventOrderLoading()));

    final dataState = await _repository.updateOrder(event.params);

    if (dataState is DataSuccess) {
      emit(
        state.copyWith(eventOrderStatus: EventOrderSuccess(dataState.data!)),
      );

      add(ChangeStatesToInit());

      if (state.eventDetailStatus is EventDetailSuccess) {
        final eventDetailStatus = state.eventDetailStatus as EventDetailSuccess;
        final eventDetailsInfo = eventDetailStatus.eventDetails;
        final index = eventDetailsInfo.orders.indexWhere(
          (order) => order.id == dataState.data!.id,
        );
        eventDetailsInfo.orders[index] = dataState.data!;
        final orders = eventDetailsInfo.orders;

        emit(
          state.copyWith(
            eventDetailStatus: EventDetailSuccess(
              eventDetailsInfo.copyWith(orders: orders),
              eventDetailStatus.members,
              eventDetailStatus.guests,
              eventDetailStatus.menuItems,
            ),
          ),
        );
      }
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(eventOrderStatus: EventOrderFailure()));
    }
  }

  Future<void> _deleteOrder(
    DeleteOrder event,
    Emitter<EventDetailsState> emit,
  ) async {
    emit(state.copyWith(eventOrderStatus: EventOrderLoading()));

    final dataState = await _repository.deleteOrder(event.orderId);

    if (dataState is DataSuccess) {
      emit(
        state.copyWith(
          eventOrderStatus: EventOrderSuccess(
            ResponseOrder(
              id: event.orderId,
              orderedByMember: null,
              orderedByGuest: null,
              eventID: 0,
              orders: [],
              isDelivered: false,
            ),
          ),
        ),
      );

      add(ChangeStatesToInit());

      if (state.eventDetailStatus is EventDetailSuccess) {
        final eventDetailStatus = state.eventDetailStatus as EventDetailSuccess;
        final eventDetailsInfo = eventDetailStatus.eventDetails;
        final orders = eventDetailsInfo.orders
          ..removeWhere((order) => order.id == event.orderId);

        emit(
          state.copyWith(
            eventDetailStatus: EventDetailSuccess(
              eventDetailsInfo.copyWith(orders: orders),
              eventDetailStatus.members,
              eventDetailStatus.guests,
              eventDetailStatus.menuItems,
            ),
          ),
        );
      }
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(eventOrderStatus: EventOrderFailure()));
    }
  }
}
