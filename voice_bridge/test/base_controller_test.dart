import 'package:flutter_test/flutter_test.dart';
import 'package:voice_bridge/screens/base/controllers/base_controller.dart';

void main() {
  group('BaseController Test', () {
    late BaseController controller;

    setUp(() {
      controller = BaseController();
    });

    test('Initial selectedIndex should be 1', () {
      expect(controller.selectedIndex.value, 1);
    });

    test('changeTab should update selectedIndex', () {
      controller.changeTab(2);
      expect(controller.selectedIndex.value, 2);
    });
  });
}
