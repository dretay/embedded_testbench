import pytest
import ctypes

# raw_hid_descriptor = "05010902A1010901A10005091901290815002501950875018102950081030600FF0940950275081581257F8102050109381581257F7508950181060930093116018026FF7F751095028106C0C0"
# hid_descriptor=bytearray.fromhex(raw_hid_descriptor)
# hexlify_hid_descriptor = binascii.hexlify(hid_descriptor)

# # raw_input_report = "05010902A1010901A1"
# raw_input_report = "deadbeef"
# input_report=bytearray.fromhex(raw_input_report)


# #load shared object
# mydll = ctypes.cdll.LoadLibrary('./build/testbench.so')

# char_array = ctypes.c_char * len(input_report)
# out = (ctypes.c_char * 100)()
# input_report_as_char = char_array.from_buffer(input_report)
# if not (mydll.test_it_all(input_report_as_char)):        
#     print("Error encoding inputreport!")

def test_func_fast():
    pass

