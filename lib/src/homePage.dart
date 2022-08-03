import 'package:flicktape/src/components/homeTabs.dart';
import 'package:flicktape/src/components/videoList.dart';

import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miniplayer/miniplayer.dart';

final selectedVideoProvider = StateProvider<Tuple6?>((ref) => null);

final miniPlayerControllerProvider =
    StateProvider.autoDispose<MiniplayerController>(
  (ref) => MiniplayerController(),
);

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final List<Tuple3> _pages = [
    const Tuple3(HomeTabs("All"), "asd", Icon(Icons.video_library)),
    const Tuple3(HomeTabs("New to you"), "sda", Icon(Icons.image)),
    const Tuple3(HomeTabs("Street Food"), "sda", Icon(Icons.image)),
    const Tuple3(HomeTabs("Live"), "sda", Icon(Icons.image)),
    const Tuple3(
        HomeTabs("Battlegrounds Mobile India"), "sda", Icon(Icons.image)),
    const Tuple3(HomeTabs("JavaScript"), "sda", Icon(Icons.image)),
    const Tuple3(HomeTabs("Gaming"), "sda", Icon(Icons.image)),
    const Tuple3(HomeTabs("sports"), "sda", Icon(Icons.image)),
  ];
  late TabController _tabController;

  static const double _playerMinHeight = 60.0;

  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _pages.length, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: globalKey,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                backgroundColor: Colors.white,
                title: const Text(
                  'Flick Tape',
                  style: TextStyle(color: Colors.black),
                ),
                centerTitle: false,
                expandedHeight: 110,
                elevation: 0,
                actions: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: const Icon(
                      Icons.search,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: const Icon(
                        Icons.notifications_outlined,
                        size: 30,
                        color: Colors.black,
                      )),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: const CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(
                        "assets/images/a2.png",
                      ),
                    ),
                  ),
                ],
                pinned: true,
                floating: true,
                primary: true,
                forceElevated: innerBoxIsScrolled,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(58.0),
                  child: TabBar(
                    automaticIndicatorColorAdjustment: false,
                    indicatorColor: Colors.transparent,
                    isScrollable: true,
                    padding: const EdgeInsets.only(left: 5),
                    labelPadding: const EdgeInsets.only(
                        left: 5, right: 5, top: 5, bottom: 5),
                    tabs: _pages
                        .map<Widget>((Tuple3 page) => page.item1)
                        .toList(),
                    controller: _tabController,
                  ),
                ),
              ),
            ),
          ];
        },
        body: Container(
          padding: const EdgeInsets.only(top: 105),
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              VideoList(),
              Container(
                color: Colors.green,
              ),
              Container(
                color: Colors.blue,
              ),
              Container(
                color: Colors.red,
              ),
              Container(
                color: Colors.cyan,
              ),
              Container(
                color: Colors.grey,
              ),
              Container(
                color: Colors.indigo,
              ),
              Container(
                color: Colors.pink,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
