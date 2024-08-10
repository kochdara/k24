// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getJobApplicationHash() => r'9fed001bd63a90c9d9fb05b94ed6b5b9d1d33699';

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

abstract class _$GetJobApplication
    extends BuildlessAutoDisposeAsyncNotifier<List<JobAppData?>?> {
  late final WidgetRef context;
  late final Map<dynamic, dynamic>? newMap;

  FutureOr<List<JobAppData?>?> build(
    WidgetRef context,
    Map<dynamic, dynamic>? newMap,
  );
}

/// See also [GetJobApplication].
@ProviderFor(GetJobApplication)
const getJobApplicationProvider = GetJobApplicationFamily();

/// See also [GetJobApplication].
class GetJobApplicationFamily extends Family<AsyncValue<List<JobAppData?>?>> {
  /// See also [GetJobApplication].
  const GetJobApplicationFamily();

  /// See also [GetJobApplication].
  GetJobApplicationProvider call(
    WidgetRef context,
    Map<dynamic, dynamic>? newMap,
  ) {
    return GetJobApplicationProvider(
      context,
      newMap,
    );
  }

  @override
  GetJobApplicationProvider getProviderOverride(
    covariant GetJobApplicationProvider provider,
  ) {
    return call(
      provider.context,
      provider.newMap,
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
  String? get name => r'getJobApplicationProvider';
}

/// See also [GetJobApplication].
class GetJobApplicationProvider extends AutoDisposeAsyncNotifierProviderImpl<
    GetJobApplication, List<JobAppData?>?> {
  /// See also [GetJobApplication].
  GetJobApplicationProvider(
    WidgetRef context,
    Map<dynamic, dynamic>? newMap,
  ) : this._internal(
          () => GetJobApplication()
            ..context = context
            ..newMap = newMap,
          from: getJobApplicationProvider,
          name: r'getJobApplicationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getJobApplicationHash,
          dependencies: GetJobApplicationFamily._dependencies,
          allTransitiveDependencies:
              GetJobApplicationFamily._allTransitiveDependencies,
          context: context,
          newMap: newMap,
        );

  GetJobApplicationProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
    required this.newMap,
  }) : super.internal();

  final WidgetRef context;
  final Map<dynamic, dynamic>? newMap;

  @override
  FutureOr<List<JobAppData?>?> runNotifierBuild(
    covariant GetJobApplication notifier,
  ) {
    return notifier.build(
      context,
      newMap,
    );
  }

  @override
  Override overrideWith(GetJobApplication Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetJobApplicationProvider._internal(
        () => create()
          ..context = context
          ..newMap = newMap,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
        newMap: newMap,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GetJobApplication, List<JobAppData?>?>
      createElement() {
    return _GetJobApplicationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetJobApplicationProvider &&
        other.context == context &&
        other.newMap == newMap;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);
    hash = _SystemHash.combine(hash, newMap.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetJobApplicationRef
    on AutoDisposeAsyncNotifierProviderRef<List<JobAppData?>?> {
  /// The parameter `context` of this provider.
  WidgetRef get context;

  /// The parameter `newMap` of this provider.
  Map<dynamic, dynamic>? get newMap;
}

class _GetJobApplicationProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetJobApplication,
        List<JobAppData?>?> with GetJobApplicationRef {
  _GetJobApplicationProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as GetJobApplicationProvider).context;
  @override
  Map<dynamic, dynamic>? get newMap =>
      (origin as GetJobApplicationProvider).newMap;
}

String _$getBadgesAppHash() => r'382a1116fb4e1f4d3c189f68a643e51d436873be';

abstract class _$GetBadgesApp
    extends BuildlessAutoDisposeAsyncNotifier<GetBadgesSerial?> {
  late final WidgetRef context;

  FutureOr<GetBadgesSerial?> build(
    WidgetRef context,
  );
}

/// See also [GetBadgesApp].
@ProviderFor(GetBadgesApp)
const getBadgesAppProvider = GetBadgesAppFamily();

/// See also [GetBadgesApp].
class GetBadgesAppFamily extends Family<AsyncValue<GetBadgesSerial?>> {
  /// See also [GetBadgesApp].
  const GetBadgesAppFamily();

  /// See also [GetBadgesApp].
  GetBadgesAppProvider call(
    WidgetRef context,
  ) {
    return GetBadgesAppProvider(
      context,
    );
  }

  @override
  GetBadgesAppProvider getProviderOverride(
    covariant GetBadgesAppProvider provider,
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
  String? get name => r'getBadgesAppProvider';
}

/// See also [GetBadgesApp].
class GetBadgesAppProvider extends AutoDisposeAsyncNotifierProviderImpl<
    GetBadgesApp, GetBadgesSerial?> {
  /// See also [GetBadgesApp].
  GetBadgesAppProvider(
    WidgetRef context,
  ) : this._internal(
          () => GetBadgesApp()..context = context,
          from: getBadgesAppProvider,
          name: r'getBadgesAppProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getBadgesAppHash,
          dependencies: GetBadgesAppFamily._dependencies,
          allTransitiveDependencies:
              GetBadgesAppFamily._allTransitiveDependencies,
          context: context,
        );

  GetBadgesAppProvider._internal(
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
  FutureOr<GetBadgesSerial?> runNotifierBuild(
    covariant GetBadgesApp notifier,
  ) {
    return notifier.build(
      context,
    );
  }

  @override
  Override overrideWith(GetBadgesApp Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetBadgesAppProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<GetBadgesApp, GetBadgesSerial?>
      createElement() {
    return _GetBadgesAppProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetBadgesAppProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetBadgesAppRef on AutoDisposeAsyncNotifierProviderRef<GetBadgesSerial?> {
  /// The parameter `context` of this provider.
  WidgetRef get context;
}

class _GetBadgesAppProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetBadgesApp,
        GetBadgesSerial?> with GetBadgesAppRef {
  _GetBadgesAppProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as GetBadgesAppProvider).context;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
