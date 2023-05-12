import 'package:flutter/material.dart';

enum ExpandableButtonType {
  baseExpandableButton,
  toggleExpandableButton,
}

class ExpandableButton extends StatefulWidget {
  /// List of [IconData] to show while expanded.
  final List<IconData> children;

  /// The callback that is called when a button is tapped.
  final void Function(int index)? onPressed;

  /// The selection state of each toggle button.
  late final List<bool>? isSelected;

  /// The icon of the main button.
  final IconData? icon;

  /// The icon of the main button while is expanded.
  final IconData? expandedIcon;

  /// The size for this button.
  final Size buttonSize;

  /// The color of this button.
  final Color? backgroundColor;

  /// The color of the foreground.
  final Color? foregroundColor;

  /// The background color for selected button.
  late final Color? selectedBackgroundColor;

  /// The duration of the expand animation.
  final Duration animationDuration;

  /// The duration of the icon switch animation.
  final Duration iconSwitchAnimationDuration;

  /// The function executed when opening.
  final VoidCallback? onOpen;

  /// The function executed when closing.
  final VoidCallback? onClose;

  /// The direction of the main axis.
  final Axis direction;

  /// The order to expand the children.
  final TextDirection textDirection;

  /// Add space between the main button and children.
  final double mainSpacing;

  /// Add space between each children.
  final double spaceBetweenChildren;

  /// Type of the this expandable button.
  late final ExpandableButtonType buttonType;

  ExpandableButton({
    super.key,
    required this.children,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.icon = Icons.visibility,
    this.expandedIcon = Icons.visibility_off,
    this.buttonSize = const Size(56.0, 56.0),
    this.animationDuration = const Duration(milliseconds: 400),
    this.iconSwitchAnimationDuration = const Duration(milliseconds: 200),
    this.onOpen,
    this.onClose,
    this.direction = Axis.horizontal,
    this.textDirection = TextDirection.ltr,
    this.mainSpacing = 0.0,
    this.spaceBetweenChildren = 0.0,
  }) {
    isSelected = null;
    selectedBackgroundColor = null;
    buttonType = ExpandableButtonType.baseExpandableButton;
  }

  ExpandableButton.toggle({
    super.key,
    required this.children,
    required this.isSelected,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.selectedBackgroundColor,
    this.icon = Icons.visibility,
    this.expandedIcon = Icons.visibility_off,
    this.buttonSize = const Size(56.0, 56.0),
    this.animationDuration = const Duration(milliseconds: 400),
    this.iconSwitchAnimationDuration = const Duration(milliseconds: 200),
    this.direction = Axis.horizontal,
    this.textDirection = TextDirection.ltr,
    this.mainSpacing = 0.0,
    this.spaceBetweenChildren = 0.0,
    this.onOpen,
    this.onClose,
  }) {
    buttonType = ExpandableButtonType.toggleExpandableButton;
  }

  @override
  State<ExpandableButton> createState() => _ExpandableButtonState();
}

class _ExpandableButtonState extends State<ExpandableButton> {
  bool _open = false;
  bool _childrenVisible = false;

  late double _width;
  late double _height;

  @override
  void initState() {
    super.initState();

    _width = widget.buttonSize.width;
    _height = widget.buttonSize.height;
  }

  ///
  double _childrenHeight() {
    return (widget.buttonSize.height - 2 + widget.spaceBetweenChildren) *
            widget.children.length +
        widget.mainSpacing;
  }

  ///
  double _childrenWidth() {
    return (widget.buttonSize.width - 2 + widget.spaceBetweenChildren) *
            widget.children.length +
        widget.mainSpacing;
  }

  /// Get the new expandable button height
  double _buttonHeight() {
    if (!_open || widget.direction == Axis.horizontal) {
      return widget.buttonSize.height;
    } else {
      return widget.buttonSize.height + _childrenHeight();
    }
  }

  /// Get the new expandable button width
  double _buttonWidth() {
    if (!_open || widget.direction == Axis.vertical) {
      return widget.buttonSize.width;
    } else {
      return widget.buttonSize.width + _childrenWidth();
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    final backgroundColor = widget.backgroundColor ?? theme.primaryColor;
    final foregroundColor = widget.foregroundColor ?? Colors.white;

    return AnimatedContainer(
      duration: widget.animationDuration,
      curve: Curves.fastLinearToSlowEaseIn,
      width: _width,
      height: _height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Wrap(
        direction: widget.direction,
        textDirection: TextDirection.rtl,
        spacing: widget.mainSpacing,
        children: [
          GestureDetector(
            onTap: () => _toggleChildren(),
            child: SizedBox(
              height: widget.buttonSize.height,
              width: widget.buttonSize.width,
              child: AnimatedSwitcher(
                duration: widget.iconSwitchAnimationDuration,
                // transitionBuilder: (child, anim) => {}
                child: _open
                    ? Icon(
                        widget.expandedIcon,
                        size: widget.buttonSize.height - 12,
                        color: foregroundColor,
                      )
                    : Icon(
                        widget.icon,
                        size: widget.buttonSize.height - 12,
                        color: foregroundColor,
                      ),
              ),
            ),
          ),
          Visibility(
            visible: _childrenVisible,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Wrap(
                direction: widget.direction,
                spacing: widget.spaceBetweenChildren,
                children: _buildChildren(context),
              ),
            ),
          ),
        ],
      ),
      onEnd: () {
        setState(() {
          if (_open) {
            _childrenVisible = true;
          }
        });
      },
    );
  }

  /// Build list of children
  List<Widget> _buildChildren(BuildContext context) {
    ThemeData theme = Theme.of(context);

    final foregroundColor = widget.foregroundColor ?? Colors.white;
    final selectedBackgroundColor =
        widget.buttonType == ExpandableButtonType.toggleExpandableButton
            ? widget.selectedBackgroundColor ?? theme.focusColor
            : null;

    return List.generate(widget.children.length, (index) {
      return GestureDetector(
        onTap: widget.onPressed != null ? () => widget.onPressed!(index) : null,
        child: Container(
          height: widget.buttonSize.height - 4,
          width: widget.buttonSize.width - 4,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.isSelected![index] ? selectedBackgroundColor : null,
          ),
          child: Icon(
            widget.children[index],
            color: foregroundColor,
          ),
        ),
      );
    });
  }

  /// Toggle children
  void _toggleChildren() {
    setState(() {
      _open = !_open;
      if (!_open) {
        _childrenVisible = false;
      }

      // Update width and height
      _width = _buttonWidth();
      _height = _buttonHeight();

      // Callback functions
      _open ? widget.onOpen?.call() : widget.onClose?.call();
    });
  }
}
