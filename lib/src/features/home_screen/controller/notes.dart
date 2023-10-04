import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../../common/models/note_model.dart';
import '../../../common/utils/storage.dart';

class Notes with ChangeNotifier {
  Notes({
    List<NoteModel>? notes,
    List<NoteModel>? secureNote,
  })  : _notes = notes ?? [],
        _secureNotes = secureNote ?? [];


  List<NoteModel> _notes;
  List<NoteModel> _secureNotes = [];
  List<NoteModel> get notes => _notes.reversed.toList();
  List<NoteModel> get secureNotes => _secureNotes;
  List<NoteModel> get allNotes => [...notes, ..._secureNotes]..sort(
      (a, b) => b.dateTime.compareTo(a.dateTime),
    );

  factory Notes.fromJson(Map<String,Object?> json) => Notes(
    notes: json["notes"] != null ? List<Map<String, Object?>>.from(json["notes"] as List).map(NoteModel.fromJson).toList() : null,
    secureNote: json["secureNote"] != null ? List<Map<String, Object?>>.from(json["secureNote"] as List).map(NoteModel.fromJson).toList() : null,
  );

  Map<String,Object?> toJson() => {
    "notes": notes.map((e) => e.toJson()).toList(),
    "secureNote": notes.map((e) => e.toJson()).toList(),
  };

  void changeSecure(NoteModel note) {
    removeNote(note);
    addNote(note.copyWith(isSecret: !note.isSecret));
  }

  Future<void> setAllNotes() async {
    List<NoteModel> a = List<Map<String,Object?>>.from(jsonDecode($storage.getString($users.currentUser.id!) ?? "[]")).map(NoteModel.fromJson).toList();
    String bString = (await $secureStorage.read(key: $users.currentUser.id!,)) ?? "[]";
    List<NoteModel> b = List<Map<String,Object?>>.from(jsonDecode(bString)).map(NoteModel.fromJson).toList();
    setSecureNotes(b);
    setNotes(a);
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
    if (!note.isSecret) {
      _notes.add(note);
      save();
    } else {
      _secureNotes.add(note);
      saveSecured();
    }
    notifyListeners();
  }

  void update(NoteModel old, NoteModel note) {
    if (note.isSecret) {
      final index = _secureNotes.indexOf(old);
      _secureNotes[index] = note;
      saveSecured();
    } else {
      int index = _notes.indexOf(old);
      _notes[index] = note;
      save();
    }
    notifyListeners();
  }

  void delete(NoteModel note) {
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
    $storage.setString($users.currentUser.id!, _notes.listEncode());
  }

  void saveSecured() {
    $secureStorage.write(key: $users.currentUser.id!, value: _secureNotes.listEncode());
  }

  @override
  String toString() {
    return 'Notes{_notes: ${_notes.map((e) => e.toString())}, _secureNotes: ${_secureNotes.map((e) => e.toString())}}';
  }
}

extension FromListToString on List<NoteModel> {
  String listEncode() {
    List<Map<String, Object?>> notes = map((e) => e.toJson()).toList();
    return jsonEncode(notes);
  }
}
