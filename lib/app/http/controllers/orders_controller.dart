import 'package:vania/vania.dart';
import 'package:vaniarestapi/app/models/orders.dart';

class OrdersController extends Controller {
  // fetch all orders
  Future<Response> index() async {
    List<Map<String, dynamic>> orders = await Orders()
        .query()
        .select([
          'orders.id',
          'customers.cust_name',
          'customers.cust_telp',
          'customers.cust_address',
          'orders.order_date',
        ])
        .join('customers', 'customers.id', '=', 'orders.cust_id')
        .get();
    return Response.json({'data': orders});
  }
  // fetch order by id
  Future<Response> show(int id) async {
    Map<String, dynamic>? order = await Orders()
        .query()
        .select([
          'orders.id',
          'customers.cust_name',
          'customers.cust_telp',
          'customers.cust_address',
          'orders.order_date',
        ])
        .join('customers', 'customers.id', '=', 'orders.cust_id')
        .where('orders.id', '=', id)
        .first();
    return Response.json({'data': order});
  }
  // create new order
  Future<Response> create(Request request) async {
    request.validate({
      'cust_id': 'required',
      'order_date': 'required',
    }, {
      'cust_id.required': 'The customer id is required',
      'order_date.required': 'The order date is required',
    });

    await Orders().query().insert({
      'cust_id': request.input('cust_id'),
      'order_date': request.input('order_date'),
    });

    return Response.json({'message': 'Order created successfully'});
  }

  // update order
  Future<Response> update(Request request, int id) async {
    request.validate({
      'cust_id': 'required',
      'order_date': 'required',
    }, {
      'cust_id.required': 'The customer id is required',
      'order_date.required': 'The order date is required',
    });

    await Orders().query().where('id', '=', id).update({
      'cust_id': request.input('cust_id'),
      'order_date': request.input('order_date'),
    });

    return Response.json({'message': 'Order updated successfully'});
  }

  // delete order
  Future<Response> destroy(int id) async {
    await Orders().query().where('id', '=', id).delete();

    return Response.json({'message': 'Order deleted successfully'});
  }
}

final OrdersController ordersController = OrdersController();
