import 'package:vania/vania.dart';
import 'package:vaniarestapi/app/models/productnotes.dart';

class ProductnotesController extends Controller {
  // fetch all productnotes
  Future<Response> index() async {
    List<Map<String, dynamic>> productnotes = await Productnotes()
        .query()
        .select([
          'productnotes.id',
          'products.prod_name',
          'productnotes.note_date',
          'productnotes.note_text',
        ])
        .join('products', 'products.id', '=', 'productnotes.prod_id')
        .get();

    return Response.json({'data': productnotes});
  }

  // fetch single productnotes
  Future<Response> show(int id) async {
    Map<String, dynamic>? productnotes = await Productnotes()
        .query()
        .select([
          'productnotes.id',
          'products.prod_name',
          'productnotes.note_date',
          'productnotes.note_text',
        ])
        .join('products', 'products.id', '=', 'productnotes.prod_id')
        .where('productnotes.id', '=', id)
        .first();

    return Response.json({'data': productnotes});
  }

  // create new productnotes
  Future<Response> create(Request request) async {
    request.validate({
      'prod_id': 'required',
      'note_date': 'required',
      'note_text': 'required',
    }, {
      'prod_id.required': 'The product id is required',
      'note_date.required': 'The note date is required',
      'note_text.required': 'The note text is required',
    });

    await Productnotes().query().insert({
      'prod_id': request.input('prod_id'),
      'note_date': request.input('note_date'),
      'note_text': request.input('note_text'),
    });

    return Response.json({'message': 'Productnotes created successfully'});
  }

  // update productnotes
  Future<Response> update(Request request, int id) async {
    request.validate({
      'prod_id': 'required',
      'note_date': 'required',
      'note_text': 'required',
    }, {
      'prod_id.required': 'The product id is required',
      'note_date.required': 'The note date is required',
      'note_text.required': 'The note text is required',
    });

    await Productnotes().query().where('id', '=', id).update({
      'prod_id': request.input('prod_id'),
      'note_date': request.input('note_date'),
      'note_text': request.input('note_text'),
    });

    return Response.json({'message': 'Productnotes updated successfully'});
  }

  // delete productnotes
  Future<Response> destroy(int id) async {
    await Productnotes().query().where('id', '=', id).delete();
    return Response.json({'message': 'Productnotes deleted successfully'});
  }
}

final ProductnotesController productnotesController = ProductnotesController();
