// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getPersonalDetailsHash() =>
    r'a4fcbe96b98ab1dde8ec055e452de6680298f002';

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

abstract class _$GetPersonalDetails
    extends BuildlessAutoDisposeAsyncNotifier<ResumePersonalDetails?> {
  late final WidgetRef context;

  FutureOr<ResumePersonalDetails?> build(
    WidgetRef context,
  );
}

/// See also [GetPersonalDetails].
@ProviderFor(GetPersonalDetails)
const getPersonalDetailsProvider = GetPersonalDetailsFamily();

/// See also [GetPersonalDetails].
class GetPersonalDetailsFamily
    extends Family<AsyncValue<ResumePersonalDetails?>> {
  /// See also [GetPersonalDetails].
  const GetPersonalDetailsFamily();

  /// See also [GetPersonalDetails].
  GetPersonalDetailsProvider call(
    WidgetRef context,
  ) {
    return GetPersonalDetailsProvider(
      context,
    );
  }

  @override
  GetPersonalDetailsProvider getProviderOverride(
    covariant GetPersonalDetailsProvider provider,
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
  String? get name => r'getPersonalDetailsProvider';
}

/// See also [GetPersonalDetails].
class GetPersonalDetailsProvider extends AutoDisposeAsyncNotifierProviderImpl<
    GetPersonalDetails, ResumePersonalDetails?> {
  /// See also [GetPersonalDetails].
  GetPersonalDetailsProvider(
    WidgetRef context,
  ) : this._internal(
          () => GetPersonalDetails()..context = context,
          from: getPersonalDetailsProvider,
          name: r'getPersonalDetailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPersonalDetailsHash,
          dependencies: GetPersonalDetailsFamily._dependencies,
          allTransitiveDependencies:
              GetPersonalDetailsFamily._allTransitiveDependencies,
          context: context,
        );

  GetPersonalDetailsProvider._internal(
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
  FutureOr<ResumePersonalDetails?> runNotifierBuild(
    covariant GetPersonalDetails notifier,
  ) {
    return notifier.build(
      context,
    );
  }

  @override
  Override overrideWith(GetPersonalDetails Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetPersonalDetailsProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<GetPersonalDetails,
      ResumePersonalDetails?> createElement() {
    return _GetPersonalDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetPersonalDetailsProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetPersonalDetailsRef
    on AutoDisposeAsyncNotifierProviderRef<ResumePersonalDetails?> {
  /// The parameter `context` of this provider.
  WidgetRef get context;
}

class _GetPersonalDetailsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetPersonalDetails,
        ResumePersonalDetails?> with GetPersonalDetailsRef {
  _GetPersonalDetailsProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as GetPersonalDetailsProvider).context;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
