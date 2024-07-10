// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ownProfileListHash() => r'631ac78995b727676272be14e19a61344be5c3a6';

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
  late final String accessTokens;

  FutureOr<List<DatumProfile>> build(
    WidgetRef context,
    String accessTokens,
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
    String accessTokens,
  ) {
    return OwnProfileListProvider(
      context,
      accessTokens,
    );
  }

  @override
  OwnProfileListProvider getProviderOverride(
    covariant OwnProfileListProvider provider,
  ) {
    return call(
      provider.context,
      provider.accessTokens,
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
    String accessTokens,
  ) : this._internal(
          () => OwnProfileList()
            ..context = context
            ..accessTokens = accessTokens,
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
          accessTokens: accessTokens,
        );

  OwnProfileListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
    required this.accessTokens,
  }) : super.internal();

  final WidgetRef context;
  final String accessTokens;

  @override
  FutureOr<List<DatumProfile>> runNotifierBuild(
    covariant OwnProfileList notifier,
  ) {
    return notifier.build(
      context,
      accessTokens,
    );
  }

  @override
  Override overrideWith(OwnProfileList Function() create) {
    return ProviderOverride(
      origin: this,
      override: OwnProfileListProvider._internal(
        () => create()
          ..context = context
          ..accessTokens = accessTokens,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
        accessTokens: accessTokens,
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
    return other is OwnProfileListProvider &&
        other.context == context &&
        other.accessTokens == accessTokens;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);
    hash = _SystemHash.combine(hash, accessTokens.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin OwnProfileListRef
    on AutoDisposeAsyncNotifierProviderRef<List<DatumProfile>> {
  /// The parameter `context` of this provider.
  WidgetRef get context;

  /// The parameter `accessTokens` of this provider.
  String get accessTokens;
}

class _OwnProfileListProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<OwnProfileList,
        List<DatumProfile>> with OwnProfileListRef {
  _OwnProfileListProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as OwnProfileListProvider).context;
  @override
  String get accessTokens => (origin as OwnProfileListProvider).accessTokens;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
