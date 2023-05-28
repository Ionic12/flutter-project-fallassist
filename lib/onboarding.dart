import 'package:fallassist/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter/material.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor:
          Color.fromARGB(255, 17, 17, 17), // set color for status bar
    ));
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 17, 17, 17),
            resizeToAvoidBottomInset: false,
            body: OnBoardingSlider(
              finishButtonText: 'Start Now',
              finishButtonStyle: const FinishButtonStyle(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  backgroundColor: Color.fromARGB(255, 136, 131, 240)),
              finishButtonTextStyle: const TextStyle(
                  letterSpacing: 0.25,
                  color: Colors.white,
                  fontSize: 16.0,
                  fontFamily: 'Bold'),
              onFinish: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const Home(),
                  ),
                );
              },
              skipTextButton: const Text(
                'Skip',
                style: TextStyle(
                  fontSize: 14.5,
                  color: Color.fromARGB(255, 200, 200, 200),
                  fontFamily: 'Semi',
                ),
              ),
              trailing: null,
              trailingFunction: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const Home(),
                  ),
                );
              },
              controllerColor: const Color.fromARGB(255, 136, 131, 240),
              totalPage: 3,
              headerBackgroundColor: const Color.fromARGB(255, 17, 17, 17),
              pageBackgroundColor: const Color.fromARGB(255, 17, 17, 17),
              background: [
                Image.asset(
                  'assets/img/onboarding-1.png',
                  height: 500,
                  width: 360,
                ),
                Image.asset(
                  'assets/img/onboarding-2.png',
                  height: 500,
                  width: 360,
                ),
                Image.asset(
                  'assets/img/onboarding-3.png',
                  height: 500,
                  width: 360,
                ),
              ],
              speed: 5,
              pageBodies: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const <Widget>[
                      SizedBox(
                        height: 480,
                      ),
                      Text(
                        'Stay Safe and Secure',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            letterSpacing: 1,
                            fontSize: 18.0,
                            fontFamily: 'Bold'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Our app detects falls with IoT sensors and sends an alert to emergency contacts. Stay secure with peace of mind.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromARGB(255, 200, 200, 200),
                            fontSize: 14.5,
                            height: 1.3,
                            fontFamily: 'Semi'),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const <Widget>[
                      SizedBox(
                        height: 480,
                      ),
                      Text(
                        ' Stay Active and Connected',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            letterSpacing: 1,
                            fontSize: 18.0,
                            fontFamily: 'Bold'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Tracking daily activity, setting medication reminders, and monitoring with family can provide the needed support.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromARGB(255, 200, 200, 200),
                            fontSize: 14.5,
                            height: 1.3,
                            fontFamily: 'Semi'),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const <Widget>[
                      SizedBox(
                        height: 480,
                      ),
                      Text(
                        'Easy and Reliable',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            letterSpacing: 1,
                            fontSize: 18.0,
                            fontFamily: 'Bold'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Download the app and stay safe. Accurate detection with seamless IoT integration. Easy to use for your safety and well-being.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromARGB(255, 200, 200, 200),
                            fontSize: 14.5,
                            height: 1.3,
                            fontFamily: 'Semi'),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
