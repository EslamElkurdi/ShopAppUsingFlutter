import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginscreen/layout/shop_app/cubit/cubit.dart';
import 'package:loginscreen/layout/shop_app/cubit/states.dart';
import 'package:loginscreen/models/shop_app/favorites_model.dart';
import 'package:loginscreen/shared/components/components.dart';
import 'package:loginscreen/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopAppStates>(
        listener: (context, state){
          print(ShopCubit.get(context).favoritesModel?.data?.data?.length);
        },
        builder: (context, state)
        {
          return ConditionalBuilder(
            condition: state is! ShopFavoritesLoadingState,
            builder: (context) => ListView.separated(
              itemBuilder: (context, index)=> buildListItem(ShopCubit.get(context).favoritesModel?.data?.data?[index].product, context),
              separatorBuilder: (context, index)=> myDivider(),
              itemCount: ShopCubit.get(context).favoritesModel?.data?.data?.length??0,
            ),
            fallback: (context) =>Center(child: CircularProgressIndicator()),
          );
        }
    );;
  }



}
