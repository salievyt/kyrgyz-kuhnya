import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;
import 'package:auto_route/auto_route.dart';
import 'package:kyrgyz_kuhnya/src/app/router/app_router.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _circleController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();

    // Контроллер для масштабирования логотипа
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Контроллер для вращения кругов
    _circleController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();

    // Анимация масштабирования логотипа
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOut),
    );

    // Анимация вращения кругов
    _rotateAnimation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      _circleController,
    );

    _logoController.forward();

    // Переход на главный экран после 3.5 секунд
    Timer(const Duration(milliseconds: 3500), () {
      if (mounted) {
        context.router.replaceAll([const CounterRoute()]);
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _circleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Градиент от красного к жёлтому (как в дизайне)
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFE63946), // Красный
              const Color(0xFFF77F00), // Оранжевый
              const Color(0xFFFCAA3E), // Жёлто-оранжевый
              const Color(0xFFFCD34D), // Жёлтый
            ],
            stops: const [0.0, 0.3, 0.6, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Декоративные треугольники вверху
            Positioned(
              top: 30,
              left: 20,
              child: Opacity(
                opacity: 0.15,
                child: Transform.rotate(
                  angle: -0.3,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                    ),
                    child: CustomPaint(
                      painter: TrianglePainter(Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 80,
              right: 40,
              child: Opacity(
                opacity: 0.1,
                child: Transform.rotate(
                  angle: 0.5,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                    ),
                    child: CustomPaint(
                      painter: TrianglePainter(Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            // Основной контент по центру
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Концентрические круги с логотипом юрты
                  SizedBox(
                    width: 250,
                    height: 250,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Внешний круг (вращается)
                        AnimatedBuilder(
                          animation: _rotateAnimation,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: _rotateAnimation.value,
                              child: CustomPaint(
                                size: const Size(250, 250),
                                painter: CirclePainter(
                                  radius: 110,
                                  color: Colors.white.withValues(alpha: 0.2),
                                  strokeWidth: 2,
                                ),
                              ),
                            );
                          },
                        ),
                        // Средний круг (вращается в обратном направлении)
                        AnimatedBuilder(
                          animation: _rotateAnimation,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: -_rotateAnimation.value * 0.8,
                              child: CustomPaint(
                                size: const Size(250, 250),
                                painter: CirclePainter(
                                  radius: 75,
                                  color: Colors.white.withValues(alpha: 0.25),
                                  strokeWidth: 2,
                                ),
                              ),
                            );
                          },
                        ),
                        // Внутренний круг (вращается)
                        AnimatedBuilder(
                          animation: _rotateAnimation,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: _rotateAnimation.value * 1.2,
                              child: CustomPaint(
                                size: const Size(250, 250),
                                painter: CirclePainter(
                                  radius: 45,
                                  color: Colors.white.withValues(alpha: 0.3),
                                  strokeWidth: 2,
                                ),
                              ),
                            );
                          },
                        ),
                        // Центральный оранжевый круг
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFF77F00).withValues(alpha: 0.6),
                          ),
                        ),
                        // Логотип юрты с анимацией
                        ScaleTransition(
                          scale: _scaleAnimation,
                          child: const YurtaIcon(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 60),
                  // Текст "Кыргыз кухня"
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: Text(
                      'Кыргыз кухня',
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 1.5,
                        shadows: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Кастомная иконка юрты
class YurtaIcon extends StatelessWidget {
  const YurtaIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(60, 60),
      painter: YurtaPainter(),
    );
  }
}

// Рисует юрту
class YurtaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final Paint trianglePaint = Paint()
      ..color = const Color(0xFFF77F00)
      ..style = PaintingStyle.fill;

    // Основная форма юрты (треугольник сверху)
    Path mainPath = Path();
    mainPath.moveTo(size.width / 2, 5); // Вершина
    mainPath.lineTo(size.width - 8, size.height - 5); // Правый угол
    mainPath.lineTo(size.width / 2 + 8, size.height - 5); // Правый край основания
    mainPath.lineTo(size.width / 2, size.height / 2 + 8); // Средина
    mainPath.lineTo(size.width / 2 - 8, size.height - 5); // Левый край основания
    mainPath.lineTo(8, size.height - 5); // Левый угол
    mainPath.close();
    canvas.drawPath(mainPath, whitePaint);

    // Маленький треугольник внутри (украшение)
    Path innerTriangle = Path();
    innerTriangle.moveTo(size.width / 2, size.height / 3);
    innerTriangle.lineTo(size.width / 2 + 6, size.height / 2 - 2);
    innerTriangle.lineTo(size.width / 2 - 6, size.height / 2 - 2);
    innerTriangle.close();
    canvas.drawPath(innerTriangle, trianglePaint);

    // Верхний крест (украшение юрты)
    canvas.drawLine(
      Offset(size.width / 2 - 10, 8),
      Offset(size.width / 2 + 10, 8),
      whitePaint..strokeWidth = 2,
    );
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, 16),
      whitePaint..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(YurtaPainter oldDelegate) => false;
}

// Рисует круги
class CirclePainter extends CustomPainter {
  final double radius;
  final Color color;
  final double strokeWidth;

  CirclePainter({
    required this.radius,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      radius,
      paint,
    );
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) =>
      oldDelegate.radius != radius || oldDelegate.color != color;
}

// Рисует треугольники (декоративные элементы вверху)
class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) => false;
}
