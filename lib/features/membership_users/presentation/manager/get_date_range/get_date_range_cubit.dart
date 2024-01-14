import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_date_range_state.dart';

class GetDateRangeCubit extends Cubit<GetDateRangeState> {

  GetDateRangeCubit() : super(GetDateRangeState.initial());

  toggleDate({required DateTime fromDate,required DateTime toDate}){
    emit(state.copyWith(fromDate: fromDate,toDate: toDate));
  }

}
