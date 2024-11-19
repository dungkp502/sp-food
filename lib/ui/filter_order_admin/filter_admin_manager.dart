import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import '../../model/order_item.dart';
import '../../services/orders_admin_service.dart';

class FilterOrderAdminManager with ChangeNotifier {
  final OrderServiceAdmin _orderService = OrderServiceAdmin();
  late List<OrderItem> _orders = [];
  late List<OrderItem> data = [];
  late List<OrderItem> _orders1 = [];

  int get orders1Count {
    return _orders1.length;
  }

  List<OrderItem> get orders1 {
    return [..._orders1];
  }

  Future<List<OrderItem>> fetchOrders() async {
    _orders1 = await _orderService.fetchOrders(3);
    var quater = 4;
    //quy
    //1 nam co 4 quy
    //1 quy co 3 thang
    var year = 2024;
      final startMonth = (quater - 1) * 3 + 1;
      final endMonth = startMonth + 2;
      return data=_orders1
          .where((e) =>
              e.dateTime.year == year &&
              e.dateTime.month >= startMonth &&
              e.dateTime.month <= endMonth)
          .toList();
  }
}
