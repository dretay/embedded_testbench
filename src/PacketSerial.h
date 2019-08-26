#pragma once

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

#include "hid.pb.h"
#include <Crc8.h>
#include <pb.h>
#include <pb_common.h>
#include <pb_decode.h>
#include <pb_encode.h>

#include "bithelper.h"
#include "log.h"

typedef void (*PACKETSERIAL_HANDLER_FNP)(char*, size_t);

struct packetserial {
    bool (*send)(const char* buffer, size_t size);
    void (*update)(void);
    void (*register_rx_handler)(void* handler);
    PACKETSERIAL_HANDLER_FNP(*get_rx_handler)
    (void);
    PACKETSERIAL_HANDLER_FNP(*get_tx_handler)
    (void);
    void (*register_tx_handler)(void* handler);
    void (*clear_handlers)(void);
};

extern const struct packetserial PacketSerial;