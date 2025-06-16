import 'package:flutter_test/flutter_test.dart';
import 'package:miles_education_app/controllers/task_controller.dart';

void main() {
  late TaskController controller;

  setUp(() {
    controller = TaskController();
  });

  test('Form should be cleared', () {
    controller.titleCtrl.text = 'Some title';
    controller.descCtrl.text = 'Some desc';

    controller.clearForm();

    expect(controller.titleCtrl.text, '');
    expect(controller.descCtrl.text, '');
  });

  test('Edit flag should detect if taskId is null or not', () {
    controller.currentTaskId = null;
    expect(controller.isEdit, false);

    controller.currentTaskId = 'abc123';
    expect(controller.isEdit, true);
  });
}
