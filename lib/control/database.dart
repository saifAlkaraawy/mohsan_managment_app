import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class Database {
  final supabase = Supabase.instance.client;
  Future<List<Map<String, dynamic>>> fetchDataFromTables() async {
    try {
      final response = await supabase
          .from('work_time_issue')
          .select('id, name ,created_at, employes(id,employee_name)')
          .execute();

      print("8888888888888888888888888888888888888888888888888888888");
      print(response.data);
      print("8888888888888888888888888888888888888888888888888888888");
      if (response.data != null && response.data is List) {
        return List<Map<String, dynamic>>.from(response.data as List);
      } else {
        throw 'Unknown error occurred';
      }
    } catch (e) {
      print('Error fetching work info: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getInfoWorkTimeIssueBasedOnDate(
      String date) async {
    try {
      final response = await supabase
          .from('work_time_issue')
          .select('id, name ,created_at, employes(id,employee_name)')
          .eq("created_at", "$date")
          .execute();

      print("8888888888888888888888888888888888888888888888888888888");
      print(response.data);
      print("8888888888888888888888888888888888888888888888888888888");
      if (response.data != null && response.data is List) {
        return List<Map<String, dynamic>>.from(response.data as List);
      } else {
        throw 'Unknown error occurred';
      }
    } catch (e) {
      print('Error fetching work info: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getInfoWorkTimeIssuDate() async {
    try {
      final response = await supabase
          .from("work_time_issue")
          .select("created_at,id")
          .order("created_at")
          // ignore: deprecated_member_use
          .execute();
      // print("8888888888888888888888888888888888888888888888888888888");
      // print(response.data);
      // print("8888888888888888888888888888888888888888888888888888888");
      if (response.data != null && response.data is List) {
        return List<Map<String, dynamic>>.from(response.data as List);
      } else {
        throw 'Unknown error occurred';
      }
    } catch (e) {
      print('Error fetching work info: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getEmployesInfo() async {
    try {
      final response = await supabase
          .from("employes")
          .select(
              "employee_name,work_time,employee_number,group_name,profile_image")
          // ignore: deprecated_member_use
          .execute();
      print("555555555555555555555555555555555555555555555");
      print(response);
      print("555555555555555555555555555555555555555555555");
      if (response.data != null && response.data is List) {
        return List<Map<String, dynamic>>.from(response.data as List);
      } else {
        throw 'Unknown error occurred';
      }
    } catch (e) {
      print('Error fetching work info: $e');
      rethrow;
    }
  }

  String getCurrentAuthUserID() {
    String auth_id = supabase.auth.currentUser!.id;

    return auth_id;
  }

  Future<void> insertEmployeeInfo(
      {required String name,
      required String workTime,
      required String employeeNumber,
      required String groupName,
      required String profileImage}) async {
    String authId = getCurrentAuthUserID();

    await supabase.from("employes").insert({
      'employee_name': name,
      'work_time': workTime,
      'auth_id': authId,
      'employee_number': employeeNumber,
      'group_name': groupName,
      'profile_image': profileImage
    });
  }

  getUserId() async {
    String authId = await getCurrentAuthUserID();
    final data =
        await supabase.from('employes').select('id').eq("auth_id", authId);
    print(data);
    return data;
  }

  Future<void> insertData(String name, String date) async {
    List user_id = await getUserId();
    print("\\\\\\\\\\\\\\\\");
    print(user_id);
    print("\\\\\\\\\\\\\\\\");
    await supabase.from('work_time_issue').insert(
        {'name': name, 'id_user': user_id[0]["id"], "created_at": date});
  }

  Future<void> signIn(String email, String password) async {
    try {
      await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } on AuthException catch (e) {
      // print(e.message);
      rethrow;
    }
  }

  Future<void> delete(int id) async {
    await supabase.from('work_time_issue').delete().match({'id': id});
  }

  Future<void> workTimeIssueUpdate(
      {required String name, required int id}) async {
    await supabase
        .from("work_time_issue")
        .update({'name': name}).match({"id": "$id"});
  }

  void signup() async {
    final AuthResponse res = await supabase.auth.signUp(
      email: 'sf@email.com',
      password: 'example-password',
    );
    // final Session? session = res.session;
    final User? user = res.user;

    // print(session!.accessToken);
    // print(user!.email);
  }

  void signOut() async {
    await supabase.auth.signOut();
  }

  // Function to upload an image
  Future<String?> uploadImage(XFile pickedFile, var fileName) async {
    try {
      final File file = File(pickedFile.path);
      final response =
          supabase.storage.from("profiles_images").upload(fileName, file);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  String generateFileName() {
    final fileName =
        '${DateTime.now().microsecondsSinceEpoch.toString()}.jpg'; // Generate a unique filename

    return fileName;
  }

  Future<XFile?> selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return pickedFile;
    } else {
      print('No image selected.');
    }
    return null;
  }

  Future<String> getPublicUrl(String fileName) async {
    String url =
        supabase.storage.from("profiles_images").getPublicUrl(fileName);
    return url;
  }

  // isThereWorkIssueToday() async {
  //   var id = await getUserId();
  //   String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  //   final response = await supabase
  //       .from("work_time_issue")
  //       .select("created_at")
  //       .eq("created_at", formattedDate)
  //       .eq(id, id[0]["id"])
  //       .execute();
  //   return response as List;
  // }

  Future<bool> isThereWorkIssueToday() async {
    var id = await getUserId();
    String localDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final response = await supabase
        .from("work_time_issue")
        .select(
            "created_at") // Select all columns, adjust based on your actual columns
        .eq("id_user", id[0]["id"])
        .eq("created_at", localDate);
    return (response != null && response.isNotEmpty);
  }
}
