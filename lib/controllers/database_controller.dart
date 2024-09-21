import 'package:e_commerce/models/add_to_cart_model.dart';
import 'package:e_commerce/models/users.dart';
import 'package:e_commerce/services/firestore_services.dart';
import 'package:e_commerce/utilities/api_path.dart';
import '../models/product.dart';

abstract class Database {
  Stream<List<Product>> sealsProductsStream();
  Stream<List<Product>> newProductsStream();
  Stream<List<AddToCartModel>> myProductsCar();
  Future<void> setUserData(UserData userData);
  Future<void> addToCart(AddToCartModel addToCartModel);
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
  Future<void> setUserData(UserData userData) async => await _services.setData(
        path: ApiPath.user(userData.uid),
        data: userData.toMap(),
      );

  @override
  Future<void> addToCart(AddToCartModel addToCartModel) async =>
      await _services.setData(
        path: ApiPath.addToCart(uid, addToCartModel.id),
        data: addToCartModel.toMap(),
      );

  @override
  Stream<List<AddToCartModel>> myProductsCar() => _services.collectionsStream(
        path: ApiPath.myProductsCart(uid),
        builder: (data, documentId) =>
            AddToCartModel.fromMap(data!, documentId),
      );
}
