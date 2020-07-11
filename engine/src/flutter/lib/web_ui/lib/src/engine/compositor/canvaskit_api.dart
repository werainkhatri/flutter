// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Bindings for CanvasKit JavaScript API.
part of engine;

final js.JsObject _jsWindow = js.JsObject.fromBrowserObject(html.window);

/// This and [_jsObjectWrapper] below are used to convert `@JS`-backed
/// objects to [js.JsObject]s. To do that we use `@JS` to pass the object
/// to JavaScript (see [JsObjectWrapper]), then use this variable (which
/// uses `dart:js`) to read the value back, causing it to be wrapped in
/// [js.JsObject].
///
// TODO(yjbanov): this is a temporary hack until we fully migrate to @JS.
final js.JsObject _jsObjectWrapperLegacy = js.JsObject(js.context['Object']);

@JS('window.flutter_js_object_wrapper')
external JsObjectWrapper get _jsObjectWrapper;

void initializeCanvasKitBindings(js.JsObject canvasKit) {
  // Because JsObject cannot be cast to a @JS type, we stash CanvasKit into
  // a global and use the [canvasKitJs] getter to access it.
  _jsWindow['flutter_canvas_kit'] = canvasKit;
  _jsWindow['flutter_js_object_wrapper'] = _jsObjectWrapperLegacy;
}

@JS()
class JsObjectWrapper {
  external set skPaint(SkPaint? paint);
  external set skMaskFilter(SkMaskFilter? filter);
  external set skColorFilter(SkColorFilter? filter);
  external set skImageFilter(SkImageFilter? filter);
}

/// Specific methods that wrap `@JS`-backed objects into a [js.JsObject]
/// for use with legacy `dart:js` API.
extension JsObjectWrappers on JsObjectWrapper {
  js.JsObject wrapSkPaint(SkPaint paint) {
    _jsObjectWrapper.skPaint = paint;
    js.JsObject wrapped = _jsObjectWrapperLegacy['skPaint'];
    _jsObjectWrapper.skPaint = null;
    return wrapped;
  }

  js.JsObject wrapSkMaskFilter(SkMaskFilter filter) {
    _jsObjectWrapper.skMaskFilter = filter;
    js.JsObject wrapped = _jsObjectWrapperLegacy['skMaskFilter'];
    _jsObjectWrapper.skMaskFilter = null;
    return wrapped;
  }

  js.JsObject wrapSkColorFilter(SkColorFilter filter) {
    _jsObjectWrapper.skColorFilter = filter;
    js.JsObject wrapped = _jsObjectWrapperLegacy['skColorFilter'];
    _jsObjectWrapper.skColorFilter = null;
    return wrapped;
  }

  js.JsObject wrapSkImageFilter(SkImageFilter filter) {
    _jsObjectWrapper.skImageFilter = filter;
    js.JsObject wrapped = _jsObjectWrapperLegacy['skImageFilter'];
    _jsObjectWrapper.skImageFilter = null;
    return wrapped;
  }
}

@JS('window.flutter_canvas_kit')
external CanvasKit get canvasKitJs;

@JS()
class CanvasKit {
  external SkBlendModeEnum get BlendMode;
  external SkPaintStyleEnum get PaintStyle;
  external SkStrokeCapEnum get StrokeCap;
  external SkStrokeJoinEnum get StrokeJoin;
  external SkFilterQualityEnum get FilterQuality;
  external SkBlurStyleEnum get BlurStyle;
  external SkTileModeEnum get TileMode;
  external SkAnimatedImage MakeAnimatedImageFromEncoded(Uint8List imageData);
  external SkShaderNamespace get SkShader;
  external SkMaskFilter MakeBlurMaskFilter(SkBlurStyle blurStyle, double sigma, bool respectCTM);
  external SkColorFilterNamespace get SkColorFilter;
  external SkImageFilterNamespace get SkImageFilter;
}

@JS()
class SkBlurStyleEnum {
  external SkBlurStyle get Normal;
  external SkBlurStyle get Solid;
  external SkBlurStyle get Outer;
  external SkBlurStyle get Inner;
}

@JS()
class SkBlurStyle {
  external int get value;
}

final List<SkBlurStyle> _skBlurStyles = <SkBlurStyle>[
  canvasKitJs.BlurStyle.Normal,
  canvasKitJs.BlurStyle.Solid,
  canvasKitJs.BlurStyle.Outer,
  canvasKitJs.BlurStyle.Inner,
];

SkBlurStyle toSkBlurStyle(ui.BlurStyle strokeCap) {
  return _skBlurStyles[strokeCap.index];
}

