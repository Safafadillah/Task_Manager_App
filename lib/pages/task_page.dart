import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../widgets/task_item.dart';
import '../widgets/add_task_dialog.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();

    return Scaffold(
      appBar: AppBar(title: Text('Task Management App'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.only(right: 8),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.list_alt, color: Colors.blue),
                        SizedBox(height: 6),
                        Text(
                          provider.totalTask.toString(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('All Task'),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.only(right: 8),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.pending_actions, color: Colors.orange),
                        SizedBox(height: 6),
                        Text(
                          provider.pendingTask.toString(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Pending'),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.only(right: 8),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green),
                        SizedBox(height: 6),
                        Text(
                          provider.completedTask.toString(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Completed'),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            TextField(
              onChanged: provider.setSearch,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search Task',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: provider.filter,
                    decoration: InputDecoration(
                      labelText: 'Filter Task',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      DropdownMenuItem(value: 'All', child: Text('All Task')),
                      DropdownMenuItem(
                        value: 'Pending',
                        child: Text('Pending'),
                      ),
                      DropdownMenuItem(
                        value: 'Completed',
                        child: Text('Completed'),
                      ),
                    ],
                    onChanged: (value) => provider.setFilter(value ?? 'All'),
                  ),
                ),

                SizedBox(width: 12),

                SizedBox(
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AddTaskDialog(),
                      );
                    },
                    icon: Icon(Icons.add),
                    label: Text(
                      'Add Task',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 0, 93, 84),
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            Expanded(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: provider.tasks.isEmpty
                    ? Center(key: ValueKey('empty'), child: Text('No Task'))
                    : ListView.builder(
                        key: ValueKey('list'),
                        itemCount: provider.tasks.length,
                        itemBuilder: (_, i) =>
                            TaskItem(task: provider.tasks[i]),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
