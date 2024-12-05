import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:invia_case_study/core/di/di.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';
import 'package:invia_case_study/features/hotels/domain/repositories/hotels_repository.dart';

part 'app_scaffold_state.dart';

@lazySingleton
class AppScaffoldCubit extends Cubit<AppScaffoldState> {
  AppScaffoldCubit() : super(AppScaffoldInitial());

  final HotelsRepository hotelsRepository = DI.getIt<HotelsRepository>();

  Future<void> addFavorite(Hotel hotel) async {
    emit(AppScaffoldLoading());
    try {
      await hotelsRepository.addFavoriteHotel(hotel: hotel);
      emit(AppScaffoldAdded(hotel));
    } catch (e) {
      emit(AppScaffoldError('Error adding favorite: $e'));
    }
  }

  void resetError() {
    // Resetting the error state back to the initial state
    emit(AppScaffoldInitial());
  }
}
