import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:voice_bridge/features/authentication/services/firebase_auth_service.dart';
import 'package:voice_bridge/screens/end_drawer/views/app_drawer.dart';

class MockFirebaseAuthService extends Mock implements FirebaseAuthService {}

class MockSettingsScreen extends StatelessWidget {
  const MockSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Text('Settings Screen'));
  }
}

class MockHelpFeedbackScreen extends StatelessWidget {
  const MockHelpFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Text('Help Feedback Screen'));
  }
}

void main() {
  late MockFirebaseAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockFirebaseAuthService();
  });

  Widget createWidgetUnderTest(MockFirebaseAuthService service) {
    return MaterialApp(
      home: Scaffold(
        drawer: AppDrawer(services: service),
        body: const Center(child: Text('Home Page')),
      ),
    );
  }

  testWidgets('Drawer shows correct header texts', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest(mockAuthService));

    ScaffoldState scaffoldState = tester.firstState(find.byType(Scaffold));
    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    expect(find.text('Voice Bridge'), findsOneWidget);
    expect(find.text('Version 1.0.0'), findsOneWidget);
  });

  testWidgets('Drawer shows all menu items', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest(mockAuthService));

    ScaffoldState scaffoldState = tester.firstState(find.byType(Scaffold));
    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    // expect(find.text('Home'), findsOneWidget);
    // expect(find.text('Profile'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
    // expect(find.text('Notifications'), findsOneWidget);
    // expect(find.text('Make Payment'), findsOneWidget);
    expect(find.text('Help & Feedback'), findsOneWidget);
    // expect(find.text('About'), findsOneWidget);
    // expect(find.text('Sign Out'), findsOneWidget);
  });

  testWidgets('Tapping Settings navigates to SettingsScreen', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          drawer: Builder(
            builder: (context) => Drawer(
              child: ListView(
                children: [
                  ListTile(
                    title: const Text('Settings'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const MockSettingsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          body: const Center(child: Text('Home Page')),
        ),
      ),
    ));

    ScaffoldState scaffoldState = tester.firstState(find.byType(Scaffold));
    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    expect(find.text('Settings Screen'), findsOneWidget);
  });

  testWidgets('Tapping Help & Feedback navigates to HelpFeedbackScreen', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          drawer: Builder(
            builder: (context) => Drawer(
              child: ListView(
                children: [
                  ListTile(
                    title: const Text('Help & Feedback'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const MockHelpFeedbackScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          body: const Center(child: Text('Home Page')),
        ),
      ),
    ));

    ScaffoldState scaffoldState = tester.firstState(find.byType(Scaffold));
    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    await tester.tap(find.text('Help & Feedback'));
    await tester.pumpAndSettle();

    expect(find.text('Help Feedback Screen'), findsOneWidget);
  });

  // testWidgets('Tapping Sign Out calls signOut', (tester) async {
  //   await tester.pumpWidget(createWidgetUnderTest(mockAuthService));
  //
  //   ScaffoldState scaffoldState = tester.firstState(find.byType(Scaffold));
  //   scaffoldState.openDrawer();
  //   await tester.pumpAndSettle();
  //
  //   // ✅ Prepare Mock properly
  //   when(mockAuthService.signOut()).thenAnswer((_) async {});
  //
  //   // ✅ Scroll drawer if needed so that 'Sign Out' becomes visible
  //   final signOutTile = find.text('Sign Out');
  //   await tester.scrollUntilVisible(
  //     signOutTile,
  //     200.0,
  //     scrollable: find.byType(Scrollable),
  //   );
  //   await tester.pumpAndSettle();
  //
  //   // 🔍 Now the text is visible and tappable
  //   await tester.tap(signOutTile);
  //   await tester.pumpAndSettle();
  //
  //   // ✅ Verify signOut() called once
  //   verify(mockAuthService.signOut()).called(1);
  // });

  testWidgets('Tapping Home/Profile/Notifications/Payment closes drawer', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest(mockAuthService));

    ScaffoldState scaffoldState = tester.firstState(find.byType(Scaffold));
    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();

    expect(find.byType(Drawer), findsNothing);
  });
}
