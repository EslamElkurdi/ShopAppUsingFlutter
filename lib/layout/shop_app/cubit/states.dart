import 'package:loginscreen/models/shop_app/change_favorites_model.dart';
import 'package:loginscreen/models/shop_app/login_model.dart';

abstract class ShopAppStates {}

class ShopInitialState extends ShopAppStates {}

class ShopChangeBottomNavState extends ShopAppStates {}

class ShopLoadingState extends ShopAppStates {}

class ShopSuccessHomeDataState extends ShopAppStates {}

class ShopErrorHomeDataState extends ShopAppStates {}

class ShopSuccessCategoriesState extends ShopAppStates {}

class ShopErrorCategoriesState extends ShopAppStates {}

class ShopSuccessChangeFavoritesState extends ShopAppStates {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopAppStates {}

class ShopChangeFavoritesState extends ShopAppStates {}

class ShopSuccessGetFavoritesState extends ShopAppStates {}

class ShopErrorGetFavoritesState extends ShopAppStates {}

class ShopFavoritesLoadingState extends ShopAppStates {}

class ShopSuccessGetUserDataState extends ShopAppStates
{
  final ShopLoginModel? model;

  ShopSuccessGetUserDataState(this.model);
}

class ShopErrorGetUserDataState extends ShopAppStates {}

class ShopUserDataLoadingState extends ShopAppStates {}

class ShopSuccessPutUserDataState extends ShopAppStates
{
  final ShopLoginModel? model;

  ShopSuccessPutUserDataState(this.model);
}

class ShopErrorPutUserDataState extends ShopAppStates {}

class ShopPutDataLoadingState extends ShopAppStates {}

