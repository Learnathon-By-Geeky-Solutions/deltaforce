import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voice_bridge/widgets/border_list_tile.dart';

void main() {
  group('BorderedListTile Tests', () {
    testWidgets('renders with only title', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: BorderedListTile(title: const Text('Title')),
          ),
        ),
      );

      expect(find.text('Title'), findsOneWidget);
    });

    testWidgets('renders leading, subtitle, trailing, and responds to onTap', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: BorderedListTile(
              leading: const Icon(Icons.star),
              title: const Text('Title'),
              subtitle: const Text('Subtitle'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
      expect(find.text('Subtitle'), findsOneWidget);

      await tester.tap(find.byType(ListTile));
      expect(tapped, isTrue);
    });

    testWidgets('applies custom border color and radius', (tester) async {
      const customColor = Colors.red;
      const customRadius = 20.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: BorderedListTile(
              title: const Text('Title'),
              borderColor: customColor,
              borderRadius: customRadius,
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;

      expect(decoration.borderRadius, BorderRadius.circular(customRadius));
      expect((decoration.border as Border).top.color, customColor);
    });

    testWidgets('uses default padding when not provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: BorderedListTile(title: const Text('Title')),
          ),
        ),
      );

      final listTile = tester.widget<ListTile>(find.byType(ListTile));
      expect(listTile.contentPadding, const EdgeInsets.symmetric(horizontal: 16.0));
    });

    testWidgets('uses custom padding if provided', (tester) async {
      const customPadding = EdgeInsets.all(24.0);

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: BorderedListTile(
              title: const Text('Title'),
              padding: customPadding,
            ),
          ),
        ),
      );

      final listTile = tester.widget<ListTile>(find.byType(ListTile));
      expect(listTile.contentPadding, customPadding);
    });
  });
}
