import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_ctx/presentation/pages/root_page/super_indexed_stack.dart';
import 'package:flutter_ctx/presentation/pages/test_page/test_page.dart';
import 'package:flutter_ctx/presentation/pages/test_page/test_page_one.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  List<Widget> children = <Widget>[
    const TestPage(),
    const TestPageOne(),
  ];
  int currentPageIndex = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(height: 1, color: const Color(0xffE3E3E3)),
            NavigationBar(
              shadowColor: Colors.blue,
              backgroundColor: const Color(0xffF7F7F7),
              elevation: 10,
              onDestinationSelected: (int index) {
                setState(() {
                  currentPageIndex = index;
                });
              },
              selectedIndex: currentPageIndex,
              destinations: const <Widget>[
                NavigationDestination(
                    icon: Icon(Icons.heart_broken_outlined),
                    selectedIcon: Icon(Icons.heart_broken_rounded),
                    label: '测试'),
                NavigationDestination(
                    selectedIcon: Icon(Icons.science_rounded),
                    icon: Icon(Icons.science_outlined),
                    label: '我的')
              ],
            ),
          ],
        ),
        body: SuperIndexedStack(
          index: currentPageIndex,
          children: children,
        )
        // body: children[currentPageIndex],
        );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      /// 当应用从后台恢复到前台
    }
  }
}
