// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'widget_build.g.dart';

void main() {
  testWidgets('test', (WidgetTester tester) async {

    final container = createContainer();

    expect(
      container.read(valueProvider).value,
      equals([1,2,3]),
    );

  });
}

@riverpod
Stream<int> value(ValueRef ref) {
  return Stream.fromIterable([1,2,3]);
}

ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  // Create a ProviderContainer, and optionally allow specifying parameters.
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );

  // When the test ends, dispose the container.
  addTearDown(container.dispose);

  return container;
}
