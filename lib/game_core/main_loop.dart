bool _running = true;

void startLoop() {
  final double _fps = 50;
  final double _second = 1000;
  final double _updateTime = _second / _fps;

  Stopwatch _loopWatch = Stopwatch();
  _loopWatch.start();

  while (_running) {
    if (_loopWatch.elapsedMilliseconds > _updateTime) {
      print("update");
      _loopWatch.reset();
    }
  }
}

void stopLoop() {
  _running = false;
}
