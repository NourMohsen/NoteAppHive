import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:note_app_hive/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:note_app_hive/cubits/note_cubit/note_cubit.dart';
import 'package:note_app_hive/views/widgets/color_list_view.dart';
import 'package:note_app_hive/views/widgets/custom_text_field.dart';
import '../../models/node_model.dart';
import 'custom_button.dart';

class NoteModelBottomSheet extends StatelessWidget {
  const NoteModelBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
  create: (context) => AddNoteCubit(),
  child: Padding(
      padding: EdgeInsets.only(top: 32, right: 16, left: 16,
      bottom: MediaQuery.of(context).viewInsets.bottom,),
      child: BlocConsumer<AddNoteCubit,AddNoteState>(
          builder: (context, state) => AbsorbPointer(
            absorbing: state is AddNoteLoading ?true:false,
              child: const SingleChildScrollView(child:AddNotesForm())),
          listener: (context,state){
            if(state is AddNoteFailure){
              debugPrint("failed ${state.errMessage}");
            }
            if(state is AddNoteSuccess){
              BlocProvider.of<NoteCubit>(context).fetchAllNotes();
              Navigator.pop(context);
            }
          }),
    ),
);
  }
}

class AddNotesForm extends StatefulWidget {
  const AddNotesForm({
    super.key,
  });

  @override
  State<AddNotesForm> createState() => _AddNotesFormState();
}
GlobalKey<FormState>formKey=GlobalKey();
AutovalidateMode autoValidateMode=AutovalidateMode.disabled;
String?title,subtitle;
class _AddNotesFormState extends State<AddNotesForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode:autoValidateMode,
      child: Column(
        children: [
          CustomTextField(
            hint: "Title",
            onSaved: (value){
              title=value;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          CustomTextField(
            hint: "Content",
            maxLines: 4,
            onSaved: (value){
              subtitle=value;
            },
          ),
         const SizedBox(
            height: 16,
          ),
          const ColorsListView(),
          const SizedBox(
            height: 16,
          ),
          BlocBuilder<AddNoteCubit, AddNoteState>(
  builder: (context, state) {
    return CustomButton(
      isLoading: state is AddNoteLoading?true:false,

            onTap: (){
               var currentDate =DateTime.now();
               var formattedCurrentDate=DateFormat("dd-MM-yyyy").format(currentDate);

              if(formKey.currentState!.validate()){
                formKey.currentState!.save();
                NoteModel noteModel=NoteModel(title!, subtitle!, formattedCurrentDate, Colors.red.value);
                BlocProvider.of<AddNoteCubit>(context).addNote(noteModel);
              }else
                {
                  autoValidateMode=AutovalidateMode.always;
                  setState(() {

                  });
                }
            },
          );
  },
),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
