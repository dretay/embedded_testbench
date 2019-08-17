##
## Auto Generated makefile by CodeLite IDE
## any manual changes will be erased      
##
## Debug
ProjectName            :=embedded_testbench
ConfigurationName      :=Debug
WorkspacePath          :=/home/drew/src
ProjectPath            :=/home/drew/src/embedded_testbench
IntermediateDirectory  :=./Debug
OutDir                 := $(IntermediateDirectory)
CurrentFileName        :=
CurrentFilePath        :=
CurrentFileFullPath    :=
User                   :=Drew
Date                   :=17/08/19
CodeLitePath           :=/home/drew/.codelite
LinkerName             :=/usr/bin/g++
SharedObjectLinkerName :=/usr/bin/g++ -shared -fPIC
ObjectSuffix           :=.o
DependSuffix           :=.o.d
PreprocessSuffix       :=.i
DebugSwitch            :=-g 
IncludeSwitch          :=-I
LibrarySwitch          :=-l
OutputSwitch           :=-o 
LibraryPathSwitch      :=-L
PreprocessorSwitch     :=-D
SourceSwitch           :=-c 
OutputFile             :=$(IntermediateDirectory)/$(ProjectName)
Preprocessors          :=$(PreprocessorSwitch)PB_FIELD_16BIT 
ObjectSwitch           :=-o 
ArchiveOutputSwitch    := 
PreprocessOnlySwitch   :=-E
ObjectsFileList        :="embedded_testbench.txt"
PCHCompileFlags        :=
MakeDirCommand         :=mkdir -p
LinkOptions            :=  
IncludePath            :=  $(IncludeSwitch). $(IncludeSwitch). $(IncludeSwitch)lib/nanopb-0.3.9.3 $(IncludeSwitch)lib/cobs-c-0.5.0 
IncludePCH             := 
RcIncludePath          := 
Libs                   := 
ArLibs                 :=  
LibPath                := $(LibraryPathSwitch). 

##
## Common variables
## AR, CXX, CC, AS, CXXFLAGS and CFLAGS can be overriden using an environment variables
##
AR       := /usr/bin/ar rcu
CXX      := /usr/bin/g++
CC       := /usr/bin/gcc
CXXFLAGS :=  -g -O0 -Wall $(Preprocessors)
CFLAGS   :=  -Wfatal-errors -g -O0 -std=c99 -Wall -Wextra -Wwrite-strings -Wno-parentheses -Warray-bounds $(Preprocessors)
ASFLAGS  := 
AS       := /usr/bin/as


##
## User defined environment variables
##
CodeLiteDir:=/usr/share/codelite
Objects0=$(IntermediateDirectory)/lib_cobs-c-0.5.0_cobsr.c$(ObjectSuffix) $(IntermediateDirectory)/lib_cobs-c-0.5.0_cobs.c$(ObjectSuffix) $(IntermediateDirectory)/src_hid.pb.c$(ObjectSuffix) $(IntermediateDirectory)/src_ProtoBuff.c$(ObjectSuffix) $(IntermediateDirectory)/src_main.c$(ObjectSuffix) $(IntermediateDirectory)/lib_nanopb-0.3.9.3_pb_encode.c$(ObjectSuffix) $(IntermediateDirectory)/lib_nanopb-0.3.9.3_pb_common.c$(ObjectSuffix) $(IntermediateDirectory)/lib_nanopb-0.3.9.3_pb_decode.c$(ObjectSuffix) $(IntermediateDirectory)/src_log.c$(ObjectSuffix) 



Objects=$(Objects0) 

##
## Main Build Targets 
##
.PHONY: all clean PreBuild PrePreBuild PostBuild MakeIntermediateDirs
all: $(OutputFile)

$(OutputFile): $(IntermediateDirectory)/.d $(Objects) 
	@$(MakeDirCommand) $(@D)
	@echo "" > $(IntermediateDirectory)/.d
	@echo $(Objects0)  > $(ObjectsFileList)
	$(LinkerName) $(OutputSwitch)$(OutputFile) @$(ObjectsFileList) $(LibPath) $(Libs) $(LinkOptions)

MakeIntermediateDirs:
	@test -d ./Debug || $(MakeDirCommand) ./Debug


$(IntermediateDirectory)/.d:
	@test -d ./Debug || $(MakeDirCommand) ./Debug

PreBuild:


