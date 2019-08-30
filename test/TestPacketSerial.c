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

void test_crc8(void)
{
    char test1[] = { 't', 'e', 's', 't' };
    char test2[] = { 't', 'e', 's', 's' };
    u8 crc1 = PacketSerial.calculate_crc(test1, sizeof(test1));
    u8 crc11 = PacketSerial.calculate_crc(test1, sizeof(test1));
    u8 crc2 = PacketSerial.calculate_crc(test2, sizeof(test2));

    TEST_ASSERT_EQUAL(crc1, crc11);
    TEST_ASSERT_NOT_EQUAL(crc1, crc2);
}
void test_build_packet(void)
{
    char data[] = { 't', 'e', 's', 't' };
    u8 sequence_number = 1;
    u8 crc = PacketSerial.calculate_crc(data, sizeof(data));
    Packet packet = Packet_init_zero;
    Packet_Flag flag = Packet_Flag_FIRST;
    PacketSerial.build_packet(&packet, data, sizeof(data), sequence_number, flag);

    TEST_ASSERT_EQUAL_STRING(packet.data, data);
    TEST_ASSERT_EQUAL(packet.sequence_number, sequence_number);
    TEST_ASSERT_EQUAL(packet.crc, crc);
    TEST_ASSERT_EQUAL(packet.flag, flag);
}
void test_send_small_packet(void)
{
    char data[] = { 't', 'e', 's', 't' };
    bool success = PacketSerial.send(data, sizeof(data));

    TEST_ASSERT_TRUE(success);
}