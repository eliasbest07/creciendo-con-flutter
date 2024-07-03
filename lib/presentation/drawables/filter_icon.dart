//Add this CustomPaint widget to the Widget Tree
// CustomPaint(
//     size: Size(WIDTH, (WIDTH*1).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
//     painter: RPSCustomPainter(),
// )

import 'package:flutter/material.dart';

class FilterIcon extends CustomPainter {
    Color? color= const Color(0xff000000);
    FilterIcon({this.color});
    @override
    void paint(Canvas canvas, Size size) {
            
Path path_0 = Path();
    path_0.moveTo(size.width*0.7193000,size.height*0.6644737);
    path_0.cubicTo(size.width*0.7909000,size.height*0.6644737,size.width*0.8518632,size.height*0.7102526,size.width*0.8744526,size.height*0.7741211);
    path_0.lineTo(size.width*0.9385947,size.height*0.7741211);
    path_0.cubicTo(size.width*0.9531368,size.height*0.7741211,size.width*0.9670842,size.height*0.7799000,size.width*0.9773632,size.height*0.7901789);
    path_0.cubicTo(size.width*0.9876474,size.height*0.8004632,size.width*0.9934211,size.height*0.8144053,size.width*0.9934211,size.height*0.8289474);
    path_0.cubicTo(size.width*0.9934211,size.height*0.8434895,size.width*0.9876474,size.height*0.8574316,size.width*0.9773632,size.height*0.8677158);
    path_0.cubicTo(size.width*0.9670842,size.height*0.8779947,size.width*0.9531368,size.height*0.8837737,size.width*0.9385947,size.height*0.8837737);
    path_0.lineTo(size.width*0.8744526,size.height*0.8837737);
    path_0.cubicTo(size.width*0.8631263,size.height*0.9158737,size.width*0.8421211,size.height*0.9436737,size.width*0.8143316,size.height*0.9633316);
    path_0.cubicTo(size.width*0.7865421,size.height*0.9829947,size.width*0.7533421,size.height*0.9935579,size.width*0.7193000,size.height*0.9935579);
    path_0.cubicTo(size.width*0.6852579,size.height*0.9935579,size.width*0.6520526,size.height*0.9829947,size.width*0.6242632,size.height*0.9633316);
    path_0.cubicTo(size.width*0.5964789,size.height*0.9436737,size.width*0.5754737,size.height*0.9158737,size.width*0.5641474,size.height*0.8837737);
    path_0.lineTo(size.width*0.06140368,size.height*0.8837737);
    path_0.cubicTo(size.width*0.04686311,size.height*0.8837737,size.width*0.03291826,size.height*0.8779947,size.width*0.02263668,size.height*0.8677158);
    path_0.cubicTo(size.width*0.01235511,size.height*0.8574316,size.width*0.006578947,size.height*0.8434895,size.width*0.006578947,size.height*0.8289474);
    path_0.cubicTo(size.width*0.006578947,size.height*0.8144053,size.width*0.01235511,size.height*0.8004632,size.width*0.02263668,size.height*0.7901789);
    path_0.cubicTo(size.width*0.03291826,size.height*0.7799000,size.width*0.04686311,size.height*0.7741211,size.width*0.06140368,size.height*0.7741211);
    path_0.lineTo(size.width*0.5641474,size.height*0.7741211);
    path_0.cubicTo(size.width*0.5754947,size.height*0.7420474,size.width*0.5965105,size.height*0.7142789,size.width*0.6242947,size.height*0.6946421);
    path_0.cubicTo(size.width*0.6520842,size.height*0.6750053,size.width*0.6852737,size.height*0.6644632,size.width*0.7193000,size.height*0.6644737);
    path_0.close();
    path_0.moveTo(size.width*0.7193000,size.height*0.7741211);
    path_0.cubicTo(size.width*0.7047579,size.height*0.7741211,size.width*0.6908105,size.height*0.7799000,size.width*0.6805316,size.height*0.7901789);
    path_0.cubicTo(size.width*0.6702474,size.height*0.8004632,size.width*0.6644737,size.height*0.8144053,size.width*0.6644737,size.height*0.8289474);
    path_0.cubicTo(size.width*0.6644737,size.height*0.8434895,size.width*0.6702474,size.height*0.8574316,size.width*0.6805316,size.height*0.8677158);
    path_0.cubicTo(size.width*0.6908105,size.height*0.8779947,size.width*0.7047579,size.height*0.8837737,size.width*0.7193000,size.height*0.8837737);
    path_0.cubicTo(size.width*0.7338368,size.height*0.8837737,size.width*0.7477842,size.height*0.8779947,size.width*0.7580632,size.height*0.8677158);
    path_0.cubicTo(size.width*0.7683474,size.height*0.8574316,size.width*0.7741211,size.height*0.8434895,size.width*0.7741211,size.height*0.8289474);
    path_0.cubicTo(size.width*0.7741211,size.height*0.8144053,size.width*0.7683474,size.height*0.8004632,size.width*0.7580632,size.height*0.7901789);
    path_0.cubicTo(size.width*0.7477842,size.height*0.7799000,size.width*0.7338368,size.height*0.7741211,size.width*0.7193000,size.height*0.7741211);
    path_0.close();
    path_0.moveTo(size.width*0.2807016,size.height*0.3355263);
    path_0.cubicTo(size.width*0.3129926,size.height*0.3355221,size.width*0.3445711,size.height*0.3450232,size.width*0.3714984,size.height*0.3628447);
    path_0.cubicTo(size.width*0.3984263,size.height*0.3806668,size.width*0.4195121,size.height*0.4060205,size.width*0.4321274,size.height*0.4357458);
    path_0.lineTo(size.width*0.4358005,size.height*0.4451753);
    path_0.lineTo(size.width*0.9385947,size.height*0.4451753);
    path_0.cubicTo(size.width*0.9525684,size.height*0.4451911,size.width*0.9660105,size.height*0.4505416,size.width*0.9761737,size.height*0.4601342);
    path_0.cubicTo(size.width*0.9863316,size.height*0.4697268,size.width*0.9924474,size.height*0.4828374,size.width*0.9932684,size.height*0.4967868);
    path_0.cubicTo(size.width*0.9940842,size.height*0.5107368,size.width*0.9895474,size.height*0.5244726,size.width*0.9805789,size.height*0.5351895);
    path_0.cubicTo(size.width*0.9716105,size.height*0.5459053,size.width*0.9588842,size.height*0.5527895,size.width*0.9450105,size.height*0.5544421);
    path_0.lineTo(size.width*0.9385947,size.height*0.5548263);
    path_0.lineTo(size.width*0.4358553,size.height*0.5548263);
    path_0.cubicTo(size.width*0.4248026,size.height*0.5860895,size.width*0.4045600,size.height*0.6132842,size.width*0.3777816,size.height*0.6328474);
    path_0.cubicTo(size.width*0.3510026,size.height*0.6524053,size.width*0.3189384,size.height*0.6634211,size.width*0.2857921,size.height*0.6644368);
    path_0.cubicTo(size.width*0.2526463,size.height*0.6654579,size.width*0.2199658,size.height*0.6564368,size.width*0.1920353,size.height*0.6385579);
    path_0.cubicTo(size.width*0.1641053,size.height*0.6206842,size.width*0.1422295,size.height*0.5947842,size.width*0.1292763,size.height*0.5642526);
    path_0.lineTo(size.width*0.1255484,size.height*0.5548263);
    path_0.lineTo(size.width*0.06140368,size.height*0.5548263);
    path_0.cubicTo(size.width*0.04742984,size.height*0.5548105,size.width*0.03398947,size.height*0.5494579,size.width*0.02382847,size.height*0.5398632);
    path_0.cubicTo(size.width*0.01366753,size.height*0.5302737,size.width*0.007552895,size.height*0.5171626,size.width*0.006734000,size.height*0.5032132);
    path_0.cubicTo(size.width*0.005915053,size.height*0.4892632,size.width*0.01045363,size.height*0.4755274,size.width*0.01942242,size.height*0.4648116);
    path_0.cubicTo(size.width*0.02839116,size.height*0.4540963,size.width*0.04111316,size.height*0.4472095,size.width*0.05498895,size.height*0.4455589);
    path_0.lineTo(size.width*0.06140368,size.height*0.4451753);
    path_0.lineTo(size.width*0.1255484,size.height*0.4451753);
    path_0.cubicTo(size.width*0.1368974,size.height*0.4130989,size.width*0.1579126,size.height*0.3853300,size.width*0.1856989,size.height*0.3656932);
    path_0.cubicTo(size.width*0.2134853,size.height*0.3460558,size.width*0.2466768,size.height*0.3355163,size.width*0.2807016,size.height*0.3355263);
    path_0.close();
    path_0.moveTo(size.width*0.2807016,size.height*0.4451753);
    path_0.cubicTo(size.width*0.2661616,size.height*0.4451753,size.width*0.2522163,size.height*0.4509516,size.width*0.2419347,size.height*0.4612332);
    path_0.cubicTo(size.width*0.2316532,size.height*0.4715147,size.width*0.2258774,size.height*0.4854595,size.width*0.2258774,size.height*0.5000000);
    path_0.cubicTo(size.width*0.2258774,size.height*0.5145405,size.width*0.2316532,size.height*0.5284842,size.width*0.2419347,size.height*0.5387684);
    path_0.cubicTo(size.width*0.2522163,size.height*0.5490474,size.width*0.2661616,size.height*0.5548263,size.width*0.2807016,size.height*0.5548263);
    path_0.cubicTo(size.width*0.2952421,size.height*0.5548263,size.width*0.3091868,size.height*0.5490474,size.width*0.3194684,size.height*0.5387684);
    path_0.cubicTo(size.width*0.3297500,size.height*0.5284842,size.width*0.3355263,size.height*0.5145405,size.width*0.3355263,size.height*0.5000000);
    path_0.cubicTo(size.width*0.3355263,size.height*0.4854595,size.width*0.3297500,size.height*0.4715147,size.width*0.3194684,size.height*0.4612332);
    path_0.cubicTo(size.width*0.3091868,size.height*0.4509516,size.width*0.2952421,size.height*0.4451753,size.width*0.2807016,size.height*0.4451753);
    path_0.close();
    path_0.moveTo(size.width*0.7193000,size.height*0.006578947);
    path_0.cubicTo(size.width*0.7909000,size.height*0.006578947,size.width*0.8518632,size.height*0.05235747,size.width*0.8744526,size.height*0.1162279);
    path_0.lineTo(size.width*0.9385947,size.height*0.1162279);
    path_0.cubicTo(size.width*0.9531368,size.height*0.1162279,size.width*0.9670842,size.height*0.1220042,size.width*0.9773632,size.height*0.1322858);
    path_0.cubicTo(size.width*0.9876474,size.height*0.1425674,size.width*0.9934211,size.height*0.1565121,size.width*0.9934211,size.height*0.1710526);
    path_0.cubicTo(size.width*0.9934211,size.height*0.1855932,size.width*0.9876474,size.height*0.1995379,size.width*0.9773632,size.height*0.2098195);
    path_0.cubicTo(size.width*0.9670842,size.height*0.2201011,size.width*0.9531368,size.height*0.2258774,size.width*0.9385947,size.height*0.2258774);
    path_0.lineTo(size.width*0.8744526,size.height*0.2258774);
    path_0.cubicTo(size.width*0.8631263,size.height*0.2579789,size.width*0.8421211,size.height*0.2857768,size.width*0.8143316,size.height*0.3054389);
    path_0.cubicTo(size.width*0.7865421,size.height*0.3251016,size.width*0.7533421,size.height*0.3356605,size.width*0.7193000,size.height*0.3356605);
    path_0.cubicTo(size.width*0.6852579,size.height*0.3356605,size.width*0.6520526,size.height*0.3251016,size.width*0.6242632,size.height*0.3054389);
    path_0.cubicTo(size.width*0.5964789,size.height*0.2857768,size.width*0.5754737,size.height*0.2579789,size.width*0.5641474,size.height*0.2258774);
    path_0.lineTo(size.width*0.06140368,size.height*0.2258774);
    path_0.cubicTo(size.width*0.04686311,size.height*0.2258774,size.width*0.03291826,size.height*0.2201011,size.width*0.02263668,size.height*0.2098195);
    path_0.cubicTo(size.width*0.01235511,size.height*0.1995379,size.width*0.006578947,size.height*0.1855932,size.width*0.006578947,size.height*0.1710526);
    path_0.cubicTo(size.width*0.006578947,size.height*0.1565121,size.width*0.01235511,size.height*0.1425674,size.width*0.02263668,size.height*0.1322858);
    path_0.cubicTo(size.width*0.03291826,size.height*0.1220042,size.width*0.04686311,size.height*0.1162279,size.width*0.06140368,size.height*0.1162279);
    path_0.lineTo(size.width*0.5641474,size.height*0.1162279);
    path_0.cubicTo(size.width*0.5754947,size.height*0.08415158,size.width*0.5965105,size.height*0.05638263,size.width*0.6242947,size.height*0.03674563);
    path_0.cubicTo(size.width*0.6520842,size.height*0.01710853,size.width*0.6852737,size.height*0.006569158,size.width*0.7193000,size.height*0.006578947);
    path_0.close();
    path_0.moveTo(size.width*0.7193000,size.height*0.1162279);
    path_0.cubicTo(size.width*0.7047579,size.height*0.1162279,size.width*0.6908105,size.height*0.1220042,size.width*0.6805316,size.height*0.1322858);
    path_0.cubicTo(size.width*0.6702474,size.height*0.1425674,size.width*0.6644737,size.height*0.1565121,size.width*0.6644737,size.height*0.1710526);
    path_0.cubicTo(size.width*0.6644737,size.height*0.1855932,size.width*0.6702474,size.height*0.1995379,size.width*0.6805316,size.height*0.2098195);
    path_0.cubicTo(size.width*0.6908105,size.height*0.2201011,size.width*0.7047579,size.height*0.2258774,size.width*0.7193000,size.height*0.2258774);
    path_0.cubicTo(size.width*0.7338368,size.height*0.2258774,size.width*0.7477842,size.height*0.2201011,size.width*0.7580632,size.height*0.2098195);
    path_0.cubicTo(size.width*0.7683474,size.height*0.1995379,size.width*0.7741211,size.height*0.1855932,size.width*0.7741211,size.height*0.1710526);
    path_0.cubicTo(size.width*0.7741211,size.height*0.1565121,size.width*0.7683474,size.height*0.1425674,size.width*0.7580632,size.height*0.1322858);
    path_0.cubicTo(size.width*0.7477842,size.height*0.1220042,size.width*0.7338368,size.height*0.1162279,size.width*0.7193000,size.height*0.1162279);
    path_0.close();

Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
paint_0_fill.color = color!;
canvas.drawPath(path_0,paint_0_fill);

}

@override
bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
}
}