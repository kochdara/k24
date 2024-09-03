// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preference_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getPreferenceHash() => r'aa0fc972a227a2386c67afc1d9028bc73d3b272a';

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

abstract class _$GetPreference
    extends BuildlessAutoDisposeAsyncNotifier<MyResumePreference?> {
  late final WidgetRef context;

  FutureOr<MyResumePreference?> build(
    WidgetRef context,
  );
}

/// See also [GetPreference].
@ProviderFor(GetPreference)
const getPreferenceProvider = GetPreferenceFamily();

/// See also [GetPreference].
class GetPreferenceFamily extends Family<AsyncValue<MyResumePreference?>> {
  /// See also [GetPreference].
  const GetPreferenceFamily();

  /// See also [GetPreference].
  GetPreferenceProvider call(
    WidgetRef context,
  ) {
    return GetPreferenceProvider(
      context,
    );
  }

  @override
  GetPreferenceProvider getProviderOverride(
    covariant GetPreferenceProvider provider,
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
  String? get name => r'getPreferenceProvider';
}

/// See also [GetPreference].
class GetPreferenceProvider extends AutoDisposeAsyncNotifierProviderImpl<
    GetPreference, MyResumePreference?> {
  /// See also [GetPreference].
  GetPreferenceProvider(
    WidgetRef context,
  ) : this._internal(
          () => GetPreference()..context = context,
          from: getPreferenceProvider,
          name: r'getPreferenceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPreferenceHash,
          dependencies: GetPreferenceFamily._dependencies,
          allTransitiveDependencies:
              GetPreferenceFamily._allTransitiveDependencies,
          context: context,
        );

  GetPreferenceProvider._internal(
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
  FutureOr<MyResumePreference?> runNotifierBuild(
    covariant GetPreference notifier,
  ) {
    return notifier.build(
      context,
    );
  }

  @override
  Override overrideWith(GetPreference Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetPreferenceProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<GetPreference, MyResumePreference?>
      createElement() {
    return _GetPreferenceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetPreferenceProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetPreferenceRef
    on AutoDisposeAsyncNotifierProviderRef<MyResumePreference?> {
  /// The parameter `context` of this provider.
  WidgetRef get context;
}

class _GetPreferenceProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetPreference,
        MyResumePreference?> with GetPreferenceRef {
  _GetPreferenceProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as GetPreferenceProvider).context;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
