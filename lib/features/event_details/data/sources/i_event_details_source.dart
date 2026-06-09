import 'package:pay_pilot/core/data/params/event_order_params.dart';
import 'package:pay_pilot/core/data/params/event_ratio_params.dart';
import 'package:pay_pilot/core/data/params/event_story_params.dart';
import 'package:pay_pilot/core/data/params/transaction_params.dart';
import 'package:pay_pilot/core/utils/resource/data_state.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_details.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_ratio.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_story.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_transaction.dart';
import 'package:pay_pilot/features/event_details/data/models/response_order.dart';
import 'package:pay_pilot/features/guests/data/models/response_guest.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';
import 'package:pay_pilot/features/menu/data/models/response_menu.dart';

abstract class IEventDetailsSource {
  Future<DataState<ResponseEventDetails>> getEvent(int id);
  Future<DataState<List<ResponseEventTransaction>>> insertTransaction(
    List<TransactionParams> params,
  );
  Future<DataState<ResponseOrder>> insertOrder(EventOrderParams params);
  Future<DataState<ResponseEventStory>> insertStory(EventStoryParams params);
  Future<DataState<ResponseEventRatio>> insertRatio(EventRatioParams params);
  Future<DataState<ResponseEventTransaction>> updateTransaction(
    TransactionParams params,
  );
  Future<DataState<ResponseOrder>> updateOrder(EventOrderParams params);
  Future<DataState<ResponseEventStory>> updateStory(EventStoryParams params);
  Future<DataState<ResponseOrder>> changeOrderStatus(int id, bool isDelivered);
  Future<DataState<int>> deleteTransaction(TransactionParams params);
  Future<DataState<int>> deleteOrder(int id);
  Future<DataState<int>> deleteStory(int id);
  Future<DataState<ResponseEventRatio>> updateEventRatio(
    EventRatioParams params,
  );
  Future<DataState<int>> deleteEventRatio(int id);
  Future<DataState<List<ResponseMember>>> getAllMembers();
  Future<DataState<List<ResponseGuest>>> getAllGuests();
  Future<DataState<List<ResponseOrder>>> getAllOrders(int eventID);
  Future<DataState<List<ResponseMenu>>> getAllMenuItems();
}
