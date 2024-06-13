// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$subListsHash() => r'b399aedf88abb3086573c495abd408921f229861';

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

abstract class _$SubLists
    extends BuildlessAutoDisposeAsyncNotifier<List<GridCard>> {
  late final String category;
  late final Map<dynamic, dynamic>? newFilter;

  FutureOr<List<GridCard>> build(
    String category, {
    Map<dynamic, dynamic>? newFilter,
  });
}

/// See also [SubLists].
@ProviderFor(SubLists)
const subListsProvider = SubListsFamily();

/// See also [SubLists].
class SubListsFamily extends Family<AsyncValue<List<GridCard>>> {
  /// See also [SubLists].
  const SubListsFamily();

  /// See also [SubLists].
  SubListsProvider call(
    String category, {
    Map<dynamic, dynamic>? newFilter,
  }) {
    return SubListsProvider(
      category,
      newFilter: newFilter,
    );
  }

  @override
  SubListsProvider getProviderOverride(
    covariant SubListsProvider provider,
  ) {
    return call(
      provider.category,
      newFilter: provider.newFilter,
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
  String? get name => r'subListsProvider';
}

/// See also [SubLists].
class SubListsProvider
    extends AutoDisposeAsyncNotifierProviderImpl<SubLists, List<GridCard>> {
  /// See also [SubLists].
  SubListsProvider(
    String category, {
    Map<dynamic, dynamic>? newFilter,
  }) : this._internal(
          () => SubLists()
            ..category = category
            ..newFilter = newFilter,
          from: subListsProvider,
          name: r'subListsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$subListsHash,
          dependencies: SubListsFamily._dependencies,
          allTransitiveDependencies: SubListsFamily._allTransitiveDependencies,
          category: category,
          newFilter: newFilter,
        );

  SubListsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.category,
    required this.newFilter,
  }) : super.internal();

  final String category;
  final Map<dynamic, dynamic>? newFilter;

  @override
  FutureOr<List<GridCard>> runNotifierBuild(
    covariant SubLists notifier,
  ) {
    return notifier.build(
      category,
      newFilter: newFilter,
    );
  }

