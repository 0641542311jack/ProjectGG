import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VDO_Hair04 extends StatefulWidget {
  const VDO_Hair04({super.key});

  @override
  State<VDO_Hair04> createState() => _VDO_Hair04State();
}

class _VDO_Hair04State extends State<VDO_Hair04> {
  final videoURL = "https://youtu.be/sAOa3iUXGTY?si=b5HqlEIjSNYTCVuw";
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
                  "ทรง Comma ",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "เสริมลุคที่ดูนุ่มนวลและทันสมัย ทรง Comma มีการจัดแต่งให้โค้งอย่างสวยงาม ช่วยให้ลุคของคุณดูเป็นมิตรและมีความนุ่มนวล เป็นที่นิยมมากในกลุ่มคนรุ่นใหม่และในวงการบันเทิงเกาหลี เพิ่มความสมดุลให้ใบหน้า การดัดผมหรือจัดให้เป็นรูปโค้งสามารถช่วยเน้นโครงหน้า โดยเฉพาะบริเวณหน้าผากและแก้ม ทำให้หน้าดูสมส่วนมากขึ้นและปรับแต่งได้หลากหลาย สามารถจัดทรงได้ทั้งแบบที่เป็นธรรมชาติหรือแบบที่ดูเนี้ยบ โดยใช้เจลหรือสเปรย์จัดทรง สามารถเพิ่มวอลลุ่มให้ดูฟูเล็กน้อยเพื่อเพิ่มเสน่ห์ เหมาะกับหลายโอกาส ไม่ว่าคุณจะต้องการลุคที่เป็นทางการหรือสบายๆ ทรงนี้ก็ปรับให้เหมาะสมได้ง่าย ทำให้มันเป็นทรงที่หลากหลายและใช้ได้ในชีวิตประจำวัน ดูแลและจัดทรงง่าย: ด้วยความที่ทรง Comma ต้องการเพียงการจัดทรงเล็กน้อย คุณสามารถดูแลและเซ็ตผมได้ง่ายด้วยการใช้ไดร์หรือผลิตภัณฑ์จัดแต่งทรงผม",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ));
  }
}
