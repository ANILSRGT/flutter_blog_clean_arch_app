import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_blog_clean_arch_app/core/common/widgets/loader/loader_widget.dart';
import 'package:http/http.dart' as http;

class NetworkMemoryImage extends StatefulWidget {
  const NetworkMemoryImage({
    required this.url,
    super.key,
  });

  final String url;

  @override
  State<NetworkMemoryImage> createState() => _NetworkMemoryImageState();
}

class _NetworkMemoryImageState extends State<NetworkMemoryImage> {
  late Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final response = await http.get(Uri.parse(widget.url));
    if (response.statusCode == 200) {
      setState(() {
        _imageBytes = response.bodyBytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoaderWidget(
      isLoading: _imageBytes == null,
      child: Image.memory(
        _imageBytes!,
        errorBuilder: (context, error, stackTrace) {
          return const Placeholder();
        },
      ),
    );
  }
}
