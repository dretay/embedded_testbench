#pragma once

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

#include "bithelper.h"
#include "log.h"

struct packetserial {
    bool (*send)(const char* buffer, size_t size);
    void (*update)(void);
    void (*register_rx_handler)(void* handler);
    void (*register_tx_handler)(void* handler);
};

extern const struct packetserial PacketSerial;