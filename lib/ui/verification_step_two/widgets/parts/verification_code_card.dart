import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_theme.dart';

class VerificationCodeCard extends StatefulWidget {
  final bool enabled;
  final ValueChanged<String> onComplete;
  final VoidCallback onResend;
  final int secondsLeft;
  final bool autoFocus;
  const VerificationCodeCard({super.key, required this.enabled, required this.onComplete, required this.onResend, required this.secondsLeft, this.autoFocus = false});

  @override
  State<VerificationCodeCard> createState() => _VerificationCodeCardState();
}

class _VerificationCodeCardState extends State<VerificationCodeCard> {
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _nodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final n in _nodes) {
      n.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.autoFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (!mounted) return;
        // esperar un breve tiempo para evitar conflictos con el teclado
        await Future.delayed(const Duration(milliseconds: 200));
        if (!mounted) return;
        try {
          _nodes[0].requestFocus();
        } catch (_) {}
      });
    }
  }

  String get _code => _controllers.map((c) => c.text).join();

  void _onChanged(int i, String v) {
    if (v.isNotEmpty) {
      if (i + 1 < _nodes.length) {
        _nodes[i + 1].requestFocus();
      } else {
        widget.onComplete(_code);
      }
    } else {
      if (i - 1 >= 0) _nodes[i - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.inputBackgroundDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: List.generate(6, (i) {
              return SizedBox(
                width: 44,
                child: TextField(
                  controller: _controllers[i],
                  focusNode: _nodes[i],
                  enabled: widget.enabled,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppTheme.whiteContainer, fontSize: 18, fontWeight: FontWeight.w600),
                  cursorColor: AppTheme.whiteContainer,
                  maxLength: 1,
                  keyboardType: TextInputType.number,
                  textInputAction: i < 5 ? TextInputAction.next : TextInputAction.done,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(counterText: ''),
                  onChanged: (v) => _onChanged(i, v),
                  onSubmitted: (_) {
                    // Si el usuario presiona done/next desde el teclado
                    try {
                      if (i + 1 < _nodes.length) {
                        _nodes[i + 1].requestFocus();
                      } else {
                        widget.onComplete(_code);
                      }
                    } catch (_) {}
                  },
                ),
              );
            })),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(child: ElevatedButton(
                onPressed: widget.enabled ? () => widget.onComplete(_code) : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.purpleColor,
                  foregroundColor: AppTheme.blackContainer,
                  shape: RoundedRectangleBorder(borderRadius: AppTheme.border),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Verificar'),
              )),
              const SizedBox(width: 8),
              TextButton(onPressed: widget.secondsLeft == 0 ? widget.onResend : null, child: Text(widget.secondsLeft == 0 ? 'Reenviar' : 'Reenviar', style: TextStyle(color: AppTheme.purpleColor))),
            ])
          ],
        ),
      ),
    );
  }
}
