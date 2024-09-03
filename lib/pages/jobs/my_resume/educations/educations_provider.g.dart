// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'educations_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getEducationsHash() => r'5f36ec73a9e49192280cd7a8aad2c8b197750081';

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

abstract class _$GetEducations
    extends BuildlessAutoDisposeAsyncNotifier<List<ResumeEducation?>> {
  late final WidgetRef context;

  FutureOr<List<ResumeEducation?>> build(
    WidgetRef context,
  );
}

/// See also [GetEducations].
@ProviderFor(GetEducations)
const getEducationsProvider = GetEducationsFamily();

/// See also [GetEducations].
class GetEducationsFamily extends Family<AsyncValue<List<ResumeEducation?>>> {
  /// See also [GetEducations].
  const GetEducationsFamily();

  /// See also [GetEducations].
  GetEducationsProvider call(
    WidgetRef context,
  ) {
    return GetEducationsProvider(
      context,
    );
  }

  @override
  GetEducationsProvider getProviderOverride(
    covariant GetEducationsProvider provider,
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
  String? get name => r'getEducationsProvider';
}

/// See also [GetEducations].
class GetEducationsProvider extends AutoDisposeAsyncNotifierProviderImpl<
    GetEducations, List<ResumeEducation?>> {
  /// See also [GetEducations].
  GetEducationsProvider(
    WidgetRef context,
  ) : this._internal(
          () => GetEducations()..context = context,
          from: getEducationsProvider,
          name: r'getEducationsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getEducationsHash,
          dependencies: GetEducationsFamily._dependencies,
          allTransitiveDependencies:
              GetEducationsFamily._allTransitiveDependencies,
          context: context,
        );

  GetEducationsProvider._internal(
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
  FutureOr<List<ResumeEducation?>> runNotifierBuild(
    covariant GetEducations notifier,
  ) {
    return notifier.build(
      context,
    );
  }

  @override
  Override overrideWith(GetEducations Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetEducationsProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<GetEducations, List<ResumeEducation?>>
      createElement() {
    return _GetEducationsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetEducationsProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetEducationsRef
    on AutoDisposeAsyncNotifierProviderRef<List<ResumeEducation?>> {
  /// The parameter `context` of this provider.
  WidgetRef get context;
}

class _GetEducationsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetEducations,
        List<ResumeEducation?>> with GetEducationsRef {
  _GetEducationsProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as GetEducationsProvider).context;
}

String _$getEducationsDetailsHash() =>
    r'32e71b3be7408e71ebc5f0eeab1ff436df4447c9';

abstract class _$GetEducationsDetails
    extends BuildlessAutoDisposeAsyncNotifier<ResumeEducation?> {
  late final WidgetRef context;
  late final String id;

  FutureOr<ResumeEducation?> build(
    WidgetRef context,
    String id,
  );
}

/// See also [GetEducationsDetails].
@ProviderFor(GetEducationsDetails)
const getEducationsDetailsProvider = GetEducationsDetailsFamily();

/// See also [GetEducationsDetails].
class GetEducationsDetailsFamily extends Family<AsyncValue<ResumeEducation?>> {
  /// See also [GetEducationsDetails].
  const GetEducationsDetailsFamily();

  /// See also [GetEducationsDetails].
  GetEducationsDetailsProvider call(
    WidgetRef context,
    String id,
  ) {
    return GetEducationsDetailsProvider(
      context,
      id,
    );
  }

  @override
  GetEducationsDetailsProvider getProviderOverride(
    covariant GetEducationsDetailsProvider provider,
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
  String? get name => r'getEducationsDetailsProvider';
}

/// See also [GetEducationsDetails].
class GetEducationsDetailsProvider extends AutoDisposeAsyncNotifierProviderImpl<
    GetEducationsDetails, ResumeEducation?> {
  /// See also [GetEducationsDetails].
  GetEducationsDetailsProvider(
    WidgetRef context,
    String id,
  ) : this._internal(
          () => GetEducationsDetails()
            ..context = context
            ..id = id,
          from: getEducationsDetailsProvider,
          name: r'getEducationsDetailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getEducationsDetailsHash,
          dependencies: GetEducationsDetailsFamily._dependencies,
          allTransitiveDependencies:
              GetEducationsDetailsFamily._allTransitiveDependencies,
          context: context,
          id: id,
        );

  GetEducationsDetailsProvider._internal(
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
  FutureOr<ResumeEducation?> runNotifierBuild(
    covariant GetEducationsDetails notifier,
  ) {
    return notifier.build(
      context,
      id,
    );
  }

  @override
  Override overrideWith(GetEducationsDetails Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetEducationsDetailsProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<GetEducationsDetails,
      ResumeEducation?> createElement() {
    return _GetEducationsDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetEducationsDetailsProvider &&
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

mixin GetEducationsDetailsRef
    on AutoDisposeAsyncNotifierProviderRef<ResumeEducation?> {
  /// The parameter `context` of this provider.
  WidgetRef get context;

  /// The parameter `id` of this provider.
  String get id;
}

class _GetEducationsDetailsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetEducationsDetails,
        ResumeEducation?> with GetEducationsDetailsRef {
  _GetEducationsDetailsProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as GetEducationsDetailsProvider).context;
  @override
  String get id => (origin as GetEducationsDetailsProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
