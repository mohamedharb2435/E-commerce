import 'package:e_commerce/models/users.dart';
import 'package:e_commerce/services/firestore_services.dart';
import 'package:e_commerce/utilities/api_path.dart';
import '../models/product.dart';

abstract class Database {
  Stream<List<Product>> sealsProductsStream();
  Stream<List<Product>> newProductsStream();
  Future<void> setUserData(UserData userData);
}

class FirestoreDatabase implements Database {
  final _services = FireStoreServices.instance;
  final String uid;
  FirestoreDatabase(this.uid);
  @override
  Stream<List<Product>> sealsProductsStream() => _services.collectionsStream(
        path: ApiPath.products(),
        builder: (data, documentId) => Product.fromMap(data!, documentId),
        queryBuilder: (query) => query.where('discountValue', isNotEqualTo: 0),
      );

  @override
  Stream<List<Product>> newProductsStream() => _services.collectionsStream(
        path: ApiPath.products(),
        builder: (data, documentId) => Product.fromMap(data!, documentId),
      );

  @override
  Future<void> setUserData(UserData userData)async=>await _services.setData(
      path: ApiPath.user(userData.uid),
      data:userData.toMap(),
  );
}
