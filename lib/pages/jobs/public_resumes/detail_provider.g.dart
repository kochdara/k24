// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getDetailsResumeHash() => r'39dd3eec1f755b0c1c5c4b3e2e599e2360106736';

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

abstract class _$GetDetailsResume
    extends BuildlessAutoDisposeAsyncNotifier<ResumeData?> {
  late final WidgetRef context;
  late final String idJob;
  late final String? keyField;

  FutureOr<ResumeData?> build(
    WidgetRef context,
    String idJob, {
    String? keyField,
  });
}

/// See also [GetDetailsResume].
@ProviderFor(GetDetailsResume)
const getDetailsResumeProvider = GetDetailsResumeFamily();

/// See also [GetDetailsResume].
class GetDetailsResumeFamily extends Family<AsyncValue<ResumeData?>> {
  /// See also [GetDetailsResume].
  const GetDetailsResumeFamily();

  /// See also [GetDetailsResume].
  GetDetailsResumeProvider call(
    WidgetRef context,
    String idJob, {
    String? keyField,
  }) {
    return GetDetailsResumeProvider(
      context,
      idJob,
      keyField: keyField,
    );
  }

  @override
  GetDetailsResumeProvider getProviderOverride(
    covariant GetDetailsResumeProvider provider,
  ) {
    return call(
      provider.context,
      provider.idJob,
      keyField: provider.keyField,
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
  String? get name => r'getDetailsResumeProvider';
}

/// See also [GetDetailsResume].
class GetDetailsResumeProvider extends AutoDisposeAsyncNotifierProviderImpl<
    GetDetailsResume, ResumeData?> {
  /// See also [GetDetailsResume].
  GetDetailsResumeProvider(
    WidgetRef context,
    String idJob, {
    String? keyField,
  }) : this._internal(
          () => GetDetailsResume()
            ..context = context
            ..idJob = idJob
            ..keyField = keyField,
          from: getDetailsResumeProvider,
          name: r'getDetailsResumeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getDetailsResumeHash,
          dependencies: GetDetailsResumeFamily._dependencies,
          allTransitiveDependencies:
              GetDetailsResumeFamily._allTransitiveDependencies,
          context: context,
          idJob: idJob,
          keyField: keyField,
        );

  GetDetailsResumeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
    required this.idJob,
    required this.keyField,
  }) : super.internal();

  final WidgetRef context;
  final String idJob;
  final String? keyField;

  @override
  FutureOr<ResumeData?> runNotifierBuild(
    covariant GetDetailsResume notifier,
  ) {
    return notifier.build(
      context,
      idJob,
      keyField: keyField,
    );
  }

  @override
  Override overrideWith(GetDetailsResume Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetDetailsResumeProvider._internal(
        () => create()
          ..context = context
          ..idJob = idJob
          ..keyField = keyField,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
        idJob: idJob,
        keyField: keyField,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GetDetailsResume, ResumeData?>
      createElement() {
    return _GetDetailsResumeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetDetailsResumeProvider &&
        other.context == context &&
        other.idJob == idJob &&
        other.keyField == keyField;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);
    hash = _SystemHash.combine(hash, idJob.hashCode);
    hash = _SystemHash.combine(hash, keyField.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetDetailsResumeRef on AutoDisposeAsyncNotifierProviderRef<ResumeData?> {
  /// The parameter `context` of this provider.
  WidgetRef get context;

  /// The parameter `idJob` of this provider.
  String get idJob;

  /// The parameter `keyField` of this provider.
  String? get keyField;
}

class _GetDetailsResumeProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetDetailsResume,
        ResumeData?> with GetDetailsResumeRef {
  _GetDetailsResumeProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as GetDetailsResumeProvider).context;
  @override
  String get idJob => (origin as GetDetailsResumeProvider).idJob;
  @override
  String? get keyField => (origin as GetDetailsResumeProvider).keyField;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
