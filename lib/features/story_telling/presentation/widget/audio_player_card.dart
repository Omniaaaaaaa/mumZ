import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerCard extends StatefulWidget {
  final String audioUrl;

  const AudioPlayerCard({super.key, required this.audioUrl});

  @override
  State<AudioPlayerCard> createState() => _AudioPlayerCardState();
}

class _AudioPlayerCardState extends State<AudioPlayerCard> {
  final AudioPlayer _player = AudioPlayer();
  bool isPlaying = false;

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE7D8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text(
            "استمعي إلى النموذج",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          IconButton(
            iconSize: 55,
            icon: Icon(
              isPlaying ? Icons.pause_circle : Icons.play_circle,
              color: Colors.orange,
            ),
            onPressed: () async {
              if (!isPlaying) {
                await _player.setUrl(widget.audioUrl);
                _player.play();
              } else {
                await _player.pause();
              }

              setState(() {
                isPlaying = !isPlaying;
              });
            },
          ),
        ],
      ),
    );
  }
}
