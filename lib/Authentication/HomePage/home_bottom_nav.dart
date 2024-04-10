import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_codsoft/Authentication/HomePage/completed_tasks.dart';
import 'package:todo_list_codsoft/Authentication/HomePage/home_screen.dart';
import 'package:todo_list_codsoft/Authentication/Providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onItemTapped(index) {
      ref.read(selectedIndexProvider.notifier).state = index;
    }

    final selectedIndex = ref.watch(selectedIndexProvider);
    return Scaffold(
      backgroundColor: Colors.blue,
      body: [
        const HomeScreen(),
        const CompletedTasks(),
      ][selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 3,
        selectedItemColor: Colors.blue,
        iconSize: 25,
        items: const [
          BottomNavigationBarItem(
            label: "New Tasks",
            icon: Icon(Icons.task_sharp),
          ),
          BottomNavigationBarItem(
            label: "Completed Tasks",
            icon: Icon(Icons.done),
          ),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}
