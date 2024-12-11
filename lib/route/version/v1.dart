import 'package:vania/vania.dart';
import 'package:vaniarestapi/app/http/controllers/auth_controller.dart';
import 'package:vaniarestapi/app/http/controllers/customers_controller.dart';
import 'package:vaniarestapi/app/http/controllers/orders_controller.dart';
import 'package:vaniarestapi/app/http/controllers/productnotes_controller.dart';
import 'package:vaniarestapi/app/http/controllers/products_controller.dart';
import 'package:vaniarestapi/app/http/controllers/vendors_controller.dart';
import 'package:vaniarestapi/app/http/middleware/authenticate.dart';
import 'package:vaniarestapi/app/http/middleware/error_response_middleware.dart';

class Version1 extends Route {
  @override
  void register() {
    Router.basePrefix('api/v1');

    /// Authentication Routes
    Router.post('/login', authController.login);
    Router.post('/sign-up', authController.signUp);
    Router.post('/refresh-token', authController.refreshToken);

    Router.get('/wrong-request', () => Response.json({
          'message': 'Hi wrong request',
    })).middleware([ErrorResponseMiddleware()]);

    // customer routes
    Router.group(
      () {
        Router.get('/details', customersController.index);
        Router.get('/details/{id}', customersController.show);
        Router.post('/create', customersController.create);
        Router.patch('/update{id}', customersController.update);
        Router.delete('/delete/{id}', customersController.destroy);
      },
      prefix: 'customer',
    );
    // order routes
    Router.group(
      () {
        Router.get('/details', ordersController.index);
        Router.get('/details/{id}', ordersController.show);
        Router.post('/create', ordersController.create);
        Router.patch('/update/{id}', ordersController.update);
        Router.delete('/delete/{id}', ordersController.destroy);
      },
      prefix: 'order',
      // middleware: [AuthenticateMiddleware()],
    );
    // productnote routes
    Router.group(
      () {
        Router.get('/details', productnotesController.index);
        Router.get('/details/{id}', productnotesController.show);
        Router.post('/create', productnotesController.create);
        Router.patch('/update/{id}', productnotesController.update);
        Router.delete('/delete/{id}', productnotesController.destroy);
      },
      prefix: 'productnote',
      middleware: [AuthenticateMiddleware()],
    );
    // product routes
    Router.group(
      () {
        Router.get('/details', productsController.index);
        Router.get('/details/{id}', productsController.show);
        Router.post('/create', productsController.create);
        Router.patch('/update/{id}', productsController.update);
        Router.delete('/delete/{id}', productsController.destroy);
      },
      prefix: 'product',
      // middleware: [AuthenticateMiddleware()],
    );
    // vendor routes
    Router.group(
      () {
        Router.get('/details', vendorsController.index);
        Router.post('/create', vendorsController.create);
        Router.patch('/update/{id}', vendorsController.update);
        Router.delete('/delete/{id}', vendorsController.destroy);
      },
      prefix: 'vendor',
      // middleware: [AuthenticateMiddleware()],
    );
  }
}