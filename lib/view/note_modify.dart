import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rest_api/model/note_for_listing.dart';
import 'package:rest_api/services/note_service.dart';

class NoteModify extends StatefulWidget {
  final String noteId;

  NoteModify({this.noteId});

  @override
  _NoteModifyState createState() => _NoteModifyState();
}

class _NoteModifyState extends State<NoteModify> {
  bool get isEditing => widget.noteId != null;

  NoteServices get service => GetIt.I<NoteServices>();

  String errorMessage;
  NoteModel noteModel;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    if (isEditing) {
      setState(() {
        _isLoading = true;
      });
      service.getNote(widget.noteId).then((value) {
        setState(() {
          _isLoading = false;
        });
        if (value.error) {
          errorMessage = value.errorMessage ?? 'An error occured';
        } else {
          noteModel = value.data;
          _titleController.text = noteModel.noteTitle;
          _contentController.text = noteModel.noteContent;
        }
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${isEditing ? 'Edit Note' : 'Create Note'}'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _isLoading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(hintText: 'Note title'),
              ),
              Container(
                height: 8,
              ),
              TextField(
                controller: _contentController,
                decoration: InputDecoration(hintText: 'Note Content'),
              ),
              Container(
                height: 32,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 35,
                  child: ElevatedButton(
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (isEditing) {} else {
                        print("tttttt else");
                        final note = NoteModel(noteTitle: _titleController.text,
                            noteContent: _contentController.text);
                        final result = await service.createNote(note);
                        final title = 'Done';
                        final text = result.error ? (result.errorMessage ??
                            'An error occurred') : 'Your note was created';
                        showDialog(context: context, builder: (_) =>
                            AlertDialog(
                              title: Text(title),
                              content: Text(text),
                              actions: [
                                TextButton(onPressed: () {
                                  service.getNoteList();
                                  Navigator.of(context).pop();
                                }, child: Text('Ok'))
                              ],
                            ));
                      }
                    },
                  ))
            ],
          ),
        ));
  }
}
