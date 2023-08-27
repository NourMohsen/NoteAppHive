import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_hive/models/node_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app_hive/views/widgets/constants.dart';
part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit() : super(AddNoteInitial());
  Color color= const Color(0xffAC3931);
      addNote(NoteModel note)async{
    emit(AddNoteLoading());
    try {
      note.color=color.value;
      var notesBox = Hive.box<NoteModel>(kNotesBox);
      await notesBox.add(note);
      emit(AddNoteSuccess());
    }catch(e){
      emit(AddNoteFailure(e.toString()));
    }


  }
}
