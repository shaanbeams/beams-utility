import 'package:flutter/material.dart';

class CustomSearchField extends StatefulWidget {
  const CustomSearchField({
    super.key,
    required this.hintLabel,
    this.fieldColor,
    this.hintSize,
    this.labelColor,
    this.borderColor,
    this.marginM,
    this.labelYn = false,
    this.label,
    this.controller,
    this.onSearchTap,
    this.onChanged,
    this.enablests = true,
    this.readonly = false,
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
  final bool? readonly;

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  @override
  Widget build(BuildContext context) {
    final bool isReadOnly = widget.readonly ?? false;
    final bool isEnabled = widget.enablests ?? true;
    final Color activeColor =
        widget.borderColor ?? widget.labelColor ?? Colors.black;

    return Container(
      margin: widget.marginM ??
          const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
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
            height: 36,
            decoration: BoxDecoration(
              color: widget.fieldColor ?? Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isEnabled
                    ? activeColor
                    : Colors.grey.withValues(alpha: 0.5),
                width: 1.5,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    readOnly: isReadOnly,
                    controller: widget.controller,
                    enabled: isEnabled,
                    onTap: isReadOnly ? widget.onSearchTap : null,
                    onChanged: widget.onChanged,
                    cursorColor: activeColor,
                    style: TextStyle(
                      fontSize: widget.hintSize ?? 12,
                      color: activeColor,
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
                        color: activeColor.withValues(alpha: 0.6),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (widget.onSearchTap != null && isEnabled)
                  Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: widget.onSearchTap,
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                        child: Icon(
                          Icons.search,
                          size: 18,
                          color: activeColor,
                        ),
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