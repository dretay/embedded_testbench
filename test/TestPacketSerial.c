#include "../src/PacketSerial.h"
#include "unity.h"
#include <string.h>

#define BUFFER_SIZE 101

void setUp(void)
{
}

void tearDown(void)
{
    PacketSerial.clear_handlers();
}

//general setup / teardown tests
void dummy_tx_handler(char* buffer, size_t size)
{
    printf("Hello, world!\n");
}
void dummy_rx_handler(char* buffer, size_t size)
{
    printf("Hello, world!\n");
}

void test_adding_tx_handler(void)
{
    PacketSerial.register_tx_handler(&dummy_tx_handler);
    TEST_ASSERT_EQUAL(dummy_tx_handler, PacketSerial.get_tx_handler());
}
void test_adding_rx_handler(void)
{
    PacketSerial.register_rx_handler(&dummy_rx_handler);
    TEST_ASSERT_EQUAL(dummy_rx_handler, PacketSerial.get_rx_handler());
}
void test_clearing_handlers(void)
{
    PacketSerial.register_rx_handler(&dummy_rx_handler);
    PacketSerial.register_tx_handler(&dummy_tx_handler);
    PacketSerial.clear_handlers();
    TEST_ASSERT_EQUAL(NULL, PacketSerial.get_tx_handler());
    TEST_ASSERT_EQUAL(NULL, PacketSerial.get_rx_handler());
}

void test_send(void)
{
    char test[] = { 't', 'e', 's', 't' };
    PacketSerial.send(test, sizeof(test));
}