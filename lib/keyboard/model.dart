class _KeyboardKeyState extends State<KeyboardKey> {
  Widget _renderLabel() {
    if (widget.label is Widget) {
      return widget.label;
    }

    return Text(
      widget.label.toString(),
      style: const TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap(widget.value);
      },
      child: Material(
        // Wrap with Material for ripple effect
        color: Colors.transparent,
        child: AspectRatio(
          aspectRatio: 2,
          child: Center(
            child: _renderLabel(),
          ),
        ),
      ),
    );
  }
}
