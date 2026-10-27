import 'package:flutter/material.dart';
import 'package:gas_utility_app/support/custom_theme.dart';

class CustomTabBar extends StatefulWidget {
  CustomTabBar({
    super.key,
    required this.tabController,
    required this.pageController,
  });
  final ValueNotifier<TabController> tabController;
  final PageController pageController;

  @override
  State<CustomTabBar> createState() => CustomTabBarState();
}

class CustomTabBarState extends State<CustomTabBar> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(top: 5),
        child: TabBar(
          onTap: (value) {
            widget.pageController.animateToPage(value,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
            // pageController.jumpToPage(value);
            widget.tabController.value.index = value;
          },
          tabAlignment: TabAlignment.start,
          splashFactory: NoSplash.splashFactory,
          controller: widget.tabController.value,
          automaticIndicatorColorAdjustment: false,
          dividerColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.label,
          isScrollable: true,
          labelPadding: const EdgeInsets.symmetric(horizontal: 5),
          indicator: BoxDecoration(
            gradient: ThemeGradient.gradient,
            borderRadius: BorderRadius.circular(30),
          ),
          tabs: [
            Tab(
              child: Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                child: Text(
                  "Main details",
                  style: TextStyle(
                    color: widget.tabController.value.index == 0
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
            Tab(
              child: Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                child: Text(
                  "Deduction",
                  style: TextStyle(
                    color: widget.tabController.value.index == 1
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
            Tab(
              child: Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                child: Text(
                  "Amount",
                  style: TextStyle(
                    color: widget.tabController.value.index == 2
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
