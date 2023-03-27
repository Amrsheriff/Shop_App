import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled/modules/shop_app/login/shop_login_screen.dart';
import 'package:untitled/shared/componants/componants.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';
import 'package:untitled/shared/styles/colors.dart';

class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel({
  required this.image,
  required this.title,
  required this.body,
});
}

class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/onboard_1.jpg',
        title: 'On Board 1 Title',
        body: 'On Board 1 Body'
    ),
    BoardingModel(
        image: 'assets/images/onboard_1.jpg',
        title: 'On Board 2 Title',
        body: 'On Board 2 Body'
    ),
    BoardingModel(
        image: 'assets/images/onboard_1.jpg',
        title: 'On Board 3 Title',
        body: 'On Board 3 Body'
    ),
  ];

  var boardController = PageController();
  bool isLast = false;

  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value){
      if(value){
        navigateAndFinish(context, ShopLoginScreen());
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
              text: 'skip')
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                onPageChanged: (int index){
                  if(index == boarding.length - 1){
                    setState(() {
                      isLast = true;
                    });
                  }else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildingBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4,
                    spacing: 5.0,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                    onPressed: (){
                      if(isLast){
                        submit();
                      }else{
                        boardController.nextPage(
                            duration: Duration(
                              microseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn
                        );
                      }
                    },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildingBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
          child: Image(image: AssetImage('${model.image}'))),
      SizedBox(
        height: 30.0,
      ),
      Text(
        '${model.title}',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 15.0,
      ),
      Text(
        '${model.body}',
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 30.0,
      ),
    ],
  );
}
