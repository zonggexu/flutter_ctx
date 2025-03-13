import 'package:flutter/material.dart';

class SuperIndexedStack extends StatefulWidget {
  final int index;

  final List<Widget> children;

  const SuperIndexedStack({
    super.key,
    required this.index,
    required this.children,
  });

  @override
  SuperIndexedStackState createState() => SuperIndexedStackState();
}

class SuperIndexedStackState extends State<SuperIndexedStack> {
  late List<Widget> _children;
  final _stackKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _children = _initialChildren();
  }

  @override
  void didUpdateWidget(final SuperIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.children.length != oldWidget.children.length) {
      _children = _initialChildren();
    }

    _children = _replaceAutoDisposedUnusedChildrenWithUnloadWidget();

    _children[widget.index] = widget.children[widget.index];
  }

  @override
  Widget build(final BuildContext context) {
    return IndexedStack(
      key: _stackKey,
      index: widget.index,
      alignment: AlignmentDirectional.topStart,
      sizing: StackFit.loose,
      children: _children,
    );
  }

  List<Widget> _initialChildren() {
    return widget.children.asMap().entries.map((entry) {
      final index = entry.key;
      final childWidget = entry.value;

      if (index == widget.index) {
        return childWidget;
      }
      return Container();
    }).toList();
  }

  List<Widget> _replaceAutoDisposedUnusedChildrenWithUnloadWidget() {
    return List.generate(_children.length, (index) {

      return _children[index];
    });
  }
}