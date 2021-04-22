/*
 * MIT License
 * Copyright (c) 2021 Hyeonki Hong <hhk7734@gmail.com>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
import 'dart:io';
import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

import 'bindings.g.dart';

LibLotUart? _libLotUart;
LibLotUart get libLotUart {
  final path = Platform.environment['LIBLOT_UART_PATH'];
  return _libLotUart ??= path != null
      ? LibLotUart(ffi.DynamicLibrary.open(path))
      : LibLotUart(ffi.DynamicLibrary.process());
}

enum UartDataBits { five, six, seven, eight }
enum UartParityBits { none, even, odd }
enum UartStopBits { one, two }

class Uart {
  final String device;
  int _fd = -1;
  final _native = libLotUart;

  Uart(this.device);

  int get fd => _fd;

  bool init() {
    final cDevice = device.toNativeUtf8();

    dispose();
    _fd = _native.init(cDevice.cast<ffi.Int8>());
    return _fd >= 0 ? true : false;
  }

  set baudrate(int baudrate) => _native.set_baudrate(_fd, baudrate);

  set dataBits(UartDataBits bits) {
    switch (bits) {
      case UartDataBits.five:
        _native.set_data_bits(_fd, CEnumUartDataBits.FIVE);
        break;
      case UartDataBits.six:
        _native.set_data_bits(_fd, CEnumUartDataBits.SIX);
        break;
      case UartDataBits.seven:
        _native.set_data_bits(_fd, CEnumUartDataBits.SEVEN);
        break;
      case UartDataBits.eight:
        _native.set_data_bits(_fd, CEnumUartDataBits.EIGHT);
        break;
    }
  }

  set parityBits(UartParityBits bits) {
    switch (bits) {
      case UartParityBits.none:
        _native.set_parity_bits(_fd, CEnumUartParityBits.NONE);
        break;
      case UartParityBits.even:
        _native.set_parity_bits(_fd, CEnumUartParityBits.EVEN);
        break;
      case UartParityBits.odd:
        _native.set_parity_bits(_fd, CEnumUartParityBits.ODD);
        break;
    }
  }

  set stopBits(UartStopBits bits) {
    switch (bits) {
      case UartStopBits.one:
        _native.set_stop_bits(_fd, CEnumUartStopBits.ONE);
        break;
      case UartStopBits.two:
        _native.set_stop_bits(_fd, CEnumUartStopBits.TWO);
        break;
    }
  }

  void transmit(Uint8List txBuf) {
    final _txBuf = malloc.allocate<ffi.Uint8>(txBuf.length);
    var index = 0;

    for (var value in txBuf) {
      _txBuf[index++] = value;
    }

    _native.transmit(_fd, _txBuf, txBuf.length);

    malloc.free(_txBuf);
  }

  int receiveAvailable() => _native.receive_available(_fd);

  Uint8List receive(int rxSize) {
    final _rxBuf = malloc.allocate<ffi.Uint8>(rxSize);
    final rxBuf = Uint8List(rxSize);

    _native.receive(_fd, _rxBuf, rxSize);

    for (var index = 0; index < rxSize; index++) {
      rxBuf[index] = _rxBuf[index];
    }

    malloc.free(_rxBuf);

    return rxBuf;
  }

  void dispose() {
    if (_fd >= 0) {
      _native.dispose(_fd);
      _fd = -1;
    }
  }
}
