import 'package:fallassist/home.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class Danger extends StatefulWidget {
  const Danger({super.key});

  @override
  State<Danger> createState() => DangerState();
}

class DangerState extends State<Danger> {
  // ignore: deprecated_member_use
  final databaseReference = FirebaseDatabase.instance.reference();
  final String phoneNumber = '911';
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor:
          Color.fromARGB(255, 17, 17, 17), // set color for status bar
    ));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FallAssist',
        home: Scaffold(
            bottomNavigationBar: BottomAppBar(
              color: Color.fromARGB(255, 17, 17, 17),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: null,
                    icon: Icon(Icons.warning,
                        color: Color.fromARGB(255, 17, 17, 17)),
                  ),
                  // Your other bottom app bar content goes here
                ],
              ),
            ),
            floatingActionButton: SizedBox(
              width: 200.0,
              child: FloatingActionButton(
                elevation: 2.0,
                backgroundColor: Color.fromARGB(255, 239, 132, 129),
                onPressed: () => makePhoneCall(phoneNumber),
                child: Icon(Icons.sos),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            backgroundColor: const Color.fromARGB(255, 17, 17, 17),
            resizeToAvoidBottomInset: true,
            body: GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: SingleChildScrollView(
                    child: SafeArea(
                        child: Center(
                            child: Container(
                                color: Color.fromARGB(255, 17, 17, 17),
                                child: Container(
                                    height:
                                        (MediaQuery.of(context).size.height),
                                    width: (MediaQuery.of(context).size.width),
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            AssetImage('assets/img/fall.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Container(
                                              decoration: const BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 17, 17, 17),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  50))),
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 5, 50, 0),
                                              child: Column(children: [
                                                Row(
                                                  children: [
                                                    RawMaterialButton(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                      constraints:
                                                          const BoxConstraints(
                                                              minWidth: 0),
                                                      onPressed: () async {
                                                        databaseReference
                                                            .child("Condition")
                                                            .set("ADL");
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const Home()),
                                                        );
                                                      },
                                                      elevation: 0,
                                                      child: const Align(
                                                        // menambahkan widget Align untuk membuat ikon menjadi tengah
                                                        alignment:
                                                            Alignment.center,
                                                        child: Icon(
                                                          Icons.arrow_back_ios,
                                                          color: Color.fromARGB(
                                                              255,
                                                              200,
                                                              200,
                                                              200),
                                                          size: 25,
                                                        ),
                                                      ),
                                                    ),
                                                    const Text(
                                                        "Everything is fine?",
                                                        style: TextStyle(
                                                            fontFamily: 'Bold',
                                                            fontSize: 16,
                                                            height: 1.5,
                                                            letterSpacing: 0.75,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    200,
                                                                    200,
                                                                    200))),
                                                    RawMaterialButton(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                      constraints:
                                                          const BoxConstraints(
                                                              minWidth: 0),
                                                      onPressed: null,
                                                      elevation: 0,
                                                      child: const Align(
                                                        // menambahkan widget Align untuk membuat ikon menjadi tengah
                                                        alignment:
                                                            Alignment.center,
                                                        child: Icon(
                                                          Icons.arrow_back_ios,
                                                          color: Color.fromARGB(
                                                              255, 17, 17, 17),
                                                          size: 25,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ])),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                20, 45, 20, 0),
                                            child: Text(
                                              "WARNING",
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontFamily: 'Bold',
                                                  fontSize: 42.5,
                                                  letterSpacing: 1,
                                                  color: Color.fromARGB(
                                                      255, 239, 132, 129)),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                15, 375, 15, 0),
                                            child: Text(
                                              "Fall has been detected. If you need emergency assistance, please press the emergency button or call for help immediately.",
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontFamily: 'Bold',
                                                  fontSize: 14,
                                                  height: 1.5,
                                                  letterSpacing: 1,
                                                  color: Color.fromARGB(
                                                      255, 200, 200, 200)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )))))))));
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
