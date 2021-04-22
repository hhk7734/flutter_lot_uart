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
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
#pragma once

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>

enum UartDataBits {
    UART_DATA_FIVE,
    UART_DATA_SIX,
    UART_DATA_SEVEN,
    UART_DATA_EIGHT
};

enum UartParityBits {
    UART_PARITY_NONE,
    UART_PARITY_EVEN,
    UART_PARITY_ODD,
    UART_PARITY_MARK,
    UART_PARITY_SPACE
};

enum UartStopBits { UART_STOP_ONE, UART_STOP_TWO };

int lot_uart_init(const char *device);

void lot_uart_dispose(int fd);

void lot_uart_set_baudrate(int fd, uint32_t baudrate);

void lot_uart_set_data_bits(int fd, UartDataBits bits);

void lot_uart_set_parity_bits(int fd, UartParityBits bits);

void lot_uart_set_stop_bits(int fd, UartStopBits bits);

void lot_uart_transmit(int fd, uint8_t *tx_buf, int tx_size);

int lot_uart_receive_available(int fd);

void lot_uart_receive(int fd, uint8_t *rx_buf, int rx_size);

#ifdef __cplusplus
}
#endif