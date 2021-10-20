import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/styles.dart';
import 'package:places/ui/screens/HomePage.dart';
import 'package:places/ui/widget/page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController();
  bool isLastPageView = false;

  void _pageChanged(int index) {
    if (index == 2) {
      setState(() {
        isLastPageView = true;
      });
    } else {
      setState(() {
        isLastPageView = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          !isLastPageView
              ? TextButton(
                  onPressed: () {
                    _pageController.animateToPage(2,
                        duration: Duration(microseconds: 500),
                        curve: Curves.linear);
                  },
                  child: Text("Пропустить"),
                )
              : SizedBox(),
        ],
      ),
      body: Container(
        // color: Colors.blue,
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: _pageChanged,
              children: [
                OnboardingPage(
                  image: onboarding_1,
                  title: "Добро пожаловать в Путеводитель",
                  subtitle: "Ищи новые локации и сохраняй самые любимые.",
                ),
                OnboardingPage(
                  image: onboarding_2,
                  title: "Построй маршрут и отправляйся в путь",
                  subtitle: "Достигай цели максимально быстро и комфортно.",
                ),
                OnboardingPage(
                  image: onboarding_3,
                  title: "Добавляй места, которые нашёл сам",
                  subtitle:
                      "Делись самыми интересными и помоги нам стать лучше!",
                ),
              ],
            ),
            Positioned(
              bottom: 24.0,
              child: Container(
                // color: Colors.yellow,
                child: PageIndicator(
                  controller: _pageController,
                  itemCount: 3,
                  selectedColor: Theme.of(context).buttonColor,
                  normalColor: lmInactiveColor,
                  width: 24.0,
                  dotWidth: 8,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: isLastPageView
          ? SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Text("НА СТАРТ"),
                  ),
                ),
              ),
            )
          : SizedBox(
              height: 64.0,
            ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  const OnboardingPage({
    Key? key,
    required this.image,
    required this.subtitle,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          image,
          color: Theme.of(context).accentColor,
        ),
        SizedBox(
          height: 42.6,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 58.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .primaryTextTheme
                .headline5!
                .copyWith(color: Theme.of(context).accentColor),
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 58.0),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: lmMatBodyText2,
          ),
        ),
      ],
    );
  }
}
