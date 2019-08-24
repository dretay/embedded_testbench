#include "ProtoBuff.h"

static volatile Handler handlers[PROTOBUFF_MAX_HANDLERS];
static uint16_t handlers_usage_mask = 0;

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
  {
		return false;
  }
    
	status = pb_decode(&substream, fields, dest_struct);
	pb_close_string_substream(stream, &substream);
	return status;
}

static bool marshal(void *src, const pb_field_t fields[], pb_byte_t *buf, size_t bufsize, bool delimited)
{
  /* Create a stream that will write to our buffer. */
	pb_ostream_t stream = pb_ostream_from_buffer(buf, bufsize);
	
  /* Now we are ready to encode the message! */
	if(delimited)
  {
    return pb_encode_delimited(&stream, fields, src);	
  }
  else
  {
    return pb_encode_delimited(&stream, fields, src);	
  }
}
static bool idx_valid(int8_t idx) {
  return idx >= 0 && idx < PROTOBUFF_MAX_HANDLERS;
}
static int8_t find_handler(const pb_field_t *type) {
  uint8_t i = 0;
  for (i = 0; i < PROTOBUFF_MAX_HANDLERS; i++) {
    if (bitRead(handlers_usage_mask, i) == 1) {
      if (handlers[i].type == type) {
        return i;
      }     
    } 
  } 
  return -1;
}
static bool unmarshal(pb_byte_t *buf, size_t bufsize, bool delimited)
{    
    pb_istream_t parent_stream = pb_istream_from_buffer(buf, bufsize); 
    pb_istream_t *decode_stream = &parent_stream;
    if(delimited)
    {
      pb_istream_t sub_stream;
      if (!pb_make_string_substream(&parent_stream, &sub_stream))
      {
        _ERROR("unable to make substream",0);
        return false;   
      }
      decode_stream = &sub_stream;
    }
    
    const pb_field_t *type = decode_unionmessage_type(decode_stream);
    int idx = find_handler(type);
    if (idx_valid(idx)) {
      handlers[idx].callback(decode_stream, type);
    }
    else
    {			
      _ERROR("unknown type",0);
    }   
    // if (type == InputReport_fields)
    // {			
    //   _DEBUG("InputReport type",0);
    //   InputReport report;
    //   if (decode_unionmessage_contents(decode_stream, InputReport_fields, &report))
    //   {				
    //     _DEBUG("%s\n",report.data);            
    //   }				
    //   else
    //   {
    //     _ERROR("unable to decode",0);
    //   }
    // }

    if(delimited)
    {
      if (!pb_close_string_substream(&parent_stream, decode_stream))
      {
        _ERROR("unable to close substream",0);
      }        
    } 
    return true;    
}


static int8_t get_unused_idx() {
  uint8_t i = 0;
  for (i = 0; i < PROTOBUFF_MAX_HANDLERS; i++) {
    if (bitRead(handlers_usage_mask, i) == 0) {
      bitSet(handlers_usage_mask, i);
      return i;
    } 
  } 
  return -1;
}
static bool add_handler(const pb_field_t *type, void* callback)
{
  int8_t idx = get_unused_idx();
  if (idx_valid(idx)) { 
    handlers[idx].callback = callback;
    handlers[idx].type = type;
    return true;
  }
  return false;
}

const struct protobuff ProtoBuff = { 
	.marshal = marshal,			
  .unmarshal = unmarshal,			
  .add_handler = add_handler,
  .decode = decode_unionmessage_contents,
};