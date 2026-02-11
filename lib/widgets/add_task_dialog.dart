import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

class AddTaskDialog extends StatefulWidget {
  AddTaskDialog({super.key});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  bool showTitleError = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: titleController,
            onChanged: (_) {
              if (showTitleError) {
                setState(() => showTitleError = false);
              }
            },
            decoration: InputDecoration(labelText: 'Title Task'),
          ),

          if (showTitleError)
            Padding(
              padding: EdgeInsets.only(top: 4, left: 4),
              child: Text(
                'Title task is required',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),

          SizedBox(height: 12),

          TextField(
            controller: descController,
            decoration: InputDecoration(labelText: 'Description Task'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (titleController.text.trim().isEmpty) {
              setState(() => showTitleError = true);
              return;
            }

            context.read<TaskProvider>().addTask(
              titleController.text,
              descController.text,
            );

            Navigator.pop(context);
          },
          child: Text('Add Task'),
        ),
      ],
    );
  }
}
