import 'package:flutter/material.dart';

class CustomSearchField extends StatefulWidget {
  const CustomSearchField({
    super.key,
    required this.hintLabel,
    this.fieldColor,
    this.hintSize,
    this.labelColor,
    this.borderColor, // Explicit border & theme color override
    this.marginM,
    this.labelYn = false,
    this.label,
    this.controller,
    this.onSearchTap,
    this.onChanged,
    this.enablests = true,
  });

  final String hintLabel;
  final Color? fieldColor;
  final TextEditingController? controller;
  final Color? labelColor;
  final Color? borderColor;
  final double? hintSize;
  final EdgeInsetsGeometry? marginM;
  final bool? labelYn;
  final String? label;
  final Function(String)? onChanged;
  final Function()? onSearchTap;
  final bool? enablests;

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  @override
  Widget build(BuildContext context) {
    // Falls back to labelColor, and defaults to white if neither is provided
    final Color activeColor =widget.labelColor?? widget.borderColor  ?? Colors.white;

    return Container(
      margin: widget.marginM ?? const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.labelYn == true) ...[
            Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 3),
              child: Text(
                widget.label ?? widget.hintLabel,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: widget.labelColor ?? activeColor,
                ),
              ),
            ),
          ],
          Container(
            height: 36, // Slim compact height
            decoration: BoxDecoration(
              // Fully transparent fill by default
              color: widget.fieldColor ?? Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: widget.borderColor ?? activeColor, // Solid white or black border
                width: 1.5,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: widget.controller,
                    enabled: widget.enablests ?? true,
                    onChanged: widget.onChanged,
                    cursorColor: activeColor,
                    style: TextStyle(
                      fontSize: widget.hintSize ?? 12,
                      color: activeColor, // Solid white or black typed text
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      hintText: widget.hintLabel,
                      hintStyle: TextStyle(
                        fontSize: widget.hintSize ?? 12,
                        // Matches the active border color with a soft opacity
                        color: activeColor.withOpacity(0.6),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (widget.onSearchTap != null)
                  InkWell(
                    onTap: widget.onSearchTap,
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        Icons.search,
                        size: 18,
                        color: activeColor,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}