@JS()
class SkStrokeCapEnum {
  external SkStrokeCap get Butt;
  external SkStrokeCap get Round;
  external SkStrokeCap get Square;
}

@JS()
class SkStrokeCap {
  external int get value;
}

final List<SkStrokeCap> _skStrokeCaps = <SkStrokeCap>[
  canvasKitJs.StrokeCap.Butt,
  canvasKitJs.StrokeCap.Round,
  canvasKitJs.StrokeCap.Square,
];

SkStrokeCap toSkStrokeCap(ui.StrokeCap strokeCap) {
  return _skStrokeCaps[strokeCap.index];
}

@JS()
class SkPaintStyleEnum {
  external SkPaintStyle get Stroke;
  external SkPaintStyle get Fill;
}

@JS()
class SkPaintStyle {
  external int get value;
}

final List<SkPaintStyle> _skPaintStyles = <SkPaintStyle>[
  canvasKitJs.PaintStyle.Fill,
  canvasKitJs.PaintStyle.Stroke,
];

SkPaintStyle toSkPaintStyle(ui.PaintingStyle paintStyle) {
  return _skPaintStyles[paintStyle.index];
}

@JS()
class SkBlendModeEnum {
  external SkBlendMode get Clear;
  external SkBlendMode get Src;
  external SkBlendMode get Dst;
  external SkBlendMode get SrcOver;
  external SkBlendMode get DstOver;
  external SkBlendMode get SrcIn;
  external SkBlendMode get DstIn;
  external SkBlendMode get SrcOut;
  external SkBlendMode get DstOut;
  external SkBlendMode get SrcATop;
  external SkBlendMode get DstATop;
  external SkBlendMode get Xor;
  external SkBlendMode get Plus;
  external SkBlendMode get Modulate;
  external SkBlendMode get Screen;
  external SkBlendMode get Overlay;
  external SkBlendMode get Darken;
  external SkBlendMode get Lighten;
  external SkBlendMode get ColorDodge;
  external SkBlendMode get ColorBurn;
  external SkBlendMode get HardLight;
  external SkBlendMode get SoftLight;
  external SkBlendMode get Difference;
  external SkBlendMode get Exclusion;
  external SkBlendMode get Multiply;
  external SkBlendMode get Hue;
  external SkBlendMode get Saturation;
  external SkBlendMode get Color;
  external SkBlendMode get Luminosity;
}

@JS()
class SkBlendMode {
  external int get value;
}

final List<SkBlendMode> _skBlendModes = <SkBlendMode>[
  canvasKitJs.BlendMode.Clear,
  canvasKitJs.BlendMode.Src,
  canvasKitJs.BlendMode.Dst,
  canvasKitJs.BlendMode.SrcOver,
  canvasKitJs.BlendMode.DstOver,
  canvasKitJs.BlendMode.SrcIn,
  canvasKitJs.BlendMode.DstIn,
  canvasKitJs.BlendMode.SrcOut,
  canvasKitJs.BlendMode.DstOut,
  canvasKitJs.BlendMode.SrcATop,
  canvasKitJs.BlendMode.DstATop,
  canvasKitJs.BlendMode.Xor,
  canvasKitJs.BlendMode.Plus,
  canvasKitJs.BlendMode.Modulate,
  canvasKitJs.BlendMode.Screen,
  canvasKitJs.BlendMode.Overlay,
  canvasKitJs.BlendMode.Darken,
  canvasKitJs.BlendMode.Lighten,
  canvasKitJs.BlendMode.ColorDodge,
  canvasKitJs.BlendMode.ColorBurn,
  canvasKitJs.BlendMode.HardLight,
  canvasKitJs.BlendMode.SoftLight,
  canvasKitJs.BlendMode.Difference,
  canvasKitJs.BlendMode.Exclusion,
  canvasKitJs.BlendMode.Multiply,
  canvasKitJs.BlendMode.Hue,
  canvasKitJs.BlendMode.Saturation,
  canvasKitJs.BlendMode.Color,
  canvasKitJs.BlendMode.Luminosity,
];

SkBlendMode toSkBlendMode(ui.BlendMode blendMode) {
  return _skBlendModes[blendMode.index];
}

@JS()
class SkStrokeJoinEnum {
  external SkStrokeJoin get Miter;
  external SkStrokeJoin get Round;
  external SkStrokeJoin get Bevel;
}

@JS()
class SkStrokeJoin {
  external int get value;
}

final List<SkStrokeJoin> _skStrokeJoins = <SkStrokeJoin>[
  canvasKitJs.StrokeJoin.Miter,
  canvasKitJs.StrokeJoin.Round,
  canvasKitJs.StrokeJoin.Bevel,
];

