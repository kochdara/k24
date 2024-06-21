// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatPageHash() => r'9ae76f5903c6f073e2e7b8bc1cb63a8cce6d5e14';

/// See also [ChatPage].
@ProviderFor(ChatPage)
final chatPageProvider =
    AutoDisposeAsyncNotifierProvider<ChatPage, List<ChatData>>.internal(
  ChatPage.new,
  name: r'chatPageProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$chatPageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ChatPage = AutoDisposeAsyncNotifier<List<ChatData>>;
String _$conversationPageHash() => r'96fd031a6f3cb4ded6c4cefc9a3cf7648639c42c';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ConversationPage
    extends BuildlessAutoDisposeStreamNotifier<List<ConData>> {
  late final String topic_id;
  late final String first_message_id;

  Stream<List<ConData>> build(
    String topic_id, {
    String first_message_id = '',
  });
}

/// See also [ConversationPage].
@ProviderFor(ConversationPage)
const conversationPageProvider = ConversationPageFamily();

/// See also [ConversationPage].
class ConversationPageFamily extends Family<AsyncValue<List<ConData>>> {
  /// See also [ConversationPage].
  const ConversationPageFamily();

  /// See also [ConversationPage].
  ConversationPageProvider call(
    String topic_id, {
    String first_message_id = '',
  }) {
    return ConversationPageProvider(
      topic_id,
      first_message_id: first_message_id,
    );
  }

  @override
  ConversationPageProvider getProviderOverride(
    covariant ConversationPageProvider provider,
  ) {
    return call(
      provider.topic_id,
      first_message_id: provider.first_message_id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'conversationPageProvider';
}

/// See also [ConversationPage].
class ConversationPageProvider extends AutoDisposeStreamNotifierProviderImpl<
    ConversationPage, List<ConData>> {
  /// See also [ConversationPage].
  ConversationPageProvider(
    String topic_id, {
    String first_message_id = '',
  }) : this._internal(
          () => ConversationPage()
            ..topic_id = topic_id
            ..first_message_id = first_message_id,
          from: conversationPageProvider,
          name: r'conversationPageProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$conversationPageHash,
          dependencies: ConversationPageFamily._dependencies,
          allTransitiveDependencies:
              ConversationPageFamily._allTransitiveDependencies,
          topic_id: topic_id,
          first_message_id: first_message_id,
        );

  ConversationPageProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.topic_id,
    required this.first_message_id,
  }) : super.internal();

  final String topic_id;
  final String first_message_id;

  @override
  Stream<List<ConData>> runNotifierBuild(
    covariant ConversationPage notifier,
  ) {
    return notifier.build(
      topic_id,
      first_message_id: first_message_id,
    );
  }

  @override
  Override overrideWith(ConversationPage Function() create) {
    return ProviderOverride(
      origin: this,
      override: ConversationPageProvider._internal(
        () => create()
          ..topic_id = topic_id
          ..first_message_id = first_message_id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        topic_id: topic_id,
        first_message_id: first_message_id,
      ),
    );
  }

  @override
  AutoDisposeStreamNotifierProviderElement<ConversationPage, List<ConData>>
      createElement() {
    return _ConversationPageProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ConversationPageProvider &&
        other.topic_id == topic_id &&
        other.first_message_id == first_message_id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, topic_id.hashCode);
    hash = _SystemHash.combine(hash, first_message_id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ConversationPageRef
    on AutoDisposeStreamNotifierProviderRef<List<ConData>> {
  /// The parameter `topic_id` of this provider.
  String get topic_id;

  /// The parameter `first_message_id` of this provider.
  String get first_message_id;
}

class _ConversationPageProviderElement
    extends AutoDisposeStreamNotifierProviderElement<ConversationPage,
        List<ConData>> with ConversationPageRef {
  _ConversationPageProviderElement(super.provider);

  @override
  String get topic_id => (origin as ConversationPageProvider).topic_id;
  @override
  String get first_message_id =>
      (origin as ConversationPageProvider).first_message_id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
