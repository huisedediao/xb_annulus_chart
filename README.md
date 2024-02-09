# xb_annulus_chart
环形图


![image.png](https://upload-images.jianshu.io/upload_images/3597041-778807ab0bccfd4b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


```
import 'package:flutter/material.dart';
import 'package:xb_custom_widget_cabin/annulus_chart/annulus_chart_vm.dart';
import 'package:xb_custom_widget_cabin/annulus_chart/xb_annulus_chart/xb_annulus_chart.dart';
import 'package:xb_custom_widget_cabin/annulus_chart/xb_annulus_chart/xb_annulus_chart_model.dart';
import 'package:xb_scaffold/xb_scaffold.dart';

class AnnulusChart extends XBPage<AnnulusChartVM> {
  const AnnulusChart({super.key});

  @override
  generateVM(BuildContext context) {
    return AnnulusChartVM(context: context);
  }

  @override
  String setTitle(AnnulusChartVM vm) {
    return "环形图demo";
  }

  @override
  Widget buildPage(vm, BuildContext context) {
    final models = [
      XBAnnulusChartModel(name: '张益达', color: Colors.orange, value: 10),
      XBAnnulusChartModel(name: 'snack', color: Colors.purple, value: 10),
      XBAnnulusChartModel(name: '吕小布', color: Colors.green, value: 10),
      XBAnnulusChartModel(name: '曾小贤', color: Colors.blue, value: 10),
      XBAnnulusChartModel(name: '吴彦祖', color: Colors.greenAccent, value: 10),
      XBAnnulusChartModel(name: '张震', color: Colors.red, value: 10)
    ];

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: XBAnnulusChart(
                annulusRadius: 100,
                models: models,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

```