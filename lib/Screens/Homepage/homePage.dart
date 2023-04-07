import 'package:flutter/material.dart';

import 'package:taskmanagement/constants.dart';
import 'package:video_player/video_player.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    final List<String> _videoUrls = [
    'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4',
    'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_2mb.mp4',
    'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_5mb.mp4',
    'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_10mb.mp4',
    'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_30mb.mp4',
  ];

  late List<VideoPlayerController> _controllers;
  late List<bool> _isPlaying;

  @override
  void initState() {
    super.initState();

    // Create instances of VideoPlayerController and initialize them
    _controllers = _videoUrls
        .map((url) => VideoPlayerController.network(url))
        .toList();

    Future.wait(_controllers.map((controller) => controller.initialize()))
        .then((_) {
      setState(() {});
    });

    _isPlaying = List.filled(_videoUrls.length, false);
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is removed from the tree
    _controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 45,
                  width: 45,
                  margin: const EdgeInsets.only(left: 20, top: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset("assets/images/profile.png"),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text(
                    "Hello, John!",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),

                //text button for go live button
                Container(
                  margin: const EdgeInsets.only(right: 20, top: 15),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Go Live",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              color: kBlueLight,
              thickness: 0.6,
            ),
            //I need a list view here to show the list of the videos
            ListView.builder(
        itemCount: _videoUrls.length,
        itemBuilder: (context, index) {
          final controller = _controllers[index];

          return GestureDetector(
            onTap: () {
              setState(() {
                // Toggle the video playback state on tap
                if (controller.value.isPlaying) {
                  controller.pause();
                  _isPlaying[index] = false;
                } else {
                  controller.play();
                  _isPlaying[index] = true;
                }
              });
            },
            child:  Stack(
              alignment: Alignment.center,
              children: [
                VideoPlayer(controller),
                if (!_isPlaying[index])
                  const Icon(
                    Icons.play_circle_fill,
                    size: 64,
                    color: Colors.white,
                  ),
              ],
            ),
          );
        },
      ),
            Expanded(child: Container()),
            BottomNavBarFb1()
          ],
        ),
      ),
    );
  }
}

class BottomNavBarFb1 extends StatelessWidget {
  const BottomNavBarFb1({Key? key}) : super(key: key);

  final primaryColor = kPrimaryColor;
  final secondaryColor = kPrimaryLightColor;
  final accentColor = const Color(0xffffffff);
  final backgroundColor = const Color(0xffffffff);
  final errorColor = const Color(0xffEF4444);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: SizedBox(
        height: 56,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconBottomBar(
                text: "",
                icon: Icons.play_circle_outline_outlined,
                selected: true,
                onPressed: () {},
              ),
              IconBottomBar(
                  text: "Search",
                  icon: Icons.search_outlined,
                  selected: false,
                  onPressed: () {}),
              IconBottomBar2(
                  text: "Home",
                  icon: Icons.home,
                  selected: false,
                  onPressed: () {}),
              IconBottomBar(
                  text: "Notification",
                  icon: Icons.notifications_active_outlined,
                  selected: false,
                  onPressed: () {}),
              IconBottomBar(
                  text: "Calendar",
                  icon: Icons.date_range_outlined,
                  selected: false,
                  onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}

class IconBottomBar extends StatelessWidget {
  const IconBottomBar(
      {Key? key,
      required this.text,
      required this.icon,
      required this.selected,
      required this.onPressed})
      : super(key: key);
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;

  final primaryColor = kPrimaryColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 25,
            color: selected ? primaryColor : Colors.black54,
          ),
        ),
      ],
    );
  }
}

class IconBottomBar2 extends StatelessWidget {
  const IconBottomBar2(
      {Key? key,
      required this.text,
      required this.icon,
      required this.selected,
      required this.onPressed})
      : super(key: key);
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;
  final primaryColor = kPrimaryColor;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: primaryColor,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 25,
          color: Colors.white,
        ),
      ),
    );
  }
}
