import 'package:almosan_mangement/control/database.dart';
import 'package:almosan_mangement/utilites/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:io';

import 'package:pdf/widgets.dart' as pw;
import 'package:file_picker/file_picker.dart';

class WorkIssueToday extends StatefulWidget {
  String date;
  String day;
  int index = 1;
  WorkIssueToday({super.key, required this.date, required this.day});

  @override
  State<WorkIssueToday> createState() => _WorkIssueTodayState();
}

// Function to copy the table data to the clipboard

class _WorkIssueTodayState extends State<WorkIssueToday> {
  List<dynamic>? data;

  Future<void> exportDataTableToPdf(BuildContext context) async {
    if (data!.isEmpty) {
      return;
    }

    final pdf = pw.Document();
    print("inside");

    final font = await rootBundle
        .load("asstes/fonts/Cairo/Cairo-VariableFont_slnt,wght.ttf");
    final ttf = pw.Font.ttf(font);

    print("after load font");

    final List<List> tableRows = data!
        .map((row) => [
              pw.Text("${row["created_at"]}",
                  textDirection: pw.TextDirection.rtl, style: pw.TextStyle()),
              pw.Text("${row["name"]}",
                  textDirection: pw.TextDirection.rtl,
                  style: pw.TextStyle(font: ttf)),
              pw.Text("${row["employes"]["employee_name"]}",
                  textDirection: pw.TextDirection.rtl,
                  style: pw.TextStyle(font: ttf)),
            ])
        .toList();

    pdf.addPage(pw.Page(build: (contrext) {
      // ignore: deprecated_member_use
      return pw.Table.fromTextArray(
        data: tableRows,
        headers: [
          pw.Text("التاريخ",
              textDirection: pw.TextDirection.rtl,
              style: pw.TextStyle(font: ttf)),
          pw.Text("الموقف",
              textDirection: pw.TextDirection.rtl,
              style: pw.TextStyle(font: ttf)),
          pw.Text("اسم المنتسب",
              textDirection: pw.TextDirection.rtl,
              style: pw.TextStyle(font: ttf)),
        ],
        cellAlignment: pw.Alignment.center,
        border: pw.TableBorder.all(width: 1),
      );
    }));
    print("after add pdf");
    // Save the PDF file
    final filePath = await FilePicker.platform.getDirectoryPath();
    final file = File('$filePath/exported_data.pdf');
    await file.writeAsBytes(await pdf.save());
  }

  final _database = Database();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: Icon(
                Icons.refresh,
                size: 30.0,
              ),
            ),
          ),
          // Add a button to copy the entire table
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
                icon: Icon(
                  Icons.save_alt,
                  size: 30.0,
                ),
                onPressed: () async {
                  await exportDataTableToPdf(context);
                }),
          ),
        ],
      ),
      body: FutureBuilder(
          future: _database.getInfoWorkTimeIssueBasedOnDate(widget.date),
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
                child: Column(
                  children: [
                    Text(errorMessage),
                    Text(
                        "هنالك خطأ حمل الصفحة من جديد وارسل صورة من الخطأ الى الدعم الفني"),
                  ],
                ),
              );
            }

            data = snapshot.data;

            if (data!.isEmpty) {
              return Center(
                child: Text(
                    "لاتوجد موقف ارجع الى الشاشة الرئسية وحمل الصفحة من جديد"),
              );
            }
            String date = data![0]["created_at"];
            // Extract unique dates
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          " ( ${widget.day} - $date)",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Text(
                          " موقف المنتسبين ",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 80.0),
                          child: DataTable(
                              border: TableBorder.all(),
                              columns: [
                                DataColumn(
                                  label: Text('اسم المنتسب '),
                                ),
                                DataColumn(
                                  label: Text('الموقف'),
                                ),
                                DataColumn(
                                  label: Text('تاريخ الموقف '),
                                ),
                              ],
                              rows: data!
                                  .map((e) => DataRow(cells: <DataCell>[
                                        DataCell(Text(e["employes"]
                                                ["employee_name"] ??
                                            "لايوجد")),
                                        DataCell(Text(e["name"])),
                                        DataCell(Text(e["created_at"])),
                                      ]))
                                  .toList()),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
