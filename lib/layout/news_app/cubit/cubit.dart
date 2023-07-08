
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginscreen/layout/news_app/cubit/states.dart';
import 'package:loginscreen/modules/news_app/business_screen/business_screen.dart';
import 'package:loginscreen/modules/news_app/science_screen/science_screen.dart';
import 'package:loginscreen/modules/news_app/sports_screen/sports_screen.dart';
import 'package:loginscreen/shared/network/remote/cach_helper.dart';
import 'package:loginscreen/shared/network/remote/dio_helper.dart';

class AppNewsCubit extends Cubit<NewsAppStates>
{
  AppNewsCubit() : super(NewsAppInitialState());

  static AppNewsCubit get(context) => BlocProvider.of(context);

  bool darkTheme = false;

  List<BottomNavigationBarItem> items  =
      [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.business,
            ),
          label: "Business"
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.sports,
            ),
            label: "Sports"
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.science,
            ),
            label: "Science"
        ),
      ];

  List<Widget> screens =
  [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  int currentIndex = 0;

  void changeBottomNavBar(int index)
  {
    currentIndex = index;
    if(index == 1)
      getSports();
    else if(index == 2)
      getScience();



    emit(NewsAppBottomNavBar());

  }

  List<dynamic> business = [];


  void getBusiness(){

    emit(NewsAppGetBusinessLoadingState());

    if(business.length == 0)
    {
      DioHelper.getData(
          url: 'v2/everything',
          query: {
            'q' : 'business',
            'from':'2022-07-17',
            'sortBy':'publishedAt',
            'apiKey':'34a764db685743299df4d9f52597d46d',

            // https://newsapi.org/v2/everything?q=tesla&from=2022-07-11&sortBy=publishedAt&apiKey=34a764db685743299df4d9f52597d46d
          }
      ).then((value){
        business = value!.data['articles'];
        //print(value.data['articles'][0]['title']);
        print(business[0]['author']);

        emit(NewsGetBusinessSuccessState());
      }).catchError((error)
      {
        print('catch Error : ${error.toString()}');

        emit(NewsGetBusinessErrorState(error.toString()));
      });
    }else{
      emit(NewsGetBusinessSuccessState());
    }

  }


  List<dynamic> science = [];

  void getScience(){
    emit(NewsAppGetScienceLoadingState());

    if(science.length == 0)
    {
      DioHelper.getData(
          url: 'v2/everything',
          query: {
            'q' : 'science',
            'from':'2022-07-17',
            'sortBy':'publishedAt',
            'apiKey':'34a764db685743299df4d9f52597d46d',

            // https://newsapi.org/v2/everything?q=tesla&from=2022-07-11&sortBy=publishedAt&apiKey=34a764db685743299df4d9f52597d46d
          }
      ).then((value){
        science = value!.data['articles'];
        //print(value.data['articles'][0]['title']);
        print(science[0]['author']);

        emit(NewsGetScienceSuccessState());
      }).catchError((error)
      {
        print('catch Error : ${error.toString()}');

        emit(NewsGetScienceErrorState(error.toString()));
      });
    }else{
      emit(NewsGetScienceSuccessState());
    }


  }


  List<dynamic> sports = [];

  void getSports(){
    emit(NewsAppGetSportsLoadingState());

    if(sports.length == 0)
    {
      DioHelper.getData(
          url: 'v2/everything',
          query: {
            'q' : 'sports',
            'from':'2022-07-17',
            'sortBy':'publishedAt',
            'apiKey':'34a764db685743299df4d9f52597d46d',

            // https://newsapi.org/v2/everything?q=tesla&from=2022-07-11&sortBy=publishedAt&apiKey=34a764db685743299df4d9f52597d46d
          }
      ).then((value){
        sports = value!.data['articles'];
        //print(value.data['articles'][0]['title']);
        print(sports[0]['author']);

        emit(NewsGetSportsSuccessState());
      }).catchError((error)
      {
        print('catch Error : ${error.toString()}');

        emit(NewsGetSportsErrorState(error.toString()));
      });
    }else{
      emit(NewsGetSportsSuccessState());
    }

  }

  List<dynamic> search = [];
  void getSearch(String value){
    emit(NewsAppGetSearchLoadingState());

    search = [];

    if(search.length == 0)
    {
      DioHelper.getData(
          url: 'v2/everything',
          query: {
            'q' : '$value',
            'from':'2022-07-17',
            'sortBy':'publishedAt',
            'apiKey':'34a764db685743299df4d9f52597d46d',

            // https://newsapi.org/v2/everything?q=tesla&from=2022-07-11&sortBy=publishedAt&apiKey=34a764db685743299df4d9f52597d46d
          }
      ).then((value){
        search = value!.data['articles'];
        //print(value.data['articles'][0]['title']);
        print(search[0]['author']);

        emit(NewsGetSearchSuccessState());
      }).catchError((error)
      {
        print('catch Error : ${error.toString()}');

        emit(NewsGetSearchErrorState(error.toString()));
      });
    }else{
      emit(NewsGetSearchSuccessState());
    }

  }

  void toggleMode({bool? former})
  {
    if(former != null){
      darkTheme = former;
      emit(NewsAppLightModeState());
    }else{
      darkTheme = !darkTheme;
      CacheHelper.putBoolean(key: 'isDark', isDark: darkTheme).then((value) {
        emit(NewsAppLightModeState());
      });
    }



  }


}