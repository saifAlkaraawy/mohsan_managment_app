import 'package:almosan_mangement/control/database.dart';
import 'package:almosan_mangement/screens/home_page/custom_drawer.dart';
import 'package:almosan_mangement/screens/work_issue_today.dart';
import 'package:almosan_mangement/utilites/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String nameOfDayInArabic(String dayName) {
    switch (dayName) {
      case "Saturday":
        {
          return "السبت";
        }

      case "Sunday":
        {
          return "الاحد";
        }

      case "Monday":
        {
          return "الاثنين";
        }
      case "Tuesday":
        {
          return "الثلاثاء";
        }

      case "Wednesday":
        {
          return "الاربعاء";
        }
      case "Thursday":
        {
          return "الخميس";
        }
      case "Friday":
        {
          return "الجمعة";
        }

      default:
        {
          return "";
        }
    }
  }

  List<String> uniqueDates = [];

  final _database = Database();
  @override
  Widget build(BuildContext context) {
    // jj();
    // _database.signOut();
    // _database.signIn("ss@ss.com", "123");
    return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: Icon(Icons.refresh))
          ],
          centerTitle: true,
          title: Text(
            "اداريات مركز المحسن",
            style: TextStyle(fontFamily: "Cairo", fontSize: 25.0),
          ),
        ),
        body: FutureBuilder(
            future: _database.getInfoWorkTimeIssuDate(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                final dynamic error = snapshot.error;
                String errorMessage;
                errorMessage = "error is $error";
                return Center(
                  child: Text(errorMessage),
                );
              }
              final data = snapshot.data;

              List<String> uniqueDates = List.from(
                {for (var item in data!) item["created_at"]},
              );

              return ListView.builder(
                  itemCount: uniqueDates.length,
                  itemBuilder: (context, index) {
                    final created_at = uniqueDates[index];
                    final dayName =
                        DateFormat('EEEE').format(DateTime.parse(created_at));
                    return InkWell(
                      onHover: (value) {},
                      hoverColor: cardColors[Random().nextInt(3)],
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WorkIssueToday(
                                date: created_at,
                                day: nameOfDayInArabic(dayName.toString()),
                              ),
                            ));
                      },
                      child: Card(
                        child: SizedBox(
                          height: 200.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                created_at,
                                style: TextStyle(fontSize: 20.0),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                nameOfDayInArabic(dayName.toString()),
                                style: TextStyle(
                                    fontSize: 15.0, fontFamily: 'ArabicFont'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }));
  }
}
