// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filters_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getFilterProHash() => r'e4f8862d8b47e02c878061be90226e3f954465ba';

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

abstract class _$GetFilterPro extends BuildlessAutoDisposeAsyncNotifier<List> {
  late final String slug;

  FutureOr<List> build(
    String slug,
  );
}

/// See also [GetFilterPro].
@ProviderFor(GetFilterPro)
const getFilterProProvider = GetFilterProFamily();

/// See also [GetFilterPro].
class GetFilterProFamily extends Family<AsyncValue<List>> {
  /// See also [GetFilterPro].
  const GetFilterProFamily();

  /// See also [GetFilterPro].
  GetFilterProProvider call(
    String slug,
  ) {
    return GetFilterProProvider(
      slug,
    );
  }

  @override
  GetFilterProProvider getProviderOverride(
    covariant GetFilterProProvider provider,
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
  String? get name => r'getFilterProProvider';
}

/// See also [GetFilterPro].
class GetFilterProProvider
    extends AutoDisposeAsyncNotifierProviderImpl<GetFilterPro, List> {
  /// See also [GetFilterPro].
  GetFilterProProvider(
    String slug,
  ) : this._internal(
          () => GetFilterPro()..slug = slug,
          from: getFilterProProvider,
          name: r'getFilterProProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getFilterProHash,
          dependencies: GetFilterProFamily._dependencies,
          allTransitiveDependencies:
              GetFilterProFamily._allTransitiveDependencies,
          slug: slug,
        );

  GetFilterProProvider._internal(
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
    covariant GetFilterPro notifier,
  ) {
    return notifier.build(
      slug,
    );
  }

  @override
  Override overrideWith(GetFilterPro Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetFilterProProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<GetFilterPro, List> createElement() {
    return _GetFilterProProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetFilterProProvider && other.slug == slug;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, slug.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetFilterProRef on AutoDisposeAsyncNotifierProviderRef<List> {
  /// The parameter `slug` of this provider.
  String get slug;
}

class _GetFilterProProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetFilterPro, List>
    with GetFilterProRef {
  _GetFilterProProviderElement(super.provider);

  @override
  String get slug => (origin as GetFilterProProvider).slug;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
