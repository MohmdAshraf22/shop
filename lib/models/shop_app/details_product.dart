class GetDetailsProduct {
  bool? status;
  String? message;
  Data? data;

  GetDetailsProduct.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

}

class Data {
  int? currentPage;
  late List<Details> data = [];

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];

   json['data'].forEach((elements)
   {
     data.add(Details.fromJson(elements));
   });
    }
}

class Details {
  late int id;
  late dynamic price;
  late dynamic old_price;
  late dynamic discount;
  late List<String> images;
  late String name;
  late bool in_favorites;
  late bool in_cart;
  String? description;


  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    images = json['images'].cast<String>();
    name = json['name'];
    description = json['description'];
  }

}
