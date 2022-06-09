import 'package:flutter/material.dart';
import 'package:genderize/features/presentation/pages/genderize/genderize_page.dart';
import 'package:genderize/features/presentation/pages/nationalize/nationalize_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Genderize',
              ),
              Tab(
                text: 'Nationalize',
              )
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            GenderizePage(),
            NationalizePage(),
          ],
        ),
      ),
    );
  }
}
