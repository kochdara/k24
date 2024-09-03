// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hobbies_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getHobbiesHash() => r'3798bfa17802ed5e57aefab40bce5a7601276819';

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

abstract class _$GetHobbies extends BuildlessAutoDisposeAsyncNotifier<Object?> {
  late final WidgetRef context;

  FutureOr<Object?> build(
    WidgetRef context,
  );
}

/// See also [GetHobbies].
@ProviderFor(GetHobbies)
const getHobbiesProvider = GetHobbiesFamily();

/// See also [GetHobbies].
class GetHobbiesFamily extends Family<AsyncValue> {
  /// See also [GetHobbies].
  const GetHobbiesFamily();

  /// See also [GetHobbies].
  GetHobbiesProvider call(
    WidgetRef context,
  ) {
    return GetHobbiesProvider(
      context,
    );
  }

  @override
  GetHobbiesProvider getProviderOverride(
    covariant GetHobbiesProvider provider,
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
  String? get name => r'getHobbiesProvider';
}

/// See also [GetHobbies].
class GetHobbiesProvider
    extends AutoDisposeAsyncNotifierProviderImpl<GetHobbies, Object?> {
  /// See also [GetHobbies].
  GetHobbiesProvider(
    WidgetRef context,
  ) : this._internal(
          () => GetHobbies()..context = context,
          from: getHobbiesProvider,
          name: r'getHobbiesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getHobbiesHash,
          dependencies: GetHobbiesFamily._dependencies,
          allTransitiveDependencies:
              GetHobbiesFamily._allTransitiveDependencies,
          context: context,
        );

  GetHobbiesProvider._internal(
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
  FutureOr<Object?> runNotifierBuild(
    covariant GetHobbies notifier,
  ) {
    return notifier.build(
      context,
    );
  }

  @override
  Override overrideWith(GetHobbies Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetHobbiesProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<GetHobbies, Object?> createElement() {
    return _GetHobbiesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetHobbiesProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetHobbiesRef on AutoDisposeAsyncNotifierProviderRef<Object?> {
  /// The parameter `context` of this provider.
  WidgetRef get context;
}

class _GetHobbiesProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetHobbies, Object?>
    with GetHobbiesRef {
  _GetHobbiesProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as GetHobbiesProvider).context;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
