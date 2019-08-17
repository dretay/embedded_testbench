#include <stdio.h>
#include <stdio.h>

#include "pb.h"
#include "pb_common.h"
#include "pb_decode.h"
#include "pb_encode.h"
#include "hid.pb.h"

#define BUFFER_SIZE 100
static const pb_field_t* decode_unionmessage_type(pb_istream_t *stream)
{
	pb_wire_type_t wire_type;
	uint32_t tag;
	bool eof;
	while (pb_decode_tag(stream, &wire_type, &tag, &eof))
	{
		if (wire_type == PB_WT_STRING)
		{
			const pb_field_t *field;
			for (field = UnionMessage_fields; field->tag != 0; field++)
			{
				if (field->tag == tag && (field->type & PB_LTYPE_SUBMESSAGE))
				{
					/* Found our field. */
					return field->ptr;
				}
			}
		}
        
		/* Wasn't our field.. */
		pb_skip_field(stream, wire_type);
	}
    
	return NULL;
}
static bool decode_unionmessage_contents(pb_istream_t *stream, const pb_field_t fields[], void *dest_struct)
{
	pb_istream_t substream;
	bool status;
	if (!pb_make_string_substream(stream, &substream))
		return false;
    
	status = pb_decode(&substream, fields, dest_struct);
	pb_close_string_substream(stream, &substream);
	return status;
}

int main(int argc, char **argv)
{
	bool status;
    UnionMessage message = UnionMessage_init_zero;
	message.has_input_report = true;
	strncpy(message.input_report.data, "hello", strlen("hello"));	
    uint8_t my_buffer[BUFFER_SIZE] = {0};
    
	
	/* Create a stream that will write to our buffer. */
	pb_ostream_t stream = pb_ostream_from_buffer(my_buffer, BUFFER_SIZE);
        
	/* Now we are ready to encode the message! */
	status = pb_encode_delimited(&stream, UnionMessage_fields, &message);
	if (status == false) {		
		printf("Fail!\n");
	}	
    printf("Success\n");
    
        
    pb_istream_t stream_in = pb_istream_from_buffer(my_buffer, BUFFER_SIZE); 
    pb_istream_t substream;
    if (!pb_make_string_substream(&stream_in, &substream))
    {
        printf("unable to make substream\n");
        return false;   
    }
    const pb_field_t *type = decode_unionmessage_type(&substream);     
    
    
	if (type == InputReport_fields)
	{			
		printf("InputReport type\n");
		InputReport report;
		if (decode_unionmessage_contents(&substream, InputReport_fields, &report))
		{				
            printf("%s\n",report.data);            
		}				
        else
        {
            printf("unable to decode\n");
        }
	}
    else
	{			
		printf("unknown type\n");
	}
    if (!pb_close_string_substream(&stream_in, &substream)){
        printf("unable to close substream\n");
    }
                    
    
    return true;
}
