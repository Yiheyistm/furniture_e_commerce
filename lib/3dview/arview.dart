import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class FurnitureARview extends StatefulWidget {
  final String modelUrl;
  const FurnitureARview({super.key, required this.modelUrl});

  @override
  State<FurnitureARview> createState() => _FurnitureARviewState();
}

class _FurnitureARviewState extends State<FurnitureARview> {
  double _scale = 0.1;
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        title: const Text('AR View'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  ModelViewer(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    src: widget.modelUrl,
                    ar: true,
                    autoRotate: true,
                    disableZoom: true,
                    loading: Loading.eager,
                    scale: '$_scale $_scale $_scale',
                    arScale: ArScale.fixed,
                    onWebViewCreated: (controller) {
                      setState(() {
                        _isLoading = false;
                      });
                    },
                  ),
                  if (_isLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
            Slider(
              value: _scale,
              min: 0.01,
              max: 1.0,
              divisions: 100,
              label: _scale.toStringAsFixed(2),
              onChanged: (double value) {
                setState(() {
                  _scale = value;
                });
              },
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Adjust Model Size'),
            ),
          ],
        ),
      ),
    );
  }
}
