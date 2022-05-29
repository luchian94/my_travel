import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import 'travel-map.model.dart';

class TravelMapBody extends ViewModelWidget<TravelMapModel> {
  const TravelMapBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, TravelMapModel model) {
    if (!model.travelsLoaded) {
      return Center(
        child: Container(
          width: 25.0,
          height: 25.0,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 3,
          ),
        ),
      );
    }
    return SfMapsTheme(
      data: SfMapsThemeData(
        shapeHoverColor: Colors.transparent,
        shapeHoverStrokeColor: Colors.transparent,
        shapeHoverStrokeWidth: 0,
      ),
      child: SfMaps(
        layers: [
          MapShapeLayer(
            showDataLabels: false,
            source: model.mapSource,
            color: Colors.white,
            strokeColor: Colors.black,
            strokeWidth: 0.5,
            zoomPanBehavior: MapZoomPanBehavior(
              showToolbar: false,
              enablePanning: true,
              enablePinching: true,
            ),
            loadingBuilder: (BuildContext context) {
              return Container(
                height: 25,
                width: 25,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
