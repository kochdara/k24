// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'more_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getBannerAdsHash() => r'feaa3f4745705661d3edeee170980b206eae8667';

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

abstract class _$GetBannerAds
    extends BuildlessAutoDisposeAsyncNotifier<BannerSerial> {
  late final String dType;
  late final String type;
  late final String? page;

  FutureOr<BannerSerial> build(
    String dType,
    String type, {
    String? page,
  });
}

/// See also [GetBannerAds].
@ProviderFor(GetBannerAds)
const getBannerAdsProvider = GetBannerAdsFamily();

/// See also [GetBannerAds].
class GetBannerAdsFamily extends Family<AsyncValue<BannerSerial>> {
  /// See also [GetBannerAds].
  const GetBannerAdsFamily();

  /// See also [GetBannerAds].
  GetBannerAdsProvider call(
    String dType,
    String type, {
    String? page,
  }) {
    return GetBannerAdsProvider(
      dType,
      type,
      page: page,
    );
  }

  @override
  GetBannerAdsProvider getProviderOverride(
    covariant GetBannerAdsProvider provider,
  ) {
    return call(
      provider.dType,
      provider.type,
      page: provider.page,
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
  String? get name => r'getBannerAdsProvider';
}

/// See also [GetBannerAds].
class GetBannerAdsProvider
    extends AutoDisposeAsyncNotifierProviderImpl<GetBannerAds, BannerSerial> {
  /// See also [GetBannerAds].
  GetBannerAdsProvider(
    String dType,
    String type, {
    String? page,
  }) : this._internal(
          () => GetBannerAds()
            ..dType = dType
            ..type = type
            ..page = page,
          from: getBannerAdsProvider,
          name: r'getBannerAdsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getBannerAdsHash,
          dependencies: GetBannerAdsFamily._dependencies,
          allTransitiveDependencies:
              GetBannerAdsFamily._allTransitiveDependencies,
          dType: dType,
          type: type,
          page: page,
        );

  GetBannerAdsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.dType,
    required this.type,
    required this.page,
  }) : super.internal();

  final String dType;
  final String type;
  final String? page;

  @override
  FutureOr<BannerSerial> runNotifierBuild(
    covariant GetBannerAds notifier,
  ) {
    return notifier.build(
      dType,
      type,
      page: page,
    );
  }

  @override
  Override overrideWith(GetBannerAds Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetBannerAdsProvider._internal(
        () => create()
          ..dType = dType
          ..type = type
          ..page = page,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        dType: dType,
        type: type,
        page: page,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GetBannerAds, BannerSerial>
      createElement() {
    return _GetBannerAdsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetBannerAdsProvider &&
        other.dType == dType &&
        other.type == type &&
        other.page == page;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, dType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetBannerAdsRef on AutoDisposeAsyncNotifierProviderRef<BannerSerial> {
  /// The parameter `dType` of this provider.
  String get dType;

  /// The parameter `type` of this provider.
  String get type;

  /// The parameter `page` of this provider.
  String? get page;
}

class _GetBannerAdsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetBannerAds, BannerSerial>
    with GetBannerAdsRef {
  _GetBannerAdsProviderElement(super.provider);

  @override
  String get dType => (origin as GetBannerAdsProvider).dType;
  @override
  String get type => (origin as GetBannerAdsProvider).type;
  @override
  String? get page => (origin as GetBannerAdsProvider).page;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
