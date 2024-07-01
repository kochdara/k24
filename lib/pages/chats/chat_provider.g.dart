// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatPageHash() => r'fc51503f33d6fd61cf14f1a928b6261f22675747';

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

abstract class _$ChatPage
    extends BuildlessAutoDisposeAsyncNotifier<List<ChatData>> {
  late final WidgetRef context;

  FutureOr<List<ChatData>> build(
    WidgetRef context,
  );
}

/// See also [ChatPage].
@ProviderFor(ChatPage)
const chatPageProvider = ChatPageFamily();

/// See also [ChatPage].
class ChatPageFamily extends Family<AsyncValue<List<ChatData>>> {
  /// See also [ChatPage].
  const ChatPageFamily();

  /// See also [ChatPage].
  ChatPageProvider call(
    WidgetRef context,
  ) {
    return ChatPageProvider(
      context,
    );
  }

  @override
  ChatPageProvider getProviderOverride(
    covariant ChatPageProvider provider,
  ) {
    return call(
      provider.context,
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
  String? get name => r'chatPageProvider';
}

/// See also [ChatPage].
class ChatPageProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ChatPage, List<ChatData>> {
  /// See also [ChatPage].
  ChatPageProvider(
    WidgetRef context,
  ) : this._internal(
          () => ChatPage()..context = context,
          from: chatPageProvider,
          name: r'chatPageProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$chatPageHash,
          dependencies: ChatPageFamily._dependencies,
          allTransitiveDependencies: ChatPageFamily._allTransitiveDependencies,
          context: context,
        );

  ChatPageProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
  }) : super.internal();

  final WidgetRef context;

  @override
  FutureOr<List<ChatData>> runNotifierBuild(
    covariant ChatPage notifier,
  ) {
    return notifier.build(
      context,
    );
  }

  @override
  Override overrideWith(ChatPage Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChatPageProvider._internal(
        () => create()..context = context,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ChatPage, List<ChatData>>
      createElement() {
    return _ChatPageProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatPageProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChatPageRef on AutoDisposeAsyncNotifierProviderRef<List<ChatData>> {
  /// The parameter `context` of this provider.
  WidgetRef get context;
}

class _ChatPageProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ChatPage, List<ChatData>>
    with ChatPageRef {
  _ChatPageProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as ChatPageProvider).context;
}

String _$conversationPageHash() => r'dac8abdbee43cc8b626502b180acc43a684fe85c';

abstract class _$ConversationPage
    extends BuildlessAutoDisposeStreamNotifier<List<ConData>> {
  late final WidgetRef context;
  late final String topic_id;
  late final String first_message;

  Stream<List<ConData>> build(
    WidgetRef context,
    String topic_id,
    String first_message,
  );
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
    WidgetRef context,
    String topic_id,
    String first_message,
  ) {
    return ConversationPageProvider(
      context,
      topic_id,
      first_message,
    );
  }

  @override
  ConversationPageProvider getProviderOverride(
    covariant ConversationPageProvider provider,
  ) {
    return call(
      provider.context,
      provider.topic_id,
      provider.first_message,
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
    WidgetRef context,
    String topic_id,
    String first_message,
  ) : this._internal(
          () => ConversationPage()
            ..context = context
            ..topic_id = topic_id
            ..first_message = first_message,
          from: conversationPageProvider,
          name: r'conversationPageProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$conversationPageHash,
          dependencies: ConversationPageFamily._dependencies,
          allTransitiveDependencies:
              ConversationPageFamily._allTransitiveDependencies,
          context: context,
          topic_id: topic_id,
          first_message: first_message,
        );

  ConversationPageProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
    required this.topic_id,
    required this.first_message,
  }) : super.internal();

  final WidgetRef context;
  final String topic_id;
  final String first_message;

  @override
  Stream<List<ConData>> runNotifierBuild(
    covariant ConversationPage notifier,
  ) {
    return notifier.build(
      context,
      topic_id,
      first_message,
    );
  }

  @override
  Override overrideWith(ConversationPage Function() create) {
    return ProviderOverride(
      origin: this,
      override: ConversationPageProvider._internal(
        () => create()
          ..context = context
          ..topic_id = topic_id
          ..first_message = first_message,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
        topic_id: topic_id,
        first_message: first_message,
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
        other.context == context &&
        other.topic_id == topic_id &&
        other.first_message == first_message;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);
    hash = _SystemHash.combine(hash, topic_id.hashCode);
    hash = _SystemHash.combine(hash, first_message.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ConversationPageRef
    on AutoDisposeStreamNotifierProviderRef<List<ConData>> {
  /// The parameter `context` of this provider.
  WidgetRef get context;

  /// The parameter `topic_id` of this provider.
  String get topic_id;

  /// The parameter `first_message` of this provider.
  String get first_message;
}

class _ConversationPageProviderElement
    extends AutoDisposeStreamNotifierProviderElement<ConversationPage,
        List<ConData>> with ConversationPageRef {
  _ConversationPageProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as ConversationPageProvider).context;
  @override
  String get topic_id => (origin as ConversationPageProvider).topic_id;
  @override
  String get first_message =>
      (origin as ConversationPageProvider).first_message;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
