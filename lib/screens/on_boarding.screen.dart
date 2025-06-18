import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wallet/screens/auth.screen.dart';
import 'package:wallet/style/theme.dart';
import 'package:wallet/utils/extensions.dart';

class OnBoardingScreen extends StatefulWidget {
  static const routeName = "OnBoarding";

  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController pageController;
  late double selectedPage;

  final pages = [
    _OnBoardingItem(
      image: SvgPicture.asset("assets/svgs/on_boarding_1.svg"),
      desc: "Trusted by millions of people, part of one part",
    ),
    _OnBoardingItem(
      image: SvgPicture.asset("assets/svgs/on_boarding_2.svg"),
      desc: "Spend money abroad, and track your expense",
    ),
    _OnBoardingItem(
      image: SvgPicture.asset("assets/svgs/on_boarding_3.svg"),
      desc: "Receive Money From Anywhere In The World",
    ),
  ];

  @override
  void initState() {
    selectedPage = 0;
    pageController = PageController(initialPage: selectedPage.round());
    pageController.addListener(onPageScrolled);
    super.initState();
  }

  @override
  void dispose() {
    pageController.removeListener(onPageScrolled);
    super.dispose();
  }

  void onPageScrolled() {
    setState(() {
      selectedPage = pageController.page ?? .0;
    });
  }

  void onPressNext() {
    if (selectedPage.round() == pages.length - 1) {
      Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
    } else {
      pageController.nextPage(
        duration: Durations.medium2,
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Stack(
            children: [
              PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                children: pages
                    .map((page) => Column(
                          children: [
                            const SizedBox(height: 48),
                            page.image,
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 17.5,
                              ),
                              child: page.desc
                                  .text(34600, color: const Color(0xFF2a2a2a)),
                            ),
                          ],
                        ))
                    .toList(),
              ),
              Positioned(
                bottom: 24 + 139,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(pages.length, (index) {
                    final delta = (index - selectedPage).abs().clamp(0, 1);
                    final offset = 19.0 * delta;

                    return Container(
                      width: 16 + offset,
                      height: 8,
                      margin: index == pages.length - 1
                          ? null
                          : const EdgeInsets.only(right: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(19),
                        color: delta < 1 ? MyColor.primary : MyColor.lightGrey,
                      ),
                    );
                  }),
                ),
              )
            ],
          )),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.5, 71, 16.5, 30),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onPressNext,
                child: const Text("Next"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnBoardingItem {
  final String desc;
  final Widget image;

  _OnBoardingItem({
    required this.desc,
    required this.image,
  });
}
