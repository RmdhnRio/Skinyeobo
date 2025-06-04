import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

void main() {
  runApp(const MaterialApp(home: MotionPatternsDemo()));
}

class MotionPatternsDemo extends StatefulWidget {
  const MotionPatternsDemo({super.key});

  @override
  State<MotionPatternsDemo> createState() => _MotionPatternDemoState();
}

class _MotionPatternDemoState extends State<MotionPatternsDemo> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const SharedAxisDemo(),
    const FadeThroughDemo(),
    const ContainerTransformDemo(),
    const FadeScaleDemo(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material Motion Patterns'),
      ),
      body: PageTransitionSwitcher(
        transitionBuilder: (child, animation, secondaryAnimation) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.swap_horiz), label: 'Shared'),
          BottomNavigationBarItem(
              icon: Icon(Icons.brightness_6), label: 'Fade'),
          BottomNavigationBarItem(
              icon: Icon(Icons.transform), label: 'Container'),
          BottomNavigationBarItem(
              icon: Icon(Icons.linear_scale_rounded), label: 'Scale'),
        ],
      ),
    );
  }
}

class SharedAxisDemo extends StatefulWidget {
  const SharedAxisDemo({super.key});

  @override
  State<SharedAxisDemo> createState() => _SharedAxisDemoState();
}

class _SharedAxisDemoState extends State<SharedAxisDemo> {
  bool _isFirstPage = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PageTransitionSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation, secondaryAnimation) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
              child: child,
            );
          },
          child: _isFirstPage
              ? Container(
                  key: const ValueKey('page1'),
                  color: Colors.blue[100],
                  padding: const EdgeInsets.all(16),
                  child: const Center(
                    child: Text('First Page - Shared Axis Pattern'),
                  ),
                )
              : Container(
                  key: const ValueKey('page2'),
                  color: Colors.green[100],
                  padding: const EdgeInsets.all(16),
                  child: const Center(
                    child: Text('Second Page - Shared Axis Pattern'),
                  ),
                ),
        ),
        ElevatedButton(
          onPressed: () => setState(() => _isFirstPage = !_isFirstPage),
          child: Text(_isFirstPage ? 'Next Page' : 'Previous Page'),
        ),
      ],
    );
  }
}

class FadeThroughDemo extends StatefulWidget {
  const FadeThroughDemo({super.key});

  @override
  State<FadeThroughDemo> createState() => _FadeThroughDemoState();
}

class _FadeThroughDemoState extends State<FadeThroughDemo> {
  bool _showFirst = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PageTransitionSwitcher(
          transitionBuilder: (child, animation, secondaryAnimation) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: _showFirst
              ? Container(
                  key: const ValueKey('fade1'),
                  color: Colors.purple[100],
                  padding: const EdgeInsets.all(16),
                  child: const Center(
                    child: Text('First View - Fade Through Pattern'),
                  ),
                )
              : Container(
                  key: const ValueKey('fade2'),
                  color: Colors.orange[100],
                  padding: const EdgeInsets.all(16),
                  child: const Center(
                    child: Text('Second View - Fade Through Pattern'),
                  ),
                ),
        ),
        ElevatedButton(
          onPressed: () => setState(() => _showFirst = !_showFirst),
          child: const Text('Toggle Fade Through'),
        ),
      ],
    );
  }
}

// 3. Container Transform Demo
class ContainerTransformDemo extends StatelessWidget {
  const ContainerTransformDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      padding: const EdgeInsets.all(8),
      itemCount: 4,
      itemBuilder: (context, index) {
        return OpenContainer(
          transitionDuration: const Duration(milliseconds: 500),
          openBuilder: (context, _) => DetailPage(index: index),
          closedBuilder: (context, openContainer) => Card(
            child: InkWell(
              onTap: openContainer,
              child: Center(
                child: Text(
                  'Item $index\nTap to expand',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class DetailPage extends StatelessWidget {
  final int index;

  const DetailPage({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Page $index')),
      body: Center(
        child: Text('Detailed content for item $index'),
      ),
    );
  }
}

// 4. Fade Scale Demo
class FadeScaleDemo extends StatelessWidget {
  const FadeScaleDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          showModal(
            context: context,
            builder: (context) => _buildDialog(context),
          );
        },
        child: const Text('Show Fade Scale Dialog'),
      ),
    );
  }

  Widget _buildDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Fade Scale Dialog'),
      content: const Text('This dialog appears with a fade-scale transition.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}

Future<void> showModal(
    {required BuildContext context, required WidgetBuilder builder}) {
  return showGeneralDialog(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) => builder(context),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeScaleTransition(
        animation: animation,
        child: child,
      );
    },
  );
}
