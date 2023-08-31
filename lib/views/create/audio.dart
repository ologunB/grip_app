import '../widgets/hex_text.dart';
import 'audio/audio_recorder_button.dart';

class AudioRecorder extends StatefulWidget {
  const AudioRecorder({super.key});

  @override
  State<AudioRecorder> createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorder> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(),
          AudioRecorderButton(maxRecordDuration: Duration(minutes: 3)),
        ],
      ),
    );
  }
}
