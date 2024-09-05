// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$loginInformationHash() => r'36b9d5a64a49c617da5664026ece18378e89ff2a';

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

abstract class _$LoginInformation
    extends BuildlessAutoDisposeAsyncNotifier<UserProfile?> {
  late final WidgetRef context;

  FutureOr<UserProfile?> build(
    WidgetRef context,
  );
}

/// See also [LoginInformation].
@ProviderFor(LoginInformation)
const loginInformationProvider = LoginInformationFamily();

/// See also [LoginInformation].
class LoginInformationFamily extends Family<AsyncValue<UserProfile?>> {
  /// See also [LoginInformation].
  const LoginInformationFamily();

  /// See also [LoginInformation].
  LoginInformationProvider call(
    WidgetRef context,
  ) {
    return LoginInformationProvider(
      context,
    );
  }

  @override
  LoginInformationProvider getProviderOverride(
    covariant LoginInformationProvider provider,
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
  String? get name => r'loginInformationProvider';
}

/// See also [LoginInformation].
class LoginInformationProvider extends AutoDisposeAsyncNotifierProviderImpl<
    LoginInformation, UserProfile?> {
  /// See also [LoginInformation].
  LoginInformationProvider(
    WidgetRef context,
  ) : this._internal(
          () => LoginInformation()..context = context,
          from: loginInformationProvider,
          name: r'loginInformationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$loginInformationHash,
          dependencies: LoginInformationFamily._dependencies,
          allTransitiveDependencies:
              LoginInformationFamily._allTransitiveDependencies,
          context: context,
        );

  LoginInformationProvider._internal(
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
  FutureOr<UserProfile?> runNotifierBuild(
    covariant LoginInformation notifier,
  ) {
    return notifier.build(
      context,
    );
  }

  @override
  Override overrideWith(LoginInformation Function() create) {
    return ProviderOverride(
      origin: this,
      override: LoginInformationProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<LoginInformation, UserProfile?>
      createElement() {
    return _LoginInformationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LoginInformationProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin LoginInformationRef on AutoDisposeAsyncNotifierProviderRef<UserProfile?> {
  /// The parameter `context` of this provider.
  WidgetRef get context;
}

class _LoginInformationProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<LoginInformation,
        UserProfile?> with LoginInformationRef {
  _LoginInformationProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as LoginInformationProvider).context;
}

String _$ownProfileListHash() => r'a2c077cee31b709de8251816a205984c2a22f0ed';

abstract class _$OwnProfileList
    extends BuildlessAutoDisposeAsyncNotifier<List<DatumProfile>> {
  late final WidgetRef context;
  late final Map<String, dynamic>? newMap;

  FutureOr<List<DatumProfile>> build(
    WidgetRef context,
    Map<String, dynamic>? newMap,
  );
}

/// See also [OwnProfileList].
@ProviderFor(OwnProfileList)
const ownProfileListProvider = OwnProfileListFamily();

/// See also [OwnProfileList].
class OwnProfileListFamily extends Family<AsyncValue<List<DatumProfile>>> {
  /// See also [OwnProfileList].
  const OwnProfileListFamily();

  /// See also [OwnProfileList].
  OwnProfileListProvider call(
    WidgetRef context,
    Map<String, dynamic>? newMap,
  ) {
    return OwnProfileListProvider(
      context,
      newMap,
    );
  }

  @override
  OwnProfileListProvider getProviderOverride(
    covariant OwnProfileListProvider provider,
  ) {
    return call(
      provider.context,
      provider.newMap,
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
  String? get name => r'ownProfileListProvider';
}

/// See also [OwnProfileList].
class OwnProfileListProvider extends AutoDisposeAsyncNotifierProviderImpl<
    OwnProfileList, List<DatumProfile>> {
  /// See also [OwnProfileList].
  OwnProfileListProvider(
    WidgetRef context,
    Map<String, dynamic>? newMap,
  ) : this._internal(
          () => OwnProfileList()
            ..context = context
            ..newMap = newMap,
          from: ownProfileListProvider,
          name: r'ownProfileListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ownProfileListHash,
          dependencies: OwnProfileListFamily._dependencies,
          allTransitiveDependencies:
              OwnProfileListFamily._allTransitiveDependencies,
          context: context,
          newMap: newMap,
        );

  OwnProfileListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
    required this.newMap,
  }) : super.internal();

  final WidgetRef context;
  final Map<String, dynamic>? newMap;

  @override
  FutureOr<List<DatumProfile>> runNotifierBuild(
    covariant OwnProfileList notifier,
  ) {
    return notifier.build(
      context,
      newMap,
    );
  }

  @override
  Override overrideWith(OwnProfileList Function() create) {
    return ProviderOverride(
      origin: this,
      override: OwnProfileListProvider._internal(
        () => create()
          ..context = context
          ..newMap = newMap,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
        newMap: newMap,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<OwnProfileList, List<DatumProfile>>
      createElement() {
    return _OwnProfileListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OwnProfileListProvider &&
        other.context == context &&
        other.newMap == newMap;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);
    hash = _SystemHash.combine(hash, newMap.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin OwnProfileListRef
    on AutoDisposeAsyncNotifierProviderRef<List<DatumProfile>> {
  /// The parameter `context` of this provider.
  WidgetRef get context;

  /// The parameter `newMap` of this provider.
  Map<String, dynamic>? get newMap;
}

class _OwnProfileListProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<OwnProfileList,
        List<DatumProfile>> with OwnProfileListRef {
  _OwnProfileListProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as OwnProfileListProvider).context;
  @override
  Map<String, dynamic>? get newMap => (origin as OwnProfileListProvider).newMap;
}

String _$getTotalPostHash() => r'10ca8e7c64a1e772fb7b005cdce79bcee520645e';

abstract class _$GetTotalPost
    extends BuildlessAutoDisposeAsyncNotifier<OwnDataTotalPost?> {
  late final WidgetRef context;

  FutureOr<OwnDataTotalPost?> build(
    WidgetRef context,
  );
}

/// See also [GetTotalPost].
@ProviderFor(GetTotalPost)
const getTotalPostProvider = GetTotalPostFamily();

/// See also [GetTotalPost].
class GetTotalPostFamily extends Family<AsyncValue<OwnDataTotalPost?>> {
  /// See also [GetTotalPost].
  const GetTotalPostFamily();

  /// See also [GetTotalPost].
  GetTotalPostProvider call(
    WidgetRef context,
  ) {
    return GetTotalPostProvider(
      context,
    );
  }

  @override
  GetTotalPostProvider getProviderOverride(
    covariant GetTotalPostProvider provider,
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
  String? get name => r'getTotalPostProvider';
}

/// See also [GetTotalPost].
class GetTotalPostProvider extends AutoDisposeAsyncNotifierProviderImpl<
    GetTotalPost, OwnDataTotalPost?> {
  /// See also [GetTotalPost].
  GetTotalPostProvider(
    WidgetRef context,
  ) : this._internal(
          () => GetTotalPost()..context = context,
          from: getTotalPostProvider,
          name: r'getTotalPostProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getTotalPostHash,
          dependencies: GetTotalPostFamily._dependencies,
          allTransitiveDependencies:
              GetTotalPostFamily._allTransitiveDependencies,
          context: context,
        );

  GetTotalPostProvider._internal(
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
  FutureOr<OwnDataTotalPost?> runNotifierBuild(
    covariant GetTotalPost notifier,
  ) {
    return notifier.build(
      context,
    );
  }

  @override
  Override overrideWith(GetTotalPost Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetTotalPostProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<GetTotalPost, OwnDataTotalPost?>
      createElement() {
    return _GetTotalPostProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetTotalPostProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetTotalPostRef
    on AutoDisposeAsyncNotifierProviderRef<OwnDataTotalPost?> {
  /// The parameter `context` of this provider.
  WidgetRef get context;
}

class _GetTotalPostProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetTotalPost,
        OwnDataTotalPost?> with GetTotalPostRef {
  _GetTotalPostProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as GetTotalPostProvider).context;
}

String _$getDeleteReasonHash() => r'2c0971b12f82d1d05145415e27327198e28eb1bc';

abstract class _$GetDeleteReason
    extends BuildlessAutoDisposeAsyncNotifier<DeleteReasonSerial?> {
  late final WidgetRef context;

  FutureOr<DeleteReasonSerial?> build(
    WidgetRef context,
  );
}

/// See also [GetDeleteReason].
@ProviderFor(GetDeleteReason)
const getDeleteReasonProvider = GetDeleteReasonFamily();

/// See also [GetDeleteReason].
class GetDeleteReasonFamily extends Family<AsyncValue<DeleteReasonSerial?>> {
  /// See also [GetDeleteReason].
  const GetDeleteReasonFamily();

  /// See also [GetDeleteReason].
  GetDeleteReasonProvider call(
    WidgetRef context,
  ) {
    return GetDeleteReasonProvider(
      context,
    );
  }

  @override
  GetDeleteReasonProvider getProviderOverride(
    covariant GetDeleteReasonProvider provider,
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
  String? get name => r'getDeleteReasonProvider';
}

/// See also [GetDeleteReason].
class GetDeleteReasonProvider extends AutoDisposeAsyncNotifierProviderImpl<
    GetDeleteReason, DeleteReasonSerial?> {
  /// See also [GetDeleteReason].
  GetDeleteReasonProvider(
    WidgetRef context,
  ) : this._internal(
          () => GetDeleteReason()..context = context,
          from: getDeleteReasonProvider,
          name: r'getDeleteReasonProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getDeleteReasonHash,
          dependencies: GetDeleteReasonFamily._dependencies,
          allTransitiveDependencies:
              GetDeleteReasonFamily._allTransitiveDependencies,
          context: context,
        );

  GetDeleteReasonProvider._internal(
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
  FutureOr<DeleteReasonSerial?> runNotifierBuild(
    covariant GetDeleteReason notifier,
  ) {
    return notifier.build(
      context,
    );
  }

  @override
  Override overrideWith(GetDeleteReason Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetDeleteReasonProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<GetDeleteReason, DeleteReasonSerial?>
      createElement() {
    return _GetDeleteReasonProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetDeleteReasonProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetDeleteReasonRef
    on AutoDisposeAsyncNotifierProviderRef<DeleteReasonSerial?> {
  /// The parameter `context` of this provider.
  WidgetRef get context;
}

class _GetDeleteReasonProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetDeleteReason,
        DeleteReasonSerial?> with GetDeleteReasonRef {
  _GetDeleteReasonProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as GetDeleteReasonProvider).context;
}

String _$getPostFilterHash() => r'5c773aab5fcb301e79fb6798989d94b3d1a044d3';

abstract class _$GetPostFilter
    extends BuildlessAutoDisposeAsyncNotifier<CategoryPostSerial?> {
  late final WidgetRef context;

  FutureOr<CategoryPostSerial?> build(
    WidgetRef context,
  );
}

/// See also [GetPostFilter].
@ProviderFor(GetPostFilter)
const getPostFilterProvider = GetPostFilterFamily();

/// See also [GetPostFilter].
class GetPostFilterFamily extends Family<AsyncValue<CategoryPostSerial?>> {
  /// See also [GetPostFilter].
  const GetPostFilterFamily();

  /// See also [GetPostFilter].
  GetPostFilterProvider call(
    WidgetRef context,
  ) {
    return GetPostFilterProvider(
      context,
    );
  }

  @override
  GetPostFilterProvider getProviderOverride(
    covariant GetPostFilterProvider provider,
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
  String? get name => r'getPostFilterProvider';
}

/// See also [GetPostFilter].
class GetPostFilterProvider extends AutoDisposeAsyncNotifierProviderImpl<
    GetPostFilter, CategoryPostSerial?> {
  /// See also [GetPostFilter].
  GetPostFilterProvider(
    WidgetRef context,
  ) : this._internal(
          () => GetPostFilter()..context = context,
          from: getPostFilterProvider,
          name: r'getPostFilterProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPostFilterHash,
          dependencies: GetPostFilterFamily._dependencies,
          allTransitiveDependencies:
              GetPostFilterFamily._allTransitiveDependencies,
          context: context,
        );

  GetPostFilterProvider._internal(
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
  FutureOr<CategoryPostSerial?> runNotifierBuild(
    covariant GetPostFilter notifier,
  ) {
    return notifier.build(
      context,
    );
  }

  @override
  Override overrideWith(GetPostFilter Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetPostFilterProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<GetPostFilter, CategoryPostSerial?>
      createElement() {
    return _GetPostFilterProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetPostFilterProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetPostFilterRef
    on AutoDisposeAsyncNotifierProviderRef<CategoryPostSerial?> {
  /// The parameter `context` of this provider.
  WidgetRef get context;
}

class _GetPostFilterProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetPostFilter,
        CategoryPostSerial?> with GetPostFilterRef {
  _GetPostFilterProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as GetPostFilterProvider).context;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
