// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$subListsHash() => r'64fc95e20ff8b21e586ed01dd2e36668d98f1708';

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

abstract class _$SubLists extends BuildlessAsyncNotifier<List<GridCard>> {
  late final String category;

  FutureOr<List<GridCard>> build({
    String category = '',
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
  SubListsProvider call({
    String category = '',
  }) {
    return SubListsProvider(
      category: category,
    );
  }

  @override
  SubListsProvider getProviderOverride(
    covariant SubListsProvider provider,
  ) {
    return call(
      category: provider.category,
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
    extends AsyncNotifierProviderImpl<SubLists, List<GridCard>> {
  /// See also [SubLists].
  SubListsProvider({
    String category = '',
  }) : this._internal(
          () => SubLists()..category = category,
          from: subListsProvider,
          name: r'subListsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$subListsHash,
          dependencies: SubListsFamily._dependencies,
          allTransitiveDependencies: SubListsFamily._allTransitiveDependencies,
          category: category,
        );

  SubListsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.category,
  }) : super.internal();

  final String category;

  @override
  FutureOr<List<GridCard>> runNotifierBuild(
    covariant SubLists notifier,
  ) {
    return notifier.build(
      category: category,
    );
  }

  @override
  Override overrideWith(SubLists Function() create) {
    return ProviderOverride(
      origin: this,
      override: SubListsProvider._internal(
        () => create()..category = category,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        category: category,
      ),
    );
  }

  @override
  AsyncNotifierProviderElement<SubLists, List<GridCard>> createElement() {
    return _SubListsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SubListsProvider && other.category == category;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SubListsRef on AsyncNotifierProviderRef<List<GridCard>> {
  /// The parameter `category` of this provider.
  String get category;
}

class _SubListsProviderElement
    extends AsyncNotifierProviderElement<SubLists, List<GridCard>>
    with SubListsRef {
  _SubListsProviderElement(super.provider);

  @override
  String get category => (origin as SubListsProvider).category;
}

String _$getFiltersHash() => r'615c75f4a8af0396e0520a47e05f1e3a5b5a78c7';

abstract class _$GetFilters extends BuildlessAsyncNotifier<List> {
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
class GetFiltersProvider extends AsyncNotifierProviderImpl<GetFilters, List> {
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
  AsyncNotifierProviderElement<GetFilters, List> createElement() {
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

mixin GetFiltersRef on AsyncNotifierProviderRef<List> {
  /// The parameter `slug` of this provider.
  String get slug;
}

class _GetFiltersProviderElement
    extends AsyncNotifierProviderElement<GetFilters, List> with GetFiltersRef {
  _GetFiltersProviderElement(super.provider);

  @override
  String get slug => (origin as GetFiltersProvider).slug;
}

String _$getLocationHash() => r'b33793541ec2e7dc5aac093d8cec6eda6d64bc22';

abstract class _$GetLocation extends BuildlessAsyncNotifier<List> {
  late final String type;
  late final String parent;

  FutureOr<List> build({
    String type = '',
    String parent = '',
  });
}

/// See also [GetLocation].
@ProviderFor(GetLocation)
const getLocationProvider = GetLocationFamily();

/// See also [GetLocation].
class GetLocationFamily extends Family<AsyncValue<List>> {
  /// See also [GetLocation].
  const GetLocationFamily();

  /// See also [GetLocation].
  GetLocationProvider call({
    String type = '',
    String parent = '',
  }) {
    return GetLocationProvider(
      type: type,
      parent: parent,
    );
  }

  @override
  GetLocationProvider getProviderOverride(
    covariant GetLocationProvider provider,
  ) {
    return call(
      type: provider.type,
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
  String? get name => r'getLocationProvider';
}

/// See also [GetLocation].
class GetLocationProvider extends AsyncNotifierProviderImpl<GetLocation, List> {
  /// See also [GetLocation].
  GetLocationProvider({
    String type = '',
    String parent = '',
  }) : this._internal(
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
      type: type,
      parent: parent,
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
  AsyncNotifierProviderElement<GetLocation, List> createElement() {
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

mixin GetLocationRef on AsyncNotifierProviderRef<List> {
  /// The parameter `type` of this provider.
  String get type;

  /// The parameter `parent` of this provider.
  String get parent;
}

class _GetLocationProviderElement
    extends AsyncNotifierProviderElement<GetLocation, List>
    with GetLocationRef {
  _GetLocationProviderElement(super.provider);

  @override
  String get type => (origin as GetLocationProvider).type;
  @override
  String get parent => (origin as GetLocationProvider).parent;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
