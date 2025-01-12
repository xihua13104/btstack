# EDIT HERE:
MK_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
CURDIR := $(patsubst %/, %, $(dir $(MK_PATH)))

NORDIC_DFU_IMG_TOOL := $(CURDIR)/tools/nrfutil-linux

C_SOURCES_NORDIC_DFU := $(CURDIR)/port/stm32-f4discovery/nrf_dfu_flash_port.c
C_SOURCES_NORDIC_DFU += $(CURDIR)/src/nrf_dfu_ble.c
C_SOURCES_NORDIC_DFU += $(CURDIR)/src/nrf_dfu.c
C_SOURCES_NORDIC_DFU += $(CURDIR)/src/nrf_dfu_transport.c
C_SOURCES_NORDIC_DFU += $(CURDIR)/src/nrf_dfu_req_handler.c
C_SOURCES_NORDIC_DFU += $(CURDIR)/src/nrf_dfu_settings.c
C_SOURCES_NORDIC_DFU += $(CURDIR)/src/nrf_dfu_utils.c
C_SOURCES_NORDIC_DFU += $(CURDIR)/src/nano-pb/pb_common.c
C_SOURCES_NORDIC_DFU += $(CURDIR)/src/nano-pb/pb_decode.c
C_SOURCES_NORDIC_DFU += $(CURDIR)/src/nano-pb/pb_encode.c
C_SOURCES_NORDIC_DFU += $(CURDIR)/src/dfu-cc.pb.c
C_SOURCES_NORDIC_DFU += $(CURDIR)/src/nrf_dfu_flash.c
C_SOURCES_NORDIC_DFU += $(CURDIR)/src/nrf_dfu_validation.c
C_SOURCES_NORDIC_DFU += $(CURDIR)/src/nrf_dfu_handling_error.c
C_SOURCES_NORDIC_DFU += $(CURDIR)/src/crc32.c

C_INCLUDES_NORDIC_DFU := -I$(CURDIR)/port/stm32-f4discovery
C_INCLUDES_NORDIC_DFU += -I$(CURDIR)/src
C_INCLUDES_NORDIC_DFU += -I$(CURDIR)/src/nano-pb
C_INCLUDES_NORDIC_DFU += -I$(CURDIR)/tools
################################################################################