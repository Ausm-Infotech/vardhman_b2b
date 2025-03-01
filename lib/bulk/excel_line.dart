import 'package:excel/excel.dart';
import 'package:vardhman_b2b/constants.dart';

class ExcelLine {
  final String merchandiser;
  final String poNumber;
  final String article;
  final String uom;
  final String shade;
  final String buyer;
  final String styleNo;
  final int quantity;
  final String lightSources;

  ExcelLine({
    required this.merchandiser,
    required this.poNumber,
    required this.article,
    required this.uom,
    required this.shade,
    required this.buyer,
    required this.styleNo,
    required this.quantity,
    required this.lightSources,
  });

  factory ExcelLine.fromRow(List<Data?> row) {
    return ExcelLine(
      poNumber: row[0]?.value?.toString().trim() ?? '',
      merchandiser: row[1]?.value?.toString().trim() ?? '',
      buyer: row[2]?.value?.toString().trim() ?? '',
      lightSources: row[3]?.value?.toString().trim() ?? '',
      article: row[4]?.value?.toString().trim() ?? '',
      uom: row[5]?.value?.toString().trim() ?? '',
      shade: row[6]?.value?.toString().trim() ?? '',
      styleNo: row[7]?.value?.toString().trim() ?? '',
      quantity: int.tryParse(row[8]?.value?.toString().trim() ?? '') ?? 0,
    );
  }

  bool get hasError =>
      merchandiser.isEmpty ||
      poNumber.isEmpty ||
      shade.isEmpty ||
      quantity < 1 ||
      article.isEmpty ||
      uom.isEmpty ||
      buyer.isEmpty ||
      lightSources.isEmpty;

  String get itemNumber =>
      getItemNumber(article: article, uom: uom, shade: shade);
}
