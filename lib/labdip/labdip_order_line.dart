class LabdipOrderLine {
  final String shade;
  final String buyerCode;
  final String firstLightSource;
  final String secondLightSource;
  final String substrate;
  final String tex;
  final String ticket;
  final String brand;
  final String article;
  final String requestType;
  final String colorName;
  final String lab;
  final String comment;
  final String billingType;
  final String uom;
  final String endUse;

  LabdipOrderLine({
    required this.endUse,
    required this.uom,
    required this.requestType,
    required this.lab,
    required this.billingType,
    required this.buyerCode,
    required this.firstLightSource,
    required this.secondLightSource,
    required this.colorName,
    required this.shade,
    required this.substrate,
    required this.tex,
    required this.brand,
    required this.article,
    required this.ticket,
    required this.comment,
  });
}
