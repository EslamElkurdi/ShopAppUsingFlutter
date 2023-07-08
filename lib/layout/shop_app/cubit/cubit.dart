import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginscreen/layout/shop_app/cubit/states.dart';
import 'package:loginscreen/models/shop_app/categorie_model.dart';
import 'package:loginscreen/models/shop_app/change_favorites_model.dart';
import 'package:loginscreen/models/shop_app/favorites_model.dart';
import 'package:loginscreen/models/shop_app/home_model.dart';
import 'package:loginscreen/models/shop_app/login_model.dart';
import 'package:loginscreen/modules/shop_app/categories/categories_screen.dart';
import 'package:loginscreen/modules/shop_app/favorites/favorites_screen.dart';
import 'package:loginscreen/modules/shop_app/products/products_screen.dart';
import 'package:loginscreen/modules/shop_app/settings_screen/settings_screen.dart';
import 'package:loginscreen/shared/components/constants.dart';
import 'package:loginscreen/shared/network/remote/dio_helper.dart';
import 'package:loginscreen/shared/network/remote/end_point.dart';

class ShopCubit extends Cubit<ShopAppStates>
{
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index)
  {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  Map<int, bool> favorites = {};

  void getHomeData()
  {
    emit(ShopLoadingState());

    DioHelper.getData(
        url: HOME,
        token: token,
    ).then((value)
    {
      // problem
      //print(value!.data['status']);
      homeModel = HomeModel.fromJson(value?.data);

      // printFullText(homeModel.toString());
       //print(homeModel?.status);

      homeModel?.data.products.forEach((element) {
        favorites.addAll({
          element.id : element.inFavorites
        });
      });

      print(favorites.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((error)
    {
      print("BIG ERROR: ${error.toString()}");
      emit(ShopErrorHomeDataState());
      
    });
  }

  CategoriesModel? categoryModel;

  void getCategories()
  {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value)
    {
      categoryModel = CategoriesModel.fromJson(value?.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error)
    {
      print("BIG ERROR: ${error.toString()}");
      emit(ShopErrorCategoriesState());

    });
  }


  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int id)
  {
    favorites[id] = favorites[id] == true ? false : true;

    emit(ShopChangeFavoritesState());

    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id' : id
        },
        token: token
    ).then((value)
    {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value?.data);
      print(value?.data);

      if(changeFavoritesModel?.status != true)
        favorites[id] = favorites[id] == true ? false : true;
      else
        getFavorites();
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }
    ).catchError((error)
    {
      favorites[id] = favorites[id] == true ? false : true;

      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites()
  {
    emit(ShopFavoritesLoadingState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value)
    {
      favoritesModel = FavoritesModel.fromJson(value?.data);
      printFullText(value!.data.toString());

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error)
    {
      print("BIG ERROR: ${error.toString()}");
      emit(ShopErrorGetFavoritesState());

    });
  }

  ShopLoginModel? userModel;

  void getUserData()
  {
    emit(ShopUserDataLoadingState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value)
    {
      userModel = ShopLoginModel.fromJson(value?.data);
      //printFullText(userModel!.data!.name);
      print(userModel!.data!.name);
      emit(ShopSuccessGetUserDataState(userModel));
    }).catchError((error)
    {
      print("BIG ERROR: ${error.toString()}");
      emit(ShopErrorGetUserDataState());
    });
  }


  void putUserData({
    required String name,
    required String phone,
    required String email,

  })
  {
    emit(ShopPutDataLoadingState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data:
      {
        "name": name,
        "phone": phone,
        "email": email
      },
    ).then((value)
    {
      userModel = ShopLoginModel.fromJson(value?.data);
      //printFullText(userModel!.data!.name);
      print(userModel!.data!.name);
      emit(ShopSuccessPutUserDataState(userModel));
    }).catchError((error)
    {
      print("BIG ERROR: ${error.toString()}");
      emit(ShopErrorPutUserDataState());
    });
  }

}