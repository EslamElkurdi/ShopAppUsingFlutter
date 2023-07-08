class HomeModel
{
  late bool status;
  late HomeDataModel data;

  HomeModel.fromJson(Map<String, dynamic> json)
  {

    // Price.fromJson(Map<String, dynamic>.from(json['lowest'])),

    status = json['status'];
    data = HomeDataModel.fromJson(Map<String, dynamic>.from(json['data']));
  }

}

class HomeDataModel
{
  List<BannerModel> banners = [];
  List<ProductModel> products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json)
  {


      json['banners'].forEach((element){
        //Map<String, dynamic>.from(json['lowest'])
        banners.add(BannerModel.fromJson(Map<String, dynamic>.from(element)));
      });

      json['products'].forEach((element){
        //products.add(element);
        products.add(ProductModel.fromJson(Map<String, dynamic>.from(element)));
      });


  }

}

class BannerModel
{
  late int id;
  late String image;

  BannerModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel
{
  late int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  late String image;
  String? name;
  late bool inFavorites;
  late bool inCart;

  ProductModel.fromJson(Map<String, dynamic> json)
  {

    id = json['id'];
    name = json['name'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}