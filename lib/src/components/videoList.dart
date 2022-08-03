import 'package:cached_network_image/cached_network_image.dart';
import 'package:flicktape/src/modal/videos.dart';
import 'package:flicktape/src/playVideos.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class VideoList extends StatelessWidget {
  const VideoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      slivers: <Widget>[
        _buildSliverContent(),
      ],
    );
  }

  SliverFixedExtentList _buildSliverContent() {
    return SliverFixedExtentList(
      itemExtent: 325,
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return _buildListItem(context, tutorials[index]);
        },
        childCount: tutorials.length,
      ),
    );
  }

  Widget _buildListItem(BuildContext context, Tuple6 tutorial) {
    return Stack(
      children: <Widget>[
        _buildCardView(
          tutorial.item2,
          tutorial.item1,
          tutorial.item4,
          tutorial.item5,
          tutorial.item6,
          context,
        ),
        _buildRippleEffectNavigation(
            context, tutorial.item1, tutorial.item2, tutorial.item3),
      ],
    );
  }

  Widget _buildCardView(String desc, String imageUrl, String chnnm,
      String views, String time, context) {
    return Positioned.fill(
      child: Container(
        // color: Colors.red,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeroWidget(imageUrl, context),
            _buildDesc(desc, chnnm, views, time),
          ],
        ),
      ),
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
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 0, top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 2, 10, 0),
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
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: const Icon(Icons.more_vert_outlined),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroWidget(String imageUrl, context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.red,
      child: Hero(
        tag: imageUrl,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            child: _buildHeroWidgetContent(imageUrl),
            onTap: () {},
          ),
        ),
        flightShuttleBuilder:
            (flightContext, animation, direction, fromContext, toContext) {
          Widget flyingWidget = toContext.widget as Hero..child;

          if (direction == HeroFlightDirection.push) {
            flyingWidget = fromContext.widget as Hero..child;
          }

          return RotationTransition(
            turns: Tween(begin: 0.0, end: 2.0)
                .chain(CurveTween(curve: Curves.ease))
                .animate(animation),
            child: flyingWidget,
          );
        },
      ),
    );
  }

  CachedNetworkImage _buildHeroWidgetContent(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildRippleEffectNavigation(
    BuildContext context,
    String imageUrl,
    String desc,
    String videoUrl,
  ) {
    return Container(
      // color: Colors.amber,
      height: 230,
      child: InkWell(
        splashColor: Colors.red.withOpacity(0.5),
        highlightColor: Colors.red.withOpacity(0.5),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext _context) =>
                    PlayVideos(imageUrl, desc, videoUrl),
              ));
        },
      ),
    );
  }
}
