
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginscreen/models/shop_app/search_model.dart';
import 'package:loginscreen/modules/shop_app/search/search_cubit/states.dart';
import 'package:loginscreen/shared/components/constants.dart';
import 'package:loginscreen/shared/network/remote/dio_helper.dart';
import 'package:loginscreen/shared/network/remote/end_point.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String text)
  {
    emit(SearchLoadingState());

    DioHelper.postData(
        url: SEARCH,
        token: token,
        data: {
          'text' : text
        }
    ).then((value){

      model = SearchModel.fromJson(value?.data);
      emit(SearchSuccessState());
    }).catchError((error){

      print('Big Error: $error');
      emit(SearchErrorState());
    });
  }
}