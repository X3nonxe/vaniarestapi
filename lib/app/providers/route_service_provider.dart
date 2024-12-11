import 'package:vania/vania.dart';
import 'package:vaniarestapi/route/api_route.dart';

class RouteServiceProvider extends ServiceProvider {
  @override
  Future<void> boot() async {}

  @override
  Future<void> register() async {
    ApiRoute().register();
  }
}
