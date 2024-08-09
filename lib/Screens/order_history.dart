import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/cubits/order_history/order_history_cubit.dart';
import 'package:store_app/widgets/order_history/order_history.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});
  static const String id = 'OrderHistory';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Order History'),
      ),
      body: OrderHistory(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: () {
          BlocProvider.of<OrderHistoryCubit>(context).clearOrders();
        },
      ),
    );
  }
}
