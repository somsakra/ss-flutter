import 'package:flutter/material.dart';
import 'package:my_first_app/src/constants/asset.dart';
import 'package:my_first_app/src/pages/home/widgets/chart.dart';
import 'package:my_first_app/src/pages/home/widgets/custom_drawer.dart';
import 'package:my_first_app/src/pages/home/widgets/custom_tab_bar.dart';
import 'package:my_first_app/src/pages/home/widgets/report.dart';
import 'package:my_first_app/src/pages/home/widgets/stock.dart';
import 'package:my_first_app/src/view-models/tab_menu_view_model.dart';

class ScreenArguments {
  final String name;
  final int age;

  ScreenArguments(this.name, this.age);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _tabsMenu = TabMenuViewModel().items;

  @override
  Widget build(BuildContext context) {
    // final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    // final models = Map.from(arguments);
    // var name = models['name'];
    // var age = models['age'];

    return DefaultTabController(
      length: _tabsMenu.length,
      child: Scaffold(
          appBar: _buildAppBar(),
          drawer: const CustomDrawer(),
          body: TabBarView(
              children: _tabsMenu.map((item) => item.widget).toList())),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("Marker"),
      bottom: CustomTabBar(_tabsMenu),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark_border)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.qr_code)),
      ],
    );
  }
}
