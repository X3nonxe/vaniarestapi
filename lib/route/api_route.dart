import 'package:vania/vania.dart';
import 'package:vaniarestapi/app/http/middleware/error_response_middleware.dart';
import 'package:vaniarestapi/route/version/v1.dart';

class ApiRoute implements Route {
  @override
  void register() {
    Version1().register();

    // Return error code 400
    Router.get('/wrong-request',
            () => Response.json({'message': 'Hi wrong request'}))
        .middleware([ErrorResponseMiddleware()]);
  }
}
