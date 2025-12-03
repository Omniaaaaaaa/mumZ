import 'package:flutter/material.dart';

class About extends StatelessWidget {
  About({super.key});

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

              _buildSection(
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

              _buildSection(
                number: '٢',
                title: 'إصدار التطبيق',
                items: [
                  'الإصدار: 1.0.0',
                ],
              ),

              _buildSection(
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

Widget _buildSection({
  required String number,
  required String title,
  required List<String> items,
  bool isLast = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '$number. $title',
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 12),
      ...items.map(
            (item) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.arrow_right, size: 18, color: Color(0xFFE89B88)), // أيقونة بدل bullet
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  item,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      if (!isLast) ...[
        const SizedBox(height: 20),
        Container(
          height: 1,
          width: double.infinity,
          color: Colors.grey,
        ),
        const SizedBox(height: 25),
      ],
    ],
  );
}
