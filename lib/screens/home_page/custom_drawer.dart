import 'package:almosan_mangement/screens/all_employes_info.dart';
import 'package:almosan_mangement/utilites/custom_dialog.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          InkWell(
            child: ListTile(
              leading: Icon(Icons.logout),
              trailing: Text("المعلومات المنتسبن",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AllEmployes()));
            },
          ),
          InkWell(
            child: ListTile(
              leading: Icon(Icons.logout),
              trailing: Text("التبليغات",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey)),
            ),
            onTap: () {
              showCustomDialog(context, "لا تتوفر هذة الميزة حالياً",
                  cancalButtion: true);
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const SignIn()));
            },
          ),
          InkWell(
            child: ListTile(
              leading: Icon(Icons.logout),
              trailing: Text(" اضافة موقف",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey)),
            ),
            onTap: () {
              showCustomDialog(context, "لا تتوفر هذة الميزة حالياً",
                  cancalButtion: true);
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const SignIn()));
            },
          ),
        ],
      ),
    );
  }
}
