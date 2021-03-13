import 'dart:convert';

import 'package:rest_api/model/api_response.dart';
import 'package:rest_api/model/note_for_listing.dart';
import 'package:http/http.dart' as http;

class NoteServices {
  static const API = "https://tq-notes-api-jkrgrdggbq-el.a.run.app";
  static const headers = {
    'apiKey': '06e67350-ac7a-4227-9b79-7e0ba67905e0',
    'Content-Type': 'application/json'
  };

  Future<APIResponse<List<NoteModel>>> getNoteList() {
    return http.get(API + '/notes', headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final notes = <NoteModel>[];
        for (var item in jsonData) {
          notes.add(NoteModel.fromJson(item));
        }
        return APIResponse<List<NoteModel>>(data: notes);
      }
      return APIResponse<List<NoteModel>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<NoteModel>>(
        error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<NoteModel>> getNote(String noteID) {
    return http.get(API + '/notes/$noteID', headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);

        return APIResponse<NoteModel>(data: NoteModel.fromJson(jsonData));
      }
      return APIResponse<NoteModel>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
        APIResponse<NoteModel>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> createNote(NoteModel noteModel) {
    return http
        .post(API + '/notes',
            headers: headers, body: json.encode(NoteModel.toJson(noteModel)))
        .then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }
}
