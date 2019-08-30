#include "PacketSerial.h"

static void (*tx_handler)(char* buffer, size_t size);
static void (*rx_handler)(char* buffer, size_t size);

static u8 calculate_crc(const char* buffer, size_t size)
{
    u8 crc = 0;
    for (int i = 0; i < size; i++) {
        crc = Crc8(crc, buffer[i]);
    }
    return crc;
}
static void build_packet(Packet* packet, const char* buffer, size_t size, u8 sequence_number, Packet_Flag flag)
{
    strncpy(packet->data, buffer, size);
    packet->crc = calculate_crc(packet->data, size);
    packet->sequence_number = sequence_number;
    packet->flag = flag;
}
static bool send(const char* buffer, size_t size)
{
    unsigned int data_chunk_size = member_size(Packet, data);
    unsigned int total_chunks = size / data_chunk_size;
    bool return_status = false;
    for (int i = 0; i < total_chunks; i++) {
        Packet packet = Packet_init_zero;
        Packet_Flag flag = Packet_Flag_FIRST;

        if (i == 0 && i == total_chunks) {
            flag = Packet_Flag_FIRSTLAST;
        }
        if (i > 0 & i < total_chunks) {
            flag = Packet_Flag_CONTINUE;
        } else if (i == total_chunks) {
            flag = Packet_Flag_LAST;
        }

        build_packet(&packet, &buffer[i * data_chunk_size], data_chunk_size, i, flag);
    }
    return return_status;
}
static void update(void)
{
}
static void register_rx_handler(void* handler)
{
    rx_handler = handler;
}
static PACKETSERIAL_HANDLER_FNP get_rx_handler(void)
{
    return rx_handler;
}
static void register_tx_handler(void* handler)
{
    tx_handler = handler;
}
static PACKETSERIAL_HANDLER_FNP get_tx_handler(void)
{
    return tx_handler;
}

static void clear_handlers(void)
{
    tx_handler = NULL;
    rx_handler = NULL;
}

const struct packetserial PacketSerial = {
    .send = send,
    .update = update,
    .register_tx_handler = register_tx_handler,
    .register_rx_handler = register_rx_handler,
    .get_rx_handler = get_rx_handler,
    .get_tx_handler = get_tx_handler,
    .clear_handlers = clear_handlers,
    .calculate_crc = calculate_crc,
    .build_packet = build_packet,
};