import 'package:barberapp/pages/UserProfilePage.dart';
import 'package:barberapp/pages/VDOHAIR.dart';
import 'package:barberapp/pages/booking_user.dart';
import 'package:barberapp/pages/hair.dart';
import 'package:barberapp/pages/myface.dart';
import 'package:barberapp/services/shared_pref.dart';
import 'package:barberapp/shop_owner/booking_owner.dart';
import 'package:flutter/material.dart';

class Home_owner extends StatefulWidget {
  const Home_owner({super.key});

  @override
  State<Home_owner> createState() => _Home_ownerState();
}

class _Home_ownerState extends State<Home_owner> {
  String? name, image;

  Future<void> getthedatafromsharedpref() async {
    name = await SharedpreferenceHelper().getUserName();
    image = await SharedpreferenceHelper().getUserImage();
    setState(() {});
  }

  Future<void> getontheload() async {
    await getthedatafromsharedpref();
  }

  @override
  void initState() {
    super.initState();
    getontheload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 37, 72),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello",
                        style: TextStyle(
                            color: Color.fromARGB(197, 255, 255, 255),
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        name ?? 'Guest',
                        style: TextStyle(
                            color: Color.fromARGB(197, 255, 255, 255),
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfile()),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: image != null
                          ? Image.network(
                              image!,
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              height: 60,
                              width: 60,
                              color: Colors.grey,
                              child: Icon(Icons.person, color: Colors.white),
                            ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Divider(color: Colors.white30),
              SizedBox(height: 5),
              Text(
                "Services",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Row(children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BookingOwner(service: 'ข้อมูลการจอง')));
                    },
                    child: Container(
                      height: 130,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 50, 83, 125),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.6), // สีของเงา
                              spreadRadius: 5, // การกระจายของเงา
                              blurRadius: 20, // การเบลอของเงา
                              offset: Offset(0, 3), // ตำแหน่งของเงา
                            )
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/booking.png",
                            height: 80,
                            width: 110,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 1),
                          Text(
                            "การจองของลูกค้า",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
              SizedBox(height: 15,),
              Row(children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Hair(service: 'แนะนำทรงผม')));
                    },
                    child: Container(
                      height: 130,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 50, 83, 125),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.6), // สีของเงา
                              spreadRadius: 5, // การกระจายของเงา
                              blurRadius: 20, // การเบลอของเงา
                              offset: Offset(0, 3), // ตำแหน่งของเงา
                            )
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/hair1.png",
                            height: 80,
                            width: 135,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 1),
                          Text(
                            "แนะนำทรงผม",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
              SizedBox(height: 15,),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Myface(service: "แนะนำโครงหน้า")));
                      },
                      child: Container(
                        height: 130,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 50, 83, 125),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    Colors.black.withOpacity(0.6), // สีของเงา
                                spreadRadius: 5, // การกระจายของเงา
                                blurRadius: 20, // การเบลอของเงา
                                offset: Offset(0, 3), // ตำแหน่งของเงา
                              )
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "images/face.png",
                              height: 80,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 1),
                            Text(
                              "แนะนำโครงหน้า",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),SizedBox(height: 15,),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    VDO(service: '')));
                      },
                      child: Container(
                        height: 120,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 50, 83, 125),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    Colors.black.withOpacity(0.6), // สีของเงา
                                spreadRadius: 5, // การกระจายของเงา
                                blurRadius: 20, // การเบลอของเงา
                                offset: Offset(0, 3), // ตำแหน่งของเงา
                              )
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "images/VDO_hair.png",
                              height: 80,
                              width: 160,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 1),
                            Text(
                              "คลิปสอนตัดผม",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
