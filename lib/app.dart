import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamyapp/features/story_telling/presentation/bloc/audio/audio_bloc.dart';
import 'package:mamyapp/features/story_telling/presentation/pages/choose_story.dart';
import 'package:mamyapp/core/di/injection_container.dart' as di;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AudioBloc>(
          create: (_) => di.sl<AudioBloc>(),
        ),

        // 👇 بعدين تزودي أي Bloc تاني هنا
        // BlocProvider<StoryBloc>(
        //   create: (_) => di.sl<StoryBloc>(),
        // ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BabyCare',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color(0xFFFDFBF7),
        ),
        home: ChooseStory(),
      ),
    );
  }
}
