import 'package:almosan_mangement/control/database.dart';
import 'package:almosan_mangement/screens/emoloyee_info.dart';
import 'package:almosan_mangement/utilites/custom_color%20copy.dart';
import 'package:flutter/material.dart';

class AllEmployes extends StatefulWidget {
  const AllEmployes({super.key});

  @override
  State<AllEmployes> createState() => _AllEmployesState();
}

class _AllEmployesState extends State<AllEmployes> {
  final _database = Database();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0, right: 20.0),
          child: Text(
            "جميع المنتسبين",
            style: TextStyle(fontSize: 20.0),
          ),
        )
      ]),
      body: FutureBuilder(
          future: _database.getEmployesInfo(),
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
            print(data);
            return GridView.builder(
                itemCount: data!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        hoverColor: kpramiryColor,
                        borderRadius: BorderRadius.circular(70),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EmployeeInfo(
                                        info: data[index],
                                      )));
                        },
                        child: CircleAvatar(
                            backgroundColor: Colors.white,
                            maxRadius: 100.0,
                            minRadius: 60.0,
                            backgroundImage: data[index]["profile_image"] !=
                                    null
                                ? NetworkImage(
                                    "${data[index]['profile_image']}")
                                : AssetImage(
                                        "asstes/images/profileimageBackround.png")
                                    as ImageProvider),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${data[index]["employee_name"]}",
                        style: TextStyle(fontSize: 20.0, fontFamily: "Cairo"),
                      )
                    ],
                  );
                });
          }),
    );
  }
}
