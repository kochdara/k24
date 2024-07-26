// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notify_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notifyListHash() => r'22d2125aa37fa286fa5339be3c6d47c7f3e0fd9f';

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

abstract class _$NotifyList
    extends BuildlessAutoDisposeAsyncNotifier<List<NotifyDatum>> {
  late final WidgetRef context;

  FutureOr<List<NotifyDatum>> build(
    WidgetRef context,
  );
}

/// See also [NotifyList].
@ProviderFor(NotifyList)
const notifyListProvider = NotifyListFamily();

/// See also [NotifyList].
class NotifyListFamily extends Family<AsyncValue<List<NotifyDatum>>> {
  /// See also [NotifyList].
  const NotifyListFamily();

  /// See also [NotifyList].
  NotifyListProvider call(
    WidgetRef context,
  ) {
    return NotifyListProvider(
      context,
    );
  }

  @override
  NotifyListProvider getProviderOverride(
    covariant NotifyListProvider provider,
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
  String? get name => r'notifyListProvider';
}

/// See also [NotifyList].
class NotifyListProvider extends AutoDisposeAsyncNotifierProviderImpl<
    NotifyList, List<NotifyDatum>> {
  /// See also [NotifyList].
  NotifyListProvider(
    WidgetRef context,
  ) : this._internal(
          () => NotifyList()..context = context,
          from: notifyListProvider,
          name: r'notifyListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$notifyListHash,
          dependencies: NotifyListFamily._dependencies,
          allTransitiveDependencies:
              NotifyListFamily._allTransitiveDependencies,
          context: context,
        );

  NotifyListProvider._internal(
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
  FutureOr<List<NotifyDatum>> runNotifierBuild(
    covariant NotifyList notifier,
  ) {
    return notifier.build(
      context,
    );
  }

  @override
  Override overrideWith(NotifyList Function() create) {
    return ProviderOverride(
      origin: this,
      override: NotifyListProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<NotifyList, List<NotifyDatum>>
      createElement() {
    return _NotifyListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NotifyListProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin NotifyListRef on AutoDisposeAsyncNotifierProviderRef<List<NotifyDatum>> {
  /// The parameter `context` of this provider.
  WidgetRef get context;
}

class _NotifyListProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<NotifyList,
        List<NotifyDatum>> with NotifyListRef {
  _NotifyListProviderElement(super.provider);

  @override
  WidgetRef get context => (origin as NotifyListProvider).context;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
