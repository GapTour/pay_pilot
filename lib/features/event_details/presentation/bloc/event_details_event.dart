part of 'event_details_bloc.dart';

sealed class EventDetailsEvent extends Equatable {
  const EventDetailsEvent();

  @override
  List<Object> get props => [];
}

class ChangePage extends EventDetailsEvent {
  final EventDetailsPage page;

  const ChangePage(this.page);
}

class LoadEventDetails extends EventDetailsEvent {
  final int eventId;

  const LoadEventDetails(this.eventId);
}

class UpdateEventDetails extends EventDetailsEvent {
  final ResponseEventDetails eventDetails;

  const UpdateEventDetails(this.eventDetails);
}

class AddTransaction extends EventDetailsEvent {
  final TransactionParams params;

  const AddTransaction(this.params);
}

class EditTransaction extends EventDetailsEvent {
  final TransactionParams params;

  const EditTransaction(this.params);
}

class DeleteTransaction extends EventDetailsEvent {
  final int transactionId;

  const DeleteTransaction(this.transactionId);
}

class AddEventRatio extends EventDetailsEvent {
  final EventRatioParams params;

  const AddEventRatio(this.params);
}

class EditEventRatio extends EventDetailsEvent {
  final EventRatioParams params;

  const EditEventRatio(this.params);
}

class DeleteEventRatio extends EventDetailsEvent {
  final int eventRatioId;

  const DeleteEventRatio(this.eventRatioId);
}

class AddOrder extends EventDetailsEvent {
  final EventOrderParams params;

  const AddOrder(this.params);
}

class EditOrder extends EventDetailsEvent {
  final EventOrderParams params;

  const EditOrder(this.params);
}

class DeleteOrder extends EventDetailsEvent {
  final int orderId;

  const DeleteOrder(this.orderId);
}

class ChangeStatesToInit extends EventDetailsEvent {}

class LoadReportList extends EventDetailsEvent {}

class UpdateOrdersList extends EventDetailsEvent {
  final int eventID;

  const UpdateOrdersList(this.eventID);
}

class ChangeOrderDeliveryStatus extends EventDetailsEvent {
  final int orderID;
  final bool isDelivered;

  const ChangeOrderDeliveryStatus(this.orderID, this.isDelivered);
}

class UpdateFilteredOrders extends EventDetailsEvent {
  final List<int> filteredOrders;

  const UpdateFilteredOrders(this.filteredOrders);
}
