import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamyapp/features/story_telling/domain/use_cases/upload_speakers_usecase.dart';
import 'speaker_event.dart';
import 'speaker_state.dart';

class SpeakerBloc extends Bloc<SpeakerEvent, SpeakerState> {
  final UploadSpeakersUseCase uploadUseCase;
  final GetSavedSpeakerPathsUseCase getSavedPathsUseCase;

  SpeakerBloc({
    required this.uploadUseCase,
    required this.getSavedPathsUseCase,
  }) : super(SpeakerInitial()) {
    on<UploadSpeakersEvent>(_onUpload);
    on<LoadSavedSpeakerPathsEvent>(_onLoadSaved);

    // Load saved paths on Bloc creation
    final savedPaths = getSavedPathsUseCase();
    if (savedPaths != null && savedPaths.isNotEmpty) {
      add(LoadSavedSpeakerPathsEvent(savedPaths));
    }
  }

  Future<void> _onUpload(
    UploadSpeakersEvent event,
    Emitter<SpeakerState> emit,
  ) async {
    emit(SpeakerUploading());

    try {
      final result = await uploadUseCase(filePaths: event.filePaths);
      emit(SpeakerUploadSuccess(result.paths));
    } catch (e) {
      emit(SpeakerUploadError(e.toString()));
    }
  }

  void _onLoadSaved(
    LoadSavedSpeakerPathsEvent event,
    Emitter<SpeakerState> emit,
  ) {
    emit(SpeakerUploadSuccess(event.paths));
  }
}