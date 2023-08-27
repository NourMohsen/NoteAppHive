import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_hive/models/node_model.dart';
import 'package:note_app_hive/simple_bloc_observer.dart';
import 'package:note_app_hive/views/notes_view.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app_hive/views/widgets/constants.dart';
import 'package:flutter/material.dart';

import 'cubits/note_cubit/note_cubit.dart';
void main() async{
  Bloc.observer=SimpleBlocObserver();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>(kNotesBox);
  runApp(const NoteApp());
}

class NoteApp extends StatelessWidget {
  const NoteApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NoteCubit(),),
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: const NotesView(),
      ),
    );
  }
}
