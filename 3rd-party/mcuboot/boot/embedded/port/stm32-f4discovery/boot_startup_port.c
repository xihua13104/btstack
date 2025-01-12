
#include "bootutil/bootutil.h"
#include "bootutil/image.h"
#include "bootutil/bootutil_log.h"
#include "port/boot_startup_port.h"

static void start_app(uint32_t pc, uint32_t sp) {
    if (system_port_is_msp_valid(sp)) {
        system_port_deinit();
        __asm volatile ("MSR msp, %0" : : "r" (sp) : );
        void (*application_reset_handler)(void) = (void *)pc;
        application_reset_handler();
    }
}

static void do_boot(struct boot_rsp *rsp) {
    MCUBOOT_LOG_INF("Starting Main Application");
    MCUBOOT_LOG_INF("Image Start Offset: 0x%x", (int)rsp->br_image_off);

    // We run from internal flash. Base address of this medium is 0x0
    uint32_t vector_table = 0x0 + rsp->br_image_off + rsp->br_hdr->ih_hdr_size;

    uint32_t *app_code = (uint32_t *)vector_table;
    uint32_t app_sp = app_code[0];
    uint32_t app_start = app_code[1];

    MCUBOOT_LOG_INF("Vector Table Start Address: 0x%x. PC=0x%x, SP=0x%x",
    (int)vector_table, app_start, app_sp);

    // We need to move the vector table to reflect the location of the main application
    system_port_remap_vector_table(vector_table);
    start_app(app_start, app_sp);
    while (1) {
      MCUBOOT_LOG_INF("should never get to there!\n");
    }
}

/** Boots firmware at specific address */
void boot_port_startup( struct boot_rsp *rsp )
{
    MCUBOOT_LOG_INF("br_image_off = 0x%x", rsp->br_image_off);
    MCUBOOT_LOG_INF("ih_hdr_size = 0x%x", rsp->br_hdr->ih_hdr_size);
    do_boot(rsp);
}
