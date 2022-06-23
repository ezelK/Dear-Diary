import 'package:diary/controllers/notes_controller.dart';
import 'package:diary/models/diary.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class DiaryPage extends StatelessWidget {
  const DiaryPage({Key? key, required this.diary}) : super(key: key);
  final Diary diary;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotesController());
    return Scaffold(
      backgroundColor: const Color.fromRGBO(188, 170, 164, 1),
      appBar: AppBar(
        toolbarHeight: 70,
        title: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(diary.title,
              style: const TextStyle(fontFamily: 'DancingBold', fontSize: 24)),
        ),
        automaticallyImplyLeading: true,
        backgroundColor: const Color.fromRGBO(62, 39, 35, 1),
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.penFancy,
                color: Color.fromRGBO(188, 170, 164, 1)),
            onPressed: () => controller.editNote(diary.id),
          ),
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.trashCan,
                color: Color.fromRGBO(188, 170, 164, 1)),
            onPressed: () => controller.removeNote(diary.id),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  diary.content,
                  style: const TextStyle(
                    color: Color.fromRGBO(62, 39, 35, 1),
                    fontSize: 28.0,
                    fontFamily: 'Dancing',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Column(
                  children: [
                    Text(diary.diaryDate,
                        style: const TextStyle(
                            fontFamily: 'Dancing',
                            color: Color.fromRGBO(62, 39, 35, 1),
                            fontSize: 20)),
                    Text(diary.hour,
                        style: const TextStyle(
                            fontFamily: 'Dancing',
                            color: Color.fromRGBO(62, 39, 35, 1),
                            fontSize: 20)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
