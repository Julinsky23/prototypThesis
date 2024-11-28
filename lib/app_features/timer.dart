import 'dart:async';



class TimerController {
  int _start = 0;
  bool isTimerRunning = false;
  Timer? _timer;

  int get start => _start;

  // Startet den Timer
  void startTimer(void Function() onUpdate) {
    if (!isTimerRunning) {
      isTimerRunning = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _start++;
        onUpdate();
      });
    }
  }

  // Stoppt den Timer
  void stopTimer() {
    if (isTimerRunning) {
      isTimerRunning = false;
      _timer?.cancel();
    }
  }

  // Setzt den Timer zurück
  void deleteTimer(void Function() onReset) {
    stopTimer();
    _start = 0;
    onReset();
  }

  // Formatierte Zeit
  String formatTime() {
    final int hours = _start ~/ 3600;
    final int minutes = (_start % 3600) ~/ 60;
    final int remainingSeconds = _start % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}