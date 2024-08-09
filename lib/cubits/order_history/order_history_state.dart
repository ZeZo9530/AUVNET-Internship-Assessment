part of 'order_history_cubit.dart';

@immutable
abstract class OrderHistoryState {}

class OrderHistoryInitial extends OrderHistoryState {}

class OrderHistoryLoaded extends OrderHistoryState {
  final List<List<ProductModel>> historyList;
  OrderHistoryLoaded({required this.historyList});
}

class OrderHistoryEmpty extends OrderHistoryState {}
