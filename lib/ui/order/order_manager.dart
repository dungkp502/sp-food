import 'package:flutter/widgets.dart';

// import '../../model/cart_item.dart';
import '../../model/order_item.dart';

import 'package:flutter/foundation.dart';

import '../../services/order_service.dart';

class OrdersManager with ChangeNotifier {
  final OrderService _orderService = OrderService();

  late List<OrderItem> _orders = [];
  int get orderCount {
    return _orders.length;
  }

  List<OrderItem> get orders {
    return [..._orders];
  }

    Future<void> fetchOrders() async {
    _orders = await _orderService.fetchOrders();
    print(_orders.length);
    print("AAAAAAAAAAAAAAAAAAAAaa");
    notifyListeners();
  }

  Future<void> addOrder(OrderItem order) async {
    final newOrder = await _orderService.addOrder(order);
    if (newOrder != null) {
      _orders.insert(0, order);
      _orders.add(order);
      print(_orders.length);
      notifyListeners();
    }
  }
}
