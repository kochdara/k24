// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getResumeInfoHash() => r'7b61bcad3ecdfe7ff3d7979a8045894dbcefbfec';

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

abstract class _$GetResumeInfo
    extends BuildlessAutoDisposeAsyncNotifier<MyResumeSerial?> {
  late final WidgetRef context;

  FutureOr<MyResumeSerial?> build(
    WidgetRef context,
  );
}

/// See also [GetResumeInfo].
@ProviderFor(GetResumeInfo)
const getResumeInfoProvider = GetResumeInfoFamily();

/// See also [GetResumeInfo].
class GetResumeInfoFamily extends Family<AsyncValue<MyResumeSerial?>> {
  /// See also [GetResumeInfo].
  const GetResumeInfoFamily();

  /// See also [GetResumeInfo].
  GetResumeInfoProvider call(
    WidgetRef context,
  ) {
    return GetResumeInfoProvider(
      context,
    );
  }

  @override
  GetResumeInfoProvider getProviderOverride(
    covariant GetResumeInfoProvider provider,
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
  String? get name => r'getResumeInfoProvider';
}

/// See also [GetResumeInfo].
class GetResumeInfoProvider extends AutoDisposeAsyncNotifierProviderImpl<
    GetResumeInfo, MyResumeSerial?> {
  /// See also [GetResumeInfo].
  GetResumeInfoProvider(
    WidgetRef context,
  ) : this._internal(
          () => GetResumeInfo()..context = context,
          from: getResumeInfoProvider,
          name: r'getResumeInfoProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getResumeInfoHash,
          dependencies: GetResumeInfoFamily._dependencies,
          allTransitiveDependencies:
              GetResumeInfoFamily._allTransitiveDependencies,
          context: context,
        );

  GetResumeInfoProvider._internal(
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
  FutureOr<MyResumeSerial?> runNotifierBuild(
    covariant GetResumeInfo notifier,
  ) {
    return notifier.build(
      context,
    );
  }

  @override
  Override overrideWith(GetResumeInfo Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetResumeInfoProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<GetResumeInfo, MyResumeSerial?>
      createElement() {
    return _GetResumeInfoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetResumeInfoProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetResumeInfoRef on AutoDisposeAsyncNotifierProviderRef<MyResumeSerial?> {
  /// The parameter `context` of this provider.
  WidgetRef get context;
}

class _GetResumeInfoProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetResumeInfo,
        MyResumeSerial?> with GetResumeInfoRef {
  _GetResumeInfoProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as GetResumeInfoProvider).context;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
