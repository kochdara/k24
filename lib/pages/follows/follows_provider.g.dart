// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follows_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getFollowsHash() => r'87c1460c2dfb947f56c4f16ef81e2ecca40ef9bd';

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

abstract class _$GetFollows
    extends BuildlessAutoDisposeAsyncNotifier<List<FollowsDatum?>?> {
  late final WidgetRef context;
  late final String? type;
  late final String? storeId;
  late final String? username;

  FutureOr<List<FollowsDatum?>?> build(
    WidgetRef context,
    String? type, {
    String? storeId,
    String? username,
  });
}

/// See also [GetFollows].
@ProviderFor(GetFollows)
const getFollowsProvider = GetFollowsFamily();

/// See also [GetFollows].
class GetFollowsFamily extends Family<AsyncValue<List<FollowsDatum?>?>> {
  /// See also [GetFollows].
  const GetFollowsFamily();

  /// See also [GetFollows].
  GetFollowsProvider call(
    WidgetRef context,
    String? type, {
    String? storeId,
    String? username,
  }) {
    return GetFollowsProvider(
      context,
      type,
      storeId: storeId,
      username: username,
    );
  }

  @override
  GetFollowsProvider getProviderOverride(
    covariant GetFollowsProvider provider,
  ) {
    return call(
      provider.context,
      provider.type,
      storeId: provider.storeId,
      username: provider.username,
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
  String? get name => r'getFollowsProvider';
}

/// See also [GetFollows].
class GetFollowsProvider extends AutoDisposeAsyncNotifierProviderImpl<
    GetFollows, List<FollowsDatum?>?> {
  /// See also [GetFollows].
  GetFollowsProvider(
    WidgetRef context,
    String? type, {
    String? storeId,
    String? username,
  }) : this._internal(
          () => GetFollows()
            ..context = context
            ..type = type
            ..storeId = storeId
            ..username = username,
          from: getFollowsProvider,
          name: r'getFollowsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getFollowsHash,
          dependencies: GetFollowsFamily._dependencies,
          allTransitiveDependencies:
              GetFollowsFamily._allTransitiveDependencies,
          context: context,
          type: type,
          storeId: storeId,
          username: username,
        );

  GetFollowsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
    required this.type,
    required this.storeId,
    required this.username,
  }) : super.internal();

  final WidgetRef context;
  final String? type;
  final String? storeId;
  final String? username;

  @override
  FutureOr<List<FollowsDatum?>?> runNotifierBuild(
    covariant GetFollows notifier,
  ) {
    return notifier.build(
      context,
      type,
      storeId: storeId,
      username: username,
    );
  }

  @override
  Override overrideWith(GetFollows Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetFollowsProvider._internal(
        () => create()
          ..context = context
          ..type = type
          ..storeId = storeId
          ..username = username,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
        type: type,
        storeId: storeId,
        username: username,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GetFollows, List<FollowsDatum?>?>
      createElement() {
    return _GetFollowsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetFollowsProvider &&
        other.context == context &&
        other.type == type &&
        other.storeId == storeId &&
        other.username == username;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);
    hash = _SystemHash.combine(hash, storeId.hashCode);
    hash = _SystemHash.combine(hash, username.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetFollowsRef
    on AutoDisposeAsyncNotifierProviderRef<List<FollowsDatum?>?> {
  /// The parameter `context` of this provider.
  WidgetRef get context;

  /// The parameter `type` of this provider.
  String? get type;

  /// The parameter `storeId` of this provider.
  String? get storeId;

  /// The parameter `username` of this provider.
  String? get username;
}

class _GetFollowsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetFollows,
        List<FollowsDatum?>?> with GetFollowsRef {
  _GetFollowsProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as GetFollowsProvider).context;
  @override
  String? get type => (origin as GetFollowsProvider).type;
  @override
  String? get storeId => (origin as GetFollowsProvider).storeId;
  @override
  String? get username => (origin as GetFollowsProvider).username;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
