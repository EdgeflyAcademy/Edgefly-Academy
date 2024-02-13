import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:better_player/better_player.dart';

class VedioScreen extends StatefulWidget {
  final String name;
  final String mediaUrl;

  const VedioScreen({required this.name, required this.mediaUrl});

  @override
  State<VedioScreen> createState() => _VedioScreenState();
}

class _VedioScreenState extends State<VedioScreen> {
  late BetterPlayerController _betterPlayerController;
  GlobalKey _betterPlayerKey = GlobalKey();

  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(aspectRatio: 16 / 9, fit: BoxFit.contain);
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network, widget.mediaUrl);
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);
    _betterPlayerController.setBetterPlayerGlobalKey(_betterPlayerKey);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 8.0),
          Expanded(
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: BetterPlayer(
                  key: _betterPlayerKey, controller: _betterPlayerController),
            ),
          ),
        ],
      ),
    );
  }
}
