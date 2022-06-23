import 'package:diary/controllers/notes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WriteNote extends GetView<NotesController> {
  const WriteNote({Key? key, this.editID}) : super(key: key);

  final int? editID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(188, 170, 164, 1),
      appBar: AppBar(
        toolbarHeight: 75,
        title: const Padding(
          padding: EdgeInsets.all(4.0),
          child: Text('Add Diary',
              style: TextStyle(fontFamily: 'DancingBold', fontSize: 24)),
        ),
        automaticallyImplyLeading: true,
        backgroundColor: const Color.fromRGBO(62, 39, 35, 1),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                if (editID == null) {
                  controller.addNote();
                } else {
                  controller.editNoteComplete(editID!);
                }
              },
              icon: const Icon(Icons.check),
              color: const Color.fromRGBO(239, 235, 233, 1)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            TextField(
              controller: controller.titleController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide:
                      const BorderSide(color: Color.fromRGBO(78, 52, 46, 1)),
                ),
                hintText: 'Title',
                hintStyle: const TextStyle(
                    color: Color.fromRGBO(62, 39, 35, 1),
                    fontSize: 30.0,
                    fontFamily: 'DancingBold'),
              ),
              style: const TextStyle(
                  color: Color.fromRGBO(62, 39, 35, 1),
                  fontSize: 30.0,
                  fontFamily: 'DancingBold'),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: TextField(
                controller: controller.descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 15,
                style: const TextStyle(
                    color: Color.fromRGBO(62, 39, 35, 1),
                    fontSize: 28.0,
                    fontFamily: 'Dancing'),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(78, 52, 46, 1)),
                    ),
                    hintStyle: const TextStyle(
                        color: Color.fromRGBO(62, 39, 35, 1),
                        fontSize: 28.0,
                        fontFamily: 'Dancing'),
                    hintText: 'Content'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
