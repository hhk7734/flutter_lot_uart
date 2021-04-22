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

#include <fcntl.h>    // open(), fcntl()
#include <termios.h>
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

void lot_uart_set_baudrate(int fd, uint32_t baudrate) {
    struct termios options;
    speed_t        baud_rate = B0;

    // clang-format off
    switch( baudrate )
    {
        case 50:        baud_rate = B50;        break;
        case 75:        baud_rate = B75;        break;
        case 110:       baud_rate = B110;       break;
        case 134:       baud_rate = B134;       break;
        case 150:       baud_rate = B150;       break;
        case 200:       baud_rate = B200;       break;
        case 300:       baud_rate = B300;       break;
        case 600:       baud_rate = B600;       break;
        case 1200:      baud_rate = B1200;      break;
        case 1800:      baud_rate = B1800;      break;
        case 2400:      baud_rate = B2400;      break;
        case 4800:      baud_rate = B4800;      break;
        case 9600:      baud_rate = B9600;      break;
        case 19200:     baud_rate = B19200;     break;
        case 38400:     baud_rate = B38400;     break;
        case 57600:     baud_rate = B57600;     break;
        case 115200:    baud_rate = B115200;    break;
        case 230400:    baud_rate = B230400;    break;
        case 460800:    baud_rate = B460800;    break;
        case 500000:    baud_rate = B500000;    break;
        case 576000:    baud_rate = B576000;    break;
        case 921600:    baud_rate = B921600;    break;
        case 1000000:   baud_rate = B1000000;   break;
        case 1152000:   baud_rate = B1152000;   break;
        case 1500000:   baud_rate = B1500000;   break;
        case 2000000:   baud_rate = B2000000;   break;
        case 2500000:   baud_rate = B2500000;   break;
        case 3000000:   baud_rate = B3000000;   break;
        case 3500000:   baud_rate = B3500000;   break;
        case 4000000:   baud_rate = B4000000;   break;
        default:
            baud_rate = B115200;
            break;
    };
    // clang-format on

    tcgetattr(fd, &options);

    cfsetispeed(&options, baud_rate);
    cfsetospeed(&options, baud_rate);

    tcsetattr(fd, TCSANOW, &options);

    usleep(10000);
}