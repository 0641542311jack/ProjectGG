import 'package:barberapp/pages/booking.dart';
import 'package:barberapp/pages/hair.dart';
import 'package:barberapp/shop_owner/login_owner.dart';
import 'package:flutter/material.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 4, 37, 72),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 60, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Login_Owner()));
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
                              "images/user.png",
                              height: 85,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 1),
                            Text(
                              "ข้อมูลผู้ใช้งาน",
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
                                builder: (context) => Login_Owner()));
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
                              "images/edshop.png",
                              height: 85,
                              width: 130,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 1),
                            Text(
                              "ข้อมูลร้านผม",
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
                                builder: (context) => Login_Owner()));
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
                              "images/hair1.png",
                              height: 80,
                              width: 140,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 1),
                            Text(
                              "ข้อมูลทรงผม",
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
                                builder: (context) => Login_Owner()));
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
                              "ข้อมูลใบหน้า",
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
