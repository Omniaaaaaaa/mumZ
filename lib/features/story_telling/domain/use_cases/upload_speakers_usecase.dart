import 'package:mamyapp/features/story_telling/domain/entities/speaker_upload_entity.dart';
import 'package:mamyapp/features/story_telling/domain/repositories/speaker_repository.dart';
class UploadSpeakersUseCase {
  final SpeakerRepository repository;

  UploadSpeakersUseCase(this.repository);

  Future<SpeakerEntity> call({required List<String> filePaths}) {
    return repository.uploadSpeakers(filePaths: filePaths);
  }
}

class GetSavedSpeakerPathsUseCase {
  final SpeakerRepository repository;

  GetSavedSpeakerPathsUseCase(this.repository);

  List<String>? call() => repository.getSpeakerPaths();
}

