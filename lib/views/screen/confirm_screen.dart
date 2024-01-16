import "dart:io";

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:tiktok_clone/controller/upload_video_controller.dart";
import "package:tiktok_clone/views/widgets/text_input_field.dart";
import "package:video_player/video_player.dart";

class ConfirmScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;

  const ConfirmScreen(
      {super.key, required this.videoFile, required this.videoPath});

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController controller;
  TextEditingController songController = TextEditingController();
  TextEditingController captionController = TextEditingController();

  UploadVideoController uploadVideoController =
      Get.put(UploadVideoController());

  @override
  void initState() {
    super.initState();
    setState(() {
      controller = VideoPlayerController.file(widget.videoFile);
    });
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              child: VideoPlayer(controller)),
          const SizedBox(
            height: 30,
          ),
          SingleChildScrollView(
            child: Column(children: [
              Container(
                width: MediaQuery.sizeOf(context).width - 20,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: TextInputField(
                    controller: songController,
                    icon: Icons.music_note,
                    labeltext: 'Song Name'),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.sizeOf(context).width - 30,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: TextInputField(
                    controller: captionController,
                    icon: Icons.description,
                    labeltext: 'Caption'),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () => uploadVideoController.uploadVideo(
                      songController.text,
                      captionController.text,
                      widget.videoPath),
                  child: const Text(
                    'Share',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ))
            ]),
          )
        ],
      )),
    );
  }
}
