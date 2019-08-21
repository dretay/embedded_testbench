#include "unity.h"
#include "../src/ProtoBuff.h"

#define BUFFER_SIZE 101

void setUp(void)
{
	
}

void tearDown(void)
{
}
void test(void)
{
	printf("test!");
}
void test_adding_handler(void)
{
	// bool status;
	// UnionMessage message = UnionMessage_init_zero;
	// message.has_input_report = true;
	// strncpy(message.input_report.data, "hello", strlen("hello"));	
	// uint8_t my_buffer[BUFFER_SIZE] = {0};
	
	// ProtoBuff.marshal(&message, UnionMessage_fields, my_buffer, BUFFER_SIZE, true);
	// ProtoBuff.unmarshal(my_buffer,BUFFER_SIZE, true);
  /* All of these should pass */
  // TEST_ASSERT_EQUAL_STRING(my_buffer, "hello");
	ProtoBuff.add_handler(InputReport_fields,&test);
  
}
void test_triggering_handler(void)
{	
	ProtoBuff.add_handler(InputReport_fields,&test);
 	
 	bool status;
	UnionMessage message = UnionMessage_init_zero;
	message.has_input_report = true;
	strncpy(message.input_report.data, "hello", strlen("hello"));	
	uint8_t my_buffer[BUFFER_SIZE] = {0};
	
	ProtoBuff.marshal(&message, UnionMessage_fields, my_buffer, BUFFER_SIZE, true);
	ProtoBuff.unmarshal(my_buffer,BUFFER_SIZE, true);
  /* All of these should pass */
  // TEST_ASSERT_EQUAL_STRING(my_buffer, "hello");
}