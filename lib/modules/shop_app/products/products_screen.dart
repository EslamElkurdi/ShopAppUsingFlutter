



import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginscreen/layout/shop_app/cubit/cubit.dart';
import 'package:loginscreen/layout/shop_app/cubit/states.dart';
import 'package:loginscreen/models/shop_app/categorie_model.dart';
import 'package:loginscreen/models/shop_app/home_model.dart';
import 'package:loginscreen/shared/components/components.dart';
import 'package:loginscreen/shared/styles/colors.dart';

class ProductScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopAppStates>(
        listener: (context, state)
        {
          if(state is ShopSuccessChangeFavoritesState)
          {
            if(state.model.status == false)
            {
              showToast(text: state.model.message!, state: ToastStata.ERROR);
            }

          }
        },
        builder: (context, state)
        {
          return ConditionalBuilder(
              condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoryModel != null,
              builder: (context)=> productBuilder(ShopCubit.get(context).homeModel, ShopCubit.get(context).categoryModel, context),
              fallback: (context)=> Center(child: CircularProgressIndicator())
          );
        },
    );
  }

  Widget productBuilder(HomeModel? model, CategoriesModel? categoryModel, context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: 
      [
        CarouselSlider(
          items: model?.data.banners.map((e) => Image(
            image: NetworkImage('${e.image}'),
            width: double.infinity,
            fit: BoxFit.cover,
          )).toList(),
          options: CarouselOptions(
            height: 250.0,
            initialPage: 0,
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayInterval: Duration(seconds: 3),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                height: 100.0,
                child: ListView.separated(
                   physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Build_Category_Item(categoryModel?.data.data[index]),
                    separatorBuilder: (context, index) => SizedBox(
                      width: 10.0,
                    ),
                    itemCount: categoryModel!.data.data.length
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Text(
                'New Products',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1 / 1.8,
            children: List.generate(model!.data.products.length,
                    (index) => buildGridProduct(model.data.products[index], context)
            ),

          ),
        ),
      ],
    ),
  );

  Widget Build_Category_Item(DataModel? data) => Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children:
    [
      Image(

        image: NetworkImage('${data?.image}'),
        height: 100.0,
        width: 100.0,
        fit: BoxFit.cover,

      ),
      Container(
        width: 100.0,
        color: Colors.black.withOpacity(0.8),
        child: Text(
          '${data?.name}',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.white
          ),
        ),
      ),
    ],

  );

  Widget buildGridProduct(ProductModel model, context) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Stack(

          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image),
              width: double.infinity,
              height: 200.0,
              // fit: BoxFit.cover,
            ),
            if(model.discount != 0)
              Container(
              color: Colors.red,
              padding: EdgeInsets.all( 3.0),
              child: Text(
                'DISCOUNT',
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.white
                ),
              ),
            ),
          ]
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                '${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                  height: 1.3,
                ),
              ),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.price.round()}',
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                      color: defaultColor
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  if(model.discount != 0)
                    Text(
                    '${model.oldPrice.round()}',
                    style: TextStyle(
                        fontSize: 14.0,
                        height: 1.3,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    padding: EdgeInsets.zero,
                      onPressed: ()
                      {
                        ShopCubit.get(context).changeFavorites(model.id);
                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor: ShopCubit.get(context).favorites[model.id] == true ? defaultColor : Colors.grey,
                        child: Icon(
                            Icons.favorite_border,
                            size: 14.0,
                        ),
                      )
                  )
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}
