import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/cubits/order_history/order_history_cubit.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/widgets/order_history/order_history_card.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OrderHistoryCubit>(context).getOrders();
  }

  @override
  Widget build(BuildContext context) {
    List<List<ProductModel>> biglist = [];
    return BlocBuilder<OrderHistoryCubit, OrderHistoryState>(
      builder: (context, state) {
        if (state is OrderHistoryLoaded) {
          biglist = state.historyList;
          return ListView.builder(
            itemCount: biglist.length,
            itemBuilder: (context, index) {
              return CustomOrderHistory(products: biglist[index]);
            },
          );
        } else {
          return const Center(child: Text('No Orders Found!'));
        }
      },
    );
  }
}
