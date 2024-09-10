// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searchuser_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getSearchUserHash() => r'5b475abe8142c9b6fa0fb80769b137122f542111';

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

abstract class _$GetSearchUser
    extends BuildlessAutoDisposeAsyncNotifier<List<Store_?>?> {
  late final WidgetRef context;
  late final String type;
  late final String keyword;

  FutureOr<List<Store_?>?> build(
    WidgetRef context,
    String type,
    String keyword,
  );
}

/// See also [GetSearchUser].
@ProviderFor(GetSearchUser)
const getSearchUserProvider = GetSearchUserFamily();

/// See also [GetSearchUser].
class GetSearchUserFamily extends Family<AsyncValue<List<Store_?>?>> {
  /// See also [GetSearchUser].
  const GetSearchUserFamily();

  /// See also [GetSearchUser].
  GetSearchUserProvider call(
    WidgetRef context,
    String type,
    String keyword,
  ) {
    return GetSearchUserProvider(
      context,
      type,
      keyword,
    );
  }

  @override
  GetSearchUserProvider getProviderOverride(
    covariant GetSearchUserProvider provider,
  ) {
    return call(
      provider.context,
      provider.type,
      provider.keyword,
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
  String? get name => r'getSearchUserProvider';
}

/// See also [GetSearchUser].
class GetSearchUserProvider extends AutoDisposeAsyncNotifierProviderImpl<
    GetSearchUser, List<Store_?>?> {
  /// See also [GetSearchUser].
  GetSearchUserProvider(
    WidgetRef context,
    String type,
    String keyword,
  ) : this._internal(
          () => GetSearchUser()
            ..context = context
            ..type = type
            ..keyword = keyword,
          from: getSearchUserProvider,
          name: r'getSearchUserProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getSearchUserHash,
          dependencies: GetSearchUserFamily._dependencies,
          allTransitiveDependencies:
              GetSearchUserFamily._allTransitiveDependencies,
          context: context,
          type: type,
          keyword: keyword,
        );

  GetSearchUserProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
    required this.type,
    required this.keyword,
  }) : super.internal();

  final WidgetRef context;
  final String type;
  final String keyword;

  @override
  FutureOr<List<Store_?>?> runNotifierBuild(
    covariant GetSearchUser notifier,
  ) {
    return notifier.build(
      context,
      type,
      keyword,
    );
  }

  @override
  Override overrideWith(GetSearchUser Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetSearchUserProvider._internal(
        () => create()
          ..context = context
          ..type = type
          ..keyword = keyword,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
        type: type,
        keyword: keyword,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GetSearchUser, List<Store_?>?>
      createElement() {
    return _GetSearchUserProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetSearchUserProvider &&
        other.context == context &&
        other.type == type &&
        other.keyword == keyword;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);
    hash = _SystemHash.combine(hash, keyword.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetSearchUserRef on AutoDisposeAsyncNotifierProviderRef<List<Store_?>?> {
  /// The parameter `context` of this provider.
  WidgetRef get context;

  /// The parameter `type` of this provider.
  String get type;

  /// The parameter `keyword` of this provider.
  String get keyword;
}

class _GetSearchUserProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetSearchUser,
        List<Store_?>?> with GetSearchUserRef {
  _GetSearchUserProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as GetSearchUserProvider).context;
  @override
  String get type => (origin as GetSearchUserProvider).type;
  @override
  String get keyword => (origin as GetSearchUserProvider).keyword;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
