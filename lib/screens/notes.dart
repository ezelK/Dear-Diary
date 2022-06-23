import 'package:diary/controllers/global_controller.dart';
import 'package:diary/controllers/notes_controller.dart';
import 'package:diary/screens/diary_page.dart';
import 'package:diary/screens/write_note.dart';
import 'package:diary/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotesController());

    return Scaffold(
      backgroundColor: const Color.fromRGBO(188, 170, 164, 1),
      appBar: AppBar(
        toolbarHeight: 70,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(4.0),
              child: Text('Dear Diary',
                  style: TextStyle(fontFamily: 'DancingBold', fontSize: 24)),
            ),
            Obx(
              () => Text(
                  "  ${controller.date.value.day < 10 ? "0" : ""}${controller.date.value.day.toString()} / ${controller.date.value.month < 10 ? "0" : ""}${controller.date.value.month.toString()} / ${controller.date.value.year.toString()}",
                  style: const TextStyle(
                      fontFamily: 'Dancing',
                      color: Color.fromRGBO(239, 235, 233, 1),
                      fontSize: 12)),
            )
          ],
        ),
        automaticallyImplyLeading: true,
        backgroundColor: const Color.fromRGBO(62, 39, 35, 1),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                controller.titleController.clear();
                controller.descriptionController.clear();
                Get.to(const WriteNote());
              },
              icon: const Icon(Icons.add_box_outlined),
              color: Colors.brown[50]),
          IconButton(
              onPressed: () async {
                final date = await Helpers.showDateSelector(context,
                    DateTime(2000), DateTime.now(), controller.date.value);
                if (date != null) {
                  controller.date.value = date;
                }
              },
              icon: const Icon(Icons.calendar_month_outlined),
              color: Colors.brown[50]),
          IconButton(
              onPressed: () async {
                Get.find<GlobalController>().logOut();
              },
              icon: const Icon(Icons.exit_to_app),
              color: Colors.brown[50]),
        ],
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : controller.notes.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await controller.restart();
                    },
                    child: ListView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      children: controller.notes
                          .map((diary) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      color: Color.fromARGB(255, 78, 52, 46),
                                      width: 0.3,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  leading: const FaIcon(FontAwesomeIcons.book,
                                      color: Color.fromRGBO(62, 39, 35, 1),
                                      size: 36),
                                  title: Text(
                                    diary.title,
                                    style: const TextStyle(
                                        color: Color.fromRGBO(62, 39, 35, 1),
                                        fontFamily: 'DancingBold',
                                        fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    diary.hour,
                                    style: const TextStyle(
                                        color: Color.fromRGBO(62, 39, 35, 1),
                                        fontFamily: 'Dancing',
                                        fontSize: 18),
                                  ),
                                  onTap: () {
                                    Get.to(DiaryPage(diary: diary));
                                  },
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const FaIcon(FontAwesomeIcons.penFancy, 
                                         
                                            color:
                                                Color.fromRGBO(62, 39, 35, 1)),
                                        onPressed: () =>
                                            controller.editNote(diary.id),
                                      ),
                                      IconButton(
                                        icon: const FaIcon(FontAwesomeIcons.trashCan,
                                            color:
                                                Color.fromRGBO(62, 39, 35, 1)),
                                        onPressed: () =>
                                            controller.removeNote(diary.id),
                                      )
                                    ],
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                )
              : const Center(
                  child: Text("Empty",
                      style: TextStyle(color: Color.fromRGBO(62, 39, 35, 1))))),
    );
  }
}
