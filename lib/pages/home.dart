import 'package:barberapp/Camera/HomeScreen.dart';
import 'package:barberapp/pages/Camera.dart';
import 'package:barberapp/pages/UserProfilePage.dart';
import 'package:barberapp/pages/VDOHAIR.dart';
import 'package:barberapp/pages/booking.dart';
import 'package:barberapp/pages/booking_user.dart';
import 'package:barberapp/pages/hair.dart';
import 'package:barberapp/pages/login.dart';
import 'package:barberapp/pages/myface.dart';
import 'package:barberapp/pages/onboarding.dart';
import 'package:barberapp/pages/shop_user.dart';
import 'package:barberapp/pages/viewmap.dart';
import 'package:barberapp/services/shared_pref.dart';
import 'package:barberapp/shop_owner/edit_shop.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  get userId => null;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
      backgroundColor: Color.fromARGB(255, 4, 37, 72),
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
              // Add the Edit Profile Button

              SizedBox(height: 15),
              // Existing content
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
                                    Hairshow()));
                      },
                      child: Container(
                        height: 130,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 50, 83, 125),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.6),
                                spreadRadius: 5,
                                blurRadius: 20,
                                offset: Offset(0, 3),
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
                  SizedBox(width: 20),
                  Flexible(
                    fit: FlexFit.tight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Faceshow()));
                      },
                      child: Container(
                        height: 130,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 50, 83, 125),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.6),
                                spreadRadius: 5,
                                blurRadius: 20,
                                offset: Offset(0, 3),
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
              ),
              SizedBox(height: 15),
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
                                    Booking(service: 'Hair Cutting')));
                      },
                      child: Container(
                        height: 130,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 50, 83, 125),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.6),
                                spreadRadius: 5,
                                blurRadius: 20,
                                offset: Offset(0, 3),
                              )
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "images/hair_cutting.png",
                              height: 80,
                              width: 95,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 1),
                            Text(
                              "จองตัดผม",
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
                  SizedBox(width: 20.0),
                  Flexible(
                    fit: FlexFit.tight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Booking(service: 'Hair Washing')));
                      },
                      child: Container(
                        height: 130,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 50, 83, 125),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.6),
                                spreadRadius: 5,
                                blurRadius: 20,
                                offset: Offset(0, 3),
                              )
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "images/hair_washing.png",
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 1),
                            Text(
                              "จองสระผม",
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
              ),
              SizedBox(height: 15),
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
                                    Booking_User(service: 'ข้อมูลการจอง')));
                      },
                      child: Container(
                        height: 130,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 50, 83, 125),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.6),
                                spreadRadius: 5,
                                blurRadius: 20,
                                offset: Offset(0, 3),
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
                              "การจองของฉัน",
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
                  SizedBox(width: 20),
                  Flexible(
                    fit: FlexFit.tight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewMap()));
                      },
                      child: Container(
                        height: 130,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 50, 83, 125),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.6),
                                spreadRadius: 5,
                                blurRadius: 20,
                                offset: Offset(0, 3),
                              )
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "images/map.png",
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 1),
                            Text(
                              "ตำแหน่งร้าน",
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
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VDO(service: '')));
                      },
                      child: Container(
                        height: 120,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 50, 83, 125),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.6),
                                spreadRadius: 5,
                                blurRadius: 20,
                                offset: Offset(0, 3),
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
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShopViewer(),
                          ),
                        );
                      },
                      child: Container(
                        height: 120,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 50, 83, 125),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.6),
                                spreadRadius: 5,
                                blurRadius: 20,
                                offset: Offset(0, 3),
                              )
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "images/edshop.png",
                              height: 80,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 1),
                            Text(
                              "ข้อมูลร้าน",
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
              ),
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
                            builder: (context) => HomeScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: 120,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 50, 83, 125),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.6),
                                spreadRadius: 5,
                                blurRadius: 20,
                                offset: Offset(0, 3),
                              )
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "images/Camera.png",
                              height: 80,
                              width: 140,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 1),
                            Text(
                              "เลือกทรงผม",
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
                  SizedBox(width: 20,),
                  Flexible(
                    fit: FlexFit.tight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Onboarding(),
                          ),
                        );
                      },
                      child: Container(
                        height: 120,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 50, 83, 125),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.6),
                                spreadRadius: 5,
                                blurRadius: 20,
                                offset: Offset(0, 3),
                              )
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "images/signout.png",
                              height: 80,
                              width: 160,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 1),
                            Text(
                              "ออกจากระบบ",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
