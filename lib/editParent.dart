import 'package:fallassist/danger.dart';
import 'package:fallassist/home.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class editParent extends StatefulWidget {
  editParent(
      {super.key, required this.name, required this.age, required this.city});
  final String name;
  final String age;
  final String city;

  @override
  State<editParent> createState() => editParentState();
}

class editParentState extends State<editParent> {
  // ignore: deprecated_member_use
  final databaseReference = FirebaseDatabase.instance.reference();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final Query condition = FirebaseDatabase.instance.ref().child('Condition');

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    cityController.dispose();
    super.dispose();
  }

  void initState() {
    nameController.text = widget.name;
    ageController.text = widget.age;
    cityController.text = widget.city;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor:
          Color.fromARGB(255, 17, 17, 17), // set color for status bar
    ));
    return StreamBuilder<DatabaseEvent>(
        stream: condition.onValue,
        builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (snapshot.data != null) {
            DataSnapshot data = snapshot.data!.snapshot;
            if (data.value.toString() == "ADL") {
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
                              child: appBar(),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 40, 0, 19),
                              child: Text(
                                "Tell me more \nabout your parent",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 200, 200, 200),
                                    fontFamily: 'Semi',
                                    letterSpacing: 0.5,
                                    fontSize: 22.5),
                              ),
                            ),
                            Container(
                              child: form(),
                            )
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

  appBar() {
    return Container(
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 17, 17, 17),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50))),
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RawMaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                constraints: const BoxConstraints(minWidth: 0),
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                },
                elevation: 0,
                child: const Align(
                  // menambahkan widget Align untuk membuat ikon menjadi tengah
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Color.fromARGB(255, 200, 200, 200),
                    size: 25,
                  ),
                ),
              ),
              const Text("Edit",
                  style: TextStyle(
                      fontFamily: 'Bold',
                      height: 1.5,
                      fontSize: 16,
                      letterSpacing: 0.75,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 200, 200, 200))),
              RawMaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                constraints: const BoxConstraints(minWidth: 0),
                onPressed: null,
                elevation: 0,
                child: const Align(
                  // menambahkan widget Align untuk membuat ikon menjadi tengah
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Color.fromARGB(255, 17, 17, 17),
                    size: 25,
                  ),
                ),
              ),
            ],
          )
        ]));
  }

  form() {
    return Container(
      margin: EdgeInsets.fromLTRB(25, 40, 25, 0),
      child: Column(children: [
        Container(
            margin: EdgeInsets.fromLTRB(0, 0, 230, 10),
            child: Text(
              'Full Name',
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Color.fromARGB(255, 200, 200, 200),
                  fontFamily: 'Semi',
                  letterSpacing: 0.75,
                  fontSize: 15),
            )),
        TextField(
          controller: nameController,
          maxLength: 50,
          style: TextStyle(
            color: Color.fromARGB(255, 200, 200, 200),
            fontFamily: 'Semi',
            fontSize: 14,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Color.fromARGB(255, 17, 17, 17),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 200, 200, 200), width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 200, 200, 200), width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: 'Enter the full name of your parent',
            hintStyle: TextStyle(
                color: Color.fromARGB(255, 200, 200, 200),
                fontFamily: 'Semi',
                fontSize: 14),
          ),
        ),
        Container(
            margin: EdgeInsets.fromLTRB(0, 10, 278, 10),
            child: Text(
              'Age',
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Color.fromARGB(255, 200, 200, 200),
                  fontFamily: 'Semi',
                  letterSpacing: 0.75,
                  fontSize: 15),
            )),
        TextField(
          controller: ageController,
          style: TextStyle(
            color: Color.fromARGB(255, 200, 200, 200),
            fontFamily: 'Semi',
            fontSize: 14,
          ),
          keyboardType: TextInputType.number,
          maxLength: 3,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color.fromARGB(255, 17, 17, 17),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 200, 200, 200), width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 200, 200, 200), width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: 'Enter the age of your parent',
            hintStyle: TextStyle(
                color: Color.fromARGB(255, 200, 200, 200),
                fontFamily: 'Semi',
                fontSize: 14),
          ),
        ),
        Container(
            margin: EdgeInsets.fromLTRB(0, 10, 277, 10),
            child: Text(
              'City',
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Color.fromARGB(255, 200, 200, 200),
                  fontFamily: 'Semi',
                  letterSpacing: 0.75,
                  fontSize: 15),
            )),
        TextField(
          controller: cityController,
          style: TextStyle(
            color: Color.fromARGB(255, 200, 200, 200),
            fontFamily: 'Semi',
            fontSize: 14,
          ),
          maxLength: 15,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color.fromARGB(255, 17, 17, 17),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 200, 200, 200), width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 200, 200, 200), width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: 'Enter the city of residence of your parent',
            hintStyle: TextStyle(
                color: Color.fromARGB(255, 200, 200, 200),
                fontFamily: 'Semi',
                fontSize: 14),
          ),
        ),
        Container(
            margin: EdgeInsets.fromLTRB(0, 170, 0, 0),
            child: ElevatedButton(
              onPressed: () {
                final String name = nameController.text.toString();
                final String age = ageController.text.toString();
                final String city = cityController.text.toString();

                if (name.isNotEmpty && age.isNotEmpty && city.isNotEmpty) {
                  databaseReference.child("name").set(name.toString());
                  databaseReference.child("age").set(age.toString());
                  databaseReference.child("city").set(city.toString());
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        backgroundColor: Color.fromARGB(255, 17, 17, 17),
                        title: Text(
                          'Complete Data',
                          style: TextStyle(
                              color: Color.fromARGB(255, 200, 200, 200),
                              fontFamily: 'Semi',
                              letterSpacing: 0.5,
                              fontSize: 14),
                        ),
                        content: Text(
                          'Please fill in all required data.',
                          style: TextStyle(
                              color: Color.fromARGB(255, 200, 200, 200),
                              fontFamily: 'Semi',
                              letterSpacing: 0.5,
                              fontSize: 14),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text(
                              'OK',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 200, 200, 200),
                                  fontFamily: 'Semi',
                                  fontSize: 14),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 136, 131, 240)),
                minimumSize: MaterialStateProperty.all<Size>(Size(267, 50)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              child: Text('Submit',
                  style: TextStyle(
                      letterSpacing: 0.25,
                      color: Colors.white,
                      fontSize: 16.0,
                      fontFamily: 'Bold')),
            ))
      ]),
    );
  }
}
