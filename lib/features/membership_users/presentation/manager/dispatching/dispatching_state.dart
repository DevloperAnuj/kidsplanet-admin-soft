part of 'dispatching_cubit.dart';

class DispatchingState {
  final List<String> dispatchingList;

  const DispatchingState({
    required this.dispatchingList,
  });

  factory DispatchingState.initial() {
    return DispatchingState(dispatchingList: []);
  }

  DispatchingState copyWith({
    List<String>? dispatchingList,
  }) {
    return DispatchingState(
      dispatchingList: dispatchingList ?? this.dispatchingList,
    );
  }
}
