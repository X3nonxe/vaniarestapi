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

    Map<String, dynamic> token = await Auth()
        .login(user)
        .createToken(expiresIn: Duration(hours: 24), withRefreshToken: true);

    return Response.json(token);
  } catch (e) {
    return Response.json({'message': 'An error occurred', 'error': e.toString()}, 500);
  }
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