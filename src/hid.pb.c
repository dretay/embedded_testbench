/* Automatically generated nanopb constant definitions */
/* Generated by nanopb-0.3.9.3 at Sat Aug 17 01:40:07 2019. */

#include "hid.pb.h"

/* @@protoc_insertion_point(includes) */
#if PB_PROTO_HEADER_VERSION != 30
#error Regenerate this file with the current version of nanopb generator.
#endif



const pb_field_t DeviceDescriptor_fields[4] = {
    PB_FIELD(  1, STRING  , REQUIRED, STATIC  , FIRST, DeviceDescriptor, iManufacturer, iManufacturer, 0),
    PB_FIELD(  2, STRING  , REQUIRED, STATIC  , OTHER, DeviceDescriptor, iProduct, iManufacturer, 0),
    PB_FIELD(  3, UINT32  , REQUIRED, STATIC  , OTHER, DeviceDescriptor, bMaxPacketSize0, iProduct, 0),
    PB_LAST_FIELD
};

const pb_field_t HIDReport_fields[2] = {
    PB_FIELD(  1, STRING  , REQUIRED, STATIC  , FIRST, HIDReport, data, data, 0),
    PB_LAST_FIELD
};

const pb_field_t InputReport_fields[2] = {
    PB_FIELD(  1, STRING  , REQUIRED, STATIC  , FIRST, InputReport, data, data, 0),
    PB_LAST_FIELD
};

const pb_field_t UnionMessage_fields[4] = {
    PB_FIELD(  1, MESSAGE , OPTIONAL, STATIC  , FIRST, UnionMessage, device_descriptor, device_descriptor, &DeviceDescriptor_fields),
    PB_FIELD(  2, MESSAGE , OPTIONAL, STATIC  , OTHER, UnionMessage, hid_report, device_descriptor, &HIDReport_fields),
    PB_FIELD(  3, MESSAGE , OPTIONAL, STATIC  , OTHER, UnionMessage, input_report, hid_report, &InputReport_fields),
    PB_LAST_FIELD
};


/* Check that field information fits in pb_field_t */
#if !defined(PB_FIELD_32BIT)
/* If you get an error here, it means that you need to define PB_FIELD_32BIT
 * compile-time option. You can do that in pb.h or on compiler command line.
 * 
 * The reason you need to do this is that some of your messages contain tag
 * numbers or field sizes that are larger than what can fit in 8 or 16 bit
 * field descriptors.
 */
PB_STATIC_ASSERT((pb_membersize(UnionMessage, device_descriptor) < 65536 && pb_membersize(UnionMessage, hid_report) < 65536 && pb_membersize(UnionMessage, input_report) < 65536), YOU_MUST_DEFINE_PB_FIELD_32BIT_FOR_MESSAGES_DeviceDescriptor_HIDReport_InputReport_UnionMessage)
#endif

#if !defined(PB_FIELD_16BIT) && !defined(PB_FIELD_32BIT)
#error Field descriptor for HIDReport.data is too large. Define PB_FIELD_16BIT to fix this.
#endif


/* @@protoc_insertion_point(eof) */