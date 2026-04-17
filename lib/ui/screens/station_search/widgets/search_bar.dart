import 'package:flutter/material.dart';
import 'package:velo_toulouse_app/ui/theme/theme.dart';

class StationSearchBar extends StatefulWidget {
  const StationSearchBar({
    super.key,
    required this.initSearchText,
    required this.onBackTap,
    required this.onSearchChanged,
  });

  final String initSearchText;
  final VoidCallback onBackTap;
  final ValueChanged<String> onSearchChanged;

  @override
  State<StationSearchBar> createState() => _StationSearchBarState();
}

class _StationSearchBarState extends State<StationSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool get searchIsNotEmpty => _searchController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.initSearchText;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  void onClearTap() {
    _searchController.clear();
    widget.onSearchChanged("");
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant StationSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initSearchText != widget.initSearchText &&
        _searchController.text != widget.initSearchText) {
      _searchController.text = widget.initSearchText;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColor.white,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: widget.onBackTap,
            icon: const Icon(Icons.arrow_back_ios, size: 18),
          ),
          Expanded(
            child: TextField(
              controller: _searchController,
              focusNode: _focusNode,
              onChanged: (value) {
                widget.onSearchChanged(value);
                setState(() {});
              },
              decoration: const InputDecoration(
                hintText: "Search station...",
                border: InputBorder.none,
              ),
            ),
          ),
          if (searchIsNotEmpty)
            IconButton(
              onPressed: onClearTap,
              icon: const Icon(Icons.close, size: 18),
            ),
        ],
      ),
    );
  }
}
