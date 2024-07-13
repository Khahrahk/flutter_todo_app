import 'package:flutter/material.dart';
import '../../../app/Models/Note.dart';
import '../../../app/Controllers/NoteController.dart';

class NoteView extends StatelessWidget {
  final Note? note;
  const NoteView({
    super.key,
    this.note
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    if(note != null){
      titleController.text = note!.title;
      descriptionController.text = note!.description;
    }

    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      appBar: AppBar(
        title: Text( note == null
            ? 'Add'
            : 'Edit'
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: Center(
                child: Text(
                  'What are you thinking about?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: TextFormField(
                controller: titleController,
                maxLines: 1,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: theme.colorScheme.secondary,
                    hintText: 'Title',
                    labelText: 'Title',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: theme.colorScheme.onPrimary,
                          width: 0.75,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ))),
              ),
            ),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: theme.colorScheme.secondary,
                  hintText: 'Description',
                  labelText: 'Description',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: theme.colorScheme.onPrimary,
                        width: 0.75,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ))),
              keyboardType: TextInputType.multiline,
              onChanged: (str) {},
              maxLines: 5,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () async {
                      final title = titleController.value.text;
                      final description = descriptionController.value.text;

                      if (title.isEmpty || description.isEmpty) {
                        return;
                      }

                      final Note model = Note(title: title, description: description, id: note?.id);
                      if(note == null){
                        await DatabaseHelper.addNote(model);
                      }else{
                        await DatabaseHelper.updateNote(model);
                      }

                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(
                            const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.white,
                                  width: 0.75,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                )))),
                    child: Text( 'Save',
                      style: TextStyle(fontSize: 20, color: theme.colorScheme.onPrimary),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
