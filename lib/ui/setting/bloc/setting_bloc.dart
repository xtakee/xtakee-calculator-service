import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:stake_calculator/domain/istake_repository.dart';

import '../../../domain/model/stake.dart';

part 'setting_event.dart';

part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final _repository = GetIt.instance<IStakeRepository>();

  void getStake() => add(GetStake());

  bool isSettingToured() => _repository.getSettingTour();

  void setSettingToured() => _repository.setSettingTour(status: true);

  void updateStake(
          {required double profit,
          required double tolerance,
          required bool decay,
          required String mode,
          required bool clearLosses,
          required bool isMultiple,
          required bool keepTag,
          required bool approxAmount,
          required double statingStake,
          required int restrictRounds,
          required bool forfeit}) =>
      add(UpdateStake(
          profit: profit,
          approxAmount: approxAmount,
          tolerance: tolerance,
          mode: mode,
          clearLosses: clearLosses,
          isMultiple: isMultiple,
          staringStake: statingStake,
          decay: decay,
          keepTag: keepTag,
          forfeit: forfeit,
          restrictRounds: restrictRounds));

  SettingBloc() : super(SettingInitial()) {
    on<GetStake>((event, emit) async {
      final stake = await _repository.getStake(cached: true);
      final bool clearLosses = await _repository.getClearLoss();
      final bool keepTag = await _repository.getKeepTag();
      emit(OnDataLoaded(
          stake: stake, clearLosses: clearLosses, keepTag: keepTag));
    });

    on<UpdateStake>((event, emit) async {
      if (event.profit < 0.01) {
        emit(OnError(message: "Invalid profit provided"));
        return;
      } else if (event.tolerance < 1) {
        emit(OnError(message: "Invalid tolerance provided"));
        return;
      } else if (event.restrictRounds < 0) {
        emit(OnError(message: "Invalid rounds provided"));
        return;
      } else if (event.staringStake < 0) {
        emit(OnError(message: "Invalid starting stake provided"));
        return;
      }

      emit(OnLoading());
      try {
        await _repository.updateState(
            decay: event.decay,
            mode: event.mode.toLowerCase(),
            isMultiple: event.isMultiple,
            tolerance: event.tolerance,
            approxAmount: event.approxAmount,
            profit: event.profit,
            keepTag: event.keepTag,
            startingStake: event.staringStake,
            forfeit: event.forfeit,
            restrictRounds: event.restrictRounds,
            clearLosses: event.clearLosses);

        emit(OnSuccess());
      } catch (error) {
        emit(OnError(message: error.toString()));
      }
    });
  }
}
