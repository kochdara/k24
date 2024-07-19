// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getMainCategoryHash() => r'98391328796c61da0e2d0b79268b3b34bae0f35f';

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

abstract class _$GetMainCategory
    extends BuildlessAutoDisposeAsyncNotifier<List<MainCategory>> {
  late final String parent;

  FutureOr<List<MainCategory>> build(
    String parent,
  );
}

/// See also [GetMainCategory].
@ProviderFor(GetMainCategory)
const getMainCategoryProvider = GetMainCategoryFamily();

/// See also [GetMainCategory].
class GetMainCategoryFamily extends Family<AsyncValue<List<MainCategory>>> {
  /// See also [GetMainCategory].
  const GetMainCategoryFamily();

  /// See also [GetMainCategory].
  GetMainCategoryProvider call(
    String parent,
  ) {
    return GetMainCategoryProvider(
      parent,
    );
  }

  @override
  GetMainCategoryProvider getProviderOverride(
    covariant GetMainCategoryProvider provider,
  ) {
    return call(
      provider.parent,
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
  String? get name => r'getMainCategoryProvider';
}

/// See also [GetMainCategory].
class GetMainCategoryProvider extends AutoDisposeAsyncNotifierProviderImpl<
    GetMainCategory, List<MainCategory>> {
  /// See also [GetMainCategory].
  GetMainCategoryProvider(
    String parent,
  ) : this._internal(
          () => GetMainCategory()..parent = parent,
          from: getMainCategoryProvider,
          name: r'getMainCategoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getMainCategoryHash,
          dependencies: GetMainCategoryFamily._dependencies,
          allTransitiveDependencies:
              GetMainCategoryFamily._allTransitiveDependencies,
          parent: parent,
        );

  GetMainCategoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.parent,
  }) : super.internal();

  final String parent;

  @override
  FutureOr<List<MainCategory>> runNotifierBuild(
    covariant GetMainCategory notifier,
  ) {
    return notifier.build(
      parent,
    );
  }

  @override
  Override overrideWith(GetMainCategory Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetMainCategoryProvider._internal(
        () => create()..parent = parent,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        parent: parent,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GetMainCategory, List<MainCategory>>
      createElement() {
    return _GetMainCategoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetMainCategoryProvider && other.parent == parent;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, parent.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetMainCategoryRef
    on AutoDisposeAsyncNotifierProviderRef<List<MainCategory>> {
  /// The parameter `parent` of this provider.
  String get parent;
}

class _GetMainCategoryProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetMainCategory,
        List<MainCategory>> with GetMainCategoryRef {
  _GetMainCategoryProviderElement(super.provider);

  @override
  String get parent => (origin as GetMainCategoryProvider).parent;
}

String _$homeListsHash() => r'884de78a9f5e40d2579c1fe6a6798fc9d7725d03';

abstract class _$HomeLists
    extends BuildlessAutoDisposeAsyncNotifier<List<GridCard>> {
  late final String accessTokens;
  late final Map<dynamic, dynamic>? newData;

  FutureOr<List<GridCard>> build(
    String accessTokens,
    Map<dynamic, dynamic>? newData,
  );
}

/// See also [HomeLists].
@ProviderFor(HomeLists)
const homeListsProvider = HomeListsFamily();

/// See also [HomeLists].
class HomeListsFamily extends Family<AsyncValue<List<GridCard>>> {
  /// See also [HomeLists].
  const HomeListsFamily();

  /// See also [HomeLists].
  HomeListsProvider call(
    String accessTokens,
    Map<dynamic, dynamic>? newData,
  ) {
    return HomeListsProvider(
      accessTokens,
      newData,
    );
  }

  @override
  HomeListsProvider getProviderOverride(
    covariant HomeListsProvider provider,
  ) {
    return call(
      provider.accessTokens,
      provider.newData,
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
  String? get name => r'homeListsProvider';
}

/// See also [HomeLists].
class HomeListsProvider
    extends AutoDisposeAsyncNotifierProviderImpl<HomeLists, List<GridCard>> {
  /// See also [HomeLists].
  HomeListsProvider(
    String accessTokens,
    Map<dynamic, dynamic>? newData,
  ) : this._internal(
          () => HomeLists()
            ..accessTokens = accessTokens
            ..newData = newData,
          from: homeListsProvider,
          name: r'homeListsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$homeListsHash,
          dependencies: HomeListsFamily._dependencies,
          allTransitiveDependencies: HomeListsFamily._allTransitiveDependencies,
          accessTokens: accessTokens,
          newData: newData,
        );

  HomeListsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.accessTokens,
    required this.newData,
  }) : super.internal();

  final String accessTokens;
  final Map<dynamic, dynamic>? newData;

  @override
  FutureOr<List<GridCard>> runNotifierBuild(
    covariant HomeLists notifier,
  ) {
    return notifier.build(
      accessTokens,
      newData,
    );
  }

  @override
  Override overrideWith(HomeLists Function() create) {
    return ProviderOverride(
      origin: this,
      override: HomeListsProvider._internal(
        () => create()
          ..accessTokens = accessTokens
          ..newData = newData,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        accessTokens: accessTokens,
        newData: newData,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<HomeLists, List<GridCard>>
      createElement() {
    return _HomeListsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HomeListsProvider &&
        other.accessTokens == accessTokens &&
        other.newData == newData;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, accessTokens.hashCode);
    hash = _SystemHash.combine(hash, newData.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin HomeListsRef on AutoDisposeAsyncNotifierProviderRef<List<GridCard>> {
  /// The parameter `accessTokens` of this provider.
  String get accessTokens;

  /// The parameter `newData` of this provider.
  Map<dynamic, dynamic>? get newData;
}

class _HomeListsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<HomeLists, List<GridCard>>
    with HomeListsRef {
  _HomeListsProviderElement(super.provider);

  @override
  String get accessTokens => (origin as HomeListsProvider).accessTokens;
  @override
  Map<dynamic, dynamic>? get newData => (origin as HomeListsProvider).newData;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
