// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applyjob_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getApplyJobHash() => r'ea912b0b6a4c900be6cf50eb98c19aaf3bf570eb';

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

abstract class _$GetApplyJob
    extends BuildlessAutoDisposeAsyncNotifier<List<ApplyJobDatum?>?> {
  late final WidgetRef context;
  late final Map<dynamic, dynamic>? newMap;

  FutureOr<List<ApplyJobDatum?>?> build(
    WidgetRef context,
    Map<dynamic, dynamic>? newMap,
  );
}

/// See also [GetApplyJob].
@ProviderFor(GetApplyJob)
const getApplyJobProvider = GetApplyJobFamily();

/// See also [GetApplyJob].
class GetApplyJobFamily extends Family<AsyncValue<List<ApplyJobDatum?>?>> {
  /// See also [GetApplyJob].
  const GetApplyJobFamily();

  /// See also [GetApplyJob].
  GetApplyJobProvider call(
    WidgetRef context,
    Map<dynamic, dynamic>? newMap,
  ) {
    return GetApplyJobProvider(
      context,
      newMap,
    );
  }

  @override
  GetApplyJobProvider getProviderOverride(
    covariant GetApplyJobProvider provider,
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
  String? get name => r'getApplyJobProvider';
}

/// See also [GetApplyJob].
class GetApplyJobProvider extends AutoDisposeAsyncNotifierProviderImpl<
    GetApplyJob, List<ApplyJobDatum?>?> {
  /// See also [GetApplyJob].
  GetApplyJobProvider(
    WidgetRef context,
    Map<dynamic, dynamic>? newMap,
  ) : this._internal(
          () => GetApplyJob()
            ..context = context
            ..newMap = newMap,
          from: getApplyJobProvider,
          name: r'getApplyJobProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getApplyJobHash,
          dependencies: GetApplyJobFamily._dependencies,
          allTransitiveDependencies:
              GetApplyJobFamily._allTransitiveDependencies,
          context: context,
          newMap: newMap,
        );

  GetApplyJobProvider._internal(
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
  FutureOr<List<ApplyJobDatum?>?> runNotifierBuild(
    covariant GetApplyJob notifier,
  ) {
    return notifier.build(
      context,
      newMap,
    );
  }

  @override
  Override overrideWith(GetApplyJob Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetApplyJobProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<GetApplyJob, List<ApplyJobDatum?>?>
      createElement() {
    return _GetApplyJobProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetApplyJobProvider &&
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

mixin GetApplyJobRef
    on AutoDisposeAsyncNotifierProviderRef<List<ApplyJobDatum?>?> {
  /// The parameter `context` of this provider.
  WidgetRef get context;

  /// The parameter `newMap` of this provider.
  Map<dynamic, dynamic>? get newMap;
}

class _GetApplyJobProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetApplyJob,
        List<ApplyJobDatum?>?> with GetApplyJobRef {
  _GetApplyJobProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as GetApplyJobProvider).context;
  @override
  Map<dynamic, dynamic>? get newMap => (origin as GetApplyJobProvider).newMap;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
