// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'likes_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getTotalLikesHash() => r'8659b57e38e8d7b1d530ae69412103de8bed0312';

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

abstract class _$GetTotalLikes
    extends BuildlessAutoDisposeAsyncNotifier<List<LikesDatum?>?> {
  late final WidgetRef context;
  late final String sort;

  FutureOr<List<LikesDatum?>?> build(
    WidgetRef context,
    String sort,
  );
}

/// See also [GetTotalLikes].
@ProviderFor(GetTotalLikes)
const getTotalLikesProvider = GetTotalLikesFamily();

/// See also [GetTotalLikes].
class GetTotalLikesFamily extends Family<AsyncValue<List<LikesDatum?>?>> {
  /// See also [GetTotalLikes].
  const GetTotalLikesFamily();

  /// See also [GetTotalLikes].
  GetTotalLikesProvider call(
    WidgetRef context,
    String sort,
  ) {
    return GetTotalLikesProvider(
      context,
      sort,
    );
  }

  @override
  GetTotalLikesProvider getProviderOverride(
    covariant GetTotalLikesProvider provider,
  ) {
    return call(
      provider.context,
      provider.sort,
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
  String? get name => r'getTotalLikesProvider';
}

/// See also [GetTotalLikes].
class GetTotalLikesProvider extends AutoDisposeAsyncNotifierProviderImpl<
    GetTotalLikes, List<LikesDatum?>?> {
  /// See also [GetTotalLikes].
  GetTotalLikesProvider(
    WidgetRef context,
    String sort,
  ) : this._internal(
          () => GetTotalLikes()
            ..context = context
            ..sort = sort,
          from: getTotalLikesProvider,
          name: r'getTotalLikesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getTotalLikesHash,
          dependencies: GetTotalLikesFamily._dependencies,
          allTransitiveDependencies:
              GetTotalLikesFamily._allTransitiveDependencies,
          context: context,
          sort: sort,
        );

  GetTotalLikesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
    required this.sort,
  }) : super.internal();

  final WidgetRef context;
  final String sort;

  @override
  FutureOr<List<LikesDatum?>?> runNotifierBuild(
    covariant GetTotalLikes notifier,
  ) {
    return notifier.build(
      context,
      sort,
    );
  }

  @override
  Override overrideWith(GetTotalLikes Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetTotalLikesProvider._internal(
        () => create()
          ..context = context
          ..sort = sort,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
        sort: sort,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GetTotalLikes, List<LikesDatum?>?>
      createElement() {
    return _GetTotalLikesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetTotalLikesProvider &&
        other.context == context &&
        other.sort == sort;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);
    hash = _SystemHash.combine(hash, sort.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetTotalLikesRef
    on AutoDisposeAsyncNotifierProviderRef<List<LikesDatum?>?> {
  /// The parameter `context` of this provider.
  WidgetRef get context;

  /// The parameter `sort` of this provider.
  String get sort;
}

class _GetTotalLikesProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetTotalLikes,
        List<LikesDatum?>?> with GetTotalLikesRef {
  _GetTotalLikesProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as GetTotalLikesProvider).context;
  @override
  String get sort => (origin as GetTotalLikesProvider).sort;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
