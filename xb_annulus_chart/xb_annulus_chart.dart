import 'package:flutter/material.dart';
import 'package:xb_custom_widget_cabin/annulus_chart/xb_annulus_chart/xb_annulus_chart_arrow.dart';
import 'package:xb_custom_widget_cabin/annulus_chart/xb_annulus_chart/xb_annulus_chart_config.dart';
import 'package:xb_custom_widget_cabin/annulus_chart/xb_annulus_chart/xb_annulus_chart_data.dart';
import 'package:xb_custom_widget_cabin/annulus_chart/xb_annulus_chart/xb_annulus_chart_model.dart';

class XBAnnulusChart extends StatefulWidget {
  /// 环形的半径，如果不传，则为控件宽度的四分之一
  final double? annulusRadius;
  final List<XBAnnulusChartModel> models;
  final XBAnnulusBottomWidgetBuilder? bottomWidgetBuilder;
  final XBAnnulusChartHoverBuilder hoverBuilder;
  final XBAnnulusChartHoverWidth hoverWidth;
  final XBAnnulusChartHoverHeight hoverHeight;
  final Color hoverColor;
  const XBAnnulusChart(
      {required this.models,
      required this.hoverBuilder,
      required this.hoverWidth,
      required this.hoverHeight,
      required this.hoverColor,
      this.bottomWidgetBuilder,
      this.annulusRadius,
      super.key});

  @override
  State<XBAnnulusChart> createState() => _XBAnnulusChartState();
}

class _XBAnnulusChartState extends State<XBAnnulusChart> {
  XBAnnulusChartModel? _selectedModel;
  Offset? _touchPosition;

  @override
  void didUpdateWidget(covariant XBAnnulusChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    XBAnnulusChartModel? temp;
    for (var element in widget.models) {
      if (element.isSelected) {
        temp = element;
        break;
      }
    }
    _selectedModel = temp;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [_datas(), _names()],
    );
  }

  late double _dataWidth;

  Widget _datas() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = widget.annulusRadius != null
            ? widget.annulusRadius! * 2
            : constraints.maxWidth * 0.5;
        _dataWidth = w;
        return Stack(
          children: [
            XBAnnulusChartData(
              width: w,
              height: w,
              models: widget.models,
              onSelected: (model, position) {
                setState(() {
                  _selectedModel = model;
                  _touchPosition = position;
                });
              },
            ),
            Visibility(
              visible: _selectedModel != null,
              child: Positioned(
                  top: _hoverTop(_touchPosition?.dy ?? 0,
                      widget.hoverHeight(_selectedModel)),
                  left: _hoverLeft(_touchPosition?.dx ?? 0,
                      widget.hoverWidth(_selectedModel)),
                  child: IgnorePointer(
                      child: Column(
                    children: [
                      widget.hoverBuilder(_selectedModel),
                      Padding(
                        padding: EdgeInsets.only(
                            left: _arrowPaddingLeft(_touchPosition?.dx ?? 0,
                                widget.hoverWidth(_selectedModel)),
                            right: _arrowPaddingRight(_touchPosition?.dx ?? 0,
                                widget.hoverWidth(_selectedModel))),
                        child: XBAnnulusChartArrow(
                          color: widget.hoverColor,
                        ),
                      )
                    ],
                  ))),
            )
          ],
        );
      },
    );
  }

  double _arrowPaddingLeft(double dx, double hoverWidth) {
    double center = dx - hoverWidth * 0.5;
    if (center + hoverWidth > _dataWidth) {
      return (center + hoverWidth - _dataWidth) * 2;
    }
    return 0;
  }

  double _arrowPaddingRight(double dx, double hoverWidth) {
    double ret = dx - hoverWidth * 0.5;
    if (ret < 0) {
      return ret.abs() * 2;
    }
    return 0;
  }

  double _hoverTop(double dy, double hoverHeight) {
    double ret = dy - hoverHeight;
    if (ret < 0) {
      ret = 0;
    }
    if (ret + hoverHeight > _dataWidth) {
      ret = _dataWidth - hoverHeight;
    }
    return ret;
  }

  double _hoverLeft(double dx, double hoverWidth) {
    double ret = dx - hoverWidth * 0.5;
    if (ret < 0) {
      ret = 0;
    }
    if (ret + hoverWidth > _dataWidth) {
      ret = _dataWidth - hoverWidth;
    }
    return ret;
  }

  Widget _names() {
    if (widget.bottomWidgetBuilder != null) {
      return widget.bottomWidgetBuilder!(widget.models);
    }
    return Container();
  }
}
