import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:video_player/video_player.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  static const _videos = [
    (
      asset: 'assets/videos/video_1.mp4',
      user: '@italia',
      description: 'Lugares y tradiciones de Italia.',
      likes: '12.8 mil',
      comments: '420',
    ),
    (
      asset: 'assets/videos/video_2.mp4',
      user: '@software',
      description: 'El plano del software explicado.',
      likes: '8.9 mil',
      comments: '236',
    ),
    (
      asset: 'assets/videos/video_3.mp4',
      user: '@alejandro.y',
      description: 'Clase educativa de CAN y CAN´T.',
      likes: '24.3 mil',
      comments: '1.120',
    ),
    (
      asset: 'assets/videos/video_4.mp4',
      user: '@ingles',
      description: 'Domina el pasado simple en ingles.',
      likes: '31.7 mil',
      comments: '884',
    ),
  ];

  final PageController _pageController = PageController();
  final List<VideoPlayerController> _controllers = [];
  bool _initializing = true;

  @override
  void initState() {
    super.initState();
    _initializeVideos();
  }

  Future<void> _initializeVideos() async {
    for (final video in _videos) {
      final controller = VideoPlayerController.asset(video.asset);
      _controllers.add(controller);
    }

    await Future.wait(
      _controllers.map((controller) => controller.initialize()),
    );
    await _controllers.first.setLooping(true);
    await _controllers.first.play();

    if (mounted) {
      setState(() => _initializing = false);
    }
  }

  Future<void> _changeVisibleVideo(int index) async {
    for (var i = 0; i < _controllers.length; i++) {
      if (i == index) {
        await _controllers[i].setLooping(true);
        await _controllers[i].play();
      } else {
        await _controllers[i].pause();
      }
    }
  }

  void _togglePlayback(int index) {
    final controller = _controllers[index];
    setState(() {
      if (controller.value.isPlaying) {
        controller.pause();
      } else {
        controller.play();
      }
    });
  }

  Future<void> _logout() async {
    if (!kIsWeb) {
      await GoogleSignIn.instance.signOut();
      await FacebookAuth.instance.logOut();
    }
    await FirebaseAuth.instance.signOut();

    if (mounted) {
      context.go('/login');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (_initializing) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: const Text('Feed'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: TextButton.icon(
              key: const Key('logoutButton'),
              onPressed: _logout,
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              icon: const Icon(Icons.logout),
              label: Text(
                user?.displayName?.trim().isNotEmpty == true
                    ? user!.displayName!
                    : user?.email ?? 'Cerrar sesión',
                key: const Key('authenticatedUser'),
              ),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: _videos.length,
        onPageChanged: _changeVisibleVideo,
        itemBuilder: (context, index) {
          final video = _videos[index];
          final controller = _controllers[index];

          return GestureDetector(
            onTap: () => _togglePlayback(index),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  color: Colors.black,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: SizedBox(
                      width: controller.value.size.width,
                      height: controller.value.size.height,
                      child: VideoPlayer(controller),
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black26,
                        Colors.transparent,
                        Colors.black87,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  right: 88,
                  bottom: 28,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        video.user,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        video.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      if (user?.email != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          user!.email!,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Positioned(
                  right: 12,
                  bottom: 28,
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, color: Colors.black),
                      ),
                      const SizedBox(height: 18),
                      _FeedAction(
                        icon: Icons.favorite,
                        label: video.likes,
                        onTap: () {},
                      ),
                      const SizedBox(height: 16),
                      _FeedAction(
                        icon: Icons.comment,
                        label: video.comments,
                        onTap: () {},
                      ),
                      const SizedBox(height: 16),
                      const _FeedAction(icon: Icons.share, label: 'Compartir'),
                    ],
                  ),
                ),
                if (!controller.value.isPlaying)
                  const Center(
                    child: Icon(
                      Icons.play_arrow,
                      size: 72,
                      color: Colors.white70,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _FeedAction extends StatelessWidget {
  const _FeedAction({required this.icon, required this.label, this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 34),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
