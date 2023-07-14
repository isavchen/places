import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/styles.dart';
import 'package:places/ui/screens/home_page.dart';
import 'package:places/ui/widget/overscroll_glow_absorber.dart';
import 'package:places/ui/widget/page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController();
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      _currentPageNotifier.value = _pageController.page?.round() ?? 0;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<OnboardingPage> _onboardingPages = [
    OnboardingPage(
      image: onboarding_1,
      title: 'onboarding.first_page.title'.tr(),
      subtitle: 'onboarding.first_page.subtitle'.tr(),
    ),
    OnboardingPage(
      image: onboarding_2,
      title: 'onboarding.second_page.title'.tr(),
      subtitle: 'onboarding.second_page.subtitle'.tr(),
    ),
    OnboardingPage(
      image: onboarding_3,
      title: 'onboarding.third_page.title'.tr(),
      subtitle: 'onboarding.third_page.subtitle'.tr(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          ValueListenableBuilder<int>(
            valueListenable: _currentPageNotifier,
            builder: (context, value, child) => value != 2
                ? TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                    child: Text(
                      'onboarding.skip'.tr(),
                    ),
                  )
                : SizedBox.shrink(),
          )
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: OverscrollGlowAbsorber(
              child: PageView(
                controller: _pageController,
                children: _onboardingPages,
              ),
            ),
          ),
          Container(
            child: ValueListenableBuilder<int>(
              valueListenable: _currentPageNotifier,
              builder: (context, value, child) => PageIndicator(
                currentIndex: value,
                itemCount: 3,
                selectedColor: Theme.of(context).colorScheme.surface,
                normalColor: lmInactiveColor,
                width: 24.0,
                dotWidth: 8,
              ),
            ),
          ),
          SizedBox(
            height: 24.0,
          ),
        ],
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _currentPageNotifier,
        builder: (context, value, child) => value == 2
            ? SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
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
                      child: Text('onboarding.start'.tr().toUpperCase()),
                    ),
                  ),
                ),
              )
            : SafeArea(
                child: SizedBox(
                  height: 64.0,
                ),
              ),
      ),
    );
  }
}

class OnboardingPage extends StatefulWidget {
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
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    _scaleAnimation = Tween<double>(
      begin: 0,
      end: 100,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) => Container(
            height: 104,
            width: 104,
            child: Center(
              child: SvgPicture.asset(
                widget.image,
                height: _scaleAnimation.value,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 42.6,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 58.0),
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .primaryTextTheme
                .headlineSmall!
                .copyWith(color: Theme.of(context).colorScheme.secondary),
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 58.0),
          child: Text(
            widget.subtitle,
            textAlign: TextAlign.center,
            style: lmMatBodyText2,
          ),
        ),
      ],
    );
  }
}
