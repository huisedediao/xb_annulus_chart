import 'package:flutter/material.dart';
import 'package:xb_custom_widget_cabin/annulus_chart/xb_annulus_chart/xb_annulus_chart_model.dart';

typedef XBAnnulusBottomWidgetBuilder = Widget Function(
    List<XBAnnulusChartModel> models);
typedef XBAnnulusOnSelected = void Function(
    XBAnnulusChartModel? model, Offset position);

typedef XBAnnulusChartHoverBuilder = Widget Function(
    XBAnnulusChartModel? model);
typedef XBAnnulusChartHoverWidth = double Function(XBAnnulusChartModel? model);
typedef XBAnnulusChartHoverHeight = double Function(XBAnnulusChartModel? model);

double XBAnnulusChartNameMarkWidth = 5;

double xbAnnulusTotal(List<XBAnnulusChartModel> models) {
  double ret = 0;
  for (var element in models) {
    ret += element.value;
  }
  return ret;
}
