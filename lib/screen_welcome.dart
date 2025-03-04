import 'package:flutter/material.dart';

import 'main.dart';
import 'worker/theme.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:transparent_image/transparent_image.dart';

class ScreenWelcome extends StatefulWidget {
  const ScreenWelcome({super.key});

  @override
  State<ScreenWelcome> createState() => _ScreenWelcomeState();
}

class _ScreenWelcomeState extends State<ScreenWelcome> {
  final _pageController = PageController();
  int page = 0;

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage("assets/welcome/1.png"), context);
    precacheImage(const AssetImage("assets/welcome/2.png"), context);
    precacheImage(const AssetImage("assets/welcome/3.png"), context);
    precacheImage(const AssetImage("assets/welcome/1dark.png"), context);
    precacheImage(const AssetImage("assets/welcome/2dark.png"), context);
    precacheImage(const AssetImage("assets/welcome/3dark.png"), context);

    return Scaffold(
        bottomNavigationBar: BottomSheet(
            enableDrag: false,
            backgroundColor: (Theme.of(context).brightness == Brightness.light)
                ? Colors.grey[100]
                : Colors.grey[900],
            onClosing: () {},
            builder: (context) {
              return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    SmoothPageIndicator(
                        controller: _pageController,
                        count: 3,
                        effect: ExpandingDotsEffect(
                            activeDotColor: (Theme.of(context).brightness ==
                                    Brightness.light)
                                ? themeLight().colorScheme.primary
                                : themeDark().colorScheme.primary)),
                  ]));
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (page < 2) {
                _pageController.nextPage(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut);
              } else {
                prefs!.setBool("welcomeFinished", true);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const MainApp()));
              }
            },
            child: (page < 2)
                ? const Icon(Icons.arrow_forward)
                : const Icon(Icons.check_rounded)),
        body: SafeArea(
            child: Column(children: [
          Expanded(
              child: PageView(
                  controller: _pageController,
                  onPageChanged: (value) {
                    setState(() {
                      page = value;
                    });
                  },
                  children: [
                Center(
                    child: (Theme.of(context).brightness == Brightness.light)
                        ? FadeInImage(
                            placeholder: MemoryImage(kTransparentImage),
                            image: const AssetImage("assets/welcome/1.png"))
                        : FadeInImage(
                            placeholder: MemoryImage(kTransparentImage),
                            image:
                                const AssetImage("assets/welcome/1dark.png"))),
                Center(
                    child: (Theme.of(context).brightness == Brightness.light)
                        ? FadeInImage(
                            placeholder: MemoryImage(kTransparentImage),
                            image: const AssetImage("assets/welcome/2.png"))
                        : FadeInImage(
                            placeholder: MemoryImage(kTransparentImage),
                            image:
                                const AssetImage("assets/welcome/2dark.png"))),
                Center(
                    child: (Theme.of(context).brightness == Brightness.light)
                        ? FadeInImage(
                            placeholder: MemoryImage(kTransparentImage),
                            image: const AssetImage("assets/welcome/3.png"))
                        : FadeInImage(
                            placeholder: MemoryImage(kTransparentImage),
                            image:
                                const AssetImage("assets/welcome/3dark.png")))
              ])),
        ])));
  }
}
