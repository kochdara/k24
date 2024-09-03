// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'languages_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getLanguagesDetailsHash() =>
    r'c58fe48e22aef0b5ce273d6ae955fd500a61e6af';

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

abstract class _$GetLanguagesDetails
    extends BuildlessAutoDisposeAsyncNotifier<ResumeLanguage?> {
  late final WidgetRef context;
  late final String id;

  FutureOr<ResumeLanguage?> build(
    WidgetRef context,
    String id,
  );
}

/// See also [GetLanguagesDetails].
@ProviderFor(GetLanguagesDetails)
const getLanguagesDetailsProvider = GetLanguagesDetailsFamily();

/// See also [GetLanguagesDetails].
class GetLanguagesDetailsFamily extends Family<AsyncValue<ResumeLanguage?>> {
  /// See also [GetLanguagesDetails].
  const GetLanguagesDetailsFamily();

  /// See also [GetLanguagesDetails].
  GetLanguagesDetailsProvider call(
    WidgetRef context,
    String id,
  ) {
    return GetLanguagesDetailsProvider(
      context,
      id,
    );
  }

  @override
  GetLanguagesDetailsProvider getProviderOverride(
    covariant GetLanguagesDetailsProvider provider,
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
  String? get name => r'getLanguagesDetailsProvider';
}

/// See also [GetLanguagesDetails].
class GetLanguagesDetailsProvider extends AutoDisposeAsyncNotifierProviderImpl<
    GetLanguagesDetails, ResumeLanguage?> {
  /// See also [GetLanguagesDetails].
  GetLanguagesDetailsProvider(
    WidgetRef context,
    String id,
  ) : this._internal(
          () => GetLanguagesDetails()
            ..context = context
            ..id = id,
          from: getLanguagesDetailsProvider,
          name: r'getLanguagesDetailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getLanguagesDetailsHash,
          dependencies: GetLanguagesDetailsFamily._dependencies,
          allTransitiveDependencies:
              GetLanguagesDetailsFamily._allTransitiveDependencies,
          context: context,
          id: id,
        );

  GetLanguagesDetailsProvider._internal(
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
    covariant GetLanguagesDetails notifier,
  ) {
    return notifier.build(
      context,
      id,
    );
  }

  @override
  Override overrideWith(GetLanguagesDetails Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetLanguagesDetailsProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<GetLanguagesDetails, ResumeLanguage?>
      createElement() {
    return _GetLanguagesDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetLanguagesDetailsProvider &&
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

mixin GetLanguagesDetailsRef
    on AutoDisposeAsyncNotifierProviderRef<ResumeLanguage?> {
  /// The parameter `context` of this provider.
  WidgetRef get context;

  /// The parameter `id` of this provider.
  String get id;
}

class _GetLanguagesDetailsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetLanguagesDetails,
        ResumeLanguage?> with GetLanguagesDetailsRef {
  _GetLanguagesDetailsProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as GetLanguagesDetailsProvider).context;
  @override
  String get id => (origin as GetLanguagesDetailsProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