  @override
  Override overrideWith(SubLists Function() create) {
    return ProviderOverride(
      origin: this,
      override: SubListsProvider._internal(
        () => create()
          ..category = category
          ..newFilter = newFilter,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        category: category,
        newFilter: newFilter,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<SubLists, List<GridCard>>
      createElement() {
    return _SubListsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SubListsProvider &&
        other.category == category &&
        other.newFilter == newFilter;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);
    hash = _SystemHash.combine(hash, newFilter.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SubListsRef on AutoDisposeAsyncNotifierProviderRef<List<GridCard>> {
  /// The parameter `category` of this provider.
  String get category;

  /// The parameter `newFilter` of this provider.
  Map<dynamic, dynamic>? get newFilter;
}

class _SubListsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<SubLists, List<GridCard>>
    with SubListsRef {
  _SubListsProviderElement(super.provider);

  @override
  String get category => (origin as SubListsProvider).category;
  @override
  Map<dynamic, dynamic>? get newFilter =>
      (origin as SubListsProvider).newFilter;
}

String _$getFiltersHash() => r'bced87216e332a514f37ae9413ec391d3a4d69bc';

abstract class _$GetFilters extends BuildlessAutoDisposeAsyncNotifier<List> {
  late final String slug;

  FutureOr<List> build(
    String slug,
  );
}

/// See also [GetFilters].
@ProviderFor(GetFilters)
const getFiltersProvider = GetFiltersFamily();

/// See also [GetFilters].
class GetFiltersFamily extends Family<AsyncValue<List>> {
  /// See also [GetFilters].
  const GetFiltersFamily();

  /// See also [GetFilters].
  GetFiltersProvider call(
    String slug,
  ) {
    return GetFiltersProvider(
      slug,
    );
  }

  @override
  GetFiltersProvider getProviderOverride(
    covariant GetFiltersProvider provider,
  ) {
    return call(
      provider.slug,
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
  String? get name => r'getFiltersProvider';
}

/// See also [GetFilters].
class GetFiltersProvider
    extends AutoDisposeAsyncNotifierProviderImpl<GetFilters, List> {
  /// See also [GetFilters].
  GetFiltersProvider(
    String slug,
  ) : this._internal(
          () => GetFilters()..slug = slug,
          from: getFiltersProvider,
          name: r'getFiltersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getFiltersHash,
          dependencies: GetFiltersFamily._dependencies,
          allTransitiveDependencies:
              GetFiltersFamily._allTransitiveDependencies,
          slug: slug,
        );

  GetFiltersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.slug,
  }) : super.internal();

  final String slug;

  @override
  FutureOr<List> runNotifierBuild(
    covariant GetFilters notifier,
  ) {
    return notifier.build(
      slug,
    );
  }

  @override
  Override overrideWith(GetFilters Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetFiltersProvider._internal(
        () => create()..slug = slug,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        slug: slug,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GetFilters, List> createElement() {
    return _GetFiltersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetFiltersProvider && other.slug == slug;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, slug.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetFiltersRef on AutoDisposeAsyncNotifierProviderRef<List> {
  /// The parameter `slug` of this provider.
  String get slug;
}

class _GetFiltersProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetFilters, List>
    with GetFiltersRef {
  _GetFiltersProviderElement(super.provider);

  @override
  String get slug => (origin as GetFiltersProvider).slug;
}

String _$getLocationHash() => r'87e2a529a3a3fdcaf7c6590fe676923b76b113db';

abstract class _$GetLocation extends BuildlessAutoDisposeAsyncNotifier<List> {
  late final String type;
  late final String parent;

  FutureOr<List> build(
    String type,
    String parent,
  );
}

/// See also [GetLocation].
@ProviderFor(GetLocation)
const getLocationProvider = GetLocationFamily();

/// See also [GetLocation].
class GetLocationFamily extends Family<AsyncValue<List>> {
  /// See also [GetLocation].
  const GetLocationFamily();

  /// See also [GetLocation].
  GetLocationProvider call(
    String type,
    String parent,
  ) {
    return GetLocationProvider(
      type,
      parent,
    );
  }

  @override
  GetLocationProvider getProviderOverride(
    covariant GetLocationProvider provider,
  ) {
    return call(
      provider.type,
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
  String? get name => r'getLocationProvider';
}

/// See also [GetLocation].
class GetLocationProvider
    extends AutoDisposeAsyncNotifierProviderImpl<GetLocation, List> {
  /// See also [GetLocation].
  GetLocationProvider(
    String type,
    String parent,
  ) : this._internal(
          () => GetLocation()
            ..type = type
            ..parent = parent,
          from: getLocationProvider,
          name: r'getLocationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getLocationHash,
          dependencies: GetLocationFamily._dependencies,
          allTransitiveDependencies:
              GetLocationFamily._allTransitiveDependencies,
          type: type,
          parent: parent,
        );

  GetLocationProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
    required this.parent,
  }) : super.internal();

  final String type;
  final String parent;

  @override
  FutureOr<List> runNotifierBuild(
    covariant GetLocation notifier,
  ) {
    return notifier.build(
      type,
      parent,
    );
  }

  @override
  Override overrideWith(GetLocation Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetLocationProvider._internal(
        () => create()
          ..type = type
          ..parent = parent,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
        parent: parent,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GetLocation, List> createElement() {
    return _GetLocationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetLocationProvider &&
        other.type == type &&
        other.parent == parent;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);
    hash = _SystemHash.combine(hash, parent.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetLocationRef on AutoDisposeAsyncNotifierProviderRef<List> {
  /// The parameter `type` of this provider.
  String get type;

  /// The parameter `parent` of this provider.
  String get parent;
}

class _GetLocationProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetLocation, List>
    with GetLocationRef {
  _GetLocationProviderElement(super.provider);

  @override
  String get type => (origin as GetLocationProvider).type;
  @override
  String get parent => (origin as GetLocationProvider).parent;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
