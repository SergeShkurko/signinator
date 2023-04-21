import 'package:flutter/material.dart';
import 'package:signinator/core/core.dart';
import 'package:signinator/utils/utils.dart';

/// Signature for callbacks that report that an underlying value has changed.
typedef ValueChanged<T> = void Function(T valuePrev, T valueNext);

/// Example:
///
/// ```dart
/// SlidingSegmentedControl<int>(
///   children: {
///     0: Text('Login'),
///     1: Text('Register'),
///   },
///   onValueChanged: (prev, next) => print([prev, next]),
/// ),
/// ```
///
/// * `onValueChanged` - on change current segment
/// * `children` - segment items map
/// * `initialValue` - initial segment
/// * `duration` - speed animation panel
/// * `curve` - curve for animated panel
/// * `height` - height panel
class SlidingSegmentedControl<T> extends StatefulWidget {
  const SlidingSegmentedControl({
    Key? key,
    required this.children,
    required this.onValueChanged,
    this.initialValue,
    this.duration,
    this.curve = Curves.easeInOut,
    this.height = 40,
  })  : assert(children.length != 0),
        super(key: key);

  final ValueChanged<T> onValueChanged;
  final Duration? duration;
  final Curve curve;
  final Map<T, Widget> children;
  final T? initialValue;

  final double? height;

  @override
  State<SlidingSegmentedControl<T>> createState() =>
      _SlidingSegmentedControlState();
}

class _SlidingSegmentedControlState<T>
    extends State<SlidingSegmentedControl<T>> {
  T? current;
  double? height;
  double offset = 0.0;
  Map<T?, double> sizes = {};
  bool hasTouch = false;
  double? maxSize;
  List<Cache<T>> cacheItems = [];

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant SlidingSegmentedControl<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    final changeInitial = oldWidget.initialValue != widget.initialValue;

    final changeChildrenLength =
        oldWidget.children.length != widget.children.length;

    if (changeInitial || changeChildrenLength) {
      hasTouch = true;
      initialize(oldCurrent: current, isChangeInitial: changeInitial);
      for (final cache in cacheItems) {
        calculateSize(
          size: cache.size,
          item: cache.item,
          isCacheEnabled: false,
        );
      }
    }
  }

  void initialize({
    T? oldCurrent,
    bool isChangeInitial = false,
  }) {
    final List<T?> list = widget.children.keys.toList();
    final index = list.indexOf(widget.initialValue);
    final keys = list.toList();

    if (!isChangeInitial && oldCurrent != null) {
      current = oldCurrent;
    } else {
      if (widget.initialValue != null) {
        current = keys[index];
      } else {
        current = keys.first;
      }
    }
  }

  double computeOffset({
    required List<double> sizes,
    required List<T?> items,
    T? current,
  }) {
    if (sizes.isNotEmpty) {
      return sizes
          .getRange(0, items.indexOf(current))
          .toList()
          .fold<double>(0, (previousValue, element) => previousValue + element);
    } else {
      return 0;
    }
  }

  void calculateSize({
    required Size size,
    required MapEntry<T?, Widget> item,
    required bool isCacheEnabled,
  }) {
    height ??= size.height;
    final Map<T?, double> temp = {};
    temp.putIfAbsent(item.key, () => size.width);
    if (widget.initialValue != null && widget.initialValue == item.key) {
      final newOffset = computeOffset(
        current: current,
        items: widget.children.keys.toList(),
        sizes: sizes.values.toList(),
      );
      setState(() {
        offset = newOffset;
      });
    }
    setState(() {
      if (isCacheEnabled) {
        cacheItems.add(Cache<T>(item: item, size: size));
      }
      sizes = {...sizes, ...temp};
    });
  }

  void onTapItem(MapEntry<T?, Widget> item) {
    if (!hasTouch) {
      setState(() => hasTouch = true);
    }
    final prev = current;
    setState(() => current = item.key);
    final List<T?> keys = widget.children.keys.toList();
    final newOffset = computeOffset(
      current: current,
      items: keys,
      sizes: sizes.values.toList(),
    );
    setState(() => offset = newOffset);
    final prevValue = keys[keys.indexOf(prev)] as T;
    final nextValue = keys[keys.indexOf(current)] as T;
    widget.onValueChanged(prevValue, nextValue);
  }

  Widget _segmentItem(MapEntry<T, Widget> item) => InkWell(
        onTap: () => onTapItem(item),
        borderRadius: BorderRadius.circular(Dimens.space24),
        child: Container(
          height: widget.height,
          width: maxSize,
          padding: const EdgeInsets.symmetric(horizontal: Dimens.space12),
          child: Center(child: item.value),
        ),
      );

  Widget layout() {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final offsetValue = isRtl ? offset * -1 : offset;

    return Container(
      decoration: BoxDecoration(
        color: context.palette.secondary,
        borderRadius: BorderRadius.circular(Dimens.space24),
      ),
      child: Stack(
        children: [
          AnimatedContainer(
            transform: Matrix4.translationValues(offsetValue, 0, 0),
            duration: hasTouch == false
                ? Duration.zero
                : widget.duration ?? const Duration(milliseconds: 200),
            curve: widget.curve,
            width: sizes[current],
            decoration: BoxDecoration(
              color: Palette.accent,
              borderRadius: BorderRadius.circular(Dimens.space24),
            ),
            height: height,
          ),
          Row(
            children: [
              for (final item in widget.children.entries)
                MeasureSize(
                  onChange: (value) {
                    calculateSize(
                      size: value,
                      item: item,
                      isCacheEnabled: true,
                    );
                  },
                  child: Expanded(
                    child: DefaultTextStyle(
                      textAlign: TextAlign.center,
                      style: Typographies.button.copyWith(
                        color: item.key == current
                            ? Palette.white
                            : context.palette.foreground,
                      ),
                      child: _segmentItem(item),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => OrientationBuilder(
        builder: (context, orientation) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [Expanded(child: layout())],
        ),
      );
}

class Cache<T> {
  final MapEntry<T?, Widget> item;
  final Size size;

  Cache({
    required this.item,
    required this.size,
  });

  @override
  bool operator ==(Object other) {
    if (other is Cache) {
      return identical(size, other.size) && identical(item, other.item);
    }
    return false;
  }

  @override
  int get hashCode => size.hashCode ^ item.hashCode;
}
