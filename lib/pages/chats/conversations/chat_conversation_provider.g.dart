// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_conversation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getTopByUidHash() => r'c7cad26e3f89b19fc1be2ba1f31669fd8b981732';

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

abstract class _$GetTopByUid
    extends BuildlessAutoDisposeAsyncNotifier<ChatData?> {
  late final WidgetRef context;
  late final String topic_id;
  late final String? to_id;
  late final String? adid;

  FutureOr<ChatData?> build(
    WidgetRef context, {
    String topic_id = '0',
    String? to_id,
    String? adid,
  });
}

/// See also [GetTopByUid].
@ProviderFor(GetTopByUid)
const getTopByUidProvider = GetTopByUidFamily();

/// See also [GetTopByUid].
class GetTopByUidFamily extends Family<AsyncValue<ChatData?>> {
  /// See also [GetTopByUid].
  const GetTopByUidFamily();

  /// See also [GetTopByUid].
  GetTopByUidProvider call(
    WidgetRef context, {
    String topic_id = '0',
    String? to_id,
    String? adid,
  }) {
    return GetTopByUidProvider(
      context,
      topic_id: topic_id,
      to_id: to_id,
      adid: adid,
    );
  }

  @override
  GetTopByUidProvider getProviderOverride(
    covariant GetTopByUidProvider provider,
  ) {
    return call(
      provider.context,
      topic_id: provider.topic_id,
      to_id: provider.to_id,
      adid: provider.adid,
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
  String? get name => r'getTopByUidProvider';
}

/// See also [GetTopByUid].
class GetTopByUidProvider
    extends AutoDisposeAsyncNotifierProviderImpl<GetTopByUid, ChatData?> {
  /// See also [GetTopByUid].
  GetTopByUidProvider(
    WidgetRef context, {
    String topic_id = '0',
    String? to_id,
    String? adid,
  }) : this._internal(
          () => GetTopByUid()
            ..context = context
            ..topic_id = topic_id
            ..to_id = to_id
            ..adid = adid,
          from: getTopByUidProvider,
          name: r'getTopByUidProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getTopByUidHash,
          dependencies: GetTopByUidFamily._dependencies,
          allTransitiveDependencies:
              GetTopByUidFamily._allTransitiveDependencies,
          context: context,
          topic_id: topic_id,
          to_id: to_id,
          adid: adid,
        );

  GetTopByUidProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
    required this.topic_id,
    required this.to_id,
    required this.adid,
  }) : super.internal();

  final WidgetRef context;
  final String topic_id;
  final String? to_id;
  final String? adid;

  @override
  FutureOr<ChatData?> runNotifierBuild(
    covariant GetTopByUid notifier,
  ) {
    return notifier.build(
      context,
      topic_id: topic_id,
      to_id: to_id,
      adid: adid,
    );
  }

  @override
  Override overrideWith(GetTopByUid Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetTopByUidProvider._internal(
        () => create()
          ..context = context
          ..topic_id = topic_id
          ..to_id = to_id
          ..adid = adid,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
        topic_id: topic_id,
        to_id: to_id,
        adid: adid,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GetTopByUid, ChatData?>
      createElement() {
    return _GetTopByUidProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetTopByUidProvider &&
        other.context == context &&
        other.topic_id == topic_id &&
        other.to_id == to_id &&
        other.adid == adid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);
    hash = _SystemHash.combine(hash, topic_id.hashCode);
    hash = _SystemHash.combine(hash, to_id.hashCode);
    hash = _SystemHash.combine(hash, adid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetTopByUidRef on AutoDisposeAsyncNotifierProviderRef<ChatData?> {
  /// The parameter `context` of this provider.
  WidgetRef get context;

  /// The parameter `topic_id` of this provider.
  String get topic_id;

  /// The parameter `to_id` of this provider.
  String? get to_id;

  /// The parameter `adid` of this provider.
  String? get adid;
}

class _GetTopByUidProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetTopByUid, ChatData?>
    with GetTopByUidRef {
  _GetTopByUidProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as GetTopByUidProvider).context;
  @override
  String get topic_id => (origin as GetTopByUidProvider).topic_id;
  @override
  String? get to_id => (origin as GetTopByUidProvider).to_id;
  @override
  String? get adid => (origin as GetTopByUidProvider).adid;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
