import 'package:flutter/material.dart';

class Myface extends StatefulWidget {
  String service;
  Myface({required this.service});

  @override
  State<Myface> createState() => _MyfaceState();
}

class _MyfaceState extends State<Myface> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 50, 83, 125),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 40, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios_new_outlined,
                      color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Image.asset(
                    "images/myface_oblong.png",
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "1.หน้ายาว (Oblong)",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Color.fromARGB(255, 2, 5, 96)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "รูปหน้าแบบนี้จะมีลักษณะคล้ายสี่เหลี่ยมผืนผ้าแนวตั้ง ความยาวจากหน้าผากถึงปลายคางจะมากที่สุด ความกว้างของหน้าผาก โหนกแก้ม แนวกรามจะมีขนาดเกือบเท่ากัน",
                    style: TextStyle(fontSize: 13,color: Colors.white)),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "ทรงผมสำหรับคนหน้ายาว",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Color.fromARGB(255, 2, 5, 96)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "ใบหน้าทรงยาวสิ่งสำคัญคือต้องหลีกเลี่ยงทรงผมที่ด้านข้างสั้น ๆ เพราะจะทำให้ใบหน้ายิ่งดูแคบลง และทรงผมสไตล์สูง ด้านบนยาวๆเพราะจะยิ่งทำให้หน้าดูยาวขึ้นลองเลือกทรงผมที่ช่วยให้ผมตกลงมาด้านข้าง หรือปิดหน้าผากเพื่อเพิ่มความกว้างของใบหน้าทรงผมที่เกิดมาเพื่อชายชาวเอเชียอย่าง Comma และ Two block ช่วยปกปิดความยาวของใบหน้าได้อย่างเห็นผล",
                    style: TextStyle(fontSize: 13,color: Colors.white)),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  color: Colors.black, //เส้น
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Image.asset(
                    "images/myface_square.png",
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "2.หน้าเหลี่ยม (Square)",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Color.fromARGB(255, 2, 5, 96)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "รูปหน้าแบบนี้จะมีลักษณะคล้ายสี่เหลี่ยมจัตุรัส ความยาวและความกว้างของใบหน้าจะเท่ากันทั้ง 4 ด้าน หน้าผากโหนกแก้มแนวกรามจะมีความกว้างเท่ากันทั้งหมด แนวกรามมีมุมเหลี่ยมอย่างชัดเจน",
                    style: TextStyle(fontSize: 13,color: Colors.white)),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "ทรงผมสำหรับคนหน้าเหลี่ยม",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Color.fromARGB(255, 2, 5, 96)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "ใบหน้าทรงเหลี่ยมมีลักษณะเด่นคือทุกส่วนบนหน้าจะมีความกว้างเท่ากัน ทั้งหน้าผากแก้มกรามควรตัดทรงผมที่ช่วยให้ใบหน้าดูยาวขึ้น และทำให้ดูหน้ากลมมากขึ้น เน้นความสูงและด้านข้างสั้น หลีกเลี่ยงทรงที่ด้านข้างหนาๆหรือบานออกเพราะจะยิ่งทำให้หน้าดูกว้างขึ้นใบหน้าทรงนี้ตัดได้ทั้งทรงผมสั้นเท่ ๆ อย่าง Fade, Undercut, Fringe, French crop ไปจนถึงทรงผมสไตล์สูง ๆ อย่าง Pompadour และ Quiff หรืออยากโชว์โครงหน้าคมกริบแบบชัด ๆ ทรงอย่าง Buzz cut หรือ Crew cut ก็เป็นอีกทางเลือกที่น่าสนใจไม่น้อย",
                    style: TextStyle(fontSize: 13,color: Colors.white)),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  color: Colors.black, //เส้น
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Image.asset(
                    "images/myface_oval.png",
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "3.หน้ารูปไข่ (Oval)",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Color.fromARGB(255, 2, 5, 96)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "รูปหน้าแบบนี้จะมีความยาวใบหน้ามากกว่าความกว้างของโหนกแก้ม หน้าผากจะมีความกว้างกว่ากราม แนวกรามจะมีความโค้ง ปลายคางเล็ก",
                    style: TextStyle(fontSize: 13,color: Colors.white)),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "ทรงผมสำหรับคนหน้ารูปไข่",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Color.fromARGB(255, 2, 5, 96)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "หน้ารูปไข่อาจไม่ใช่รูปหน้าส่วนใหญ่ของผู้ชาย แต่ถ้าใครมีรูปหน้าทรงนี้คือโคตรโชคดีเพราะเป็นรูปทรงหน้าที่ได้สัดส่วนและเหมาะกับทรงผมแทบทุกแบบ ทรงสั้น ทรงยาว ทรงเตี้ย ทรงสูง ทรงคลาสสิกวินเทจ สามารถลองได้หมดแล้วแต่เทรนด์และสไตล์การแต่งตัวอย่างไรก็ตามมีคำแนะนำเล็กๆน้อยสำหรับผู้ชายใบหน้าทรงนี้คือไว้ผมปิดหน้าผากเล็กน้อยเพื่อสร้างวอลลุ่มให้ดูมีดีเทลน่ามองยิ่งขึ้นและถ้าต้องการทรงที่เหล่าช่างผมชั้นนำมองว่าเหมาะสมที่สุดคือทรงผมสไตล์ข้างสั้น-หลังสั้น หน้าไว้ยาวพอประมาณสำหรับการเซ็ตในรูแบบต่าง ๆ Slick back, Brush back, Comb over, Side part, Side swept, Quiff, Pompadour",
                    style: TextStyle(fontSize: 13,color: Colors.white)),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  color: Colors.black, //เส้น
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Image.asset(
                    "images/myface_round.png",
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "4.หน้ากลม (Round)",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Color.fromARGB(255, 2, 5, 96)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "รูปหน้าแบบนี้ ความยาวใบหน้าและโหนกแก้มจะมีขนาดใกล้เคียงกันความกว้างของหน้าผากและกรามใกล้เคียงกันแนวกรามก็มีความโค้งกลมที่มากกว่าหน้ารูปไข่",
                    style: TextStyle(fontSize: 13,color: Colors.white)),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "ทรงผมสำหรับคนหน้ากลม",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Color.fromARGB(255, 2, 5, 96)),
                  ),
                ),
                Text(
                    "ใบหน้าทรงกลมที่มีคางมนและแนวกรามที่ไม่มีเส้นหรือมุมที่ชัดเจนจน บางครั้งอาจดูหน้าอ้วนหรือเจ้าเนื้อ จำเป็นต้องสร้างภาพลวงตาด้วยทรงผมที่ช่วยให้ใบหน้าดูยาวขึ้นหรือพรางให้หน้าดูมีเหลี่ยมมีมุมมากขึ้น หลีกเลี่ยงทรงผมที่มีด้านข้างหนา ๆ ดูเทอะทะ เพราะนั่นจะทำให้ใบหน้ายิ่งดูกลมเข้าไปอีกหน้าทรงนี้เหมาะกับทรงผมสไตล์สูง ๆ ด้านข้างเตียน ๆ เช่น French crop, Pompadour, Fringe, Quiff, Brush Back, Comb Over ซึ่งทรงเหล่านี้พื้นฐานมาจากการตัด undercut หรือ Fade แล้วจะใช้การเซ็ตให้สูงดูมีเลเยอร์ หรือจะหักดิบด้วยทรง Flat Top สไตล์อเมริกันได้ดูไม่ซ้ำใครในยุคนี้",
                    style: TextStyle(fontSize: 13,color: Colors.white)),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  color: Colors.black, //เส้น
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Image.asset(
                    "images/myface_diamond.png",
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "5.หน้ารูปเพชร (Diamond)",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Color.fromARGB(255, 2, 5, 96)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "รูปหน้าแบบนี้จะมีลักษะหน้าผากแคบ โหนกแก้มกว้างที่สุด กรามแคบและลู่เข้าหาปลายคาง",
                    style: TextStyle(fontSize: 13,color: Colors.white)),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "ทรงผมสำหรับคนหน้ารูปเพชร",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Color.fromARGB(255, 2, 5, 96)),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "ช่วงคางและหน้าผากแคบ โหนกแก้มกว้าง ทรงหน้ารูปเพชรหนึ่งในรูปหน้าที่หายากสำหรับผู้ชาย ด้วยเหตุนี้ทรงผมที่เพิ่มความกว้างบริเวณหน้าผากจึงเป็นตัวเลือกที่เข้าท่าเพื่อเป็นการเพิ่มมิติให้กับใบหน้าโดยรวม ขณะเดียวกันก็ยังสามารถไว้ผมยาวแล้วทัดหูเพื่อโชว์กรอบหน้าคม ๆ ได้เช่นกัน อย่างไรก็ตาม อย่าเลือกทรงที่ด้านข้างสั้นเกินไปเนื่องจากจะทำให้ช่วงใบหูและโหนกแก้มดูกว้างขึ้นทรงผมที่เหมาะกับใบหน้ารูปเพชรมีหลายทรง Men Merge ขอแนะนำทรงผมยาว ๆ เซอร์ ๆ เป็นทางเลือก เช่น ทรงยุ่ง ๆ สไตล์ Messy hair เน้นเซ็ตให้ผมมีเลเยอร์ ทรงรากไทรเท่ ๆ อย่าง Mullet ก็ตัดได้ รวมถึงทรงเพื่อชายชาวเอเชียอย่าง Two block ก็ตัดได้เช่นกัน หรือจะเซอร์ให้สุดกับทรง Man bun ก็เท่ดีเหมือนกัน",
                    style: TextStyle(fontSize: 13,color: Colors.white)),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  color: Colors.black, //เส้น
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Image.asset(
                    "images/myface_triangle.png",
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                  child: Text(
                    "6.หน้ารูปสามเหลี่ยม (Triangle)",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Color.fromARGB(255, 2, 5, 96)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "รูปหน้าแบบนี้หน้าผากจะแคบที่สุด โหนกแก้มกว้างขึ้น และมีกรามกว้างที่สุด คางสั้น",
                    style: TextStyle(fontSize: 13,color: Colors.white)),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "ทรงผมสำหรับคนหน้ารูปสามเหลี่ยม",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Color.fromARGB(255, 2, 5, 96)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "เนื่องจากหน้าผากแคบและแนวกรามที่กว้าง ใบหน้ารูปสามเหลี่ยมจึงเหมาะกับทรงผมที่มีวอลลุ่มและมีด้านข้างที่ยาวสักเล็กน้อยเพื่อช่วยเพิ่มความกว้างให้กับช่วงหน้าผากและลดความแหลมของรูปสามเหลี่ยม ทรงผมที่ตัดด้านข้างสั้นเตียนไม่ค่อยเหมาะกับรูปหน้าแบบนี้ ทรงที่เหมาะกับใบหน้าสามเหลี่ยมมีหลายทรง เริ่มจากทรงง่าย ๆ อย่างรองทรง เลือกตัดได้ทั้งต่ำและสูง เช่นเดียวกับ Fade ที่ตัดได้ทั้ง Low, Medium, High ทรงอย่าง French crop, Fringe รวมถึง Pompadour และ Quiff ก็สามารถตัดได้เช่นกัน โดยเน้นวอลลุ่มให้ดูมีชั้นผมที่ด้านหน้า",
                    style: TextStyle(fontSize: 13,color: Colors.white)),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  color: Colors.black, //เส้น
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Image.asset(
                    "images/myface_heart.png",
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "7.หน้ารูปหัวใจ (Heart)",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Color.fromARGB(255, 2, 5, 96)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "รูปหน้าแบบนี้หน้าผากจะกว้าง โหนกแก้มโค้งมน แนวกรามแคบกว่าโหนกแก้ม และมีคางเล็ก",
                    style: TextStyle(fontSize: 13,color: Colors.white)),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "ทรงผมสำหรับคนหน้ารูปหัวใจ",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Color.fromARGB(255, 2, 5, 96)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "หน้าผากกว้างและค่อยๆ แคบลงจนถึงคาง ใบหน้ารูปหัวใจเป็นอีกหนึ่งรูปหน้าที่หาได้ยากในผู้ชาย แนะนำให้หลีกเลี่ยงทรงผมที่มีด้านข้างหนา ๆ ยาว ๆ เพราะจะเป็นการเน้นให้เห็นความแคบของคางและความกว้างของหน้าผากชัดขึ้นควรเลือกทรงที่มีความยาวปานกลาง เน้นซอยให้บางและดูมีวอลลุ่ม สามารถเซ็ตให้ผมสูงขึ้นด้านบน หรือเสยไปด้านหลังเพื่อโชว์กรอบหน้ารูปหัวใจชัด ๆ ได้ใบหน้ารูปหัวใจสามารถตัดสั้นได้หลายทรง อาทิ Fade, Undercut, รวมถึงทรงวินเทจอย่าง Slick back, Brush Back, Side part, Quiff, Pompadour การไว้เคราช่วยปกปิดความแคบของกรามและคางได้ ช่วยให้ใบหน้าโดยรวมดูเต็มมากขึ้น",
                    style: TextStyle(fontSize: 13,color: Colors.white)),
                    SizedBox(
                height: 20,
              ),
              Divider(
                color: Colors.black, //เส้น
              ),
              ],
            ),
          ),
        ));
  }
}
