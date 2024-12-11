import 'package:vania/vania.dart';
import 'package:vaniarestapi/app/models/vendors.dart';

class VendorsController extends Controller {
  // fetch all vendors
  Future<Response> index() async {
    List<Map<String, dynamic>> vendors = await Vendors().query().get();
    return Response.json({'data': vendors});
  }

  // fetch single vendor
  Future<Response> show(int id) async {
    Map<String, dynamic>? vendor =
        await Vendors().query().where('id', '=', id).first();
    return Response.json({'data': vendor});
  }

  // create new vendor
  Future<Response> create(Request request) async {
    request.validate({
      'vend_name': 'required|max_length:25|min_length:2',
      'vend_address': 'required',
      'vend_city': 'required',
      'vend_state': 'required',
      'vend_zip': 'required',
      'vend_country': 'required',
    }, {
      'vend_name.required': 'The name is required',
      'vend_name.max_length': 'The name is too long',
      'vend_name.min_length': 'The name is too short',
      'vend_address.required': 'The address is required',
      'vend_city.required': 'The city is required',
      'vend_state.required': 'The state is required',
      'vend_zip.required': 'The zip code is required',
      'vend_country.required': 'The country is required',
    });

    await Vendors().query().insert({
      'vend_name': request.input('vend_name'),
      'vend_address': request.input('vend_address'),
      'vend_city': request.input('vend_city'),
      'vend_state': request.input('vend_state'),
      'vend_zip': request.input('vend_zip'),
      'vend_country': request.input('vend_country'),
    });

    return Response.json({'message': 'Vendor created successfully'});
  }

  // update vendor
  Future<Response> update(Request request, int id) async {
    request.validate({
      'vend_name': 'required|max_length:25|min_length:2',
      'vend_address': 'required',
      'vend_kota': 'required',
      'vend_state': 'required',
      'vend_zip': 'required',
      'vend_country': 'required',
    }, {
      'vend_name.required': 'The name is required',
      'vend_name.max_length': 'The name is too long',
      'vend_name.min_length': 'The name is too short',
      'vend_address.required': 'The address is required',
      'vend_kota.required': 'The city is required',
      'vend_state.required': 'The state is required',
      'vend_zip.required': 'The zip code is required',
      'vend_country.required': 'The country is required',
    });

    await Vendors().query().where('id', '=', id).update({
      'vend_name': request.input('vend_name'),
      'vend_address': request.input('vend_address'),
      'vend_kota': request.input('vend_kota'),
      'vend_state': request.input('vend_state'),
      'vend_zip': request.input('vend_zip'),
      'vend_country': request.input('vend_country'),
    });

    return Response.json({'message': 'Vendor updated successfully'});
  }

  // delete vendor
  Future<Response> destroy(int id) async {
    await Vendors().query().where('id', '=', id).delete();
    return Response.json({'message': 'Vendor deleted successfully'});
  }
}

final VendorsController vendorsController = VendorsController();
