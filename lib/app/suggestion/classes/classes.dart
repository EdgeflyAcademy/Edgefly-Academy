import 'package:edgefly_academy/app/suggestion/classes/vedio_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClassesPage extends StatelessWidget {
  const ClassesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Classses'),
        centerTitle: true,
      ),
      body: ListView(
        children: vediolist
            .map((e) => GestureDetector(
                  onTap: () {
                    Get.to(VedioScreen(
                        name: e['name']!, mediaUrl: e['media_url']!));
                  },
                  child: Image.network(e['thumb_url']!),
                ))
            .toList(),
      ),
    );
  }
}

var vediolist = [
  {
    'name': 'Math Class',
    'media_url':
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'thumb_url':
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg'
  },
  {
    'name': 'English Class',
    'media_url':
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    'thumb_url':
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg'
  },
  {
    'name': 'Bangla Class',
    'media_url':
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    'thumb_url':
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg'
  },
  {
    'name': 'Physic Class',
    'media_url':
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
    'thumb_url':
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerEscapes.jpg'
  },
  {
    'name': 'Chamistry Class',
    'media_url':
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
    'thumb_url':
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerFun.jpg'
  }
];
