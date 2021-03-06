// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
import 'dart:ffi' as ffi;

/// Bindings to `liblot_uart`
class LibLotUart {
  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  /// The symbols are looked up in [dynamicLibrary].
  LibLotUart(ffi.DynamicLibrary dynamicLibrary)
      : _lookup = dynamicLibrary.lookup;

  /// The symbols are looked up with [lookup].
  LibLotUart.fromLookup(
      ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
          lookup)
      : _lookup = lookup;

  int init(
    ffi.Pointer<ffi.Int8> device,
  ) {
    return _init(
      device,
    );
  }

  late final _init_ptr = _lookup<ffi.NativeFunction<_c_init>>('lot_uart_init');
  late final _dart_init _init = _init_ptr.asFunction<_dart_init>();

  void dispose(
    int fd,
  ) {
    return _dispose(
      fd,
    );
  }

  late final _dispose_ptr =
      _lookup<ffi.NativeFunction<_c_dispose>>('lot_uart_dispose');
  late final _dart_dispose _dispose = _dispose_ptr.asFunction<_dart_dispose>();

  void set_baudrate(
    int fd,
    int baudrate,
  ) {
    return _set_baudrate(
      fd,
      baudrate,
    );
  }

  late final _set_baudrate_ptr =
      _lookup<ffi.NativeFunction<_c_set_baudrate>>('lot_uart_set_baudrate');
  late final _dart_set_baudrate _set_baudrate =
      _set_baudrate_ptr.asFunction<_dart_set_baudrate>();

  void set_data_bits(
    int fd,
    int bits,
  ) {
    return _set_data_bits(
      fd,
      bits,
    );
  }

  late final _set_data_bits_ptr =
      _lookup<ffi.NativeFunction<_c_set_data_bits>>('lot_uart_set_data_bits');
  late final _dart_set_data_bits _set_data_bits =
      _set_data_bits_ptr.asFunction<_dart_set_data_bits>();

  void set_parity_bits(
    int fd,
    int bits,
  ) {
    return _set_parity_bits(
      fd,
      bits,
    );
  }

  late final _set_parity_bits_ptr =
      _lookup<ffi.NativeFunction<_c_set_parity_bits>>(
          'lot_uart_set_parity_bits');
  late final _dart_set_parity_bits _set_parity_bits =
      _set_parity_bits_ptr.asFunction<_dart_set_parity_bits>();

  void set_stop_bits(
    int fd,
    int bits,
  ) {
    return _set_stop_bits(
      fd,
      bits,
    );
  }

  late final _set_stop_bits_ptr =
      _lookup<ffi.NativeFunction<_c_set_stop_bits>>('lot_uart_set_stop_bits');
  late final _dart_set_stop_bits _set_stop_bits =
      _set_stop_bits_ptr.asFunction<_dart_set_stop_bits>();

  void transmit(
    int fd,
    ffi.Pointer<ffi.Uint8> tx_buf,
    int tx_size,
  ) {
    return _transmit(
      fd,
      tx_buf,
      tx_size,
    );
  }

  late final _transmit_ptr =
      _lookup<ffi.NativeFunction<_c_transmit>>('lot_uart_transmit');
  late final _dart_transmit _transmit =
      _transmit_ptr.asFunction<_dart_transmit>();

  int receive_available(
    int fd,
  ) {
    return _receive_available(
      fd,
    );
  }

  late final _receive_available_ptr =
      _lookup<ffi.NativeFunction<_c_receive_available>>(
          'lot_uart_receive_available');
  late final _dart_receive_available _receive_available =
      _receive_available_ptr.asFunction<_dart_receive_available>();

  void receive(
    int fd,
    ffi.Pointer<ffi.Uint8> rx_buf,
    int rx_size,
  ) {
    return _receive(
      fd,
      rx_buf,
      rx_size,
    );
  }

  late final _receive_ptr =
      _lookup<ffi.NativeFunction<_c_receive>>('lot_uart_receive');
  late final _dart_receive _receive = _receive_ptr.asFunction<_dart_receive>();
}

class __fsid_t extends ffi.Opaque {}

abstract class CEnumUartDataBits {
  static const int FIVE = 0;
  static const int SIX = 1;
  static const int SEVEN = 2;
  static const int EIGHT = 3;
}

abstract class CEnumUartParityBits {
  static const int NONE = 0;
  static const int EVEN = 1;
  static const int ODD = 2;
  static const int MARK = 3;
  static const int SPACE = 4;
}

abstract class CEnumUartStopBits {
  static const int ONE = 0;
  static const int TWO = 1;
}

typedef _c_init = ffi.Int32 Function(
  ffi.Pointer<ffi.Int8> device,
);

typedef _dart_init = int Function(
  ffi.Pointer<ffi.Int8> device,
);

typedef _c_dispose = ffi.Void Function(
  ffi.Int32 fd,
);

typedef _dart_dispose = void Function(
  int fd,
);

typedef _c_set_baudrate = ffi.Void Function(
  ffi.Int32 fd,
  ffi.Uint32 baudrate,
);

typedef _dart_set_baudrate = void Function(
  int fd,
  int baudrate,
);

typedef _c_set_data_bits = ffi.Void Function(
  ffi.Int32 fd,
  ffi.Int32 bits,
);

typedef _dart_set_data_bits = void Function(
  int fd,
  int bits,
);

typedef _c_set_parity_bits = ffi.Void Function(
  ffi.Int32 fd,
  ffi.Int32 bits,
);

typedef _dart_set_parity_bits = void Function(
  int fd,
  int bits,
);

typedef _c_set_stop_bits = ffi.Void Function(
  ffi.Int32 fd,
  ffi.Int32 bits,
);

typedef _dart_set_stop_bits = void Function(
  int fd,
  int bits,
);

typedef _c_transmit = ffi.Void Function(
  ffi.Int32 fd,
  ffi.Pointer<ffi.Uint8> tx_buf,
  ffi.Int32 tx_size,
);

typedef _dart_transmit = void Function(
  int fd,
  ffi.Pointer<ffi.Uint8> tx_buf,
  int tx_size,
);

typedef _c_receive_available = ffi.Int32 Function(
  ffi.Int32 fd,
);

typedef _dart_receive_available = int Function(
  int fd,
);

typedef _c_receive = ffi.Void Function(
  ffi.Int32 fd,
  ffi.Pointer<ffi.Uint8> rx_buf,
  ffi.Int32 rx_size,
);

typedef _dart_receive = void Function(
  int fd,
  ffi.Pointer<ffi.Uint8> rx_buf,
  int rx_size,
);
