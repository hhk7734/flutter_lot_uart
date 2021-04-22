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
  late final int fd;
  final _native = libLotUart;

  Uart(this.device);

  bool init() {
    final cDevice = device.toNativeUtf8();
    fd = _native.init(cDevice.cast<ffi.Int8>());
    return fd >= 0 ? true : false;
  }

  set baudrate(int baudrate) => _native.set_baudrate(fd, baudrate);

  set dataBits(UartDataBits bits) {
    switch (bits) {
      case UartDataBits.five:
        _native.set_data_bits(fd, CEnumUartDataBits.FIVE);
        break;
      case UartDataBits.six:
        _native.set_data_bits(fd, CEnumUartDataBits.SIX);
        break;
      case UartDataBits.seven:
        _native.set_data_bits(fd, CEnumUartDataBits.SEVEN);
        break;
      case UartDataBits.eight:
        _native.set_data_bits(fd, CEnumUartDataBits.EIGHT);
        break;
    }
  }

  set parityBits(UartParityBits bits) {
    switch (bits) {
      case UartParityBits.none:
        _native.set_parity_bits(fd, CEnumUartParityBits.NONE);
        break;
      case UartParityBits.even:
        _native.set_parity_bits(fd, CEnumUartParityBits.EVEN);
        break;
      case UartParityBits.odd:
        _native.set_parity_bits(fd, CEnumUartParityBits.ODD);
        break;
    }
  }

  set stopBits(UartStopBits bits) {
    switch (bits) {
      case UartStopBits.one:
        _native.set_stop_bits(fd, CEnumUartStopBits.ONE);
        break;
      case UartStopBits.two:
        _native.set_stop_bits(fd, CEnumUartStopBits.TWO);
        break;
    }
  }

  void dispose() {
    if (fd >= 0) {
      _native.dispose(fd);
    }
  }
}
