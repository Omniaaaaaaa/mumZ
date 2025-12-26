abstract class AudioEvent {}
class SynthesizeStoryEvent extends AudioEvent {
  final String text;
  final List<String>? speakerPaths;
  SynthesizeStoryEvent({required this.text, this.speakerPaths});
}
