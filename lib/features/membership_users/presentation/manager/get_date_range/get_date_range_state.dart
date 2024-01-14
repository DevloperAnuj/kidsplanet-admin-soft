part of 'get_date_range_cubit.dart';

class GetDateRangeState {
  final DateTime fromDate;
  final DateTime toDate;

  const GetDateRangeState({
    required this.fromDate,
    required this.toDate,
  });

  factory GetDateRangeState.initial() {
    return GetDateRangeState(
      fromDate: DateTime(2023, 4),
      toDate: DateTime.now(),
    );
  }

  GetDateRangeState copyWith({
    DateTime? fromDate,
    DateTime? toDate,
  }) {
    return GetDateRangeState(
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
    );
  }
}
