// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$profilePublicHash() => r'4b1666fbbed3b7199ef0f7d6a7573d185fd39eff';

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

abstract class _$ProfilePublic
    extends BuildlessAutoDisposeAsyncNotifier<ProfileSerial?> {
  late final WidgetRef context;
  late final String? username;

  FutureOr<ProfileSerial?> build(
    WidgetRef context,
    String? username,
  );
}

/// See also [ProfilePublic].
@ProviderFor(ProfilePublic)
const profilePublicProvider = ProfilePublicFamily();

/// See also [ProfilePublic].
class ProfilePublicFamily extends Family<AsyncValue<ProfileSerial?>> {
  /// See also [ProfilePublic].
  const ProfilePublicFamily();

  /// See also [ProfilePublic].
  ProfilePublicProvider call(
    WidgetRef context,
    String? username,
  ) {
    return ProfilePublicProvider(
      context,
      username,
    );
  }

  @override
  ProfilePublicProvider getProviderOverride(
    covariant ProfilePublicProvider provider,
  ) {
    return call(
      provider.context,
      provider.username,
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
  String? get name => r'profilePublicProvider';
}

/// See also [ProfilePublic].
class ProfilePublicProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ProfilePublic, ProfileSerial?> {
  /// See also [ProfilePublic].
  ProfilePublicProvider(
    WidgetRef context,
    String? username,
  ) : this._internal(
          () => ProfilePublic()
            ..context = context
            ..username = username,
          from: profilePublicProvider,
          name: r'profilePublicProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$profilePublicHash,
          dependencies: ProfilePublicFamily._dependencies,
          allTransitiveDependencies:
              ProfilePublicFamily._allTransitiveDependencies,
          context: context,
          username: username,
        );

  ProfilePublicProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
    required this.username,
  }) : super.internal();

  final WidgetRef context;
  final String? username;

  @override
  FutureOr<ProfileSerial?> runNotifierBuild(
    covariant ProfilePublic notifier,
  ) {
    return notifier.build(
      context,
      username,
    );
  }

  @override
  Override overrideWith(ProfilePublic Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProfilePublicProvider._internal(
        () => create()
          ..context = context
          ..username = username,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
        username: username,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ProfilePublic, ProfileSerial?>
      createElement() {
    return _ProfilePublicProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProfilePublicProvider &&
        other.context == context &&
        other.username == username;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);
    hash = _SystemHash.combine(hash, username.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ProfilePublicRef on AutoDisposeAsyncNotifierProviderRef<ProfileSerial?> {
  /// The parameter `context` of this provider.
  WidgetRef get context;

  /// The parameter `username` of this provider.
  String? get username;
}

class _ProfilePublicProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ProfilePublic,
        ProfileSerial?> with ProfilePublicRef {
  _ProfilePublicProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as ProfilePublicProvider).context;
  @override
  String? get username => (origin as ProfilePublicProvider).username;
}

String _$profileListHash() => r'813428710e8e2a810edd036cfabcb0166703f624';

abstract class _$ProfileList
    extends BuildlessAutoDisposeAsyncNotifier<List<GridCard>> {
  late final WidgetRef context;
  late final String username;

  FutureOr<List<GridCard>> build(
    WidgetRef context,
    String username,
  );
}

/// See also [ProfileList].
@ProviderFor(ProfileList)
const profileListProvider = ProfileListFamily();

/// See also [ProfileList].
class ProfileListFamily extends Family<AsyncValue<List<GridCard>>> {
  /// See also [ProfileList].
  const ProfileListFamily();

  /// See also [ProfileList].
  ProfileListProvider call(
    WidgetRef context,
    String username,
  ) {
    return ProfileListProvider(
      context,
      username,
    );
  }

  @override
  ProfileListProvider getProviderOverride(
    covariant ProfileListProvider provider,
  ) {
    return call(
      provider.context,
      provider.username,
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
  String? get name => r'profileListProvider';
}

/// See also [ProfileList].
class ProfileListProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ProfileList, List<GridCard>> {
  /// See also [ProfileList].
  ProfileListProvider(
    WidgetRef context,
    String username,
  ) : this._internal(
          () => ProfileList()
            ..context = context
            ..username = username,
          from: profileListProvider,
          name: r'profileListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$profileListHash,
          dependencies: ProfileListFamily._dependencies,
          allTransitiveDependencies:
              ProfileListFamily._allTransitiveDependencies,
          context: context,
          username: username,
        );

  ProfileListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
    required this.username,
  }) : super.internal();

  final WidgetRef context;
  final String username;

  @override
  FutureOr<List<GridCard>> runNotifierBuild(
    covariant ProfileList notifier,
  ) {
    return notifier.build(
      context,
      username,
    );
  }

  @override
  Override overrideWith(ProfileList Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProfileListProvider._internal(
        () => create()
          ..context = context
          ..username = username,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
        username: username,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ProfileList, List<GridCard>>
      createElement() {
    return _ProfileListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProfileListProvider &&
        other.context == context &&
        other.username == username;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);
    hash = _SystemHash.combine(hash, username.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ProfileListRef on AutoDisposeAsyncNotifierProviderRef<List<GridCard>> {
  /// The parameter `context` of this provider.
  WidgetRef get context;

  /// The parameter `username` of this provider.
  String get username;
}

class _ProfileListProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ProfileList, List<GridCard>>
    with ProfileListRef {
  _ProfileListProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as ProfileListProvider).context;
  @override
  String get username => (origin as ProfileListProvider).username;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
