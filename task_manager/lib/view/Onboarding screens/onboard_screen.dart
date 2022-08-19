import 'package:budget_app/config/colors.dart';
import 'package:budget_app/config/text.dart';
import 'package:budget_app/view/UI%20widgets/buttons.dart';
import 'package:budget_app/view/login_screen.dart';
import 'package:budget_app/view/multipage_signup/selectimage_signup.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:flutter_svg/flutter_svg.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({Key? key}) : super(key: key);

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int pageIndex = 0;

    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bkgrColor,
      body: SafeArea(
        child: Stack(children: [
          PageView.builder(
              controller: _controller,
              itemCount: onboardImages.length,
              itemBuilder: (BuildContext context, int index) {
                return OnboardScreenWidget(context, onboardImages[index],
                    headlineText[index], bodyText[index]);
              }),
          Positioned(
              bottom: 100,
              left: (size.width * 0.5) - 22,
              child: SmoothPageIndicator(

                onDotClicked: (index) {

                  

                },
                count: onboardImages.length,
                controller: _controller,
                effect: const ExpandingDotsEffect(
                  activeDotColor: primColor,
                  dotWidth: 10,
                  dotHeight: 10,
                  radius: 10,
                  dotColor: unselected,
                  spacing: 5,
                  
                ),
              )),
          Positioned(
            top: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: ((context) => const ImageSelection())));
                  },
               
                    child: Text(
                      'Skip',
                      style: latobody,
                    ),
                  ),
               
              ],
            ),
          ),
        ]),
      ),
    );
  }

  List onboardImages = [
    'asset/images/Illustration2.svg',
    'asset/images/Illustration1.svg',
    'asset/images/Illustration3.svg',
  ];

  List bodyText = [
    'TaskSpace allows you to create new task task,\nmanage your task with ease. ',
    'Enjoy simple task management, get reminders, \ntask chart analysis on your overall efficiency,\ntask memebers performance.',
    'Work with your team anywhere in the world, \ncreate new team and complete every task.',
  ];

  List headlineText = [
    'Create your task',
    'Manage your task',
    'Start a task team',
  ];

  List<Widget> carousel = [Container(), Container(), Container()];

  Widget OnboardScreenWidget(context, assetImage, headlinetext, bodylinetext) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              child: SvgPicture.asset(
                assetImage,
                fit: BoxFit.cover,
                height: 350,
                width: 350,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Column(
            children: [
              Text(
                headlinetext,
                style: latoheading1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                bodylinetext,
                style: latobody2,
                textAlign: TextAlign.center,
              )
            ],
          ),
          const SizedBox(
            height: 60,
          ),
          assetImage == onboardImages[2]
              ? GestureDetector(
                  onTap: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: ((context) => const ImageSelection()))),
                  child: Button(
                      Text(
                        'Let\'s get started',
                        style: lightlatobody,
                      ),
                      null),
                )
              : Container()
        ],
      ),
    );
  }

  Widget carouselWidget(int pageIndex, int index, Color color, double size) {
    return Container(
      height: 10,
      width: size,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(30), color: color),
    );
  }
}
