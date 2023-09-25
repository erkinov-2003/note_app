import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:note_app/src/common/utils/storage.dart';

import '../../../common/models/note_model.dart';

class Notes with ChangeNotifier {
  late bool isLogged;
  List<NoteModel> _notes = [];
  List<NoteModel> _secureNotes = [];

  List<NoteModel> get notes => _notes.reversed.toList();

  List<NoteModel> get secureNotes => _secureNotes;

  List<NoteModel> get allNotes => [...notes, ..._secureNotes]..sort(
      (a, b) => b.dateTime.compareTo(a.dateTime),
    );

  void changeSecure(NoteModel note) {
    removeNote(note);
    addNote(note.copyWith(isSecret: !note.isSecret));
  }

  void changeSecureSet(NoteModel note) {
    removeNote(note);
    addNote(note.copyWith(isSecret: false));
    notifyListeners();
  }

  void setNotes(List<NoteModel> newNote) {
    _notes = newNote;
  }

  void setSecureNotes(List<NoteModel> newNote) {
    _secureNotes = newNote;
  }

  void removeNote(NoteModel note) {
    if (!note.isSecret) {
      _notes.remove(note);
      save();
    } else {
      _secureNotes.remove(note);
      saveSecured();
    }
    notifyListeners();
  }

  void addNote(NoteModel note) {
    if(!note.isSecret){
      _notes.add(note);
      save();
    }else{
      _secureNotes.add(note);
      saveSecured();
    }
    notifyListeners();
  }

  void update(int id, NoteModel note) {
    if (note.isSecret) {
      int index = _secureNotes.indexOf(note);
      _secureNotes[index] = note;
      saveSecured();
    } else {
      int index = _notes.indexOf(note);
      _notes[index] = note;
      save();
    }
    notifyListeners();
  }

  void delete(String id, NoteModel note) {
    if (note.isSecret) {
      _secureNotes.remove(note);
      saveSecured();
    } else {
      _notes.remove(note);
      save();
    }
    notifyListeners();
  }

  void clear() {
    _secureNotes.clear();
    _notes.clear();
    notifyListeners();
  }

  void save() {
    $storage.setString("notes", _notes.listEncode());
  }

  void saveSecured() {
    $secureStorage.write(key: "notes", value: _secureNotes.listEncode());
  }
}

extension FromListToString on List<NoteModel> {
  String listEncode() {
    List<Map<String, Object?>> notes = map((e) => e.toJson()).toList();
    return jsonEncode(notes);
  }
}
