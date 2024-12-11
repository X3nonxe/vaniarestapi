import 'package:vania/vania.dart';
import 'package:vaniarestapi/app/models/customers.dart';

class CustomersController extends Controller {
  // fetch all customers
  Future<Response> index() async {
    List<Map<String, dynamic>> customers = await Customers().query().get();
    return Response.json({'data': customers});
  }
  // fetch customer by id
  Future<Response> show(Request request, int id) async {
    print(id);
    Map<String, dynamic>? customer = await Customers().query().where('id', '=', id).first();
    return Response.json({'data': customer});
  }
  // create new customer
  Future<Response> create(Request request) async {
    request.validate({
      'cust_name': 'required|max_length:20|min_length:2',
      'cust_telp': 'required|max_length:15',
      'cust_address': 'required',
      'cust_city': 'required',
      'cust_state': 'required',
      'cust_zip': 'required',
      'cust_country': 'required',
    }, {
      'cust_name.required': 'The name is required',
      'cust_name.max_length': 'The name is too long',
      'cust_name.min_length': 'The name is too short',
      'cust_telp.required': 'The phone number is required',
      'cust_telp.max_length': 'The phone number is too long',
      'cust_address.required': 'The address is required',
      'cust_city.required': 'The city is required',
      'cust_state.required': 'The state is required',
      'cust_zip.required': 'The zip code is required',
      'cust_country.required': 'The country is required',
    });

    await Customers().query().insert({
      'cust_name': request.input('cust_name'),
      'cust_telp': request.input('cust_telp'),
      'cust_address': request.input('cust_address'),
      'cust_city': request.input('cust_city'),
      'cust_state': request.input('cust_state'),
      'cust_zip': request.input('cust_zip'),
      'cust_country': request.input('cust_country'),
    });

    return Response.json({'message': 'Customer created successfully'});
  }
  // update customer
  Future<Response> update(Request request, int id) async {
    request.validate({
      'cust_name': 'required|max_length:20|min_length:2',
      'cust_telp': 'required|max_length:15',
      'cust_address': 'required',
      'cust_city': 'required',
      'cust_state': 'required',
      'cust_zip': 'required',
      'cust_country': 'required',
    }, {
      'cust_name.required': 'The name is required',
      'cust_name.max_length': 'The name is too long',
      'cust_name.min_length': 'The name is too short',
      'cust_telp.required': 'The phone number is required',
      'cust_telp.max_length': 'The phone number is too long',
      'cust_address.required': 'The address is required',
      'cust_city.required': 'The city is required',
      'cust_state.required': 'The state is required',
      'cust_zip.required': 'The zip code is required',
      'cust_country.required': 'The country is required',
    });

    await Customers().query().where('id', '=', id).update({
      'cust_name': request.input('cust_name'),
      'cust_telp': request.input('cust_telp'),
      'cust_address': request.input('cust_address'),
      'cust_city': request.input('cust_city'),
      'cust_state': request.input('cust_state'),
      'cust_zip': request.input('cust_zip'),
      'cust_country': request.input('cust_country'),
    });

    return Response.json({'message': 'Customer updated successfully'});
  }
  // delete customer
  Future<Response> destroy(int id) async {
    await Customers().query().where('id', '=', id).delete();
    return Response.json({});
  }
}

final CustomersController customersController = CustomersController();
