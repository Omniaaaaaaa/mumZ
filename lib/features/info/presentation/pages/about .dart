// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mamyapp/features/info/presentation/widget/info_section.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF0E8),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFD4C4),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFFE89B88)),
            onPressed: () {},
          ),
          title: const Text(
            'حول التطبيق',
            style: TextStyle(
              color: Color(0xFFE89B88),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),

              InfoSection(
                number: '١',
                title: 'Mum Z Baby care',
                items: [
                  '''تطبيق ذكي يساعد الأمهات في فهم أطفالهن بشكل أسهل من خلال تقنيات:''',
                  '- تحليل بكاء الطفل.',
                  '- مكتبة قصص وسجل التحليلات.',
                  '- مساعد ذكي للإجابة عن الأسئلة اليومية.',
                  '- إنشاء قصص صوتية مخصّصة بصوت الأم.',
                  '''يهدف التطبيق إلى تسهيل رحلة الأمومة وتقديم دعم سريع وآمن وموثوق.''',
                ],
              ),

              InfoSection(
                number: '٢',
                title: 'إصدار التطبيق',
                items: [
                  'الإصدار: 1.0.0',
                ],
              ),

              InfoSection(
                number: '٣',
                title: 'تواصل معنا',
                items: [
                  'Email: example@email.com',
                  'Facebook: MumZBabyCare',
                  'Instagram: @MumZBabyCare',
                ],
                isLast: true, // آخر Section بدون الخط السفلي
              ),
            ],
          ),
        ),
      ),
    );
  }
}

