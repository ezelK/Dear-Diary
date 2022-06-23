import 'package:diary/models/create_diary.dart';
import 'package:diary/models/diary.dart';
import 'package:diary/screens/diary_page.dart';
import 'package:diary/screens/write_note.dart';
import 'package:diary/services/diary_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotesController extends GetxController {
  final notes = <Diary>[].obs;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  final isLoading = true.obs;

  final date = DateTime.now().obs;

  @override
  void onInit() {
    ever(date, (_) {
      fetch();
    });

    date.value = DateTime.now();
    super.onInit();
  }

  Future<void> fetch() async {
    isLoading.value = true;
    final result = await DiaryApi.getDiaries(date.value);
    if (result == null) {
      Get.snackbar("Error", "Couldn't get diaries.");
    } else {
      notes.value = result;
    }
    isLoading.value = false;
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  Future<void> restart() async {
    await fetch();
  }

  void addNote() async {
    final createDiary = CreateDiary(
      title: titleController.text,
      content: descriptionController.text,
    );

    if (titleController.text != "" && descriptionController.text != "") {
      final diary = await DiaryApi.createDiary(createDiary);

      if (diary == null) {
        return;
      }
      if (diary.date.year == date.value.year &&
          diary.date.month == date.value.month &&
          diary.date.day == date.value.day) notes.insert(0, diary);
      Get.back();
      titleController.clear();
      descriptionController.clear();
    } 
  }

  void removeNote(int id) async {
    final result = await DiaryApi.deleteDiary(id);
    if (result) {
      notes.removeWhere((element) => element.id == id);
      return;
    }
    Get.snackbar("Error", "Couldn't delete diary.");
  }

  void editNote(int id) {
    final diary = notes.firstWhere((element) => element.id == id);
    titleController.text = diary.title;
    descriptionController.text = diary.content;
    Get.to(WriteNote(editID: id));
  }

  void editNoteComplete(int id) async {
    final createDiary = CreateDiary(
      title: titleController.text,
      content: descriptionController.text,
    );
    final edit = await DiaryApi.updateDiary(id, createDiary);

    if (edit == null) return;

    final idx = notes.indexWhere((element) => element.id == id);

    final newDiary = notes[idx].copyWith(
      title: titleController.text,
      content: descriptionController.text,
    );

    notes[idx] = newDiary;
    notes.refresh();
    Get.back();
  }
}
