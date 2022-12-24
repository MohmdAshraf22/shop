import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:shop/modules/shop_app/login/shop_login.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel{
  late final String image;
  late final String title;
  late final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
});

}
class onBoardingScreen extends StatefulWidget {

  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  bool isLast = false;
  bool isNotLast = false;

  List<BoardingModel> Boarding = [
    BoardingModel(
      image: 'assets/images/SM.jpg',
      title: 'on Board 1 Title',
      body: 'on Board 1 Body',
    ),
    BoardingModel(
      image: 'assets/images/SM.jpg',
      title: 'on Board 2 Title',
      body: 'on Board 2 Body',
    ),
    BoardingModel(
      image: 'assets/images/SM.jpg',
      title: 'on Board 3 Title',
      body: 'on Board 3 Body',
    ),
  ];

  var boardController = PageController();
  void ToLogin(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value)
        {
          navigateAndFinish(context, ShopLogin());
        }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: ToLogin,

            child: Text('SKIP',),),
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.all(30.0),
        child: Column(
         children: [
           Expanded(
             child: PageView.builder(
               controller: boardController,
               onPageChanged: (value) {
                 if (value > 0)
                   {
                     setState((){
                       isNotLast = true;
                     });
                   }
                 else
                 {
                   setState((){
                     isNotLast = false;
                   });
                 }
                 if(value == Boarding.length-1)
                   {
                     setState((){
                       isLast = true;
                     });
                   }
                 else
                   {
                     setState((){
                       isLast = false;
                     });
                   }
               },
               physics: BouncingScrollPhysics(),
               itemBuilder: (context, index) => buildBoardingItem(Boarding[index]),
               itemCount: Boarding.length,

             ),
           ),
           SizedBox(height: 40,),
           Row(
             children: [
               SmoothPageIndicator(
                   controller: boardController,
                   count: Boarding.length,
                 effect: ExpandingDotsEffect(
                   dotColor: Colors.grey,
                    dotHeight: 15,
                   activeDotColor: Colors.orange,
                   expansionFactor: 3.6,
                   dotWidth: 10,
                   spacing: 10,
                 ) ,
               ),
               const Spacer(),
               ConditionalBuilder(
                 condition: isNotLast ,
                 builder: (context) => FloatingActionButton(
                   heroTag: null,
                   onPressed: (){
                     boardController.previousPage(
                       duration: Duration(
                           milliseconds: 750
                       ),
                       curve: Curves.fastLinearToSlowEaseIn,
                     );
                   },
                   child: Icon(
                     Icons.arrow_back_ios_new_outlined,
                   ),
                   mini: true,
                 ),
                 fallback: null,
               ),
               FloatingActionButton(
                 heroTag: null,
                 onPressed: (){
                   if(isLast == true)
                   {
                     ToLogin();
                   }
                   else
                   {
                     boardController.nextPage(
                       duration: Duration(
                         milliseconds: 750,
                       ),
                       curve: Curves.fastLinearToSlowEaseIn,
                     );
                   }
                 },
                 child: Icon(
                     Icons.arrow_forward_ios_outlined),
                 mini: true,
               ),
             ],
           ),
         ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(boarding) =>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
            image: AssetImage(
            '${boarding.image}'),
          fit: BoxFit.cover,
        ),
      ),
      SizedBox(
        height: 30,
      ),
      Text('${boarding.title}',
      style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          fontFamily: 'Jannah',
        ),
      ),
      SizedBox(
        height: 15,
      ),
      Text('${boarding.body}',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          fontFamily: 'Jannah',
        ),
      ),
      SizedBox(
        height: 30,
      ),
    ],
  );
}
