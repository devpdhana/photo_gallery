import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photogallery/pages/reusables/empty_view.dart';
import 'package:photogallery/pages/reusables/error_view.dart';
import 'package:photogallery/pages/reusables/loading_view.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

  testWidgets('ErrorView shows the message and fires the retry action',
      (tester) async {
    var retried = false;
    await tester.pumpWidget(
      wrap(
        ErrorView(
          message: 'No internet connection. Check your network.',
          onRetry: () => retried = true,
        ),
      ),
    );

    expect(
      find.text('No internet connection. Check your network.'),
      findsOneWidget,
    );
    expect(find.text('Try again'), findsOneWidget);

    await tester.tap(find.text('Try again'));

    expect(retried, isTrue);
  });

  testWidgets('EmptyView shows the title and the subtitle', (tester) async {
    await tester.pumpWidget(
      wrap(
        const EmptyView(
          icon: Icons.favorite_border,
          title: 'No favorites yet',
          subtitle: 'Tap the heart on any photo to keep it here.',
        ),
      ),
    );

    expect(find.text('No favorites yet'), findsOneWidget);
    expect(
      find.text('Tap the heart on any photo to keep it here.'),
      findsOneWidget,
    );
  });

  testWidgets('LoadingView shows a progress indicator with its label',
      (tester) async {
    await tester.pumpWidget(wrap(const LoadingView()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Loading photos...'), findsOneWidget);
  });
}
