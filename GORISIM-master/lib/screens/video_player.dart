import 'dart:developer';

import 'package:bitirme/screens/translate_vcToGest.dart';
import 'package:bitirme/utilities/colors.dart';
import 'package:bitirme/widgets/video_player_widget.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerr extends StatefulWidget {
  static const String routeName = '/videoplayer';
  const VideoPlayerr({
    Key? key,
    this.urlList,
  }) : super(key: key);
  final List<String>? urlList;
  @override
  State<VideoPlayerr> createState() => _VideoPlayerrState();
}

VideoPlayerController? controller;

class _VideoPlayerrState extends State<VideoPlayerr> {
  void printer() {
    print("urlList");
    print(urlList);
  }

  late PageController _pageController;
  late List<VideoPlayerController> _controllers;
  late int _currentPageIndex;

  @override
  void initState() {
    super.initState();

    // Initialize the video player controllers
    _controllers = widget.urlList!.map((url) {
      return VideoPlayerController.network(url)
        ..initialize().then((_) {
          setState(() {});
        });
    }).toList();

    // Initialize the page controller
    _pageController = PageController(initialPage: 0);
    _currentPageIndex = 0;

    // Play the first video
    _controllers[0].play();

    // Listen for page changes and play the corresponding video
    _pageController.addListener(() {
      final newPageIndex = _pageController.page!.round();
      if (newPageIndex != _currentPageIndex) {
        _controllers[_currentPageIndex].pause();
        _controllers[newPageIndex].play();
        setState(() {
          _currentPageIndex = newPageIndex;
        });
      }
    });
  }

  @override
  void dispose() {
    // Dispose the video player controllers when the widget is disposed
    _controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        centerTitle: true,
        title: const Text("Video Oynatıcı"),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 35.0,
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.close_sharp,
                size: 50,
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  TranslateVcToGest.routeName,
                );
              },
            );
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: 1 / 1,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.urlList!.length,
              itemBuilder: (context, index) {
                return _controllers[index].value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _controllers[index].value.aspectRatio,
                        child: VideoPlayer(_controllers[index]),
                      )
                    : Container();
              },
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Videoyu kaydırarak çevirebilirsiniz",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
