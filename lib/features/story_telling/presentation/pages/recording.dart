// ignore_for_file: deprecated_member_use, use_build_context_synchronously
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class VoiceRecordingPage extends StatefulWidget {
  const VoiceRecordingPage({super.key});

  @override
  State<VoiceRecordingPage> createState() => _VoiceRecordingPageState();
}

class _VoiceRecordingPageState extends State<VoiceRecordingPage> {
  final AudioRecorder _audioRecorder = AudioRecorder();
  bool _isRecording = false;
  int _currentSentence = 0;
  final int _totalSentences = 20;
  final List<String> _recordedFiles = [];

  final List<String> _sentences = [
    "مرحباً، كيف حالك اليوم؟",
    "الطقس جميل في هذا الوقت من السنة",
    "أحب قراءة الكتب في أوقات فراغي",
    "السفر يوسع المدارك ويثري التجربة",
    "التعليم هو مفتاح النجاح في الحياة",
    "الرياضة مهمة للحفاظ على الصحة",
    "الأسرة هي الأساس في المجتمع",
    "العمل الجاد يؤدي إلى النجاح",
    "الصداقة كنز لا يقدر بثمن",
    "الصبر مفتاح الفرج",
    "العلم نور والجهل ظلام",
    "الوقت كالسيف إن لم تقطعه قطعك",
    "من جد وجد ومن زرع حصد",
    "الأمل هو ما يبقينا أقوياء",
    "التفاؤل يجعل الحياة أجمل",
    "الإبداع يبدأ من التفكير خارج الصندوق",
    "المثابرة طريق النجاح",
    "الاحترام أساس العلاقات الناجحة",
    "التواضع من أجمل الصفات",
    "الحياة رحلة جميلة مليئة بالمفاجآت",
  ];

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  Future<void> _requestPermission() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('يرجى السماح بالوصول إلى الميكروفون')),
        );
      }
    }
  }

  Future<void> _startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        final directory = await getApplicationDocumentsDirectory();
        final path =
            '${directory.path}/recording_${DateTime.now().millisecondsSinceEpoch}.m4a';

        await _audioRecorder.start(
          const RecordConfig(encoder: AudioEncoder.aacLc),
          path: path,
        );

        setState(() {
          _isRecording = true;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('بدأ التسجيل... 🎤'),
              duration: Duration(seconds: 1),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('يرجى السماح بالوصول إلى الميكروفون'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error starting recording: $e');
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ في بدء التسجيل: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _stopRecording() async {
    try {
      final path = await _audioRecorder.stop();
      setState(() {
        _isRecording = false;
        if (path != null && _currentSentence < _totalSentences) {
          _recordedFiles.add(path);
          _currentSentence++;
        }
      });

      if (mounted && path != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'تم حفظ التسجيل ✅ ($_currentSentence/$_totalSentences)',
            ),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );

        // لما يخلص الـ 20 جملة، يروح للصفحة التانية
        if (_currentSentence == _totalSentences) {
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const VoiceProcessingPage(),
              ),
            );
          });
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error stopping recording: $e');
      }
      setState(() {
        _isRecording = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ في إيقاف التسجيل: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      await _stopRecording();
    } else {
      if (_currentSentence < _totalSentences) {
        await _startRecording();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('لقد انتهيت من تسجيل جميع الجمل')),
        );
      }
    }
  }

  @override
  void dispose() {
    _audioRecorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFD4BA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'برنامج تدريب الصوت',
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Title
                const Text(
                  'اقرأي الجمل التالية بصوت واضح.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D4037),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'سيتم حفظ كل جملة في مقطع صوت منفصل',
                  style: TextStyle(fontSize: 13, color: Color(0xFF8B7265)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),

                // Sentence display box
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'الجملة ${_currentSentence == 0 ? 'الأولى' : (_currentSentence + 1).toString()}',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF8B7265),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Divider(color: Color(0xFFE0E0E0), thickness: 1),
                      const SizedBox(height: 12),
                      Text(
                        _currentSentence < _totalSentences
                            ? _sentences[_currentSentence]
                            : 'تم الانتهاء من جميع الجمل',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          height: 1.6,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),

                // Counter text
                Text(
                  _currentSentence == 0
                      ? 'لم يتم رفع أي مقطع بعد'
                      : 'تم رفع $_currentSentence مقطع',
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
                const SizedBox(height: 30),

                // Recording button label
                const Text(
                  'ابدأ في التسجيل',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5D4037),
                  ),
                ),
                const SizedBox(height: 25),

                // Microphone button
                GestureDetector(
                  onTap: _toggleRecording,
                  child: Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          _isRecording
                              ? Colors.red.withOpacity(0.8)
                              : const Color(0xFFFFB399),
                      boxShadow: [
                        BoxShadow(
                          color: (_isRecording
                                  ? Colors.red
                                  : const Color(0xFFFFB399))
                              .withOpacity(0.4),
                          spreadRadius: 3,
                          blurRadius: 15,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      _isRecording ? Icons.stop_rounded : Icons.mic_rounded,
                      size: 55,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 35),

                // Progress indicator
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$_currentSentence',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFB399),
                            ),
                          ),
                          const Text(
                            ' / ',
                            style: TextStyle(
                              fontSize: 22,
                              color: Color(0xFF8B7265),
                            ),
                          ),
                          Text(
                            '$_totalSentences',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF8B7265),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: _currentSentence / _totalSentences,
                          backgroundColor: const Color(0xFFFFE4D6),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFFFFB399),
                          ),
                          minHeight: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 35),

                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_currentSentence < _totalSentences) {
                              setState(() {
                                _currentSentence++;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFB399),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 2,
                          ),
                          child: const Text(
                            'المقطع التالي',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: ElevatedButton(
                          onPressed: _toggleRecording,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFD4BA),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 2,
                          ),
                          child: Text(
                            _isRecording ? 'إيقاف التسجيل' : 'إعادة التسجيل',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// الصفحة الثانية - معالجة الصوت
class VoiceProcessingPage extends StatefulWidget {
  const VoiceProcessingPage({super.key});

  @override
  State<VoiceProcessingPage> createState() => _VoiceProcessingPageState();
}

class _VoiceProcessingPageState extends State<VoiceProcessingPage> {
  @override
  void initState() {
    super.initState();
    // بعد 5 ثواني يروح للصفحة الثالثة
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const VoiceResultPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFD4BA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'انشاء النسخة',
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
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Sound wave animation
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFFFB399), width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.asset(
                  'assets/sound_wave.png',
                  height: 100,
                  errorBuilder: (context, error, stackTrace) {
                    return SizedBox(
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(20, (index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            width: 3,
                            height: 40 + (index % 5) * 10.0,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFB399),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          );
                        }),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'يتم إنشاء النسخة بالصوت الشخصي',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF5D4037),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              // Loading circle
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFFFB399), width: 3),
                ),
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFFFFB399),
                    ),
                    strokeWidth: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// الصفحة الثالثة - النتيجة النهائية
