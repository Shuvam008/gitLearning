import 'package:chewie/chewie.dart';
import 'package:flicktape/src/components/videoList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tuple/tuple.dart';
import 'package:video_player/video_player.dart';
import 'package:flicktape/src/modal/videos.dart';

import 'components/homeTabs.dart';

class PlayVideos extends StatefulWidget {
  final String imageUrl;
  final String desc;
  final String videoUrl;
  const PlayVideos(
    this.imageUrl,
    this.desc,
    this.videoUrl, {
    Key? key,
  }) : super(key: key);

  @override
  State<PlayVideos> createState() => _PlayVideosState();
}

class _PlayVideosState extends State<PlayVideos>
    with SingleTickerProviderStateMixin {
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    _chewieController = ChewieController(
      videoPlayerController: VideoPlayerController.network(widget.videoUrl),
      aspectRatio: 16 / 9,

      autoInitialize: true,
      autoPlay: true,
      looping: false,
      showControls: true,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              errorMessage,
              style: TextStyle(color: Colors.black),
            ),
          ),
        );
      },
    );

    _tabController = TabController(length: _pages.length, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child:
            // Column(
            //   // mainAxisSize: MainAxisSize.max,
            //   children: [
            //     _buildHeroWidgetContent(widget.imageUrl),
            //     Scaffold(
            //       body: ListView(
            //         shrinkWrap: true,
            //         children: [
            //           _buildDescSingle1(),
            //           VideoList(),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),

            NestedScrollView(
          floatHeaderSlivers: false,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              _buildContent(context, widget.imageUrl),
              _buildDescSingle(),
            ];
          },
          body: VideoList(),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildContent(BuildContext context, imageUrl) {
    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[
          _buildHeroWidgetContent(imageUrl),
          // _buildDesc(),
        ],
      ),
    );
  }

  SliverFixedExtentList _buildDescSingle() {
    return SliverFixedExtentList(
      itemExtent: 100,
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return _buildDesc(
            tutorials[index].item2,
            tutorials[index].item4,
            tutorials[index].item5,
            tutorials[index].item6,
          );
        },
        childCount: 1,
      ),
    );
  }

  Widget _buildDescSingle1() {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      shrinkWrap: true,
      itemCount: 1,
      itemBuilder: (context, index) {
        return _buildDesc(
          tutorials[index].item2,
          tutorials[index].item4,
          tutorials[index].item5,
          tutorials[index].item6,
        );
      },
    );
  }

  Expanded _buildDesc(
    String desc,
    String chnnm,
    String views,
    String time,
  ) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 0, top: 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 2, 10, 10),
              child: const CircleAvatar(
                radius: 22,
                backgroundImage: AssetImage(
                  "assets/images/a2.png",
                ),
              ),
            ),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      desc,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Flexible(
                    child: Wrap(
                      direction: Axis.horizontal,
                      spacing: 0,
                      children: [
                        Text(
                          chnnm,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                          maxLines: 1,
                          textWidthBasis: TextWidthBasis.longestLine,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(5, 8, 5, 0),
                          child: const CircleAvatar(
                            radius: 1,
                            backgroundColor: Colors.black54,
                          ),
                        ),
                        Text(
                          views,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(5, 8, 5, 0),
                          child: const CircleAvatar(
                            radius: 1,
                            backgroundColor: Colors.black54,
                          ),
                        ),
                        Text(
                          time,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                          maxLines: 2,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
              child: const Icon(Icons.more_vert_outlined),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroWidgetContent(imageUrl) {
    return Hero(
      tag: imageUrl,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: Chewie(controller: _chewieController),
          ),
          onTap: () {},
        ),
      ),
    );
  }

  // Widget _buildDesc() {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Text(
  //       widget.desc,
  //       style: const TextStyle(
  //         fontSize: 30,
  //       ),
  //       textAlign: TextAlign.center,
  //     ),
  //   );
  // }

  @override
  void dispose() {
    _chewieController.videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
