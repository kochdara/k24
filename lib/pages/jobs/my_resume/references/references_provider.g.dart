// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'references_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getReferencesDetailsHash() =>
    r'5b1d10526d3b84112255c7c8bc0d012e35e74de1';

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

abstract class _$GetReferencesDetails
    extends BuildlessAutoDisposeAsyncNotifier<ResumeReferences?> {
  late final WidgetRef context;
  late final String id;

  FutureOr<ResumeReferences?> build(
    WidgetRef context,
    String id,
  );
}

/// See also [GetReferencesDetails].
@ProviderFor(GetReferencesDetails)
const getReferencesDetailsProvider = GetReferencesDetailsFamily();

/// See also [GetReferencesDetails].
class GetReferencesDetailsFamily extends Family<AsyncValue<ResumeReferences?>> {
  /// See also [GetReferencesDetails].
  const GetReferencesDetailsFamily();

  /// See also [GetReferencesDetails].
  GetReferencesDetailsProvider call(
    WidgetRef context,
    String id,
  ) {
    return GetReferencesDetailsProvider(
      context,
      id,
    );
  }

  @override
  GetReferencesDetailsProvider getProviderOverride(
    covariant GetReferencesDetailsProvider provider,
  ) {
    return call(
      provider.context,
      provider.id,
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
  String? get name => r'getReferencesDetailsProvider';
}

/// See also [GetReferencesDetails].
class GetReferencesDetailsProvider extends AutoDisposeAsyncNotifierProviderImpl<
    GetReferencesDetails, ResumeReferences?> {
  /// See also [GetReferencesDetails].
  GetReferencesDetailsProvider(
    WidgetRef context,
    String id,
  ) : this._internal(
          () => GetReferencesDetails()
            ..context = context
            ..id = id,
          from: getReferencesDetailsProvider,
          name: r'getReferencesDetailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getReferencesDetailsHash,
          dependencies: GetReferencesDetailsFamily._dependencies,
          allTransitiveDependencies:
              GetReferencesDetailsFamily._allTransitiveDependencies,
          context: context,
          id: id,
        );

  GetReferencesDetailsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
    required this.id,
  }) : super.internal();

  final WidgetRef context;
  final String id;

  @override
  FutureOr<ResumeReferences?> runNotifierBuild(
    covariant GetReferencesDetails notifier,
  ) {
    return notifier.build(
      context,
      id,
    );
  }

  @override
  Override overrideWith(GetReferencesDetails Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetReferencesDetailsProvider._internal(
        () => create()
          ..context = context
          ..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GetReferencesDetails,
      ResumeReferences?> createElement() {
    return _GetReferencesDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetReferencesDetailsProvider &&
        other.context == context &&
        other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetReferencesDetailsRef
    on AutoDisposeAsyncNotifierProviderRef<ResumeReferences?> {
  /// The parameter `context` of this provider.
  WidgetRef get context;

  /// The parameter `id` of this provider.
  String get id;
}

class _GetReferencesDetailsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetReferencesDetails,
        ResumeReferences?> with GetReferencesDetailsRef {
  _GetReferencesDetailsProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as GetReferencesDetailsProvider).context;
  @override
  String get id => (origin as GetReferencesDetailsProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