class VoiceResultPage extends StatelessWidget {
  const VoiceResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFD4BA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'اكتملت النسخة',
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Title
                const Text(
                  'العنوان: اليوم الذي لن أنساه',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D4037),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // Description
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        spreadRadius: 1,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: const Text(
                    'كان يوماً مشرقاً عندما بدأت رحلتي نحو النجاح. لقد تعلمت أن الإصرار والعمل الجاد هما مفتاح تحقيق الأحلام. كل خطوة صغيرة تأخذنا نحو هدفنا الكبير، وكل تحدٍ نواجهه يجعلنا أقوى وأكثر حكمة.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF5D4037),
                      height: 1.8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
                // Sound wave
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(30, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        width: 3,
                        height: 30 + (index % 7) * 8.0,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFB399),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'تم إنشاء النسخة بالصوت الخاص بك',
                  style: TextStyle(fontSize: 13, color: Color(0xFF8B7265)),
                ),
                const SizedBox(height: 30),
                // Play controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Previous button
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFD4BA),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.skip_previous_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 20),
                    // Play button
                    Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFFB399),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 20),
                    // Next button
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFD4BA),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.skip_next_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  'مدة المقطع: 45 ثانية',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5D4037),
                  ),
                ),
                const SizedBox(height: 40),
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFB399),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'تقييم الصوت',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFD4BA),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'اعادة تجربة نسخة',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: unused_element
class _VoiceRecPageState extends State<VoiceRecordingPage> {
  final AudioRecorder _audioRecorder = AudioRecorder();
  bool _isRecording = false;
  int _currentSentence = 0;
  final int _totalSentences = 20;
  final List<String> _recordedFiles = [];

