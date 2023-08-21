class Item {
  int? id;

  String? image;
  String? productName;
  int? quantity;

  String? purchaseDate;
  String? expiryDate;

  String? notificationDate;
  String? notificationTime;
  String? notificationId;

  int? productBarcode;

  Item({
    this.id,
    this.image,
    this.productName,
    this.quantity,
    required this.purchaseDate,
    required this.expiryDate,
    this.notificationDate,
    this.notificationTime,
    this.notificationId,
    this.productBarcode,
  });

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'].toString();
    productName = json['productName'].toString();
    quantity = json['quantity'];
    purchaseDate = json['purchaseDate'].toString();
    expiryDate = json['expiryDate'].toString();
    notificationDate = json['notificationDate'].toString();
    notificationTime = json['notificationTime'].toString();
    notificationId = json['notificationId'].toString();
    productBarcode = json['productBarcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> date = {
      'id': id,
      'image': image,
      'productName': productName,
      'quantity': quantity,
      'purchaseDate': purchaseDate,
      'expiryDate': expiryDate,
      'notificationDate': notificationDate,
      'notificationTime': notificationTime,
      'notificationId': notificationId,
      'productBarcode': productBarcode,
    };

    return date;
  }
}
