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
#include "lot_uart.h"

#include <fcntl.h>     // open(), fcntl()
#include <unistd.h>    // close()

int lot_uart_init(const char *device) {
    // No controlling tty, Enables nonblocking mode.
    int fd = open(device, O_RDWR | O_NOCTTY | O_NONBLOCK);
    if(fd < 0) { return fd; }

    // Explicit reset due to O_NONBLOCK.
    fcntl(fd, F_SETFL, O_RDWR);

    // Default, 115200, 8 bits, none parity bits, 1 stop bits
    lot_uart_set_baudrate(fd, 115200);

    lot_uart_set_data_bits(fd, UART_DATA_EIGHT);

    lot_uart_set_parity_bits(fd, UART_PARITY_NONE);

    lot_uart_set_stop_bits(fd, UART_STOP_ONE);

    return fd;
}

void lot_uart_dispose(int fd) { close(fd); }