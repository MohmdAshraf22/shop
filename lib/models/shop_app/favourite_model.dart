class AddFavourites
{
   bool? status;
   String? message;
  AddFavourites.fromJson(Map<String,dynamic> json)
  {
    status = json['status'];
    message = json['message'];
  }
}