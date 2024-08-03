// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$commentsPagesHash() => r'08bdc967c205ed03f847dd709c26f77ae1e78ddf';

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

abstract class _$CommentsPages
    extends BuildlessAutoDisposeAsyncNotifier<List<CommentDatum>> {
  late final WidgetRef context;

  FutureOr<List<CommentDatum>> build(
    WidgetRef context,
  );
}

/// See also [CommentsPages].
@ProviderFor(CommentsPages)
const commentsPagesProvider = CommentsPagesFamily();

/// See also [CommentsPages].
class CommentsPagesFamily extends Family<AsyncValue<List<CommentDatum>>> {
  /// See also [CommentsPages].
  const CommentsPagesFamily();

  /// See also [CommentsPages].
  CommentsPagesProvider call(
    WidgetRef context,
  ) {
    return CommentsPagesProvider(
      context,
    );
  }

  @override
  CommentsPagesProvider getProviderOverride(
    covariant CommentsPagesProvider provider,
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
  String? get name => r'commentsPagesProvider';
}

/// See also [CommentsPages].
class CommentsPagesProvider extends AutoDisposeAsyncNotifierProviderImpl<
    CommentsPages, List<CommentDatum>> {
  /// See also [CommentsPages].
  CommentsPagesProvider(
    WidgetRef context,
  ) : this._internal(
          () => CommentsPages()..context = context,
          from: commentsPagesProvider,
          name: r'commentsPagesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$commentsPagesHash,
          dependencies: CommentsPagesFamily._dependencies,
          allTransitiveDependencies:
              CommentsPagesFamily._allTransitiveDependencies,
          context: context,
        );

  CommentsPagesProvider._internal(
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
  FutureOr<List<CommentDatum>> runNotifierBuild(
    covariant CommentsPages notifier,
  ) {
    return notifier.build(
      context,
    );
  }

  @override
  Override overrideWith(CommentsPages Function() create) {
    return ProviderOverride(
      origin: this,
      override: CommentsPagesProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<CommentsPages, List<CommentDatum>>
      createElement() {
    return _CommentsPagesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CommentsPagesProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CommentsPagesRef
    on AutoDisposeAsyncNotifierProviderRef<List<CommentDatum>> {
  /// The parameter `context` of this provider.
  WidgetRef get context;
}

class _CommentsPagesProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CommentsPages,
        List<CommentDatum>> with CommentsPagesRef {
  _CommentsPagesProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as CommentsPagesProvider).context;
}

String _$conversationCommentsHash() =>
    r'42a05c7f6b2d7fd65db9057c1be1ff5de3ac53b1';

abstract class _$ConversationComments
    extends BuildlessAutoDisposeAsyncNotifier<List<CommentDatum>> {
  late final WidgetRef context;
  late final String postID;
  late final String? sort;

  FutureOr<List<CommentDatum>> build(
    WidgetRef context,
    String postID,
    String? sort,
  );
}

/// See also [ConversationComments].
@ProviderFor(ConversationComments)
const conversationCommentsProvider = ConversationCommentsFamily();

/// See also [ConversationComments].
class ConversationCommentsFamily
    extends Family<AsyncValue<List<CommentDatum>>> {
  /// See also [ConversationComments].
  const ConversationCommentsFamily();

  /// See also [ConversationComments].
  ConversationCommentsProvider call(
    WidgetRef context,
    String postID,
    String? sort,
  ) {
    return ConversationCommentsProvider(
      context,
      postID,
      sort,
    );
  }

  @override
  ConversationCommentsProvider getProviderOverride(
    covariant ConversationCommentsProvider provider,
  ) {
    return call(
      provider.context,
      provider.postID,
      provider.sort,
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
  String? get name => r'conversationCommentsProvider';
}

/// See also [ConversationComments].
class ConversationCommentsProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ConversationComments, List<CommentDatum>> {
  /// See also [ConversationComments].
  ConversationCommentsProvider(
    WidgetRef context,
    String postID,
    String? sort,
  ) : this._internal(
          () => ConversationComments()
            ..context = context
            ..postID = postID
            ..sort = sort,
          from: conversationCommentsProvider,
          name: r'conversationCommentsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$conversationCommentsHash,
          dependencies: ConversationCommentsFamily._dependencies,
          allTransitiveDependencies:
              ConversationCommentsFamily._allTransitiveDependencies,
          context: context,
          postID: postID,
          sort: sort,
        );

  ConversationCommentsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
    required this.postID,
    required this.sort,
  }) : super.internal();

  final WidgetRef context;
  final String postID;
  final String? sort;

  @override
  FutureOr<List<CommentDatum>> runNotifierBuild(
    covariant ConversationComments notifier,
  ) {
    return notifier.build(
      context,
      postID,
      sort,
    );
  }

  @override
  Override overrideWith(ConversationComments Function() create) {
    return ProviderOverride(
      origin: this,
      override: ConversationCommentsProvider._internal(
        () => create()
          ..context = context
          ..postID = postID
          ..sort = sort,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
        postID: postID,
        sort: sort,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ConversationComments,
      List<CommentDatum>> createElement() {
    return _ConversationCommentsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ConversationCommentsProvider &&
        other.context == context &&
        other.postID == postID &&
        other.sort == sort;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);
    hash = _SystemHash.combine(hash, postID.hashCode);
    hash = _SystemHash.combine(hash, sort.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ConversationCommentsRef
    on AutoDisposeAsyncNotifierProviderRef<List<CommentDatum>> {
  /// The parameter `context` of this provider.
  WidgetRef get context;

  /// The parameter `postID` of this provider.
  String get postID;

  /// The parameter `sort` of this provider.
  String? get sort;
}

class _ConversationCommentsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ConversationComments,
        List<CommentDatum>> with ConversationCommentsRef {
  _ConversationCommentsProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as ConversationCommentsProvider).context;
  @override
  String get postID => (origin as ConversationCommentsProvider).postID;
  @override
  String? get sort => (origin as ConversationCommentsProvider).sort;
}

String _$replyCommentsHash() => r'9629eb03e45503c4c2b8c7532b2c4507c15e2dff';

abstract class _$ReplyComments
    extends BuildlessAutoDisposeAsyncNotifier<CommentDatum?> {
  late final WidgetRef context;
  late final String postID;
  late final String? sort;
  late final String? reply_id;

  FutureOr<CommentDatum?> build(
    WidgetRef context,
    String postID,
    String? sort,
    String? reply_id,
  );
}

/// See also [ReplyComments].
@ProviderFor(ReplyComments)
const replyCommentsProvider = ReplyCommentsFamily();

/// See also [ReplyComments].
class ReplyCommentsFamily extends Family<AsyncValue<CommentDatum?>> {
  /// See also [ReplyComments].
  const ReplyCommentsFamily();

  /// See also [ReplyComments].
  ReplyCommentsProvider call(
    WidgetRef context,
    String postID,
    String? sort,
    String? reply_id,
  ) {
    return ReplyCommentsProvider(
      context,
      postID,
      sort,
      reply_id,
    );
  }

  @override
  ReplyCommentsProvider getProviderOverride(
    covariant ReplyCommentsProvider provider,
  ) {
    return call(
      provider.context,
      provider.postID,
      provider.sort,
      provider.reply_id,
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
  String? get name => r'replyCommentsProvider';
}

/// See also [ReplyComments].
class ReplyCommentsProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ReplyComments, CommentDatum?> {
  /// See also [ReplyComments].
  ReplyCommentsProvider(
    WidgetRef context,
    String postID,
    String? sort,
    String? reply_id,
  ) : this._internal(
          () => ReplyComments()
            ..context = context
            ..postID = postID
            ..sort = sort
            ..reply_id = reply_id,
          from: replyCommentsProvider,
          name: r'replyCommentsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$replyCommentsHash,
          dependencies: ReplyCommentsFamily._dependencies,
          allTransitiveDependencies:
              ReplyCommentsFamily._allTransitiveDependencies,
          context: context,
          postID: postID,
          sort: sort,
          reply_id: reply_id,
        );

  ReplyCommentsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
    required this.postID,
    required this.sort,
    required this.reply_id,
  }) : super.internal();

  final WidgetRef context;
  final String postID;
  final String? sort;
  final String? reply_id;

  @override
  FutureOr<CommentDatum?> runNotifierBuild(
    covariant ReplyComments notifier,
  ) {
    return notifier.build(
      context,
      postID,
      sort,
      reply_id,
    );
  }

  @override
  Override overrideWith(ReplyComments Function() create) {
    return ProviderOverride(
      origin: this,
      override: ReplyCommentsProvider._internal(
        () => create()
          ..context = context
          ..postID = postID
          ..sort = sort
          ..reply_id = reply_id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
        postID: postID,
        sort: sort,
        reply_id: reply_id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ReplyComments, CommentDatum?>
      createElement() {
    return _ReplyCommentsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ReplyCommentsProvider &&
        other.context == context &&
        other.postID == postID &&
        other.sort == sort &&
        other.reply_id == reply_id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);
    hash = _SystemHash.combine(hash, postID.hashCode);
    hash = _SystemHash.combine(hash, sort.hashCode);
    hash = _SystemHash.combine(hash, reply_id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ReplyCommentsRef on AutoDisposeAsyncNotifierProviderRef<CommentDatum?> {
  /// The parameter `context` of this provider.
  WidgetRef get context;

  /// The parameter `postID` of this provider.
  String get postID;

  /// The parameter `sort` of this provider.
  String? get sort;

  /// The parameter `reply_id` of this provider.
  String? get reply_id;
}

class _ReplyCommentsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ReplyComments,
        CommentDatum?> with ReplyCommentsRef {
  _ReplyCommentsProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as ReplyCommentsProvider).context;
  @override
  String get postID => (origin as ReplyCommentsProvider).postID;
  @override
  String? get sort => (origin as ReplyCommentsProvider).sort;
  @override
  String? get reply_id => (origin as ReplyCommentsProvider).reply_id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