SkStrokeJoin toSkStrokeJoin(ui.StrokeJoin strokeJoin) {
  return _skStrokeJoins[strokeJoin.index];
}


@JS()
class SkFilterQualityEnum {
  external SkFilterQuality get None;
  external SkFilterQuality get Low;
  external SkFilterQuality get Medium;
  external SkFilterQuality get High;
}

@JS()
class SkFilterQuality {
  external int get value;
}

final List<SkFilterQuality> _skFilterQualitys = <SkFilterQuality>[
  canvasKitJs.FilterQuality.None,
  canvasKitJs.FilterQuality.Low,
  canvasKitJs.FilterQuality.Medium,
  canvasKitJs.FilterQuality.High,
];

SkFilterQuality toSkFilterQuality(ui.FilterQuality filterQuality) {
  return _skFilterQualitys[filterQuality.index];
}


@JS()
class SkTileModeEnum {
  external SkTileMode get Clamp;
  external SkTileMode get Repeat;
  external SkTileMode get Mirror;
}

@JS()
class SkTileMode {
  external int get value;
}

final List<SkTileMode> _skTileModes = <SkTileMode>[
  canvasKitJs.TileMode.Clamp,
  canvasKitJs.TileMode.Repeat,
  canvasKitJs.TileMode.Mirror,
];

SkTileMode toSkTileMode(ui.TileMode filterQuality) {
  return _skTileModes[filterQuality.index];
}

@JS()
class SkAnimatedImage {
  external int getFrameCount();
  /// Returns duration in milliseconds.
  external int getRepetitionCount();
  external int decodeNextFrame();
  external SkImage getCurrentFrame();
  external int width();
  external int height();

  /// Deletes the C++ object.
  ///
  /// This object is no longer usable after calling this method.
  external void delete();
}

@JS()
class SkImage {
  external void delete();
  external int width();
  external int height();
  external SkShader makeShader(SkTileMode tileModeX, SkTileMode tileModeY);
}

@JS()
class SkShaderNamespace {
  external SkShader MakeLinearGradient(
    Float32List from, // 2-element array
    Float32List to, // 2-element array
    List<Float32List> colors,
    Float32List colorStops,
    SkTileMode tileMode,
  );

  external SkShader MakeRadialGradient(
    Float32List center, // 2-element array
    double radius,
    List<Float32List> colors,
    Float32List colorStops,
    SkTileMode tileMode,
    Float32List? matrix, // 3x3 matrix
    int flags,
  );

  external SkShader MakeTwoPointConicalGradient(
    Float32List focal,
    double focalRadius,
    Float32List center,
    double radius,
    List<Float32List> colors,
    Float32List colorStops,
    SkTileMode tileMode,
    Float32List? matrix, // 3x3 matrix
    int flags,
  );
}

@JS()
class SkShader {

}

// This needs to be bound to top-level because SkPaint is initialized
// with `new`. Also in Dart you can't write this:
//
//     external SkPaint SkPaint();
@JS('window.flutter_canvas_kit.SkPaint')
class SkPaint {
  // TODO(yjbanov): implement invertColors, see paint.cc
  external SkPaint();
  external void setBlendMode(SkBlendMode blendMode);
  external void setStyle(SkPaintStyle paintStyle);
  external void setStrokeWidth(double width);
  external void setStrokeCap(SkStrokeCap cap);
  external void setStrokeJoin(SkStrokeJoin join);
  external void setAntiAlias(bool isAntiAlias);
  external void setColorInt(int color);
  external void setShader(SkShader? shader);
  external void setMaskFilter(SkMaskFilter? maskFilter);
  external void setFilterQuality(SkFilterQuality filterQuality);
  external void setColorFilter(SkColorFilter? colorFilter);
  external void setStrokeMiter(double miterLimit);
  external void setImageFilter(SkImageFilter? imageFilter);
}

@JS()
class SkMaskFilter {}

@JS()
class SkColorFilterNamespace {
  external SkColorFilter MakeBlend(Float32List color, SkBlendMode blendMode);
  external SkColorFilter MakeMatrix(
    Float32List matrix, // 20-element matrix
  );
  external SkColorFilter MakeLinearToSRGBGamma();
  external SkColorFilter MakeSRGBToLinearGamma();
}

@JS()
class SkColorFilter {}

@JS()
class SkImageFilterNamespace {
  external SkImageFilter MakeBlur(
    double sigmaX,
    double sigmaY,
    SkTileMode tileMode,
    Null input, // we don't use this yet
  );

