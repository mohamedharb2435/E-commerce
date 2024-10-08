class AddToCartModel {
  final String id;
  final String productId ;
  final String title;
  final int price;
  final int quantity;
  final String imgUrl;
  final int discountValue;
  final String color;
  final String size;

  AddToCartModel(
      {required this.id,
      required this.productId,
      required this.title,
      required this.price,
      this.quantity = 1,
      required this.imgUrl,
      this.discountValue = 0,
      this.color = 'Black',
      required this.size});

  Map<String,dynamic>toMap(){
    final result=<String,dynamic>{};
    result.addAll({'id':id});
    result.addAll({'title':title});
    result.addAll({'price':price});
    result.addAll({'quantity':quantity});
    result.addAll({'imgUrl':imgUrl});
    result.addAll({'discountValue':discountValue});
    result.addAll({'color':color});
    result.addAll({'size':size});
     return result;
  }

  factory AddToCartModel.fromMap(Map<String, dynamic> map,String documentId) {
    return AddToCartModel(
      id: documentId,
      productId:map['productId']?? '',
      title: map['title']??'',
      price: map['price']?.toint()?? 0,
      quantity: map['quantity']?.toInt()?? 0,
      imgUrl: map['imgUrl']??'',
      discountValue:map['discountValue']?.toInt()?? 0 ,
      color: map['color']?? '',
      size: map['size']?? '',
    );
  }
}
