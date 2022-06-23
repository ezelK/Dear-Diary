import 'package:diary/models/create_diary.dart';
import 'package:diary/models/diary.dart';
import 'package:diary/services/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DiaryApi {
  static Future<List<Diary>?> getDiaries(DateTime date) async {
    try {
      Dio dio = await Api.dioAuth();
      Response response = await dio.get(
          "/diary/${date.year}-${date.month < 10 ? "0" : ""}${date.month}-${date.day}");
      if (response.statusCode == 200) {
        final List<dynamic> list = response.data;
        return list.map((e) => Diary.fromMap(e)).toList();
      }
      return null;
    } on DioError catch (err) {
      debugPrint("Get Diaries Error $err");
      return null;
    }
  }

  static Future<bool> deleteDiary(int id) async {
    try {
      Dio dio = await Api.dioAuth();
      Response response = await dio.delete("/diary/$id");
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } on DioError catch (err) {
      debugPrint("Delete Diary Error $err");
      return false;
    }
  }

  static Future<Diary?> createDiary(CreateDiary diary) async {
    try {
      Dio dio = await Api.dioAuth();
      Response response = await dio.post("/diary", data: diary.toJSON());
      if (response.statusCode == 201) {
        return Diary.fromMap(response.data);
      }
      return null;
    } on DioError catch (err) {
      debugPrint("Create Diary Error $err");
      return null;
    }
  }

  static Future<Diary?> updateDiary(int id, CreateDiary createDiary) async {
    try {
      Dio dio = await Api.dioAuth();
      Response response =
          await dio.put("/diary/$id", data: createDiary.toJSON());
      if (response.statusCode == 200) {
        return Diary.fromMap(response.data);
      }
      return null;
    } on DioError catch (err) {
      debugPrint("Update Diary Error $err");
      return null;
    }
  }
}
