// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Asked extends StatelessWidget {
  Asked({super.key});

  final TextEditingController messageController = TextEditingController();

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
            'الأسئلة الشائعة',
            style: TextStyle(
              color: Color(0xFFE89B88),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_right_alt_outlined, color: Color(0xFFE89B88)),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),

              _buildSection(
                number: '١',
                title: 'هل تحليل بكاء الطفل دقيق؟',
                items: [
                  '''نعم، يعتمد التحليل على نموذج ذكاء اصطناعي مدرّب، لكنه ليس بديلاً عن استشارة الطبيب عند الضرورة''',
                ],
              ),

              _buildSection(
                number: '٢',
                title: 'كم عدد المقاطع المطلوبة لنسخ الصوت؟',
                items: [
                  'يجب تسجيل 20 مقطع صوتي.',
                  '(الحد الأدنى للحصول على أفضل دقة).',
                ],
              ),

              _buildSection(
                number: '٣',
                title: 'كيف يتم إنشاء القصص؟',
                items: [
                  '''يعتمد التطبيق على الذكاء الاصطناعي لتوليد قصة قصيرة بصوتك أو بالصوت الافتراضي حسب اختيارك''',
                ],
              ),

              _buildSection(
                number: '٤',
                title: 'ماذا أفعل إذا واجهت مشكلة؟',
                items: [
                  'يمكنك التواصل معنا عبر:',
                  '• البريد الإلكتروني',
                  '• إرسال رسالة داخل التطبيق',
                ],
                isLast: true,
              ),

              const SizedBox(height: 30),

              TextField(
                controller: messageController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.chat, color: Color(0xFFE89B88)),
                  hintText: 'اكتب رسالتك هنا...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                maxLines: 4,
              ),

              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    String msg = messageController.text;
                    if (msg.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تم إرسال الرسالة بنجاح!')),
                      );
                      messageController.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFB4A0),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "تم الإرسال",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'سعداء بالإجابة عن أسئلتك دائماً️',
                  style: TextStyle(
                    color: Color(0xFFE89B88),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
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
              const Text(
                '• ',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.6,
                ),
              ),
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
