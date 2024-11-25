// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'editpage_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$editProfileHash() => r'15d911f317d76d735b9c19e3ffcaef73b3074a42';

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

abstract class _$EditProfile
    extends BuildlessAutoDisposeAsyncNotifier<EditProfileData?> {
  late final WidgetRef context;

  FutureOr<EditProfileData?> build(
    WidgetRef context,
  );
}

/// See also [EditProfile].
@ProviderFor(EditProfile)
const editProfileProvider = EditProfileFamily();

/// See also [EditProfile].
class EditProfileFamily extends Family<AsyncValue<EditProfileData?>> {
  /// See also [EditProfile].
  const EditProfileFamily();

  /// See also [EditProfile].
  EditProfileProvider call(
    WidgetRef context,
  ) {
    return EditProfileProvider(
      context,
    );
  }

  @override
  EditProfileProvider getProviderOverride(
    covariant EditProfileProvider provider,
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
  String? get name => r'editProfileProvider';
}

/// See also [EditProfile].
class EditProfileProvider extends AutoDisposeAsyncNotifierProviderImpl<
    EditProfile, EditProfileData?> {
  /// See also [EditProfile].
  EditProfileProvider(
    WidgetRef context,
  ) : this._internal(
          () => EditProfile()..context = context,
          from: editProfileProvider,
          name: r'editProfileProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$editProfileHash,
          dependencies: EditProfileFamily._dependencies,
          allTransitiveDependencies:
              EditProfileFamily._allTransitiveDependencies,
          context: context,
        );

  EditProfileProvider._internal(
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
  FutureOr<EditProfileData?> runNotifierBuild(
    covariant EditProfile notifier,
  ) {
    return notifier.build(
      context,
    );
  }

  @override
  Override overrideWith(EditProfile Function() create) {
    return ProviderOverride(
      origin: this,
      override: EditProfileProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<EditProfile, EditProfileData?>
      createElement() {
    return _EditProfileProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EditProfileProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EditProfileRef on AutoDisposeAsyncNotifierProviderRef<EditProfileData?> {
  /// The parameter `context` of this provider.
  WidgetRef get context;
}

class _EditProfileProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<EditProfile,
        EditProfileData?> with EditProfileRef {
  _EditProfileProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as EditProfileProvider).context;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