##
## Objects
##
$(IntermediateDirectory)/lib_cobs-c-0.5.0_cobsr.c$(ObjectSuffix): lib/cobs-c-0.5.0/cobsr.c $(IntermediateDirectory)/lib_cobs-c-0.5.0_cobsr.c$(DependSuffix)
	$(CC) $(SourceSwitch) "/home/drew/src/embedded_testbench/lib/cobs-c-0.5.0/cobsr.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/lib_cobs-c-0.5.0_cobsr.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/lib_cobs-c-0.5.0_cobsr.c$(DependSuffix): lib/cobs-c-0.5.0/cobsr.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/lib_cobs-c-0.5.0_cobsr.c$(ObjectSuffix) -MF$(IntermediateDirectory)/lib_cobs-c-0.5.0_cobsr.c$(DependSuffix) -MM lib/cobs-c-0.5.0/cobsr.c

$(IntermediateDirectory)/lib_cobs-c-0.5.0_cobsr.c$(PreprocessSuffix): lib/cobs-c-0.5.0/cobsr.c
	$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/lib_cobs-c-0.5.0_cobsr.c$(PreprocessSuffix) lib/cobs-c-0.5.0/cobsr.c

$(IntermediateDirectory)/lib_cobs-c-0.5.0_cobs.c$(ObjectSuffix): lib/cobs-c-0.5.0/cobs.c $(IntermediateDirectory)/lib_cobs-c-0.5.0_cobs.c$(DependSuffix)
	$(CC) $(SourceSwitch) "/home/drew/src/embedded_testbench/lib/cobs-c-0.5.0/cobs.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/lib_cobs-c-0.5.0_cobs.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/lib_cobs-c-0.5.0_cobs.c$(DependSuffix): lib/cobs-c-0.5.0/cobs.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/lib_cobs-c-0.5.0_cobs.c$(ObjectSuffix) -MF$(IntermediateDirectory)/lib_cobs-c-0.5.0_cobs.c$(DependSuffix) -MM lib/cobs-c-0.5.0/cobs.c

$(IntermediateDirectory)/lib_cobs-c-0.5.0_cobs.c$(PreprocessSuffix): lib/cobs-c-0.5.0/cobs.c
	$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/lib_cobs-c-0.5.0_cobs.c$(PreprocessSuffix) lib/cobs-c-0.5.0/cobs.c

$(IntermediateDirectory)/src_hid.pb.c$(ObjectSuffix): src/hid.pb.c $(IntermediateDirectory)/src_hid.pb.c$(DependSuffix)
	$(CC) $(SourceSwitch) "/home/drew/src/embedded_testbench/src/hid.pb.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/src_hid.pb.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/src_hid.pb.c$(DependSuffix): src/hid.pb.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/src_hid.pb.c$(ObjectSuffix) -MF$(IntermediateDirectory)/src_hid.pb.c$(DependSuffix) -MM src/hid.pb.c

$(IntermediateDirectory)/src_hid.pb.c$(PreprocessSuffix): src/hid.pb.c
	$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/src_hid.pb.c$(PreprocessSuffix) src/hid.pb.c

$(IntermediateDirectory)/src_ProtoBuff.c$(ObjectSuffix): src/ProtoBuff.c $(IntermediateDirectory)/src_ProtoBuff.c$(DependSuffix)
	$(CC) $(SourceSwitch) "/home/drew/src/embedded_testbench/src/ProtoBuff.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/src_ProtoBuff.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/src_ProtoBuff.c$(DependSuffix): src/ProtoBuff.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/src_ProtoBuff.c$(ObjectSuffix) -MF$(IntermediateDirectory)/src_ProtoBuff.c$(DependSuffix) -MM src/ProtoBuff.c

$(IntermediateDirectory)/src_ProtoBuff.c$(PreprocessSuffix): src/ProtoBuff.c
	$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/src_ProtoBuff.c$(PreprocessSuffix) src/ProtoBuff.c

$(IntermediateDirectory)/src_main.c$(ObjectSuffix): src/main.c $(IntermediateDirectory)/src_main.c$(DependSuffix)
	$(CC) $(SourceSwitch) "/home/drew/src/embedded_testbench/src/main.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/src_main.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/src_main.c$(DependSuffix): src/main.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/src_main.c$(ObjectSuffix) -MF$(IntermediateDirectory)/src_main.c$(DependSuffix) -MM src/main.c

$(IntermediateDirectory)/src_main.c$(PreprocessSuffix): src/main.c
	$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/src_main.c$(PreprocessSuffix) src/main.c

