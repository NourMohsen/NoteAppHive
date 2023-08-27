import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_hive/views/widgets/custom_appbar.dart';
import 'package:note_app_hive/views/widgets/custom_text_field.dart';
import 'package:note_app_hive/views/widgets/edit_note_list_color.dart';
import '../cubits/note_cubit/note_cubit.dart';
import '../models/node_model.dart';

class EditNotesView extends StatefulWidget {
  const EditNotesView({Key? key, required this.note,}) : super(key: key);
  final NoteModel note ;

  @override
  State<EditNotesView> createState() => _EditNotesViewState();
}

class _EditNotesViewState extends State<EditNotesView> {


  String?title, subtitle;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30,),
                  CustomAppBar(
                    title: "Edit Note", icon: Icons.check, onPressed: () {
                    widget.note.title = title ?? widget.note.title;
                    widget.note.subtitle = subtitle ?? widget.note.subtitle;
                    widget.note.save();
                    BlocProvider.of<NoteCubit>(context).fetchAllNotes();
                    Navigator.of(context).pop();
                  },),
                  const SizedBox(height: 50,),
                  CustomTextField(
                    hint: widget.note.title,
                    onChanged: (value) {
                      title = value;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    hint: widget.note.subtitle,
                    maxLines: 5,
                    onChanged: (value) {
                      subtitle = value;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  EditNoteColorsList(note:widget.note),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}
