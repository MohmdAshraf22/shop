class CategoriesModel
{
  late bool status;
  late CategoriesData data;
  CategoriesModel.fromJson(Map<String,dynamic> json)
  {
    status = json['status'];
    data = CategoriesData.fromJson(json['data']); 
  }
}
class CategoriesData
{
  late int current_page;
  late List<DataModel> datamodel = [];

  CategoriesData.fromJson(Map<String,dynamic> json)
  {
    current_page = json['current_page'];

    json['data'].forEach((elements){
      datamodel.add(DataModel.fromJson(elements));
    });
  }
}
class DataModel
{
  late int id;
  late String name;
  late String image;
  DataModel.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}