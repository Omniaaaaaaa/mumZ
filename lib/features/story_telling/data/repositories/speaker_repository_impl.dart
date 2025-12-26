import 'package:mamyapp/core/storage/speaker_local_storage.dart';
import 'package:mamyapp/features/story_telling/data/datasources/speaker_remote_datasource.dart';
import 'package:mamyapp/features/story_telling/domain/entities/speaker_upload_entity.dart';
import 'package:mamyapp/features/story_telling/domain/repositories/speaker_repository.dart';
class SpeakerRepositoryImpl implements SpeakerRepository {
  final SpeakerRemoteDatasource remote;
  final SpeakerLocalStorage local;

  SpeakerRepositoryImpl(this.remote, this.local);

  @override
  Future<SpeakerEntity> uploadSpeakers({required List<String> filePaths}) async {
    final model = await remote.upload(filePaths: filePaths);
    await local.saveSpeakerPaths(model.paths);
    return model.toEntity();
  }

  @override
  Future<void> saveSpeakerPaths(List<String> paths) async {
    await local.saveSpeakerPaths(paths);
  }

  @override
  List<String>? getSpeakerPaths() => local.getSpeakerPaths();
}
