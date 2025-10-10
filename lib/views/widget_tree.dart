import 'package:flutter/material.dart';
import 'package:project_kanso/data/notifiers.dart';
import 'package:project_kanso/views/Widgets/nav_bar_widget.dart';
import 'package:project_kanso/views/pages/community.dart';
import 'package:project_kanso/views/pages/home.dart';
import 'package:project_kanso/views/pages/settings.dart';
import 'Widgets/nav_bar_widget.dart';

List<Widget> pages = [SettingPage(), HomePage(), CommunityPage()];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return pages.elementAt(selectedPage);
        },
      ),
      bottomNavigationBar: NavBarWidget(),
    );
  }
}
