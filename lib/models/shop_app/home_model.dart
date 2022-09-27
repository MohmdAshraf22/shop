class HomeModel
{
 late  bool status;
 late  DataShop data;

 HomeModel.fromJson(Map<String,dynamic> json)
 {
   status = json['status'];
   data =  DataShop.fromJson(json['data']);
 }
}

class DataShop
{
 late List<Banners> banners = [];
 late List<Products> products = [];

 DataShop.fromJson(Map<String,dynamic> json)
 {


   json['banners'].forEach((elements){
     banners.add(Banners.fromJson(elements));
   });

   json['products'].forEach((elements){
     products.add(Products.fromJson(elements));
   });
 }
}
class Banners
{
 late int id;
 late String image;

 Banners.fromJson(Map<String,dynamic> json){
   id = json['id'];
   image = json['image'];
 }

}
class Products
{
  late int id;
  late dynamic price;
  late dynamic old_price;
  late dynamic discount;
  late String image;
  late String name;
  late bool in_favorites;
  late bool in_cart;
  String? description;
  late List<String> images;



  Products.fromJson(Map<String,dynamic> json){
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    images = json['images'].cast<String>();
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
    description = json['description'];

  }
}