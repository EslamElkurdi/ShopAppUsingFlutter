import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginscreen/layout/shop_app/cubit/cubit.dart';
import 'package:loginscreen/layout/shop_app/cubit/states.dart';
import 'package:loginscreen/models/shop_app/categorie_model.dart';
import 'package:loginscreen/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopAppStates>(
        listener: (context, state){},
        builder: (context, state)
        {
          return ListView.separated(
              itemBuilder: (context, index)=> BuildCatItem(ShopCubit.get(context).categoryModel!.data.data[index]),
              separatorBuilder: (context, index)=> myDivider(),
              itemCount: ShopCubit.get(context).categoryModel!.data.data.length
          );
        }
    );
  }

  Widget BuildCatItem(DataModel model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:
      [
        Image(
          image: NetworkImage('${model.image}'),
          height: 80.0,
          width: 80.0,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 20.0,
        ),
        Text(
          '${model.name}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        Spacer(),
        Icon(
            Icons.arrow_forward_ios
        ),


      ],
    ),
  );

}
