// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
//
// Modifications of the Flutter Platform Widgets plugin example:
// https://github.com/stryder-dev/flutter_platform_widgets
// which is under MIT License with my modifications under
// BSD clause 3 license copyright 2021 by Fredrick Allan Grott

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:suggested_layout_arch/features/tab/ui/content_view.dart';
import 'package:suggested_layout_arch/widget_extends/extensions.dart';



class DynamicTabbedPage extends StatefulWidget {
  final TargetPlatform platform;

  const DynamicTabbedPage({Key? key, required this.platform}) : super(key: key);

  @override
  _DynamicTabbedPageState createState() => _DynamicTabbedPageState();
}

class _DynamicTabbedPageState extends State<DynamicTabbedPage> {
  static final titles = ['One', 'Two', 'Three'];
  // ignore: prefer_function_declarations_over_variables
  final icons = (BuildContext context) => [
        Icon(context.platformIcons.batteryFull),
        Icon(context.platformIcons.folder),
        Icon(context.platformIcons.shoppingCart),
      ];
  final colors = [
    Colors.amber,
    Colors.cyan,
    Colors.lime,
  ];
  late List<BottomNavigationBarItem> Function(BuildContext) items;

  // This needs to be captured here in a stateful widget
  late PlatformTabController tabController;

  @override
  void initState() {
    super.initState();

    // If you want further control of the tabs have one of these

    tabController = PlatformTabController(
      initialIndex: 1,
    );

    items = (BuildContext context) => [
          BottomNavigationBarItem(
            label: titles[0],
            icon: icons(context)[0],
            activeIcon: Icon(icons(context)[0].icon, color: colors[0]),
          ),
          BottomNavigationBarItem(
            label: titles[1],
            icon: icons(context)[1],
            activeIcon: Icon(icons(context)[1].icon, color: colors[1]),
          ),
          BottomNavigationBarItem(
            label: titles[2],
            icon: icons(context)[2],
            activeIcon: Icon(icons(context)[2].icon, color: colors[2]),
          ),
        ];
  }

  @override
  Widget build(BuildContext context) {
    return PlatformTabScaffold(
      iosContentPadding: true,
      tabController: tabController,
      appBarBuilder: (_, index) => PlatformAppBar(
        title: Text('${widget.platform.text} Page Title'),
        backgroundColor: colors[index],
        trailingActions: <Widget>[
          PlatformIconButton(
            padding: EdgeInsets.zero,
            icon: Icon(context.platformIcons.share),
            // ignore: no-empty-block
            onPressed: () {},
          ),
        ],
        cupertino: (_, __) => CupertinoNavigationBarData(
          title: Text(titles[index]),
        ),
      ),
      bodyBuilder: (context, index) => ContentView(index, widget.platform),
      items: items(context),
      materialBuilder: (context, __, index) => MaterialTabScaffoldData(
        floatingActionButton: FloatingActionButton(
          backgroundColor: colors[index],
          // ignore: no-empty-block
          onPressed: () {},
          child: icons(context)[index],
        ),
      ),
      cupertinoBuilder: (_, __, index) => CupertinoTabScaffoldData(
        backgroundColor: colors[index],
      ),
    );
  }
}