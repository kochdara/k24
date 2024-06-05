// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getMainCategoryHash() => r'ecac940b085c062a73f102cec5381216bb11ebfa';

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
    extends BuildlessAsyncNotifier<List<MainCategory>> {
  late final String parent;

  FutureOr<List<MainCategory>> build({
    String parent = '0',
  });
}

/// See also [GetMainCategory].
@ProviderFor(GetMainCategory)
const getMainCategoryProvider = GetMainCategoryFamily();

/// See also [GetMainCategory].
class GetMainCategoryFamily extends Family<AsyncValue<List<MainCategory>>> {
  /// See also [GetMainCategory].
  const GetMainCategoryFamily();

  /// See also [GetMainCategory].
  GetMainCategoryProvider call({
    String parent = '0',
  }) {
    return GetMainCategoryProvider(
      parent: parent,
    );
  }

  @override
  GetMainCategoryProvider getProviderOverride(
    covariant GetMainCategoryProvider provider,
  ) {
    return call(
      parent: provider.parent,
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
class GetMainCategoryProvider
    extends AsyncNotifierProviderImpl<GetMainCategory, List<MainCategory>> {
  /// See also [GetMainCategory].
  GetMainCategoryProvider({
    String parent = '0',
  }) : this._internal(
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
      parent: parent,
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
  AsyncNotifierProviderElement<GetMainCategory, List<MainCategory>>
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

mixin GetMainCategoryRef on AsyncNotifierProviderRef<List<MainCategory>> {
  /// The parameter `parent` of this provider.
  String get parent;
}

class _GetMainCategoryProviderElement
    extends AsyncNotifierProviderElement<GetMainCategory, List<MainCategory>>
    with GetMainCategoryRef {
  _GetMainCategoryProviderElement(super.provider);

  @override
  String get parent => (origin as GetMainCategoryProvider).parent;
}

String _$homeListsHash() => r'16afc1209e1e5c9c55951d852f56a87a693ae990';

/// See also [HomeLists].
@ProviderFor(HomeLists)
final homeListsProvider =
    AsyncNotifierProvider<HomeLists, List<GridCard>>.internal(
  HomeLists.new,
  name: r'homeListsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$homeListsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HomeLists = AsyncNotifier<List<GridCard>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
