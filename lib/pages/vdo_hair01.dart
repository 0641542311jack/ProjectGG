import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VDO_Hair01 extends StatefulWidget {
  const VDO_Hair01({super.key});

  @override
  State<VDO_Hair01> createState() => _VDO_Hair01State();
}

class _VDO_Hair01State extends State<VDO_Hair01> {
  final videoURL = "https://youtu.be/Z-C9jUCGZ_s?si=ADngrO6Ko_cp-8Oh";
  late YoutubePlayerController playerController;

  @override
  void initState() {
    final videoId = YoutubePlayer.convertUrlToId(videoURL);
    playerController = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: const YoutubePlayerFlags(autoPlay: false),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 50, 83, 125),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 50, 83, 125),
        foregroundColor: Colors.white,
        title: const Text("VDO สอนตัดผม"),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              YoutubePlayer(controller: playerController),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "ทรง รองทรง ",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "ดูสะอาดและเรียบร้อย ด้วยการไล่ระดับของผมจากด้านข้างและด้านหลังสั้นขึ้นไปยาวด้านบน ทำให้ทรงดูมีความเป็นระเบียบและสะอาด\nจัดทรงง่าย ทรงนี้ง่ายต่อการจัดทรงในชีวิตประจำวัน ไม่ต้องใช้ผลิตภัณฑ์จัดแต่งผมมากนัก ผมจะอยู่ทรงได้ดีโดยไม่ต้องดูแลมากและดูทันสมัย ผมรองทรงเป็นทรงที่เรียบง่ายแต่มีความทันสมัย สามารถปรับแต่งได้ตามสไตล์ของแต่ละคนและเหมาะกับทุกสถานการณ์ ไม่ว่าจะเป็นการทำงานในออฟฟิศ หรืองานสังคม ผมรองทรงเหมาะกับทุกสถานการณ์เพราะให้ลุคที่เป็นทางการและดูดี",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        )
    );
  }
}
