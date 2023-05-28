import 'package:fallassist/danger.dart';
import 'package:fallassist/editParent.dart';
import 'package:fallassist/registerParent.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  final TextEditingController textController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final Query x = FirebaseDatabase.instance.ref().child('X');
  final Query y = FirebaseDatabase.instance.ref().child('Y');
  final Query z = FirebaseDatabase.instance.ref().child('Z');
  final Query note = FirebaseDatabase.instance.ref().child('Note');
  final Query condition = FirebaseDatabase.instance.ref().child('Condition');
  // ignore: deprecated_member_use
  final databaseReference = FirebaseDatabase.instance.reference();
  bool isLoading = true;

  @override
  void dispose() {
    textController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor:
          Color.fromARGB(255, 136, 131, 240), // set color for status bar
    ));
    return StreamBuilder<DatabaseEvent>(
        stream: condition.onValue,
        builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (snapshot.data != null) {
            DataSnapshot data = snapshot.data!.snapshot;
            if (data.value.toString() == "ADL") {
              SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
                statusBarColor: Color.fromARGB(
                    255, 136, 131, 240), // set color for status bar
              ));
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'FallAssist',
                  home: Scaffold(
                      backgroundColor: const Color.fromARGB(255, 17, 17, 17),
                      resizeToAvoidBottomInset: true,
                      body: GestureDetector(
                          onTap: () =>
                              FocusManager.instance.primaryFocus?.unfocus(),
                          child: SingleChildScrollView(
                              child: SafeArea(
                                  child: Center(
                                      child: Column(children: <Widget>[
                            Container(
                              child: parentProfile(),
                            ),
                            Container(
                              child: health(),
                            ),
                            Container(
                              child: angle(),
                            ),
                          ])))))));
            } else {
              return const Danger();
            }
          } else {
            SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
              statusBarColor:
                  Color.fromARGB(255, 17, 17, 17), // set color for status bar
            ));
            return Container(
                color: const Color.fromARGB(255, 17, 17, 17),
                child: Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                  size: 40,
                  color: Color.fromARGB(255, 136, 131, 240),
                )));
          }
        });
  }

  appBar(String name, String age, String city) {
    return Container(
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 136, 131, 240),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50))),
        padding: const EdgeInsets.fromLTRB(10, 5, 8, 0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RawMaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                constraints: const BoxConstraints(minWidth: 0),
                onPressed: () {
                  SystemNavigator.pop();
                },
                elevation: 0,
                child: const Align(
                  // menambahkan widget Align untuk membuat ikon menjadi tengah
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
              const Text("Parent Profile",
                  style: TextStyle(
                      fontFamily: 'Bold',
                      fontSize: 16,
                      height: 1.5,
                      letterSpacing: 0.75,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              RawMaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                constraints: const BoxConstraints(minWidth: 0),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            editParent(name: name, age: age, city: city)),
                  );
                },
                elevation: 0,
                child: const Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
            ],
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(0, 8, 0, 22),
              child: const CircleAvatar(
                radius: 45,
                backgroundImage: AssetImage('assets/img/profile.png'),
              )),
          Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
              child: Text(toBeginningOfSentenceCase(name).toString(),
                  maxLines: 1,
                  style: TextStyle(
                      fontFamily: 'Bold',
                      fontSize: 18,
                      letterSpacing: 0.25,
                      color: Colors.white))),
          Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 25),
              child: Text(
                  "${age} • ${toBeginningOfSentenceCase(city).toString()}",
                  maxLines: 1,
                  style: TextStyle(
                      fontFamily: 'Medium',
                      fontSize: 12,
                      letterSpacing: 0.75,
                      fontWeight: FontWeight.w800,
                      color: Colors.white))),
        ]));
  }

  appBarNoData() {
    return Container(
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 136, 131, 240),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50))),
        padding: const EdgeInsets.fromLTRB(10, 5, 8, 0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RawMaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                constraints: const BoxConstraints(minWidth: 0),
                onPressed: () {
                  SystemNavigator.pop();
                },
                elevation: 0,
                child: const Align(
                  // menambahkan widget Align untuk membuat ikon menjadi tengah
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
              const Text("Parent Profile",
                  style: TextStyle(
                      fontFamily: 'Bold',
                      fontSize: 16,
                      height: 1.5,
                      letterSpacing: 0.75,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              RawMaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                constraints: const BoxConstraints(minWidth: 0),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const registerParent()),
                  );
                },
                elevation: 0,
                child: const Align(
                    // menambahkan widget Align untuk membuat ikon menjadi tengah
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 25,
                    )),
              ),
            ],
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(0, 8, 0, 22),
              child: const CircleAvatar(
                radius: 45,
                backgroundImage: AssetImage('assets/img/profile.png'),
              )),
          Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
              child: const Text("Silly Senior Sage",
                  style: TextStyle(
                      fontFamily: 'Bold',
                      fontSize: 18,
                      letterSpacing: 0.25,
                      color: Colors.white))),
          Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 25),
              child: const Text("65 yrs • Elderburg",
                  style: TextStyle(
                      fontFamily: 'Medium',
                      fontSize: 12,
                      letterSpacing: 0.75,
                      fontWeight: FontWeight.w800,
                      color: Colors.white))),
        ]));
  }

  healthNoteData(String data) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 38, 43, 55),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(children: [
        Container(
            margin: const EdgeInsets.fromLTRB(5, 5, 0, 0),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              RawMaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                constraints: const BoxConstraints(minWidth: 0),
                onPressed: () {},
                elevation: 0,
                child: const Align(
                  // menambahkan widget Align untuk membuat ikon menjadi tengah
                  alignment: Alignment.center,
                  child: Icon(
                    // ignore: deprecated_member_use
                    Icons.favorite,
                    color: Color.fromARGB(255, 239, 132, 129),
                    size: 20,
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: const Text("Health Note",
                      style: TextStyle(
                          fontFamily: 'Bold',
                          fontSize: 16,
                          letterSpacing: 0.5,
                          color: Color.fromARGB(255, 239, 132, 129)))),
            ])),
        Container(
          margin: const EdgeInsets.fromLTRB(17, 0, 17, 0),
          child: Text(
            data.toString(),
            maxLines: 2,
            textAlign: TextAlign.justify,
            style: const TextStyle(
                fontFamily: 'Semi',
                fontSize: 14,
                height: 1.5,
                color: Color.fromARGB(255, 200, 200, 200)),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(18.5, 0, 2, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(DateFormat('dd-MM-yyyy').format(DateTime.now()).toString(),
                  style: const TextStyle(
                      fontFamily: 'Medium',
                      fontSize: 11,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w800,
                      color: Color.fromARGB(255, 200, 200, 200))),
              RawMaterialButton(
                constraints: const BoxConstraints(minWidth: 0),
                onPressed: () {
                  SystemChrome.setSystemUIOverlayStyle(
                      const SystemUiOverlayStyle(
                    statusBarColor: Color.fromARGB(
                        255, 62, 60, 110), // set color for status bar
                  ));
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor:
                              const Color.fromARGB(250, 17, 17, 17),
                          content: Stack(
                            clipBehavior: Clip.none,
                            children: <Widget>[
                              Positioned(
                                right: -40.0,
                                top: -40.0,
                                child: InkResponse(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    textController.clear();
                                  },
                                  child: const CircleAvatar(
                                    backgroundColor:
                                        Color.fromARGB(255, 239, 132, 129),
                                    child: Icon(
                                      Icons.close,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Form(
                                key: formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 15, 0, 0),
                                      child: TextField(
                                        style: const TextStyle(
                                            fontFamily: 'Regular',
                                            fontSize: 12,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                        maxLines: null,
                                        maxLength: 128,
                                        controller: textController,
                                        keyboardType: TextInputType.multiline,
                                        decoration: InputDecoration(
                                          focusColor: Colors.white,
                                          filled: true,
                                          fillColor: const Color.fromARGB(
                                              255, 38, 43, 55),
                                          hintText: 'Type your message here',
                                          hintStyle: TextStyle(
                                            color: Colors.grey.withOpacity(1),
                                            fontFamily: 'Bold',
                                            fontSize: 13,
                                            height: 1,
                                            letterSpacing: 0.5,
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide.none),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide.none,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Color.fromARGB(
                                                    255, 38, 43, 55)),
                                          ),
                                          suffixIcon: IconButton(
                                            icon: const Icon(
                                              Icons.send,
                                              size: 20,
                                              color: Color.fromARGB(
                                                  255, 136, 131, 240),
                                            ),
                                            onPressed: () async {
                                              if (textController.text
                                                  .toString()
                                                  .isNotEmpty) {
                                                databaseReference
                                                    .child("Note")
                                                    .set(textController.text);
                                                textController.clear();
                                                Navigator.of(context).pop();
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
                elevation: 0,
                child: const Align(
                  // menambahkan widget Align untuk membuat ikon menjadi tengah
                  alignment: Alignment.center,
                  child: Icon(
                    // ignore: deprecated_member_use
                    Icons.edit,
                    color: Color.fromARGB(255, 200, 200, 200),
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }

  healthNoteNoData() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 38, 43, 55),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(children: [
        Container(
            margin: const EdgeInsets.fromLTRB(5, 5, 0, 0),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              RawMaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                constraints: const BoxConstraints(minWidth: 0),
                onPressed: () {},
                elevation: 0,
                child: const Align(
                  // menambahkan widget Align untuk membuat ikon menjadi tengah
                  alignment: Alignment.center,
                  child: Icon(
                    // ignore: deprecated_member_use
                    Icons.favorite,
                    color: Color.fromARGB(255, 239, 132, 129),
                    size: 20,
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: const Text("Health Note",
                      style: TextStyle(
                          fontFamily: 'Bold',
                          fontSize: 16,
                          letterSpacing: 0.5,
                          color: Color.fromARGB(255, 239, 132, 129)))),
            ])),
        Container(
          margin: const EdgeInsets.fromLTRB(17, 0, 17, 0),
          child: const Text(
            "Use This for monitor the health of the elderly with a record of medical history",
            maxLines: 2,
            textAlign: TextAlign.justify,
            style: const TextStyle(
                fontFamily: 'Semi',
                fontSize: 14,
                height: 1.5,
                color: Color.fromARGB(255, 200, 200, 200)),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 5, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(DateFormat('dd-MM-yyyy').format(DateTime.now()).toString(),
                  style: const TextStyle(
                      fontFamily: 'Medium',
                      fontSize: 11,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w800,
                      color: Color.fromARGB(255, 200, 200, 200))),
              RawMaterialButton(
                constraints: const BoxConstraints(minWidth: 0),
                onPressed: () {
                  SystemChrome.setSystemUIOverlayStyle(
                      const SystemUiOverlayStyle(
                    statusBarColor: Color.fromARGB(
                        255, 62, 60, 110), // set color for status bar
                  ));
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor:
                              const Color.fromARGB(250, 17, 17, 17),
                          content: Stack(
                            clipBehavior: Clip.none,
                            children: <Widget>[
                              Positioned(
                                right: -40.0,
                                top: -40.0,
                                child: InkResponse(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    textController.clear();
                                  },
                                  child: const CircleAvatar(
                                    backgroundColor:
                                        Color.fromARGB(255, 239, 132, 129),
                                    child: Icon(
                                      Icons.close,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Form(
                                key: formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 15, 0, 0),
                                      child: TextField(
                                        style: const TextStyle(
                                            fontFamily: 'Regular',
                                            fontSize: 12,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                        maxLines: null,
                                        maxLength: 128,
                                        controller: textController,
                                        keyboardType: TextInputType.multiline,
                                        decoration: InputDecoration(
                                          focusColor: Colors.white,
                                          filled: true,
                                          fillColor: const Color.fromARGB(
                                              255, 38, 43, 55),
                                          hintText: 'Type your message here',
                                          hintStyle: TextStyle(
                                            color: Colors.grey.withOpacity(1),
                                            fontFamily: 'Bold',
                                            fontSize: 13,
                                            height: 1,
                                            letterSpacing: 0.5,
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide.none),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide.none,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Color.fromARGB(
                                                    255, 38, 43, 55)),
                                          ),
                                          suffixIcon: IconButton(
                                            icon: const Icon(
                                              Icons.send,
                                              size: 20,
                                              color: Color.fromARGB(
                                                  255, 136, 131, 240),
                                            ),
                                            onPressed: () async {
                                              if (textController.text
                                                  .toString()
                                                  .isNotEmpty) {
                                                databaseReference
                                                    .child("Note")
                                                    .set(textController.text);
                                                textController.clear();
                                                Navigator.of(context).pop();
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
                elevation: 0,
                child: const Align(
                  // menambahkan widget Align untuk membuat ikon menjadi tengah
                  alignment: Alignment.center,
                  child: Icon(
                    // ignore: deprecated_member_use
                    Icons.edit,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }

  health() {
    return StreamBuilder<DatabaseEvent>(
        stream: note.onValue,
        builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (snapshot.data?.snapshot.value != null) {
            DataSnapshot data = snapshot.data!.snapshot;
            return healthNoteData(data.value.toString());
          } else {
            return healthNoteNoData();
          }
        });
  }

  angle() {
    return Container(
        margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 38, 43, 55),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(children: [
          Container(
              margin: const EdgeInsets.fromLTRB(4, 5, 0, 0),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                RawMaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  constraints: const BoxConstraints(minWidth: 0),
                  onPressed: () {},
                  elevation: 0,
                  child: const Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.rotate_90_degrees_ccw,
                      color: Color.fromARGB(255, 0, 186, 136),
                      size: 20,
                    ),
                  ),
                ),
                const Text("Body Angle",
                    style: TextStyle(
                        fontFamily: 'Bold',
                        fontSize: 16,
                        letterSpacing: 0.5,
                        color: Color.fromARGB(255, 0, 186, 136))),
              ])),
          Container(
              margin: const EdgeInsets.fromLTRB(2, 4, 0, 13.5),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      child: firebaseRenderX(),
                    )),
                    Expanded(
                        child: Container(
                      child: firebaseRenderY(),
                    )),
                    Expanded(
                        child: Container(
                      child: firebaseRenderZ(),
                    )),
                  ])),
          Container(
            margin: const EdgeInsets.fromLTRB(17, 0, 18, 25),
            child: const Text(
                'Note : Data is measured in units of gravitational force.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontFamily: 'Medium',
                    fontSize: 11,
                    height: 1.5,
                    letterSpacing: 0.75,
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 200, 200, 200))),
          )
        ]));
  }

  firebaseRenderX() {
    return StreamBuilder<DatabaseEvent>(
        stream: x.onValue,
        builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (snapshot.data != null) {
            DataSnapshot data = snapshot.data!.snapshot;
            var value = double.parse(data.value.toString());
            return Column(children: [
              Text('X : ${value.toStringAsFixed(5)}',
                  style: const TextStyle(
                      fontFamily: 'Semi',
                      fontSize: 14,
                      letterSpacing: 0.25,
                      color: Color.fromARGB(255, 200, 200, 200)))
            ]);
          } else {
            return Column(children: const [
              Text('X : 0.00000 ',
                  style: TextStyle(
                      fontFamily: 'Semi',
                      fontSize: 14,
                      letterSpacing: 0.25,
                      color: Color.fromARGB(255, 200, 200, 200)))
            ]);
          }
        });
  }

  firebaseRenderY() {
    return StreamBuilder<DatabaseEvent>(
        stream: y.onValue,
        builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (snapshot.data != null) {
            DataSnapshot data = snapshot.data!.snapshot;
            var value = double.parse(data.value.toString());
            return Column(children: [
              Text('Y : ${value.toStringAsFixed(5)}',
                  style: const TextStyle(
                      fontFamily: 'Semi',
                      fontSize: 14,
                      letterSpacing: 0.25,
                      color: Color.fromARGB(255, 200, 200, 200)))
            ]);
          } else {
            return Column(children: const [
              Text('Y : 0.00000',
                  style: TextStyle(
                      fontFamily: 'Semi',
                      fontSize: 14,
                      letterSpacing: 0.25,
                      color: Color.fromARGB(255, 200, 200, 200)))
            ]);
          }
        });
  }

  firebaseRenderZ() {
    return StreamBuilder<DatabaseEvent>(
        stream: z.onValue,
        builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (snapshot.data != null) {
            DataSnapshot data = snapshot.data!.snapshot;
            var value = double.parse(data.value.toString());
            return Column(children: [
              Text('Z : ${value.toStringAsFixed(5)}',
                  style: const TextStyle(
                      fontFamily: 'Semi',
                      fontSize: 14,
                      letterSpacing: 0.25,
                      color: Color.fromARGB(255, 200, 200, 200)))
            ]);
          } else {
            return Column(children: const [
              Text('Z : 0.00000',
                  style: TextStyle(
                      fontFamily: 'Semi',
                      fontSize: 14,
                      letterSpacing: 0.25,
                      color: Color.fromARGB(255, 200, 200, 200)))
            ]);
          }
        });
  }

  parentProfile() {
    return StreamBuilder<DatabaseEvent>(
        stream: databaseReference.child('name').onValue,
        builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
            DataSnapshot name = snapshot.data!.snapshot;
            return StreamBuilder<DatabaseEvent>(
                stream: databaseReference.child('age').onValue,
                builder: (BuildContext context,
                    AsyncSnapshot<DatabaseEvent> snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data!.snapshot.value != null) {
                    DataSnapshot age = snapshot.data!.snapshot;
                    return StreamBuilder<DatabaseEvent>(
                        stream: databaseReference.child('city').onValue,
                        builder: (BuildContext context,
                            AsyncSnapshot<DatabaseEvent> snapshot) {
                          if (snapshot.hasData &&
                              snapshot.data!.snapshot.value != null) {
                            DataSnapshot city = snapshot.data!.snapshot;
                            return appBar(name.value.toString(),
                                age.value.toString(), city.value.toString());
                          } else {
                            return appBarNoData();
                          }
                        });
                  } else {
                    return appBarNoData();
                  }
                });
          } else {
            return appBarNoData();
          }
        });
  }
}