  final List<String> _sentences = [
    "مرحباً، كيف حالك اليوم؟",
    "الطقس جميل في هذا الوقت من السنة",
    "أحب قراءة الكتب في أوقات فراغي",
    "السفر يوسع المدارك ويثري التجربة",
    "التعليم هو مفتاح النجاح في الحياة",
    "الرياضة مهمة للحفاظ على الصحة",
    "الأسرة هي الأساس في المجتمع",
    "العمل الجاد يؤدي إلى النجاح",
    "الصداقة كنز لا يقدر بثمن",
    "الصبر مفتاح الفرج",
    "العلم نور والجهل ظلام",
    "الوقت كالسيف إن لم تقطعه قطعك",
    "من جد وجد ومن زرع حصد",
    "الأمل هو ما يبقينا أقوياء",
    "التفاؤل يجعل الحياة أجمل",
    "الإبداع يبدأ من التفكير خارج الصندوق",
    "المثابرة طريق النجاح",
    "الاحترام أساس العلاقات الناجحة",
    "التواضع من أجمل الصفات",
    "الحياة رحلة جميلة مليئة بالمفاجآت",
  ];

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  Future<void> _requestPermission() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('يرجى السماح بالوصول إلى الميكروفون')),
        );
      }
    }
  }

  Future<void> _startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        final directory = await getApplicationDocumentsDirectory();
        final path =
            '${directory.path}/recording_${DateTime.now().millisecondsSinceEpoch}.m4a';

        await _audioRecorder.start(
          const RecordConfig(encoder: AudioEncoder.aacLc),
          path: path,
        );

        setState(() {
          _isRecording = true;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('بدأ التسجيل... 🎤'),
              duration: Duration(seconds: 1),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('يرجى السماح بالوصول إلى الميكروفون'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error starting recording: $e');
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ في بدء التسجيل: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _stopRecording() async {
    try {
      final path = await _audioRecorder.stop();
      setState(() {
        _isRecording = false;
        if (path != null && _currentSentence < _totalSentences) {
          _recordedFiles.add(path);
          _currentSentence++;
        }
      });

      if (mounted && path != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'تم حفظ التسجيل ✅ ($_currentSentence/$_totalSentences)',
            ),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error stopping recording: $e');
      }
      setState(() {
        _isRecording = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ في إيقاف التسجيل: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      await _stopRecording();
    } else {
      if (_currentSentence < _totalSentences) {
        await _startRecording();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('لقد انتهيت من تسجيل جميع الجمل')),
        );
      }
    }
  }

  @override
  void dispose() {
    _audioRecorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFD4BA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'برنامج تدريب الصوت',
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Title
                const Text(
                  'اقرأي الجمل التالية بصوت واضح.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D4037),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'سيتم حفظ كل جملة في مقطع صوت منفصل',
                  style: TextStyle(fontSize: 13, color: Color(0xFF8B7265)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),

                // Sentence display box
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'الجملة ${_currentSentence == 0 ? 'الأولى' : (_currentSentence + 1).toString()}',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF8B7265),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Divider(color: Color(0xFFE0E0E0), thickness: 1),
                      const SizedBox(height: 12),
                      Text(
                        _currentSentence < _totalSentences
                            ? _sentences[_currentSentence]
                            : 'تم الانتهاء من جميع الجمل',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          height: 1.6,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),

                // Counter text
                Text(
                  _currentSentence == 0
                      ? 'لم يتم رفع أي مقطع بعد'
                      : 'تم رفع $_currentSentence مقطع',
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
                const SizedBox(height: 30),

                // Recording button label
                const Text(
                  'ابدأ في التسجيل',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5D4037),
                  ),
                ),
                const SizedBox(height: 25),

                // Microphone button - الزرار البرتقالي للتسجيل 🎤
                GestureDetector(
                  onTap: _toggleRecording,
                  child: Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          _isRecording
                              ? Colors.red.withOpacity(0.8)
                              : const Color(0xFFFFB399),
                      boxShadow: [
                        BoxShadow(
                          color: (_isRecording
                                  ? Colors.red
                                  : const Color(0xFFFFB399))
                              .withOpacity(0.4),
                          spreadRadius: 3,
                          blurRadius: 15,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      _isRecording ? Icons.stop_rounded : Icons.mic_rounded,
                      size: 55,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 35),

                // Progress indicator
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$_currentSentence',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFB399),
                            ),
                          ),
                          const Text(
                            ' / ',
                            style: TextStyle(
                              fontSize: 22,
                              color: Color(0xFF8B7265),
                            ),
                          ),
                          Text(
                            '$_totalSentences',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF8B7265),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: _currentSentence / _totalSentences,
                          backgroundColor: const Color(0xFFFFE4D6),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFFFFB399),
                          ),
                          minHeight: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 35),

                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // زر المقطع التالي
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_currentSentence < _totalSentences) {
                              setState(() {
                                _currentSentence++;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFB399),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 2,
                          ),
                          child: const Text(
                            'المقطع التالي',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // زر إعادة التسجيل
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: ElevatedButton(
                          onPressed: _toggleRecording,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFD4BA),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 2,
                          ),
                          child: Text(
                            _isRecording ? 'إيقاف التسجيل' : 'إعادة التسجيل',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
