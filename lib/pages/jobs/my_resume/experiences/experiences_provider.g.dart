// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experiences_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getExperiencesHash() => r'4f403d4371156657614894a1c0a550e33522ef29';

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

abstract class _$GetExperiences
    extends BuildlessAutoDisposeAsyncNotifier<List<ResumeExperience?>> {
  late final WidgetRef context;

  FutureOr<List<ResumeExperience?>> build(
    WidgetRef context,
  );
}

/// See also [GetExperiences].
@ProviderFor(GetExperiences)
const getExperiencesProvider = GetExperiencesFamily();

/// See also [GetExperiences].
class GetExperiencesFamily extends Family<AsyncValue<List<ResumeExperience?>>> {
  /// See also [GetExperiences].
  const GetExperiencesFamily();

  /// See also [GetExperiences].
  GetExperiencesProvider call(
    WidgetRef context,
  ) {
    return GetExperiencesProvider(
      context,
    );
  }

  @override
  GetExperiencesProvider getProviderOverride(
    covariant GetExperiencesProvider provider,
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
  String? get name => r'getExperiencesProvider';
}

/// See also [GetExperiences].
class GetExperiencesProvider extends AutoDisposeAsyncNotifierProviderImpl<
    GetExperiences, List<ResumeExperience?>> {
  /// See also [GetExperiences].
  GetExperiencesProvider(
    WidgetRef context,
  ) : this._internal(
          () => GetExperiences()..context = context,
          from: getExperiencesProvider,
          name: r'getExperiencesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getExperiencesHash,
          dependencies: GetExperiencesFamily._dependencies,
          allTransitiveDependencies:
              GetExperiencesFamily._allTransitiveDependencies,
          context: context,
        );

  GetExperiencesProvider._internal(
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
  FutureOr<List<ResumeExperience?>> runNotifierBuild(
    covariant GetExperiences notifier,
  ) {
    return notifier.build(
      context,
    );
  }

  @override
  Override overrideWith(GetExperiences Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetExperiencesProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<GetExperiences,
      List<ResumeExperience?>> createElement() {
    return _GetExperiencesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetExperiencesProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetExperiencesRef
    on AutoDisposeAsyncNotifierProviderRef<List<ResumeExperience?>> {
  /// The parameter `context` of this provider.
  WidgetRef get context;
}

class _GetExperiencesProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetExperiences,
        List<ResumeExperience?>> with GetExperiencesRef {
  _GetExperiencesProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as GetExperiencesProvider).context;
}

String _$getExperiencesDetailsHash() =>
    r'4ca4530d687f1aa4cae8420426c91e730a37316f';

abstract class _$GetExperiencesDetails
    extends BuildlessAutoDisposeAsyncNotifier<ResumeExperience?> {
  late final WidgetRef context;
  late final String id;

  FutureOr<ResumeExperience?> build(
    WidgetRef context,
    String id,
  );
}

/// See also [GetExperiencesDetails].
@ProviderFor(GetExperiencesDetails)
const getExperiencesDetailsProvider = GetExperiencesDetailsFamily();

/// See also [GetExperiencesDetails].
class GetExperiencesDetailsFamily
    extends Family<AsyncValue<ResumeExperience?>> {
  /// See also [GetExperiencesDetails].
  const GetExperiencesDetailsFamily();

  /// See also [GetExperiencesDetails].
  GetExperiencesDetailsProvider call(
    WidgetRef context,
    String id,
  ) {
    return GetExperiencesDetailsProvider(
      context,
      id,
    );
  }

  @override
  GetExperiencesDetailsProvider getProviderOverride(
    covariant GetExperiencesDetailsProvider provider,
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
  String? get name => r'getExperiencesDetailsProvider';
}

/// See also [GetExperiencesDetails].
class GetExperiencesDetailsProvider
    extends AutoDisposeAsyncNotifierProviderImpl<GetExperiencesDetails,
        ResumeExperience?> {
  /// See also [GetExperiencesDetails].
  GetExperiencesDetailsProvider(
    WidgetRef context,
    String id,
  ) : this._internal(
          () => GetExperiencesDetails()
            ..context = context
            ..id = id,
          from: getExperiencesDetailsProvider,
          name: r'getExperiencesDetailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getExperiencesDetailsHash,
          dependencies: GetExperiencesDetailsFamily._dependencies,
          allTransitiveDependencies:
              GetExperiencesDetailsFamily._allTransitiveDependencies,
          context: context,
          id: id,
        );

  GetExperiencesDetailsProvider._internal(
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
  FutureOr<ResumeExperience?> runNotifierBuild(
    covariant GetExperiencesDetails notifier,
  ) {
    return notifier.build(
      context,
      id,
    );
  }

  @override
  Override overrideWith(GetExperiencesDetails Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetExperiencesDetailsProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<GetExperiencesDetails,
      ResumeExperience?> createElement() {
    return _GetExperiencesDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetExperiencesDetailsProvider &&
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

mixin GetExperiencesDetailsRef
    on AutoDisposeAsyncNotifierProviderRef<ResumeExperience?> {
  /// The parameter `context` of this provider.
  WidgetRef get context;

  /// The parameter `id` of this provider.
  String get id;
}

class _GetExperiencesDetailsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetExperiencesDetails,
        ResumeExperience?> with GetExperiencesDetailsRef {
  _GetExperiencesDetailsProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as GetExperiencesDetailsProvider).context;
  @override
  String get id => (origin as GetExperiencesDetailsProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
