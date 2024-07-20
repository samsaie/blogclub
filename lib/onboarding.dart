// ignore_for_file: unused_import

import 'package:blogclub/auth.dart';
import 'package:blogclub/data.dart';
import 'package:blogclub/gen/assets.gen.dart';
import 'package:blogclub/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  final items = AppDatabase.onBoardingItems;

  int page = 0;

  @override
  void initState() {
    _pageController.addListener(() {
      if (_pageController.page!.round() != page) {
        setState(() {
          page = _pageController.page!.round();
          debugPrint('Onboarding: Selected Page -> $page');
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 32, bottom: 8),
                child: Assets.img.background.onboarding.image(),
              ),
            ),
            Container(
                height: 260,
                decoration: BoxDecoration(
                    color: themeData.colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        color: Colors.black.withOpacity(0.1),
                      )
                    ],
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32))),
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        itemCount: items.length,
                        controller: _pageController,
                        itemBuilder: (context, indext) {
                          return Padding(
                            padding: const EdgeInsets.all(32),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  items[indext].title,
                                  style: themeData.textTheme.headline4,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  items[indext].description,
                                  style: themeData.textTheme.subtitle1!
                                      .apply(fontSizeFactor: 0.9),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      height: 60,
                      padding:
                          const EdgeInsets.only(left: 32, right: 32, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SmoothPageIndicator(
                            controller: _pageController,
                            count: items.length,
                            effect: ExpandingDotsEffect(
                                activeDotColor: themeData.colorScheme.primary,
                                dotWidth: 8,
                                dotHeight: 8,
                                dotColor: themeData.colorScheme.primary
                                    .withOpacity(0.1)),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (page == items.length - 1) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen()));
                              } else {
                                _pageController.animateToPage(page + 1,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.decelerate);
                              }
                            },
                            style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                    const Size(84, 60)),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                )),
                            child: Icon(page == items.length - 1
                                ? CupertinoIcons.check_mark
                                : CupertinoIcons.arrow_right),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
