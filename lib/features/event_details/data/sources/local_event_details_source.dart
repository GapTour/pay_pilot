import 'package:flutter/services.dart';
import 'package:pay_pilot/core/data/params/event_order_params.dart';
import 'package:pay_pilot/core/data/params/event_ratio_params.dart';
import 'package:pay_pilot/core/data/params/event_story_params.dart';
import 'package:pay_pilot/core/data/params/transaction_params.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/database/daos/event_dao/event_details_dao.dart';
import 'package:pay_pilot/core/database/daos/event_dao/event_orders_dao.dart';
import 'package:pay_pilot/core/database/daos/event_dao/event_ratios_dao.dart';
import 'package:pay_pilot/core/database/daos/event_dao/event_stories_dao.dart';
import 'package:pay_pilot/core/database/daos/event_dao/event_transactions_dao.dart';
import 'package:pay_pilot/core/database/daos/guest_dao/guest_dao.dart';
import 'package:pay_pilot/core/database/daos/member_dao/member_dao.dart';
import 'package:pay_pilot/core/database/daos/menu_dao/menu_dao.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_details.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_ratio.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_story.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_transaction.dart';
import 'package:pay_pilot/features/event_details/data/models/response_order.dart';
import 'package:pay_pilot/features/event_details/data/sources/i_event_details_source.dart';
import 'package:pay_pilot/features/guests/data/models/response_guest.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';
import 'package:pay_pilot/features/menu/data/models/response_menu.dart';

class LocalEventDetailsSource implements IEventDetailsSource {
  final EventDetailsDao _dbServiceForEventDetails;
  final EventTransactionsDao _dbServiceForEventTransactions;
  final EventOrdersDao _dbServiceForEventOrders;
  final EventRatiosDao _dbServiceForEventRatios;
  final EventStoriesDao _dbServiceForEventStories;
  final GuestDao _dbServiceForGuest;
  final MemberDao _dbServiceForMember;
  final MenuDao _dbServiceForMenu;

  LocalEventDetailsSource(
    this._dbServiceForEventDetails,
    this._dbServiceForEventOrders,
    this._dbServiceForEventRatios,
    this._dbServiceForEventStories,
    this._dbServiceForEventTransactions,
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
      final response = await _dbServiceForEventOrders.changeOrderDeliveryStatus(
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
      await _dbServiceForEventRatios.deleteRatio(id);

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
      await _dbServiceForEventOrders.deleteOrder(id);

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
      await _dbServiceForEventTransactions.deleteTransaction(params);

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
      final response = await _dbServiceForEventOrders.getAllOrders(eventID);
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
      final response = await _dbServiceForEventDetails
          .getEventInfoWithoutBalance(id);

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
      final response = await _dbServiceForEventOrders.insertOrder(params);
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
      final response = await _dbServiceForEventRatios.insertRatio(params);
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
        final response = await _dbServiceForEventTransactions.insertTransaction(
          param,
        );
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
      await _dbServiceForEventRatios.updateRatio(params);
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
      final response = await _dbServiceForEventOrders.updateOrder(params);
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
      await _dbServiceForEventTransactions.updateTransaction(params);
      final transaction = ResponseEventTransaction.fromParams(params);

      return DataSuccess(transaction);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<int>> deleteStory(int id) async {
    try {
      await _dbServiceForEventStories.deleteStory(id);

      return DataSuccess(id);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<ResponseEventStory>> insertStory(
    EventStoryParams params,
  ) async {
    try {
      final response = await _dbServiceForEventStories.insertStory(params);
      final story = ResponseEventStory.fromParams(
        params.copyWith(id: response),
      );

      return DataSuccess(story);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }

  @override
  Future<DataState<ResponseEventStory>> updateStory(
    EventStoryParams params,
  ) async {
    try {
      await _dbServiceForEventStories.updateStory(params);
      final story = ResponseEventStory.fromParams(params);

      return DataSuccess(story);
    } on PlatformException catch (e) {
      return DataFailed(
        ErrorResponse.defaultError(e.message, int.tryParse(e.code)),
      );
    }
  }
}
