import 'package:flutter_test/flutter_test.dart';
import 'package:mxhck/alarmas.dart';

void main() {
  group('ListViewModel', () {
    test('creates instance with required fields', () {
      final model = ListViewModel(
        medicina: 'Paracetamol',
        descripcion: 'Para fiebre',
        hora: '8:00 am',
      );
      expect(model.medicina, 'Paracetamol');
      expect(model.descripcion, 'Para fiebre');
      expect(model.hora, '8:00 am');
    });

    test('listViewData has predefined entries', () {
      expect(listViewData.length, 4);
      expect(listViewData[0].medicina, 'Medicina');
      expect(listViewData[1].medicina, 'Otra medicina');
      expect(listViewData[2].medicina, 'Una medicina mas');
      expect(listViewData[3].medicina, 'Medicina plus');
    });

    test('can add new entry to listViewData', () {
      final initialLength = listViewData.length;
      listViewData.add(
        ListViewModel(
          medicina: 'Ibuprofeno',
          descripcion: 'Antiinflamatorio',
          hora: '10:00 pm',
        ),
      );
      expect(listViewData.length, initialLength + 1);
      expect(listViewData.last.medicina, 'Ibuprofeno');
      listViewData.removeLast();
    });

    test('can remove entry from listViewData', () {
      final initialLength = listViewData.length;
      listViewData.removeAt(0);
      expect(listViewData.length, initialLength - 1);
      listViewData.insert(
        0,
        ListViewModel(
          medicina: 'Medicina',
          descripcion: 'De la que cura',
          hora: '1:53 pm',
        ),
      );
    });
  });
}
