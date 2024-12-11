import 'dart:math';

import 'package:vania/vania.dart';
import 'package:vaniarestapi/app/models/customers.dart';

class AuthController extends Controller {
  /// Login
  Future<Response> login(Request request) async {
    try {
      request.validate({
        'cust_name': 'required',
        'cust_telp': 'required',
      }, {
        'cust_name.required': 'The name is required',
        'cust_telp.required': 'The phone number is required',
      });

      String name = request.input('cust_name');
      String custTelp = request.input('cust_telp').toString();

      final user = await Customers().query().where('cust_name', name).first();

      if (user == null) {
        return Response.json({'message': 'Customer not found'});
      }

      if (user['cust_telp'] != custTelp) {
        return Response.json({'message': 'Invalid phone number'});
      }

      // If you have guard and multi access like user and admin you can pass the guard Auth().guard('admin')
      Map<String, dynamic> token = await Auth()
          .login(user)
          .createToken(expiresIn: Duration(hours: 24), withRefreshToken: true);

      return Response.json(token);
    } catch (e) {
      return Response.json({'message': 'An error occurred', 'error': e.toString()}, 500);
    }
  }

  /// Creating new user
  Future<Response> signUp(Request request) async {
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

    /// Checking if the user already exists
    Map<String, dynamic>? customer = await Customers()
        .query()
        .where('cust_telp', '=', request.input('cust_telp'))
        .first();
    if (customer != null) {
      return Response.json({'message': 'Customer already exists'});
    }

    await Customers().query().insert({
      'cust_name': request.input('cust_name'),
      'cust_telp': request.input('cust_telp'),
      'cust_address': request.input('cust_address'),
      'cust_city': request.input('cust_city'),
      'cust_state': request.input('cust_state'),
      'cust_zip': request.input('cust_zip'),
      'cust_country': request.input('cust_country'),
    });

    return Response.json({'message': 'User created successfully'});
  }

  Future<Response> otp(Request request) {
    Random rnd = Random();
    int otp = rnd.nextInt(999999 - 111111);

    Cache.put('otp', otp.toString(), duration: Duration(minutes: 3));

    return Response.json({'message': 'OTP sent successfully'});
  }

  Future<Response> verifyOTO(Request request) async {
    String otp = request.input('otp');
    final otpValue = Cache.get('otp');

    if (otpValue == otp) {
      Cache.delete('otp');
      return Response.json({'message': 'OTP verified successfully'});
    } else {
      return Response.json(
        {'message': 'Invalid OTP'},
        400,
      );
    }
  }

  /// Generating a new token if the accessToken is expired
  Future<Response> refreshToken(Request request) {
    final newToken = Auth().createTokenByRefreshToken(
        request.header('Authorization')!,
        expiresIn: Duration(hours: 24));
    return Response.json(newToken);
  }
}

final AuthController authController = AuthController();