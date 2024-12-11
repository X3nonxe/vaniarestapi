import 'package:vania/vania.dart';
import 'package:vaniarestapi/app/models/products.dart';

class ProductsController extends Controller {
  // fetch all products
  Future<Response> index() async {
    List<Map<String, dynamic>> products = await Products()
        .query()
        .select([
          'products.id',
          'products.prod_name',
          'products.prod_price',
          'products.prod_desc',
          'vendors.vend_name',
          'vendors.vend_address',
        ])
        .join('vendors', 'vendors.id', '=', 'products.vend_id')
        .get();

    return Response.json({'data': products});
  }

  // fetch single product
  Future<Response> show(int id) async {
    Map<String, dynamic>? product = await Products()
        .query()
        .select([
          'products.id',
          'products.prod_name',
          'products.prod_price',
          'products.prod_desc',
          'vendors.vend_name',
          'vendors.vend_address',
        ])
        .join('vendors', 'vendors.id', '=', 'products.vend_id')
        .where('products.id', '=', id)
        .first();

    return Response.json({'data': product});
  }

  // create new product
  Future<Response> create(Request request) async {
    request.validate({
      'prod_name': 'required|max_length:25|min_length:2',
      'prod_price': 'required',
      'prod_desc': 'required',
      'vend_id': 'required',
    }, {
      'prod_name.required': 'The name is required',
      'prod_name.max_length': 'The name is too long',
      'prod_name.min_length': 'The name is too short',
      'prod_price.required': 'The price is required',
      'prod_desc.required': 'The description is required',
      'vend_id.required': 'The vendor id is required',
    });

    await Products().query().insert({
      'prod_name': request.input('prod_name'),
      'prod_price': request.input('prod_price'),
      'prod_desc': request.input('prod_desc'),
      'vend_id': request.input('vend_id'),
    });

    return Response.json({'message': 'Product created successfully'});
  }

  // update product
  Future<Response> update(Request request, int id) async {
    request.validate({
      'prod_name': 'required|max_length:25|min_length:2',
      'prod_price': 'required',
      'prod_desc': 'required',
      'vend_id': 'required',
    }, {
      'prod_name.required': 'The name is required',
      'prod_name.max_length': 'The name is too long',
      'prod_name.min_length': 'The name is too short',
      'prod_price.required': 'The price is required',
      'prod_desc.required': 'The description is required',
      'vend_id.required': 'The vendor id is required',
    });

    await Products().query().where('id', '=', id).update({
      'prod_name': request.input('prod_name'),
      'prod_price': request.input('prod_price'),
      'prod_desc': request.input('prod_desc'),
      'vend_id': request.input('vend_id'),
    });

    return Response.json({'message': 'Product updated successfully'});
  }

  // delete product
  Future<Response> destroy(int id) async {
    await Products().query().where('id', '=', id).delete();

    return Response.json({'message': 'Product deleted successfully'});
  }
}

final ProductsController productsController = ProductsController();
