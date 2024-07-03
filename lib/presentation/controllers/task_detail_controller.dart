import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskDetailController extends StateNotifier<bool> {
  TaskDetailController() : super(true);

  String projectoID = '';
  String goalID = '';
  String currentUserID = '';
  String? userTask;

  void setUser() {
    state = !state;
    state = !state; // son dos veces porque asi esta funcionando xd
  }
}
