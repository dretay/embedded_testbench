#include "unity.h"
#include "../src/ProtoBuff.h"
#include<string.h>

#define BUFFER_SIZE 101

void setUp(void)
{
	ProtoBuff.clear_handlers();
}

void tearDown(void)
{
  
}

//general setup / teardown tests
void dummy_parser(void){}
void test_adding_handler(void)
{	
	bool result = ProtoBuff.add_handler(InputReport_fields,&dummy_parser);  
  TEST_ASSERT_TRUE(result);
}
void test_adding_handler_twice_fails(void)
{	
	bool result;
  result = ProtoBuff.add_handler(InputReport_fields,&dummy_parser);  
  TEST_ASSERT_TRUE(result);
  
  result = ProtoBuff.add_handler(InputReport_fields,&dummy_parser); 
  TEST_ASSERT_FALSE(result);
}

//InputReport tests
void parse_inputreport(pb_istream_t *stream, const pb_field_t *type)
{
	InputReport report;
	if (ProtoBuff.decode(stream, type, &report))
	{	
		TEST_ASSERT_EQUAL_STRING("hello",report.data);
	}		
	else
	{
		TEST_FAIL_MESSAGE("Failed to parse report");
	}
}
void test_encode_decode_inputreport(void)
{	
	bool result = ProtoBuff.add_handler(InputReport_fields,&parse_inputreport);
  TEST_ASSERT_TRUE(result);
	UnionMessage message = UnionMessage_init_zero;
	message.has_input_report = true;
	strncpy(message.input_report.data, "hello", strlen("hello")+1);	
	uint8_t my_buffer[BUFFER_SIZE] = {0};
	
	ProtoBuff.marshal(&message, UnionMessage_fields, my_buffer, BUFFER_SIZE, true);
	ProtoBuff.unmarshal(my_buffer,BUFFER_SIZE, true);  
}

//DeviceDescriptor tests
void parse_devicedescriptor(pb_istream_t *stream, const pb_field_t *type)
{
	DeviceDescriptor report;
	if (ProtoBuff.decode(stream, type, &report))
	{	
		TEST_ASSERT_EQUAL_STRING("hello",report.iManufacturer);
	}		
	else
	{
		TEST_FAIL_MESSAGE("Failed to parse report");
	}
}
void test_encode_decode_devicedescriptor(void)
{	
	bool result = ProtoBuff.add_handler(DeviceDescriptor_fields,&parse_devicedescriptor);
  TEST_ASSERT_TRUE(result);
	UnionMessage message = UnionMessage_init_zero;
	message.has_device_descriptor = true;
	strncpy(message.device_descriptor.iManufacturer, "hello", strlen("hello")+1);	
	uint8_t my_buffer[BUFFER_SIZE] = {0};
	
	ProtoBuff.marshal(&message, UnionMessage_fields, my_buffer, BUFFER_SIZE, true);
	ProtoBuff.unmarshal(my_buffer,BUFFER_SIZE, true);  
}

//HIDReport tests
void parse_hidreport(pb_istream_t *stream, const pb_field_t *type)
{
	HIDReport report;
	if (ProtoBuff.decode(stream, type, &report))
	{	
		TEST_ASSERT_EQUAL_STRING("hello",report.data);
	}		
	else
	{
		TEST_FAIL_MESSAGE("Failed to parse report");
	}
}
void test_encode_decode_hidreport(void)
{	
	bool result = ProtoBuff.add_handler(HIDReport_fields,&parse_hidreport);
  TEST_ASSERT_TRUE(result);
	UnionMessage message = UnionMessage_init_zero;
	message.has_hid_report = true;
	strncpy(message.hid_report.data, "hello", strlen("hello")+1);	
	uint8_t my_buffer[BUFFER_SIZE] = {0};
	
	ProtoBuff.marshal(&message, UnionMessage_fields, my_buffer, BUFFER_SIZE, true);
	ProtoBuff.unmarshal(my_buffer,BUFFER_SIZE, true);  
}