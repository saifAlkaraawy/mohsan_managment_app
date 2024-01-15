import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EmployeeInfo extends StatelessWidget {
  Map info;
  EmployeeInfo({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0, right: 20.0),
            child: Text(
              "معلومات  الخادم",
              style: TextStyle(fontSize: 20.0),
            ),
          )
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "الاسم :",
                        style: TextStyle(fontSize: 21.0),
                      ),
                      Text(
                        "${info["employee_name"]}",
                        style: TextStyle(fontSize: 21.0),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.edit),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1.0,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "الرقم الوضيفي :",
                        style: TextStyle(fontSize: 21.0),
                      ),
                      Text(
                        "${info["employee_number"]}",
                        style: TextStyle(fontSize: 21.0),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.edit),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1.0,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "الوحدة  :",
                        style: TextStyle(fontSize: 21.0),
                      ),
                      Text(
                        "${info["group_name"]}",
                        style: TextStyle(fontSize: 21.0),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.edit),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1.0,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "وقت الدوام  :",
                        style: TextStyle(fontSize: 21.0),
                      ),
                      Text(
                        "${info["work_time"]}",
                        style: TextStyle(fontSize: 21.0),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.edit),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