$(IntermediateDirectory)/lib_nanopb-0.3.9.3_pb_encode.c$(ObjectSuffix): lib/nanopb-0.3.9.3/pb_encode.c $(IntermediateDirectory)/lib_nanopb-0.3.9.3_pb_encode.c$(DependSuffix)
	$(CC) $(SourceSwitch) "/home/drew/src/embedded_testbench/lib/nanopb-0.3.9.3/pb_encode.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/lib_nanopb-0.3.9.3_pb_encode.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/lib_nanopb-0.3.9.3_pb_encode.c$(DependSuffix): lib/nanopb-0.3.9.3/pb_encode.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/lib_nanopb-0.3.9.3_pb_encode.c$(ObjectSuffix) -MF$(IntermediateDirectory)/lib_nanopb-0.3.9.3_pb_encode.c$(DependSuffix) -MM lib/nanopb-0.3.9.3/pb_encode.c

$(IntermediateDirectory)/lib_nanopb-0.3.9.3_pb_encode.c$(PreprocessSuffix): lib/nanopb-0.3.9.3/pb_encode.c
	$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/lib_nanopb-0.3.9.3_pb_encode.c$(PreprocessSuffix) lib/nanopb-0.3.9.3/pb_encode.c

$(IntermediateDirectory)/lib_nanopb-0.3.9.3_pb_common.c$(ObjectSuffix): lib/nanopb-0.3.9.3/pb_common.c $(IntermediateDirectory)/lib_nanopb-0.3.9.3_pb_common.c$(DependSuffix)
	$(CC) $(SourceSwitch) "/home/drew/src/embedded_testbench/lib/nanopb-0.3.9.3/pb_common.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/lib_nanopb-0.3.9.3_pb_common.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/lib_nanopb-0.3.9.3_pb_common.c$(DependSuffix): lib/nanopb-0.3.9.3/pb_common.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/lib_nanopb-0.3.9.3_pb_common.c$(ObjectSuffix) -MF$(IntermediateDirectory)/lib_nanopb-0.3.9.3_pb_common.c$(DependSuffix) -MM lib/nanopb-0.3.9.3/pb_common.c

$(IntermediateDirectory)/lib_nanopb-0.3.9.3_pb_common.c$(PreprocessSuffix): lib/nanopb-0.3.9.3/pb_common.c
	$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/lib_nanopb-0.3.9.3_pb_common.c$(PreprocessSuffix) lib/nanopb-0.3.9.3/pb_common.c

$(IntermediateDirectory)/lib_nanopb-0.3.9.3_pb_decode.c$(ObjectSuffix): lib/nanopb-0.3.9.3/pb_decode.c $(IntermediateDirectory)/lib_nanopb-0.3.9.3_pb_decode.c$(DependSuffix)
	$(CC) $(SourceSwitch) "/home/drew/src/embedded_testbench/lib/nanopb-0.3.9.3/pb_decode.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/lib_nanopb-0.3.9.3_pb_decode.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/lib_nanopb-0.3.9.3_pb_decode.c$(DependSuffix): lib/nanopb-0.3.9.3/pb_decode.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/lib_nanopb-0.3.9.3_pb_decode.c$(ObjectSuffix) -MF$(IntermediateDirectory)/lib_nanopb-0.3.9.3_pb_decode.c$(DependSuffix) -MM lib/nanopb-0.3.9.3/pb_decode.c

$(IntermediateDirectory)/lib_nanopb-0.3.9.3_pb_decode.c$(PreprocessSuffix): lib/nanopb-0.3.9.3/pb_decode.c
	$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/lib_nanopb-0.3.9.3_pb_decode.c$(PreprocessSuffix) lib/nanopb-0.3.9.3/pb_decode.c

$(IntermediateDirectory)/src_log.c$(ObjectSuffix): src/log.c $(IntermediateDirectory)/src_log.c$(DependSuffix)
	$(CC) $(SourceSwitch) "/home/drew/src/embedded_testbench/src/log.c" $(CFLAGS) $(ObjectSwitch)$(IntermediateDirectory)/src_log.c$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/src_log.c$(DependSuffix): src/log.c
	@$(CC) $(CFLAGS) $(IncludePath) -MG -MP -MT$(IntermediateDirectory)/src_log.c$(ObjectSuffix) -MF$(IntermediateDirectory)/src_log.c$(DependSuffix) -MM src/log.c

$(IntermediateDirectory)/src_log.c$(PreprocessSuffix): src/log.c
	$(CC) $(CFLAGS) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/src_log.c$(PreprocessSuffix) src/log.c


-include $(IntermediateDirectory)/*$(DependSuffix)
##
## Clean
##
clean:
	$(RM) -r ./Debug/


