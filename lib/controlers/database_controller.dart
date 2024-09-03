import 'package:e_commerce/services/firestore_services.dart';
import '../models/product.dart';

abstract class Database {
  Stream<List<Product>> productsStream();
}

class FirestoreDatabase implements Database {
  final _services = FireStoreServices.instance;

  @override
  Stream<List<Product>> productsStream() => _services.collectionsStream(
        path: 'products/',
        builder: (data, documentId) => Product.fromMap(data!, documentId),
      );
}
