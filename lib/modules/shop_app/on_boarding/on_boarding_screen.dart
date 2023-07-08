import 'package:flutter/material.dart';
import 'package:loginscreen/modules/shop_app/login/shop_login_screen.dart';
import 'package:loginscreen/shared/components/components.dart';
import 'package:loginscreen/shared/network/remote/cach_helper.dart';
import 'package:loginscreen/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class BoardingModel
{
  late final String title;
  late final String image;
  late final String body;

  BoardingModel({
   required this.title,
   required this.body,
   required this.image
});
}

class OnBoardingScreen extends StatefulWidget {

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding =
  [
    BoardingModel(title: 'title 1', body: 'body 1', image: 'assets/on_boarding.jpg'),
    BoardingModel(title: 'title 2', body: 'body 2', image: 'assets/on_boarding.jpg'),
    BoardingModel(title: 'title 3', body: 'body 3', image: 'assets/on_boarding.jpg'),
  ];

  var controllerPage = PageController();

  bool isLast = false;

  void submit(){
    CacheHelper.saveData(
        key: 'onBoarding',
        value: true).then((value)
    {
      if(value == true)
       {
         navigateAndFinish(
             context,
             ShopLoginScreen()
         );
       }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              function: (){
                submit();
              },
              text: 'skip'
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children:
          [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: controllerPage,
                onPageChanged: (int index)
                {
                  if(index == boarding.length - 1)
                  {

                    setState(()
                    {
                      isLast = true;
                    });
                  }else
                  {
                    setState(() {
                      isLast = false;
                    });
                  }
                  },
                itemBuilder: (context, index) => buildingBoardItem(boarding[index]),
                itemCount: 3,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: controllerPage,
                    count: boarding.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: defaultColor,
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                    onPressed: ()
                    {
                      if(isLast)
                      {
                        submit();
                      }else{
                        controllerPage.nextPage(
                            duration: Duration(
                                milliseconds: 750
                            ),
                            curve: Curves.fastLinearToSlowEaseIn
                        );
                      }
                    },
                  child: Icon(
                    Icons.arrow_forward_ios
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildingBoardItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Expanded(
        child: Image(
            image: AssetImage('${model.image}')
        ),
      ),
      SizedBox(
        height: 10.0,
      ),
      Text(
        "${model.title}",
        style: TextStyle(
            fontSize: 24.0
        ),
      ),
      SizedBox(
        height: 10.0,
      ),
      Text(
        "${model.body}",
      ),
      SizedBox(
        height: 10.0,
      ),

    ],
  );
}
