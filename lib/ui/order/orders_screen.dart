import 'package:flutter/material.dart';
import 'package:foodapp/ui/shared/app_drawer.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

import 'order_detail_screen.dart';
import 'order_item_card.dart';
import 'order_manager.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late Future<void> _fetchOrders = Future(() => null);
  @override
  void initState() {
    super.initState();
    _fetchOrders = context.read<OrdersManager>().fetchOrders();
    print("-------------------------------");
    print(_fetchOrders);
    print('-----------------------------');
  }

  @override
  Widget build(BuildContext context) {
    final ordersManager = OrdersManager();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Đơn hàng'),
        ),
        drawer: const AppDrawer(),
        body: FutureBuilder(
            future: _fetchOrders,
            builder: (contex, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Consumer<OrdersManager>(
                    builder: (ctx, ordersManager, child) {
                        return ListView.builder(
                            itemCount: ordersManager.orderCount,
                            itemBuilder: (ctx, i) => GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => OrderDetailScreen(
                                              ordersManager.orders[i])),
                                    );
                                  },
                                  child: ordersManager.orderCount == 0
                                      ? Center(
                                          child: Text("Đơn hàng trống!"),
                                        )
                                      : OrderItemCard(ordersManager.orders[i]),
                                ));
                });
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }
}
