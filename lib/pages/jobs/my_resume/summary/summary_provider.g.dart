// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getSummaryHash() => r'0d624c401139f5bff1180b545f56d55cdfe9c610';

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

abstract class _$GetSummary extends BuildlessAutoDisposeAsyncNotifier<Object?> {
  late final WidgetRef context;

  FutureOr<Object?> build(
    WidgetRef context,
  );
}

/// See also [GetSummary].
@ProviderFor(GetSummary)
const getSummaryProvider = GetSummaryFamily();

/// See also [GetSummary].
class GetSummaryFamily extends Family<AsyncValue> {
  /// See also [GetSummary].
  const GetSummaryFamily();

  /// See also [GetSummary].
  GetSummaryProvider call(
    WidgetRef context,
  ) {
    return GetSummaryProvider(
      context,
    );
  }

  @override
  GetSummaryProvider getProviderOverride(
    covariant GetSummaryProvider provider,
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
  String? get name => r'getSummaryProvider';
}

/// See also [GetSummary].
class GetSummaryProvider
    extends AutoDisposeAsyncNotifierProviderImpl<GetSummary, Object?> {
  /// See also [GetSummary].
  GetSummaryProvider(
    WidgetRef context,
  ) : this._internal(
          () => GetSummary()..context = context,
          from: getSummaryProvider,
          name: r'getSummaryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getSummaryHash,
          dependencies: GetSummaryFamily._dependencies,
          allTransitiveDependencies:
              GetSummaryFamily._allTransitiveDependencies,
          context: context,
        );

  GetSummaryProvider._internal(
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
    covariant GetSummary notifier,
  ) {
    return notifier.build(
      context,
    );
  }

  @override
  Override overrideWith(GetSummary Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetSummaryProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<GetSummary, Object?> createElement() {
    return _GetSummaryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetSummaryProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetSummaryRef on AutoDisposeAsyncNotifierProviderRef<Object?> {
  /// The parameter `context` of this provider.
  WidgetRef get context;
}

class _GetSummaryProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetSummary, Object?>
    with GetSummaryRef {
  _GetSummaryProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as GetSummaryProvider).context;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
