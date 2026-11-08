import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';

class OfflineAIScreen extends StatefulWidget {
  const OfflineAIScreen({super.key});

  @override
  State<OfflineAIScreen> createState() => _OfflineAIScreenState();
}

class _OfflineAIScreenState extends State<OfflineAIScreen> {
  final TextEditingController _controller = TextEditingController();
  final SpeechToText _speechToText = SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();

  bool _isListening = false;
  bool _speechAvailable = false;

  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Hello! I am Nexora AI. Tap the Mic button below and speak. Ask about Fever, Cold, Headache, Diabetes.',
      'isUser': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    _speechAvailable = await _speechToText.initialize();
    if (mounted) setState(() {});
  }

  String _getOfflineAnswer(String question) {
    final q = question.toLowerCase();

    if (q.contains('fever')) {
      return 'For Fever: Take rest, drink plenty of water. Take Paracetamol if fever is high. If fever continues for more than 3 days, please consult a doctor.';
    }
    if (q.contains('cold')) {
      return 'For Cold: Drink warm water, take steam inhalation. Take rest. Avoid cold drinks.';
    }
    if (q.contains('headache')) {
      return 'For Headache: Take rest in a quiet dark room, drink water. Avoid stress and mobile screen.';
    }
    if (q.contains('diabetes') || q.contains('sugar')) {
      return 'For Diabetes: Avoid sugar, walk daily for 30 minutes, eat less rice, eat more vegetables. Check sugar regularly.';
    }
    if (q.contains('hello') || q.contains('hi') || q.contains('hey')) {
      return 'Hello! How can I help you? Ask about Fever, Cold, Headache, Diabetes.';
    }
    return 'I understand. Please ask about Fever, Cold, Headache, Diabetes. For serious problems, please consult a doctor.';
  }

  void _sendMessage({String? spokenText}) async {
    final text = spokenText ?? _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'text': text, 'isUser': true});
    });
    _controller.clear();

    final answer = _getOfflineAnswer(text);

    setState(() {
      _messages.add({'text': answer, 'isUser': false});
    });

    await _flutterTts.speak(answer);
  }

  Future<void> _toggleListening() async {
    if (!_speechAvailable) {
      await _initSpeech();
      if (!_speechAvailable) return;
    }

    if (_isListening) {
      await _speechToText.stop();
      setState(() => _isListening = false);
    } else {
      setState(() => _isListening = true);
      await _speechToText.listen(
        onResult: (result) {
          if (result.finalResult) {
            _sendMessage(spokenText: result.recognizedWords);
            setState(() => _isListening = false);
          }
        },
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _speechToText.stop();
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F5C4D),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Offline AI - Nexora',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg['isUser'] as bool;
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: isUser ? const Color(0xFF0F5C4D) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            msg['text'],
                            style: TextStyle(
                              color: isUser ? Colors.white : Colors.black87,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        if (!isUser)
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: const Icon(Icons.volume_up, color: Color(0xFF0F5C4D)),
                            onPressed: () => _flutterTts.speak(msg['text']),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: _isListening ? Colors.green : const Color(0xFFD32F2F),
                  child: IconButton(
                    icon: Icon(
                      _isListening ? Icons.mic : Icons.mic_none,
                      color: Colors.white,
                    ),
                    onPressed: _toggleListening,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Tap to Speak',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Ask about Fever, Cold...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 26,
                  backgroundColor: const Color(0xFF0F5C4D),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () => _sendMessage(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}