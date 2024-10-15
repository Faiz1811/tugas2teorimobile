import 'dart:async';
import 'package:flutter/material.dart';

class StopwatchPage extends StatefulWidget {
  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  late Stopwatch _stopwatch;
  late Timer _timer;
  List<String> _lapTimes = [];
  bool _isStopwatchFinished = false; // Status apakah stopwatch sudah selesai

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  String _formatTime(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate() % 100;
    int seconds = (milliseconds / 1000).truncate() % 60;
    int minutes = (milliseconds / (1000 * 60)).truncate();

    String formattedMinutes = minutes.toString().padLeft(2, '0');
    String formattedSeconds = seconds.toString().padLeft(2, '0');
    String formattedHundreds = hundreds.toString().padLeft(2, '0');

    return '$formattedMinutes:$formattedSeconds:$formattedHundreds';
  }

  void _recordLapTime() {
    String formattedTime = _formatTime(_stopwatch.elapsedMilliseconds);
    setState(() {
      _lapTimes.add(formattedTime);
    });
  }

  void _finishStopwatch() {
    setState(() {
      _stopwatch.stop();
      _timer.cancel();
      _isStopwatchFinished = true; // Menandakan stopwatch sudah selesai
    });
  }

  void _resetStopwatch() {
    setState(() {
      _stopwatch.reset();
      _lapTimes.clear();
      _isStopwatchFinished = false; // Mengatur ulang status
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Stopwatch timer display in the center
              Text(
                _formatTime(_stopwatch.elapsedMilliseconds),
                style: TextStyle(fontSize: 48.0),
              ),
              SizedBox(height: 20),

              // Tombol untuk mengontrol stopwatch (Play, Pause, Lap Time)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () {
                        if (!_stopwatch.isRunning) {
                          _stopwatch.start();
                          _startTimer();
                        }
                      },
                      child: Text('Play'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_stopwatch.isRunning) {
                          _stopwatch.stop();
                          _timer.cancel();
                        }
                      },
                      child: Text('Pause'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_stopwatch.isRunning || _stopwatch.elapsedMilliseconds > 0) {
                          _recordLapTime();
                        }
                      },
                      child: Text('Lap Time'),
                    ),
                  ),
                  SizedBox(width: 10),
                  if (!_isStopwatchFinished) // Tombol "Selesai" hanya muncul jika stopwatch belum selesai
                    Flexible(
                      child: ElevatedButton(
                        onPressed: _finishStopwatch,
                        child: Text('End'),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 20),

              // Expanded widget for the lap times list (scrollable if needed)
              Expanded(
                child: _lapTimes.isEmpty
                    ? Center(child: Text('No laps yet'))
                    : ListView.builder(
                        itemCount: _lapTimes.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text('Lap ${index + 1}'),
                            trailing: Text(_lapTimes[index]),
                          );
                        },
                      ),
              ),
              SizedBox(height: 20),

              // Tombol Reset, hanya muncul saat stopwatch sudah selesai
              if (_isStopwatchFinished)
                ElevatedButton(
                  onPressed: _resetStopwatch,
                  child: Text('Reset'),
                ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFE6F7FF),
    );
  }
}
