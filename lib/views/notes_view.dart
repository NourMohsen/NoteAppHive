import 'package:flutter/material.dart';
import 'package:note_app_hive/views/notes_view_body.dart';
import 'package:note_app_hive/views/widgets/note_model_bottom_sheet.dart';

class NotesView extends StatelessWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const NotesViewBody(),
      floatingActionButton: FloatingActionButton(


          onPressed: () {
            showModalBottomSheet(context: context,
              builder: (context) => const NoteModelBottomSheet(),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
              ),
              isScrollControlled: true,
            );
          },
          child: const Icon(Icons.add)
      ),
    );
  }
}
