
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_hive/cubits/note_cubit/note_cubit.dart';
import 'package:note_app_hive/views/widgets/custom_appbar.dart';
import 'package:note_app_hive/views/widgets/note_list_view.dart';

class NotesViewBody extends StatefulWidget {
  const NotesViewBody({Key? key}) : super(key: key);

  @override
  State<NotesViewBody> createState() => _NotesViewBodyState();
}

class _NotesViewBodyState extends State<NotesViewBody> {

  @override
  void initState(){
    BlocProvider.of<NoteCubit>(context).fetchAllNotes();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  const Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children:[
          SizedBox(
          height: 50,),
          CustomAppBar(title: "Notes", icon:Icons.search,),
          Expanded(
            child: NoteListView()
          )
        ],
      ),
    );
  }
}
