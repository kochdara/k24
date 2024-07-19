// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getPostFilterHash() => r'9497dd88f590cb768701f4a4ee21f7e404a34fdd';

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

abstract class _$GetPostFilter
    extends BuildlessAutoDisposeAsyncNotifier<PostSerial?> {
  late final WidgetRef context;
  late final String slug;
  late final String? storeid;

  FutureOr<PostSerial?> build(
    WidgetRef context,
    String slug,
    String? storeid,
  );
}

/// See also [GetPostFilter].
@ProviderFor(GetPostFilter)
const getPostFilterProvider = GetPostFilterFamily();

/// See also [GetPostFilter].
class GetPostFilterFamily extends Family<AsyncValue<PostSerial?>> {
  /// See also [GetPostFilter].
  const GetPostFilterFamily();

  /// See also [GetPostFilter].
  GetPostFilterProvider call(
    WidgetRef context,
    String slug,
    String? storeid,
  ) {
    return GetPostFilterProvider(
      context,
      slug,
      storeid,
    );
  }

  @override
  GetPostFilterProvider getProviderOverride(
    covariant GetPostFilterProvider provider,
  ) {
    return call(
      provider.context,
      provider.slug,
      provider.storeid,
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
  String? get name => r'getPostFilterProvider';
}

/// See also [GetPostFilter].
class GetPostFilterProvider
    extends AutoDisposeAsyncNotifierProviderImpl<GetPostFilter, PostSerial?> {
  /// See also [GetPostFilter].
  GetPostFilterProvider(
    WidgetRef context,
    String slug,
    String? storeid,
  ) : this._internal(
          () => GetPostFilter()
            ..context = context
            ..slug = slug
            ..storeid = storeid,
          from: getPostFilterProvider,
          name: r'getPostFilterProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPostFilterHash,
          dependencies: GetPostFilterFamily._dependencies,
          allTransitiveDependencies:
              GetPostFilterFamily._allTransitiveDependencies,
          context: context,
          slug: slug,
          storeid: storeid,
        );

  GetPostFilterProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
    required this.slug,
    required this.storeid,
  }) : super.internal();

  final WidgetRef context;
  final String slug;
  final String? storeid;

  @override
  FutureOr<PostSerial?> runNotifierBuild(
    covariant GetPostFilter notifier,
  ) {
    return notifier.build(
      context,
      slug,
      storeid,
    );
  }

  @override
  Override overrideWith(GetPostFilter Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetPostFilterProvider._internal(
        () => create()
          ..context = context
          ..slug = slug
          ..storeid = storeid,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
        slug: slug,
        storeid: storeid,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GetPostFilter, PostSerial?>
      createElement() {
    return _GetPostFilterProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetPostFilterProvider &&
        other.context == context &&
        other.slug == slug &&
        other.storeid == storeid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);
    hash = _SystemHash.combine(hash, slug.hashCode);
    hash = _SystemHash.combine(hash, storeid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetPostFilterRef on AutoDisposeAsyncNotifierProviderRef<PostSerial?> {
  /// The parameter `context` of this provider.
  WidgetRef get context;

  /// The parameter `slug` of this provider.
  String get slug;

  /// The parameter `storeid` of this provider.
  String? get storeid;
}

class _GetPostFilterProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetPostFilter, PostSerial?>
    with GetPostFilterRef {
  _GetPostFilterProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as GetPostFilterProvider).context;
  @override
  String get slug => (origin as GetPostFilterProvider).slug;
  @override
  String? get storeid => (origin as GetPostFilterProvider).storeid;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
