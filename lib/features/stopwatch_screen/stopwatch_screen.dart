import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timer_task2/core/widgets/my_circular_progress_indicator.dart';

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({super.key});

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  late Duration _elapsedTime;
  late String _elapsedTimeString;
  late Timer timer;

  @override
  void initState() {
    super.initState();

    _elapsedTime = Duration.zero;
    _elapsedTimeString = _formatElapsedTime(_elapsedTime);

    // Create a timer that runs a callback every 100 milliseconds to update UI
    timer = Timer.periodic(const Duration(milliseconds: 100), (Timer timer) {
      setState(() {
        // Update elapsed time only if the stopwatch is running
        if (_stopwatch.isRunning) {
          _updateElapsedTime();
        }
      });
    });
  }

  // Start/Stop button callback
  void _startStopwatch() {
    if (!_stopwatch.isRunning) {
      // Start the stopwatch and update elapsed time
      _stopwatch.start();
      _updateElapsedTime();
    } else {
      // Stop the stopwatch
      _stopwatch.stop();
    }
  }

  // Reset button callback
  void _resetStopwatch() {
    // Reset the stopwatch to zero and update elapsed time
    _stopwatch.reset();
    _updateElapsedTime();
  }

  // Update elapsed time and formatted time string
  void _updateElapsedTime() {
    setState(() {
      _elapsedTime = _stopwatch.elapsed;
      _elapsedTimeString = _formatElapsedTime(_elapsedTime);
    });
  }

  // Format a Duration into a string (MM:SS.SS)
  String _formatElapsedTime(Duration time) {
    return '${time.inHours.remainder(60).toString().padLeft(2, '0')}:${time.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(time.inSeconds.remainder(60)).toString().padLeft(2, '0')}';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(Icons.arrow_back_ios),
                  ),
                  Text(
                    "Stopwatch",
                    style: TextStyle(
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
              // ticker
              Stack(
                children: [
                  Positioned(
                    top: 115,
                    left: 85,
                    child: Text(
                      _elapsedTimeString,
                      style: const TextStyle(
                        fontSize: 28,
                      ),
                    ),
                  ),
                  MyCircularProgressIndicator(
                    percent: double.parse(
                        (_elapsedTime.inSeconds.remainder(60) * 0.0168)
                            .toString()
                            .padLeft(2, '0')),
                    progressColor: Colors.lightBlue,
                    radius: 140,
                  )
                ],
              ),
              // play and pause and reset button
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(
                      width: 100,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(24),
                        ),
                        onPressed: () {
                          _startStopwatch();
                          // setState(() {});
                        },
                        child: _stopwatch.isRunning
                            ? const Icon(
                                Icons.pause,
                                size: 55,
                              )
                            : const Icon(
                                Icons.play_arrow_rounded,
                                size: 55,
                              )),
                    Column(
                      children: [
                        const SizedBox(height: 25),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(24),
                          ),
                          onPressed: _resetStopwatch,
                          child: const Icon(
                            Icons.rotate_left,
                            size: 30,
                          ),
                        ),
                        const Text("Reset")
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
