import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VDO_Hair03 extends StatefulWidget {
  const VDO_Hair03({super.key});

  @override
  State<VDO_Hair03> createState() => _VDO_Hair03State();
}

class _VDO_Hair03State extends State<VDO_Hair03> {
  final videoURL = "https://youtu.be/cXehEKDd4wQ?si=6btbc8erJi43p1pB";
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
                  "ทรง Mullet ",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "ลุคที่เป็นเอกลักษณ์: ทรง Mullet มีลักษณะเฉพาะที่โดดเด่นและแตกต่างจากทรงผมทั่วไป ทำให้ผู้ที่ใส่รู้สึกมีสไตล์ที่เป็นเอกลักษณ์\nเพิ่มความมีเสน่ห์และความน่าสนใจ: ทรง Mullet มักจะดึงดูดความสนใจและทำให้ผู้ที่สวมใส่ดูเด่นกว่าใครในกลุ่ม ปรับแต่งได้หลากหลาย คุณสามารถปรับแต่งทรงนี้ได้หลายแบบ เช่น การเพิ่มวอลลุ่มให้กับผมด้านหลังหรือการเซ็ตให้ดูเรียบเก๋ ไม่ต้องดูแลมาก: การรักษาความยาวของผมด้านหลังไม่จำเป็นต้องบำรุงมากเหมือนกับผมด้านหน้า ทำให้การดูแลรักษาง่ายขึ้น \nเหมาะกับการจัดทรงสบายๆ: ทรง Mullet เป็นตัวเลือกที่ดีสำหรับผู้ที่ต้องการลุคที่ดูสบายๆ และไม่ต้องการความยุ่งยากในการจัดทรง",
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
