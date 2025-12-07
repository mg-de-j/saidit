// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quotes_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(quotesRepository)
const quotesRepositoryProvider = QuotesRepositoryProvider._();

final class QuotesRepositoryProvider
    extends
        $FunctionalProvider<
          QuotesRepository,
          QuotesRepository,
          QuotesRepository
        >
    with $Provider<QuotesRepository> {
  const QuotesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'quotesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$quotesRepositoryHash();

  @$internal
  @override
  $ProviderElement<QuotesRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  QuotesRepository create(Ref ref) {
    return quotesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(QuotesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<QuotesRepository>(value),
    );
  }
}

String _$quotesRepositoryHash() => r'7e11f1bdcf04a542ebed806aacc6fa5147bff9fa';

@ProviderFor(groupQuotes)
const groupQuotesProvider = GroupQuotesFamily._();

final class GroupQuotesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Quote>>,
          List<Quote>,
          Stream<List<Quote>>
        >
    with $FutureModifier<List<Quote>>, $StreamProvider<List<Quote>> {
  const GroupQuotesProvider._({
    required GroupQuotesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'groupQuotesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$groupQuotesHash();

  @override
  String toString() {
    return r'groupQuotesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Quote>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Quote>> create(Ref ref) {
    final argument = this.argument as String;
    return groupQuotes(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GroupQuotesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$groupQuotesHash() => r'2c57de1adfe5cae05208ee38c080a205bc92fc17';

final class GroupQuotesFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Quote>>, String> {
  const GroupQuotesFamily._()
    : super(
        retry: null,
        name: r'groupQuotesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GroupQuotesProvider call(String groupId) =>
      GroupQuotesProvider._(argument: groupId, from: this);

  @override
  String toString() => r'groupQuotesProvider';
}
