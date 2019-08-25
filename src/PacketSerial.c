#include "PacketSerial.h"

static void (*tx_handler)(char* buffer, size_t size);
static void (*rx_handler)(char* buffer, size_t size);

static bool send(const char* buffer, size_t size)
{
    printf("%s %lu", buffer, size);
    return false;
}
static void update(void)
{
}
static void register_rx_handler(void* handler)
{
    rx_handler = handler;
}
static void register_tx_handler(void* handler)
{
    tx_handler = handler;
}

const struct packetserial PacketSerial = {
    .send = send,
    .update = update,
    .register_tx_handler = register_tx_handler,
    .register_rx_handler = register_rx_handler,
};