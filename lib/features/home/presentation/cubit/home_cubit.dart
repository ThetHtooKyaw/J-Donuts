import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_home_data_usecase.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHomeDataUsecase _getHomeDataUseCase;

  HomeCubit(this._getHomeDataUseCase) : super(const HomeState());

  Future<void> loadHomeData() async {
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final result = await _getHomeDataUseCase();
      emit(state.copyWith(isLoading: false, data: result));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to load home data. Showing offline cache.',
          isOffline: true,
        ),
      );
    }
  }
}
