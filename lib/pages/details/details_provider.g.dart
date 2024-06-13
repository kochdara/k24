// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getDetailPostHash() => r'099b22e112ff46399fc9f677739e42697db0aa03';

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

abstract class _$GetDetailPost
    extends BuildlessAutoDisposeAsyncNotifier<GridCard> {
  late final String id;

  FutureOr<GridCard> build(
    String id,
  );
}

/// See also [GetDetailPost].
@ProviderFor(GetDetailPost)
const getDetailPostProvider = GetDetailPostFamily();

/// See also [GetDetailPost].
class GetDetailPostFamily extends Family<AsyncValue<GridCard>> {
  /// See also [GetDetailPost].
  const GetDetailPostFamily();

  /// See also [GetDetailPost].
  GetDetailPostProvider call(
    String id,
  ) {
    return GetDetailPostProvider(
      id,
    );
  }

  @override
  GetDetailPostProvider getProviderOverride(
    covariant GetDetailPostProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'getDetailPostProvider';
}

/// See also [GetDetailPost].
class GetDetailPostProvider
    extends AutoDisposeAsyncNotifierProviderImpl<GetDetailPost, GridCard> {
  /// See also [GetDetailPost].
  GetDetailPostProvider(
    String id,
  ) : this._internal(
          () => GetDetailPost()..id = id,
          from: getDetailPostProvider,
          name: r'getDetailPostProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getDetailPostHash,
          dependencies: GetDetailPostFamily._dependencies,
          allTransitiveDependencies:
              GetDetailPostFamily._allTransitiveDependencies,
          id: id,
        );

  GetDetailPostProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  FutureOr<GridCard> runNotifierBuild(
    covariant GetDetailPost notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(GetDetailPost Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetDetailPostProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GetDetailPost, GridCard>
      createElement() {
    return _GetDetailPostProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetDetailPostProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetDetailPostRef on AutoDisposeAsyncNotifierProviderRef<GridCard> {
  /// The parameter `id` of this provider.
  String get id;
}

class _GetDetailPostProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetDetailPost, GridCard>
    with GetDetailPostRef {
  _GetDetailPostProviderElement(super.provider);

  @override
  String get id => (origin as GetDetailPostProvider).id;
}

String _$relateDetailPostHash() => r'e775c17277c37837f0ea483051abd4c5d79e19c3';

abstract class _$RelateDetailPost
    extends BuildlessAutoDisposeAsyncNotifier<List<GridCard>> {
  late final String id;

  FutureOr<List<GridCard>> build(
    String id,
  );
}

/// See also [RelateDetailPost].
@ProviderFor(RelateDetailPost)
const relateDetailPostProvider = RelateDetailPostFamily();

/// See also [RelateDetailPost].
class RelateDetailPostFamily extends Family<AsyncValue<List<GridCard>>> {
  /// See also [RelateDetailPost].
  const RelateDetailPostFamily();

  /// See also [RelateDetailPost].
  RelateDetailPostProvider call(
    String id,
  ) {
    return RelateDetailPostProvider(
      id,
    );
  }

  @override
  RelateDetailPostProvider getProviderOverride(
    covariant RelateDetailPostProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'relateDetailPostProvider';
}

/// See also [RelateDetailPost].
class RelateDetailPostProvider extends AutoDisposeAsyncNotifierProviderImpl<
    RelateDetailPost, List<GridCard>> {
  /// See also [RelateDetailPost].
  RelateDetailPostProvider(
    String id,
  ) : this._internal(
          () => RelateDetailPost()..id = id,
          from: relateDetailPostProvider,
          name: r'relateDetailPostProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$relateDetailPostHash,
          dependencies: RelateDetailPostFamily._dependencies,
          allTransitiveDependencies:
              RelateDetailPostFamily._allTransitiveDependencies,
          id: id,
        );

  RelateDetailPostProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  FutureOr<List<GridCard>> runNotifierBuild(
    covariant RelateDetailPost notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(RelateDetailPost Function() create) {
    return ProviderOverride(
      origin: this,
      override: RelateDetailPostProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<RelateDetailPost, List<GridCard>>
      createElement() {
    return _RelateDetailPostProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RelateDetailPostProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RelateDetailPostRef
    on AutoDisposeAsyncNotifierProviderRef<List<GridCard>> {
  /// The parameter `id` of this provider.
  String get id;
}

class _RelateDetailPostProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<RelateDetailPost,
        List<GridCard>> with RelateDetailPostRef {
  _RelateDetailPostProviderElement(super.provider);

  @override
  String get id => (origin as RelateDetailPostProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
