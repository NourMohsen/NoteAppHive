import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/node_model.dart';
import '../../views/widgets/constants.dart';
part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());

  List<NoteModel>?notes;
  fetchAllNotes(){
    var notesBox = Hive.box<NoteModel>(kNotesBox);
    notes=notesBox.values.toList();
    emit(NoteSuccess());
  }
}
