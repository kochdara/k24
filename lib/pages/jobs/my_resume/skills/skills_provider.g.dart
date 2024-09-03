// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skills_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getSkillsDetailsHash() => r'f022db354d6db6b6f09b47d5765791eecc37b2ac';

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

abstract class _$GetSkillsDetails
    extends BuildlessAutoDisposeAsyncNotifier<ResumeLanguage?> {
  late final WidgetRef context;
  late final String id;

  FutureOr<ResumeLanguage?> build(
    WidgetRef context,
    String id,
  );
}

/// See also [GetSkillsDetails].
@ProviderFor(GetSkillsDetails)
const getSkillsDetailsProvider = GetSkillsDetailsFamily();

/// See also [GetSkillsDetails].
class GetSkillsDetailsFamily extends Family<AsyncValue<ResumeLanguage?>> {
  /// See also [GetSkillsDetails].
  const GetSkillsDetailsFamily();

  /// See also [GetSkillsDetails].
  GetSkillsDetailsProvider call(
    WidgetRef context,
    String id,
  ) {
    return GetSkillsDetailsProvider(
      context,
      id,
    );
  }

  @override
  GetSkillsDetailsProvider getProviderOverride(
    covariant GetSkillsDetailsProvider provider,
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
  String? get name => r'getSkillsDetailsProvider';
}

/// See also [GetSkillsDetails].
class GetSkillsDetailsProvider extends AutoDisposeAsyncNotifierProviderImpl<
    GetSkillsDetails, ResumeLanguage?> {
  /// See also [GetSkillsDetails].
  GetSkillsDetailsProvider(
    WidgetRef context,
    String id,
  ) : this._internal(
          () => GetSkillsDetails()
            ..context = context
            ..id = id,
          from: getSkillsDetailsProvider,
          name: r'getSkillsDetailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getSkillsDetailsHash,
          dependencies: GetSkillsDetailsFamily._dependencies,
          allTransitiveDependencies:
              GetSkillsDetailsFamily._allTransitiveDependencies,
          context: context,
          id: id,
        );

  GetSkillsDetailsProvider._internal(
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
  FutureOr<ResumeLanguage?> runNotifierBuild(
    covariant GetSkillsDetails notifier,
  ) {
    return notifier.build(
      context,
      id,
    );
  }

  @override
  Override overrideWith(GetSkillsDetails Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetSkillsDetailsProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<GetSkillsDetails, ResumeLanguage?>
      createElement() {
    return _GetSkillsDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetSkillsDetailsProvider &&
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

mixin GetSkillsDetailsRef
    on AutoDisposeAsyncNotifierProviderRef<ResumeLanguage?> {
  /// The parameter `context` of this provider.
  WidgetRef get context;

  /// The parameter `id` of this provider.
  String get id;
}

class _GetSkillsDetailsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetSkillsDetails,
        ResumeLanguage?> with GetSkillsDetailsRef {
  _GetSkillsDetailsProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as GetSkillsDetailsProvider).context;
  @override
  String get id => (origin as GetSkillsDetailsProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
