import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dispatching_state.dart';

class DispatchingCubit extends Cubit<DispatchingState> {
  DispatchingCubit() : super(DispatchingState.initial());

  late List<String> _rawDispatchList = [];

  void addToDispatchList(String phone) {
    if (!_rawDispatchList.contains(phone)) {
      _rawDispatchList.add(phone);
    }
    emit(state.copyWith(dispatchingList: _rawDispatchList));
  }

}
