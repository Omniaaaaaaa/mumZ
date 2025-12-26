import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import 'package:mamyapp/features/story_telling/presentation/bloc/audio/audio_bloc.dart';
import 'package:mamyapp/features/story_telling/presentation/bloc/audio/audio_event.dart';
import 'package:mamyapp/features/story_telling/presentation/bloc/audio/audio_state.dart';
import 'package:mamyapp/features/story_telling/presentation/widget/audio_player_card.dart';
import 'package:mamyapp/features/story_telling/presentation/widget/default_button_story.dart';

class VirtualVoicePreviewScreen extends StatefulWidget {
  const VirtualVoicePreviewScreen({super.key});

  @override
  State<VirtualVoicePreviewScreen> createState() =>
      _VirtualVoicePreviewScreenState();
}

class _VirtualVoicePreviewScreenState
    extends State<VirtualVoicePreviewScreen> {
  final AudioPlayer _player = AudioPlayer();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();

    context.read<AudioBloc>().add(
          SynthesizeStoryEvent(
            text: "مرحبًا، هذا نموذج صوت افتراضي لسرد القصص",
          ),
        );
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFD4BA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'اختاري صوت افتراضي',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),

            SizedBox(
              width: 320,
              child: Text(
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                "استخدمي صوتًا جاهزًا لسرد القصص بصوت دافئ ومريح، يمكنك الاستماع إلى نموذج قبل المتابعة.",
                style: const TextStyle(
                  color: Color(0xff4A4A4A),
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            const SizedBox(height: 70),

            Image.asset('assets/images/headphone.png'),

            const SizedBox(height: 40),

          BlocBuilder<AudioBloc, AudioState>(
  builder: (context, state) {
    if (state is AudioLoading) {
      return const CircularProgressIndicator();
    }

    if (state is AudioSuccess) {
      // هنا صح: state.audio.audioUrl
      return Column(
        children: [
          AudioPlayerCard(audioUrl: state.audio.audioUrl),


          SizedBox(
            width: 260,
            height: 72,
            child: DefaultButtonStory(text: 'استخدام الصوت', onClick: (){
            
            }),
          )
        ],
      );
    }

    if (state is AudioError) {
      return const Text(
        "حدث خطأ أثناء تحميل الصوت",
        style: TextStyle(color: Colors.red),
      );
    }

    return const SizedBox();
  },
),
          ],
        ),
      ),
    );
  }

  }

