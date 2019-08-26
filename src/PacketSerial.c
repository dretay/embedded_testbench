#include "PacketSerial.h"

static void (*tx_handler)(char* buffer, size_t size);
static void (*rx_handler)(char* buffer, size_t size);

static bool send(const char* buffer, size_t size)
{
    Packet packet = Packet_init_zero;
    unsigned int data_chunk_size = sizeof(packet.data);
    for (int i = 0; i < size / data_chunk_size; i++) {
        strncpy(packet.data, &buffer[i * data_chunk_size], data_chunk_size);
        unsigned char crc = 0;
        for (int count = 0; count < sizeof(packet.data); count++) {
            crc = Crc8(crc, packet.data[count]);
        }
        packet.crc = crc;
        packet.sequence_number = i;
        packet.flag = Packet_Flag_FIRST;
    }
    // printf("%s %lu", buffer, size);
    return false;
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
};