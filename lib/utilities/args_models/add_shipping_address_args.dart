import '../../controllers/database_controller.dart';
import '../../models/shipping_address.dart';

class AddShippingAddressArgs {
  final Database database;
  final ShippingAddress? shippingAddress;

  AddShippingAddressArgs({required this.database, this.shippingAddress});
}
