
import 'package:flutter/material.dart';
import 'database_helper.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<Map<String, dynamic>> notes = [];

  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  int? selectedNoteId;

  Future<void> loadNotes() async {
    final data = await DatabaseHelper().getNotes();

    if (!mounted) return;

    setState(() {
      notes = data;
    });
  }

  Future<void> addNote() async {
    if (titleController.text.trim().isEmpty ||
        bodyController.text.trim().isEmpty) {
      return;
    }

    final note = {
      'title': titleController.text,
      'body': bodyController.text,
      'created_at': DateTime.now().toString(),
    };

    await DatabaseHelper().insertNote(note);

    titleController.clear();
    bodyController.clear();

    await loadNotes();
  }

  Future<void> updateNote(int id) async {
    if (titleController.text.trim().isEmpty ||
        bodyController.text.trim().isEmpty) {
      return;
    }

    final note = {
      'title': titleController.text,
      'body': bodyController.text,
    };

    await DatabaseHelper().updateNote(id, note);

    titleController.clear();
    bodyController.clear();
    selectedNoteId = null;

    await loadNotes();
  }

  Future<void> deleteNote(int id) async {
    await DatabaseHelper().deleteNote(id);

    if (selectedNoteId == id) {
      titleController.clear();
      bodyController.clear();
      selectedNoteId = null;
    }

    await loadNotes();
  }

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
      ),
      body: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
          ),

          TextField(
            controller: bodyController,
            decoration: const InputDecoration(
              labelText: 'Content',
            ),
          ),

          ElevatedButton(
            onPressed: () {
              if (selectedNoteId == null) {
                addNote();
              } else {
                updateNote(selectedNoteId!);
              }
            },
            child: Text(
              selectedNoteId == null ? 'Save Note' : 'Update Note',
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];

                return ListTile(
                  title: Text(note['title']),
                  subtitle: Text(note['body']),
                  leading: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      titleController.text = note['title'];
                      bodyController.text = note['body'];

                      setState(() {
                        selectedNoteId = note['id'] as int;
                      });
                    },
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      deleteNote(note['id'] as int);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
