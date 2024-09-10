// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getSearchPostHash() => r'd168a68d6edaee84a8213eaf1d2dc5df6953f8c9';

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

abstract class _$GetSearchPost
    extends BuildlessAutoDisposeAsyncNotifier<List<GridCard?>?> {
  late final WidgetRef context;
  late final String keyword;

  FutureOr<List<GridCard?>?> build(
    WidgetRef context,
    String keyword,
  );
}

/// See also [GetSearchPost].
@ProviderFor(GetSearchPost)
const getSearchPostProvider = GetSearchPostFamily();

/// See also [GetSearchPost].
class GetSearchPostFamily extends Family<AsyncValue<List<GridCard?>?>> {
  /// See also [GetSearchPost].
  const GetSearchPostFamily();

  /// See also [GetSearchPost].
  GetSearchPostProvider call(
    WidgetRef context,
    String keyword,
  ) {
    return GetSearchPostProvider(
      context,
      keyword,
    );
  }

  @override
  GetSearchPostProvider getProviderOverride(
    covariant GetSearchPostProvider provider,
  ) {
    return call(
      provider.context,
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
  String? get name => r'getSearchPostProvider';
}

/// See also [GetSearchPost].
class GetSearchPostProvider extends AutoDisposeAsyncNotifierProviderImpl<
    GetSearchPost, List<GridCard?>?> {
  /// See also [GetSearchPost].
  GetSearchPostProvider(
    WidgetRef context,
    String keyword,
  ) : this._internal(
          () => GetSearchPost()
            ..context = context
            ..keyword = keyword,
          from: getSearchPostProvider,
          name: r'getSearchPostProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getSearchPostHash,
          dependencies: GetSearchPostFamily._dependencies,
          allTransitiveDependencies:
              GetSearchPostFamily._allTransitiveDependencies,
          context: context,
          keyword: keyword,
        );

  GetSearchPostProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
    required this.keyword,
  }) : super.internal();

  final WidgetRef context;
  final String keyword;

  @override
  FutureOr<List<GridCard?>?> runNotifierBuild(
    covariant GetSearchPost notifier,
  ) {
    return notifier.build(
      context,
      keyword,
    );
  }

  @override
  Override overrideWith(GetSearchPost Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetSearchPostProvider._internal(
        () => create()
          ..context = context
          ..keyword = keyword,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
        keyword: keyword,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GetSearchPost, List<GridCard?>?>
      createElement() {
    return _GetSearchPostProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetSearchPostProvider &&
        other.context == context &&
        other.keyword == keyword;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);
    hash = _SystemHash.combine(hash, keyword.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetSearchPostRef
    on AutoDisposeAsyncNotifierProviderRef<List<GridCard?>?> {
  /// The parameter `context` of this provider.
  WidgetRef get context;

  /// The parameter `keyword` of this provider.
  String get keyword;
}

class _GetSearchPostProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetSearchPost,
        List<GridCard?>?> with GetSearchPostRef {
  _GetSearchPostProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as GetSearchPostProvider).context;
  @override
  String get keyword => (origin as GetSearchPostProvider).keyword;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
