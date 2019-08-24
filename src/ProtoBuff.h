#pragma once

#include <stdio.h>
#include <stdbool.h>
#include <pb.h>
#include <pb_common.h>
#include <pb_decode.h>
#include <pb_encode.h>

#include "log.h"
#include "bithelper.h"
#include "hid.pb.h"

typedef struct {
	const pb_field_t *type;
	void(*callback)(pb_istream_t *decode_stream, const pb_field_t *type);
} Handler;

#define PROTOBUFF_MAX_HANDLERS 16

struct protobuff {
    bool(*marshal)(void *src, const pb_field_t fields[], pb_byte_t *buf, size_t bufsize, bool delimited);			
    bool(*unmarshal)(pb_byte_t *buf, size_t bufsize, bool delimited);	
    bool(*add_handler)(const pb_field_t *type, void* callback);		
    bool(*decode)(pb_istream_t *stream, const pb_field_t fields[], void *dest_struct);
};

extern const struct protobuff ProtoBuff;