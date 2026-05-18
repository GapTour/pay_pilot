import 'package:flutter/services.dart';
import 'package:pay_pilot/core/data/params/event_order_params.dart';
import 'package:pay_pilot/core/data/params/event_ratio_params.dart';
import 'package:pay_pilot/core/data/params/transaction_params.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/database/daos/event_dao/event_dao.dart';
import 'package:pay_pilot/core/database/daos/guest_dao/guest_dao.dart';
import 'package:pay_pilot/core/database/daos/member_dao/member_dao.dart';
import 'package:pay_pilot/core/database/daos/menu_dao/menu_dao.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_details.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_ratio.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_transaction.dart';
import 'package:pay_pilot/features/event_details/data/models/response_order.dart';
import 'package:pay_pilot/features/event_details/data/sources/i_event_details_source.dart';
import 'package:pay_pilot/features/guests/data/models/response_guest.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';
import 'package:pay_pilot/features/menu/data/models/response_menu.dart';

class LocalEventDetailsSource implements IEventDetailsSource {
  final EventDao _dbServiceForEvent;
  final GuestDao _dbServiceForGuest;
  final MemberDao _dbServiceForMember;
  final MenuDao _dbServiceForMenu;

  LocalEventDetailsSource(
    this._dbServiceForEvent,
    this._dbServiceForGuest,
    this._dbServiceForMember,
    this._dbServiceForMenu,
  );

  @override
  Future<DataState<ResponseOrder>> changeOrderStatus(
    int id,
    bool isDelivered,
  ) async {
    try {
      final response = await _dbServiceForEvent.changeOrderDeliveryStatus(
        id,
        isDelivered,
      );
      final order = ResponseOrder.fromDb(response);

      return DataSuccess(order);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<int>> deleteEventRatio(int id) async {
    try {
      await _dbServiceForEvent.deleteRatio(id);

      return DataSuccess(id);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<int>> deleteOrder(int id) async {
    try {
      await _dbServiceForEvent.deleteOrder(id);

      return DataSuccess(id);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<int>> deleteTransaction(TransactionParams params) async {
    try {
      await _dbServiceForEvent.deleteTransaction(params);

      return DataSuccess(params.id!);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<List<ResponseGuest>>> getAllGuests() async {
    try {
      final response = await _dbServiceForGuest.getAllGuests();
      final guests = response.map(ResponseGuest.fromDb).toList();

      return DataSuccess(guests);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<List<ResponseMember>>> getAllMembers() async {
    try {
      final response = await _dbServiceForMember.getAllMembers();
      final members = response.map(ResponseMember.fromDb).toList();

      return DataSuccess(members);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<List<ResponseMenu>>> getAllMenuItems() async {
    try {
      final response = await _dbServiceForMenu.getAllMenus();
      final items = response.map(ResponseMenu.fromDb).toList();

      return DataSuccess(items);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<List<ResponseOrder>>> getAllOrders(int eventID) async {
    try {
      final response = await _dbServiceForEvent.getAllOrders(eventID);
      final orders = response.map(ResponseOrder.fromDb).toList();

      return DataSuccess(orders);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<ResponseEventDetails>> getEvent(int id) async {
    try {
      final response = await _dbServiceForEvent.getEventInfoWithoutBalance(id);

      return DataSuccess(response);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<ResponseOrder>> insertOrder(EventOrderParams params) async {
    try {
      final response = await _dbServiceForEvent.insertOrder(params);
      final order = ResponseOrder.fromParams(params.copyWith(id: response));

      return DataSuccess(order);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<ResponseEventRatio>> insertRatio(
    EventRatioParams params,
  ) async {
    try {
      final response = await _dbServiceForEvent.insertRatio(params);
      final ratio = ResponseEventRatio.fromParams(
        params.copyWith(id: response),
      );

      return DataSuccess(ratio);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<List<ResponseEventTransaction>>> insertTransaction(
    List<TransactionParams> params,
  ) async {
    try {
      final transactions = <ResponseEventTransaction>[];
      for (var param in params) {
        final response = await _dbServiceForEvent.insertTransaction(param);
        transactions.add(
          ResponseEventTransaction.fromParams(param.copyWith(id: response)),
        );
      }

      return DataSuccess(transactions);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<ResponseEventRatio>> updateEventRatio(
    EventRatioParams params,
  ) async {
    try {
      await _dbServiceForEvent.updateRatio(params);
      final ratio = ResponseEventRatio.fromParams(params);

      return DataSuccess(ratio);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<ResponseOrder>> updateOrder(EventOrderParams params) async {
    try {
      final response = await _dbServiceForEvent.updateOrder(params);
      final order = ResponseOrder.fromDb(response);

      return DataSuccess(order);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<ResponseEventTransaction>> updateTransaction(
    TransactionParams params,
  ) async {
    try {
      await _dbServiceForEvent.updateTransaction(params);
      final transaction = ResponseEventTransaction.fromParams(params);

      return DataSuccess(transaction);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }
}
