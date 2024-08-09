import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:store_app/models/product_model.dart';

part 'order_history_state.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  OrderHistoryCubit() : super(OrderHistoryInitial());
  List<List<ProductModel>> orderHistory = [];

  //clearing the order history "idk why"
  void clearOrders() {
    orderHistory.clear();
    emit(OrderHistoryEmpty());
  }

  //adding order to order history
  void addOrder(List<List<ProductModel>> orderList) {
    orderHistory = orderList;
    emit(OrderHistoryLoaded(historyList: orderHistory));
  }

  //getting order history if the order list is not empty
  void getOrders() {
    if (orderHistory.isEmpty) {
      emit(OrderHistoryEmpty());
    } else {
      print(orderHistory);
      emit(OrderHistoryLoaded(historyList: orderHistory));
    }
  }
}
