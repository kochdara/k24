// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ownProfileListHash() => r'b0c4be8daba3b7626726947bbb13781083e3cc61';

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

abstract class _$OwnProfileList
    extends BuildlessAutoDisposeAsyncNotifier<List<DatumProfile>> {
  late final WidgetRef context;

  FutureOr<List<DatumProfile>> build(
    WidgetRef context,
  );
}

/// See also [OwnProfileList].
@ProviderFor(OwnProfileList)
const ownProfileListProvider = OwnProfileListFamily();

/// See also [OwnProfileList].
class OwnProfileListFamily extends Family<AsyncValue<List<DatumProfile>>> {
  /// See also [OwnProfileList].
  const OwnProfileListFamily();

  /// See also [OwnProfileList].
  OwnProfileListProvider call(
    WidgetRef context,
  ) {
    return OwnProfileListProvider(
      context,
    );
  }

  @override
  OwnProfileListProvider getProviderOverride(
    covariant OwnProfileListProvider provider,
  ) {
    return call(
      provider.context,
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
  String? get name => r'ownProfileListProvider';
}

/// See also [OwnProfileList].
class OwnProfileListProvider extends AutoDisposeAsyncNotifierProviderImpl<
    OwnProfileList, List<DatumProfile>> {
  /// See also [OwnProfileList].
  OwnProfileListProvider(
    WidgetRef context,
  ) : this._internal(
          () => OwnProfileList()..context = context,
          from: ownProfileListProvider,
          name: r'ownProfileListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ownProfileListHash,
          dependencies: OwnProfileListFamily._dependencies,
          allTransitiveDependencies:
              OwnProfileListFamily._allTransitiveDependencies,
          context: context,
        );

  OwnProfileListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
  }) : super.internal();

  final WidgetRef context;

  @override
  FutureOr<List<DatumProfile>> runNotifierBuild(
    covariant OwnProfileList notifier,
  ) {
    return notifier.build(
      context,
    );
  }

  @override
  Override overrideWith(OwnProfileList Function() create) {
    return ProviderOverride(
      origin: this,
      override: OwnProfileListProvider._internal(
        () => create()..context = context,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<OwnProfileList, List<DatumProfile>>
      createElement() {
    return _OwnProfileListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OwnProfileListProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin OwnProfileListRef
    on AutoDisposeAsyncNotifierProviderRef<List<DatumProfile>> {
  /// The parameter `context` of this provider.
  WidgetRef get context;
}

class _OwnProfileListProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<OwnProfileList,
        List<DatumProfile>> with OwnProfileListRef {
  _OwnProfileListProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as OwnProfileListProvider).context;
}

String _$getTotalPostHash() => r'10ca8e7c64a1e772fb7b005cdce79bcee520645e';

abstract class _$GetTotalPost
    extends BuildlessAutoDisposeAsyncNotifier<OwnDataTotalPost?> {
  late final WidgetRef context;

  FutureOr<OwnDataTotalPost?> build(
    WidgetRef context,
  );
}

/// See also [GetTotalPost].
@ProviderFor(GetTotalPost)
const getTotalPostProvider = GetTotalPostFamily();

/// See also [GetTotalPost].
class GetTotalPostFamily extends Family<AsyncValue<OwnDataTotalPost?>> {
  /// See also [GetTotalPost].
  const GetTotalPostFamily();

  /// See also [GetTotalPost].
  GetTotalPostProvider call(
    WidgetRef context,
  ) {
    return GetTotalPostProvider(
      context,
    );
  }

  @override
  GetTotalPostProvider getProviderOverride(
    covariant GetTotalPostProvider provider,
  ) {
    return call(
      provider.context,
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
  String? get name => r'getTotalPostProvider';
}

/// See also [GetTotalPost].
class GetTotalPostProvider extends AutoDisposeAsyncNotifierProviderImpl<
    GetTotalPost, OwnDataTotalPost?> {
  /// See also [GetTotalPost].
  GetTotalPostProvider(
    WidgetRef context,
  ) : this._internal(
          () => GetTotalPost()..context = context,
          from: getTotalPostProvider,
          name: r'getTotalPostProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getTotalPostHash,
          dependencies: GetTotalPostFamily._dependencies,
          allTransitiveDependencies:
              GetTotalPostFamily._allTransitiveDependencies,
          context: context,
        );

  GetTotalPostProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
  }) : super.internal();

  final WidgetRef context;

  @override
  FutureOr<OwnDataTotalPost?> runNotifierBuild(
    covariant GetTotalPost notifier,
  ) {
    return notifier.build(
      context,
    );
  }

  @override
  Override overrideWith(GetTotalPost Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetTotalPostProvider._internal(
        () => create()..context = context,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GetTotalPost, OwnDataTotalPost?>
      createElement() {
    return _GetTotalPostProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetTotalPostProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetTotalPostRef
    on AutoDisposeAsyncNotifierProviderRef<OwnDataTotalPost?> {
  /// The parameter `context` of this provider.
  WidgetRef get context;
}

class _GetTotalPostProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetTotalPost,
        OwnDataTotalPost?> with GetTotalPostRef {
  _GetTotalPostProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as GetTotalPostProvider).context;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