  external SkImageFilter MakeMatrixTransform(
    Float32List matrix, // 3x3 matrix
    SkFilterQuality filterQuality,
    Null input, // we don't use this yet
  );
}

@JS()
class SkImageFilter {}

/// Converts a 4x4 Flutter matrix (represented as a [Float32List]) to an
/// SkMatrix, which is a 3x3 transform matrix.
Float32List toSkMatrixFromFloat32(Float32List matrix4) {
  final Float32List skMatrix = Float32List(9);
  for (int i = 0; i < 9; ++i) {
    final int matrix4Index = _skMatrixIndexToMatrix4Index[i];
    if (matrix4Index < matrix4.length)
      skMatrix[i] = matrix4[matrix4Index];
    else
      skMatrix[i] = 0.0;
  }
  return skMatrix;
}

/// Converts an [offset] into an `[x, y]` pair stored in a `Float32List`.
///
/// The returned list can be passed to CanvasKit API that take points.
Float32List toSkPoint(ui.Offset offset) {
  final Float32List point = Float32List(2);
  point[0] = offset.dx;
  point[1] = offset.dy;
  return point;
}

/// Color stops used when the framework specifies `null`.
final Float32List _kDefaultSkColorStops = Float32List(2)
  ..[0] = 0
  ..[1] = 1;

/// Converts a list of color stops into a Skia-compatible JS array or color stops.
///
/// In Flutter `null` means two color stops `[0, 1]` that in Skia must be specified explicitly.
Float32List toSkColorStops(List<double>? colorStops) {
  if (colorStops == null) {
    return _kDefaultSkColorStops;
  }

  final int len = colorStops.length;
  final Float32List skColorStops = Float32List(len);
  for (int i = 0; i < len; i++) {
    skColorStops[i] = colorStops[i];
  }
  return skColorStops;
}

@JS('Float32Array')
external _NativeFloat32ArrayType get _nativeFloat32ArrayType;

@JS()
class _NativeFloat32ArrayType {}

@JS('window.flutter_canvas_kit.Malloc')
external SkFloat32List _mallocFloat32List(
  _NativeFloat32ArrayType float32ListType,
  int size,
);

/// Allocates a [Float32List] backed by WASM memory, managed by
/// a [SkFloat32List].
SkFloat32List mallocFloat32List(int size) {
  return _mallocFloat32List(_nativeFloat32ArrayType, size);
}

/// Wraps a [Float32List] backed by WASM memory.
///
/// This wrapper is necessary because the raw [Float32List] will get detached
/// when WASM grows its memory. Call [toTypedArray] to get a new instance
/// that's attached to the current WASM memory block.
@JS()
class SkFloat32List {
  /// Returns the [Float32List] object backed by WASM memory.
  ///
  /// Do not reuse the returned list across multiple WASM function/method
  /// invocations that may lead to WASM memory to grow. When WASM memory
  /// grows the [Float32List] object becomes "detached" and is no longer
  /// usable. Instead, call this method every time you need to read from
  /// or write to the list.
  external Float32List toTypedArray();
}

/// Writes [color] information into the given [skColor] buffer.
Float32List _populateSkColor(SkFloat32List skColor, ui.Color color) {
  final Float32List array = skColor.toTypedArray();
  array[0] = color.red / 255.0;
  array[1] = color.green / 255.0;
  array[2] = color.blue / 255.0;
  array[3] = color.alpha / 255.0;
  return array;
}

/// Unpacks the [color] into CanvasKit-compatible representation stored
/// in a shared memory location #1.
///
/// Use this only for passing transient data to CanvasKit. Because the
/// memory is shared the value will not persist.
Float32List toSharedSkColor1(ui.Color color) {
  return _populateSkColor(_sharedSkColor1, color);
}
final SkFloat32List _sharedSkColor1 = mallocFloat32List(4);

/// Unpacks the [color] into CanvasKit-compatible representation stored
/// in a shared memory location #2.
///
/// Use this only for passing transient data to CanvasKit. Because the
/// memory is shared the value will not persist.
Float32List toSharedSkColor2(ui.Color color) {
  return _populateSkColor(_sharedSkColor2, color);
}
final SkFloat32List _sharedSkColor2 = mallocFloat32List(4);

/// Unpacks the [color] into CanvasKit-compatible representation stored
/// in a shared memory location #3.
///
/// Use this only for passing transient data to CanvasKit. Because the
/// memory is shared the value will not persist.
Float32List toSharedSkColor3(ui.Color color) {
  return _populateSkColor(_sharedSkColor3, color);
}
final SkFloat32List _sharedSkColor3 = mallocFloat32List(4);
