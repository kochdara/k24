// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getTotalSaveHash() => r'8c904210778e7582450a3ad77c4cd55b3e50b97e';

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

abstract class _$GetTotalSave
    extends BuildlessAutoDisposeAsyncNotifier<List<LikesDatum?>?> {
  late final WidgetRef context;
  late final String sort;
  late final String? type;

  FutureOr<List<LikesDatum?>?> build(
    WidgetRef context,
    String sort, {
    String? type = 'post',
  });
}

/// See also [GetTotalSave].
@ProviderFor(GetTotalSave)
const getTotalSaveProvider = GetTotalSaveFamily();

/// See also [GetTotalSave].
class GetTotalSaveFamily extends Family<AsyncValue<List<LikesDatum?>?>> {
  /// See also [GetTotalSave].
  const GetTotalSaveFamily();

  /// See also [GetTotalSave].
  GetTotalSaveProvider call(
    WidgetRef context,
    String sort, {
    String? type = 'post',
  }) {
    return GetTotalSaveProvider(
      context,
      sort,
      type: type,
    );
  }

  @override
  GetTotalSaveProvider getProviderOverride(
    covariant GetTotalSaveProvider provider,
  ) {
    return call(
      provider.context,
      provider.sort,
      type: provider.type,
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
  String? get name => r'getTotalSaveProvider';
}

/// See also [GetTotalSave].
class GetTotalSaveProvider extends AutoDisposeAsyncNotifierProviderImpl<
    GetTotalSave, List<LikesDatum?>?> {
  /// See also [GetTotalSave].
  GetTotalSaveProvider(
    WidgetRef context,
    String sort, {
    String? type = 'post',
  }) : this._internal(
          () => GetTotalSave()
            ..context = context
            ..sort = sort
            ..type = type,
          from: getTotalSaveProvider,
          name: r'getTotalSaveProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getTotalSaveHash,
          dependencies: GetTotalSaveFamily._dependencies,
          allTransitiveDependencies:
              GetTotalSaveFamily._allTransitiveDependencies,
          context: context,
          sort: sort,
          type: type,
        );

  GetTotalSaveProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
    required this.sort,
    required this.type,
  }) : super.internal();

  final WidgetRef context;
  final String sort;
  final String? type;

  @override
  FutureOr<List<LikesDatum?>?> runNotifierBuild(
    covariant GetTotalSave notifier,
  ) {
    return notifier.build(
      context,
      sort,
      type: type,
    );
  }

  @override
  Override overrideWith(GetTotalSave Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetTotalSaveProvider._internal(
        () => create()
          ..context = context
          ..sort = sort
          ..type = type,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
        sort: sort,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GetTotalSave, List<LikesDatum?>?>
      createElement() {
    return _GetTotalSaveProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetTotalSaveProvider &&
        other.context == context &&
        other.sort == sort &&
        other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);
    hash = _SystemHash.combine(hash, sort.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetTotalSaveRef
    on AutoDisposeAsyncNotifierProviderRef<List<LikesDatum?>?> {
  /// The parameter `context` of this provider.
  WidgetRef get context;

  /// The parameter `sort` of this provider.
  String get sort;

  /// The parameter `type` of this provider.
  String? get type;
}

class _GetTotalSaveProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetTotalSave,
        List<LikesDatum?>?> with GetTotalSaveRef {
  _GetTotalSaveProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as GetTotalSaveProvider).context;
  @override
  String get sort => (origin as GetTotalSaveProvider).sort;
  @override
  String? get type => (origin as GetTotalSaveProvider).type;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
