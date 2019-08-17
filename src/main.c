#include <stdio.h>

#include "ProtoBuff.h"

#define BUFFER_SIZE 101


int main(int argc, char **argv)
{
	bool status;
    UnionMessage message = UnionMessage_init_zero;
	message.has_input_report = true;
	strncpy(message.input_report.data, "hello", strlen("hello"));	
    uint8_t my_buffer[BUFFER_SIZE] = {0};
	
	ProtoBuff.marshal(&message, UnionMessage_fields, my_buffer, BUFFER_SIZE, true);
    ProtoBuff.unmarshal(my_buffer,BUFFER_SIZE, true);
                    
    
    return true;
}
