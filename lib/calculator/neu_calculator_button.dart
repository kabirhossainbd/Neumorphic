import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'concave_decoration.dart';
import 'neumorphic_theme.dart';

class NeuCalculatorButton extends StatefulWidget {
  const NeuCalculatorButton({super.key,
    required this.text,
    this.textColor = Colors.red,
    this.textSize = 24,
    this.isPill = false,
    required this.onPressed,
    this.isChosen = false,
  });

  final bool isChosen;
  final bool isPill;
  final VoidCallback onPressed;
  final String text;
  final Color textColor;
  final double textSize;

  @override
  State<NeuCalculatorButton> createState() => _NeuCalculatorButtonState();
}

class _NeuCalculatorButtonState extends State<NeuCalculatorButton> {
  bool _isPressed = false;

  @override
  void didUpdateWidget(NeuCalculatorButton oldWidget) {
    if (oldWidget.isChosen != widget.isChosen) {
      setState(() => _isPressed = widget.isChosen);
    }
    super.didUpdateWidget(oldWidget);
  }

  void _onPointerDown(PointerDownEvent event) {
    setState(() => _isPressed = true);
    widget.onPressed();
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() => _isPressed = widget.isChosen);
  }

  @override
  Widget build(BuildContext context) {
    final neumorphicTheme = Provider.of<NeumorphicTheme>(context);
    final width = MediaQuery.of(context).size.width;
    final squareSideLength = width / 5;
    final buttonWidth = squareSideLength * (widget.isPill ? 2.2 : 1);
    final buttonSize = Size(buttonWidth, squareSideLength);

    final innerShadow = ConcaveDecoration(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(buttonSize.width),
      ),
      colors: neumorphicTheme.innerShadowColors,
      depression: 10,
    );

    final outerShadow = BoxDecoration(
      border: Border.all(color: neumorphicTheme.borderColor),
      borderRadius: BorderRadius.circular(buttonSize.width),
      color: neumorphicTheme.buttonColor,
      boxShadow: neumorphicTheme.outerShadow,
    );

    return SizedBox(
      height: buttonSize.height,
      width: buttonSize.width,
      child: Listener(
        onPointerDown: _onPointerDown,
        onPointerUp: _onPointerUp,
        child: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 50),
              padding: EdgeInsets.all(width / 12),
              decoration: _isPressed ? innerShadow : outerShadow,
            ),
            Align(
              alignment: Alignment(widget.isPill ? -0.6 : 0, 0),
              child: Text(
                widget.text,
                style: GoogleFonts.montserrat(
                  fontSize: widget.textSize ?? 30,
                  fontWeight: FontWeight.w200,
                  color: widget.textColor
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
