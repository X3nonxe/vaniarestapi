import 'package:vaniarestapi/app/models/customers.dart';

Map<String, dynamic> authConfig = {
  'guards': {
    'default': {
      'provider': Customers(),
    }
  }
};
