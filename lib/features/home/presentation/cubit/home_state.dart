import '../../domain/usecases/get_home_data_usecase.dart';

class HomeState {
  final bool isLoading;
  final HomeDataResult? data;
  final String? errorMessage;
  final bool isOffline;

  const HomeState({
    this.isLoading = false,
    this.data,
    this.errorMessage,
    this.isOffline = false,
  });

  HomeState copyWith({
    bool? isLoading,
    HomeDataResult? data,
    String? errorMessage,
    bool? isOffline,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      errorMessage: errorMessage,
      isOffline: isOffline ?? this.isOffline,
    );
  }
}
