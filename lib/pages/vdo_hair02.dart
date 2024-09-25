import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VDO_Hair02 extends StatefulWidget {
  const VDO_Hair02({super.key});

  @override
  State<VDO_Hair02> createState() => _VDO_Hair02State();
}

class _VDO_Hair02State extends State<VDO_Hair02> {
  final videoURL = "https://youtu.be/kM96_QXltz8?si=oEGKh3n38To2xeqo";
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
                  "ทรง Two Block ",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "ลุคทันสมัยและเป็นเอกลักษณ์: ทรงนี้ให้ลุคที่ดูมีสไตล์ เป็นที่นิยมในกลุ่มคนรุ่นใหม่และผู้ที่สนใจแฟชั่น โดยเฉพาะในวัฒนธรรมเกาหลี และปรับแต่งได้หลากหลาย ผมด้านบนที่ยาวกว่าสามารถจัดทรงได้หลายแบบ ยังช่วยให้หน้าดูเรียวยาว สำหรับคนที่มีรูปหน้ากลม ทรงนี้สามารถทำให้ใบหน้าดูยาวและมีสัดส่วนที่สมดุลมากขึ้น ด้วยการเพิ่มวอลลุ่มที่ผมด้านบน เพิ่มความมั่นใจ ด้วยลุคที่ดูโดดเด่นและทันสมัย ทรง Two Block ทำให้หลายคนรู้สึกมั่นใจในตัวเองมากขึ้น  การดูและก็ดูแลง่าย ถึงแม้ผมด้านบนจะยาว แต่ส่วนล่างที่ถูกตัดสั้นช่วยลดความรำคาญ และทำให้การดูแลผมโดยรวมง่ายขึ้น ไม่ต้องใช้เวลาในการจัดทรง",
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
