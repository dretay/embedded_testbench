#pragma once

#include <stdio.h>
#include <stdbool.h>
#include <pb.h>
#include <pb_common.h>
#include <pb_decode.h>
#include <pb_encode.h>

#include "log.h"
#include "hid.pb.h"

struct protobuff {
    bool(*marshal)(void *src, const pb_field_t fields[], pb_byte_t *buf, size_t bufsize, bool delimited);			
    bool(*unmarshal)(pb_byte_t *buf, size_t bufsize, bool delimited);			
};

extern const struct protobuff ProtoBuff;