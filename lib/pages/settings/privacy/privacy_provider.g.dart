// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'privacy_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getPrivacyHash() => r'c39e41ff980a4b51676cbf57c966dd9cb1e06efd';

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

abstract class _$GetPrivacy
    extends BuildlessAutoDisposeAsyncNotifier<PrivacySerial?> {
  late final WidgetRef context;

  FutureOr<PrivacySerial?> build(
    WidgetRef context,
  );
}

/// See also [GetPrivacy].
@ProviderFor(GetPrivacy)
const getPrivacyProvider = GetPrivacyFamily();

/// See also [GetPrivacy].
class GetPrivacyFamily extends Family<AsyncValue<PrivacySerial?>> {
  /// See also [GetPrivacy].
  const GetPrivacyFamily();

  /// See also [GetPrivacy].
  GetPrivacyProvider call(
    WidgetRef context,
  ) {
    return GetPrivacyProvider(
      context,
    );
  }

  @override
  GetPrivacyProvider getProviderOverride(
    covariant GetPrivacyProvider provider,
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
  String? get name => r'getPrivacyProvider';
}

/// See also [GetPrivacy].
class GetPrivacyProvider
    extends AutoDisposeAsyncNotifierProviderImpl<GetPrivacy, PrivacySerial?> {
  /// See also [GetPrivacy].
  GetPrivacyProvider(
    WidgetRef context,
  ) : this._internal(
          () => GetPrivacy()..context = context,
          from: getPrivacyProvider,
          name: r'getPrivacyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPrivacyHash,
          dependencies: GetPrivacyFamily._dependencies,
          allTransitiveDependencies:
              GetPrivacyFamily._allTransitiveDependencies,
          context: context,
        );

  GetPrivacyProvider._internal(
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
  FutureOr<PrivacySerial?> runNotifierBuild(
    covariant GetPrivacy notifier,
  ) {
    return notifier.build(
      context,
    );
  }

  @override
  Override overrideWith(GetPrivacy Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetPrivacyProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<GetPrivacy, PrivacySerial?>
      createElement() {
    return _GetPrivacyProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetPrivacyProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetPrivacyRef on AutoDisposeAsyncNotifierProviderRef<PrivacySerial?> {
  /// The parameter `context` of this provider.
  WidgetRef get context;
}

class _GetPrivacyProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetPrivacy, PrivacySerial?>
    with GetPrivacyRef {
  _GetPrivacyProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as GetPrivacyProvider).context;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
