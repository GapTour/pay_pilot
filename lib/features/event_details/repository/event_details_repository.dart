import 'package:dio/dio.dart';
import 'package:pay_pilot/core/data/params/event_order_params.dart';
import 'package:pay_pilot/core/data/params/event_ratio_params.dart';
import 'package:pay_pilot/core/data/params/transaction_params.dart';
import 'package:pay_pilot/core/data/response/error_response.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/event_details/data/event_details_api_provider.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_details.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_ratio.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_transaction.dart';
import 'package:pay_pilot/features/event_details/data/models/response_order.dart';
import 'package:pay_pilot/features/guests/data/models/response_guest.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';
import 'package:pay_pilot/features/menu/data/models/response_menu.dart';

class EventDetailsRepository {
  // final EventDetailsDbProvider _dbProvider;
  final EventDetailsApiProvider _apiProvider;

  EventDetailsRepository(
    // this._dbProvider,
    this._apiProvider,
  );

  Future<DataState<ResponseEventDetails>> getEvent(int id) async {
    try {
      final Response response = await _apiProvider.getEventDetails(id);
      if (response.statusCode == 200) {
        final rawData = response.data['data'];
        final eventDetails = ResponseEventDetails.fromMap(rawData);

        return DataSuccess(eventDetails);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  Future<DataState<ResponseEventTransaction>> insertTransaction(
    TransactionParams params,
  ) async {
    try {
      final Response response = await _apiProvider.addTransaction(params);

      if (response.statusCode == 201) {
        final rawData = response.data['data'];
        final transaction = ResponseEventTransaction.fromMap(rawData);

        return DataSuccess(transaction);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  Future<DataState<ResponseOrder>> insertOrder(EventOrderParams params) async {
    try {
      final Response response = await _apiProvider.addOrder(params);

      if (response.statusCode == 201) {
        final rawData = response.data['data'];
        final order = ResponseOrder.fromMap(rawData);

        return DataSuccess(order);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  Future<DataState<ResponseEventRatio>> insertRatio(
    EventRatioParams params,
  ) async {
    try {
      final Response response = await _apiProvider.addRatio(params);

      if (response.statusCode == 201) {
        final rawData = response.data['data'];
        final eventRatio = ResponseEventRatio.fromMap(rawData);

        return DataSuccess(eventRatio);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  Future<DataState<ResponseEventTransaction>> updateTransaction(
    TransactionParams params,
  ) async {
    try {
      final Response response = await _apiProvider.editTransaction(params);

      if (response.statusCode == 201) {
        final rawData = response.data['data'];
        final transaction = ResponseEventTransaction.fromMap(rawData);

        return DataSuccess(transaction);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  Future<DataState<ResponseOrder>> updateOrder(EventOrderParams params) async {
    try {
      final Response response = await _apiProvider.editOrder(params);

      if (response.statusCode == 201) {
        final rawData = response.data['data'];
        final order = ResponseOrder.fromMap(rawData);

        return DataSuccess(order);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  Future<DataState<int>> deleteTransaction(int id) async {
    try {
      final Response response = await _apiProvider.deleteTransaction(id);

      if (response.statusCode == 204) {
        return DataSuccess(id);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  Future<DataState<int>> deleteOrder(int id) async {
    try {
      final Response response = await _apiProvider.deleteOrder(id);

      if (response.statusCode == 204) {
        return DataSuccess(id);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  Future<DataState<ResponseEventRatio>> updateEventRatio(
    EventRatioParams params,
  ) async {
    try {
      final Response response = await _apiProvider.editRatio(params);

      if (response.statusCode == 201) {
        final rawData = response.data['data'];
        final eventRatio = ResponseEventRatio.fromMap(rawData);

        return DataSuccess(eventRatio);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  Future<DataState<int>> deleteEventRatio(int id) async {
    try {
      final Response response = await _apiProvider.deleteRatio(id);

      if (response.statusCode == 204) {
        return DataSuccess(id);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  Future<DataState<List<ResponseMember>>> getAllMembers() async {
    try {
      final Response response = await _apiProvider.getAllMembers();

      if (response.statusCode == 200) {
        final rawData = response.data['data'] as List<dynamic>;
        final members = rawData.map((e) {
          return ResponseMember.fromMap(e);
        }).toList();

        return DataSuccess(members);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  Future<DataState<List<ResponseGuest>>> getAllGuests() async {
    try {
      final Response response = await _apiProvider.getAllGuests();

      if (response.statusCode == 200) {
        final rawData = response.data['data'] as List<dynamic>;
        final members = rawData.map((e) {
          return ResponseGuest.fromMap(e);
        }).toList();

        return DataSuccess(members);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }

  Future<DataState<List<ResponseMenu>>> getAllMenuItems() async {
    try {
      final Response response = await _apiProvider.getAllMenuItems();

      if (response.statusCode == 200) {
        final rawData = response.data['data'] as List<dynamic>;
        final members = rawData.map((e) {
          return ResponseMenu.fromMap(e);
        }).toList();

        return DataSuccess(members);
      }

      return DataFailed(ErrorResponse.defaultError(null, response.statusCode));
    } on DioException catch (e) {
      return DataFailed(ErrorResponse.fromMap(e));
    }
  }
}
