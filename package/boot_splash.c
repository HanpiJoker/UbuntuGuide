#include <linux/fb.h>
#include <linux/init.h>
#include <linux/slab.h>
#include <linux/workqueue.h>

#define CONFIG_DISPLAY_FB 0
#define CONFIG_BOOT_PROCESS
#define CONFIG_BOOT_PROCESS_BAR
#define CONFIG_PROCESS_DURATION 15

static struct delayed_work boot_process_work;
static u32 palette[2] = {0x003300, 0x003333};
static void draw_box(int x, int y, int width, int height, int color_index)
{
    struct fb_info* fb;
    struct fb_image process;
    char* data;
    if (color_index >= sizeof(palette) / sizeof(u32)) {
        printk("color_index out of range!\n");
        return;
    }
    data = kmalloc(width * height, GFP_KERNEL);
    memset(data, color_index, width * height);
    process.dx = x;
    process.dy = y;
    process.width = width;
    process.height = height;
    process.data = data;
    process.depth = 8;
    fb = registered_fb[CONFIG_DISPLAY_FB];
    fb->pseudo_palette = palette;
    fb->fbops->fb_imageblit(fb, &process);
    kfree(data);
}

#define PROCESS_BLOCK_NUM 200
static void process_worker(struct work_struct* work)
{
    static unsigned long timestamp;
    static int process_width;
    static int process_height;
    static int block_num_adjust;
    static int block_width;
    static int process_x;
    static int process_y;
    static int step;
    if (registered_fb[CONFIG_DISPLAY_FB] == NULL) {
        printk("Boot process: fb dev not inited, boot process not start!\n");
        return;
    }
    /* fisrt call process_worker, set timestamp as jiffies */
    if (!timestamp) {
        int screen_width;
        int screen_height;
        timestamp = jiffies;
        step = 0;
        screen_width = registered_fb[CONFIG_DISPLAY_FB]->var.xres;
        screen_height = registered_fb[CONFIG_DISPLAY_FB]->var.yres;
        /* draw process bar background */
        process_width = screen_width;
        process_height = screen_height / 24;
        process_x = 0;
        process_y = 400;
        block_width = process_width / PROCESS_BLOCK_NUM;
        block_num_adjust = process_width / block_width;
    } else {
        int i;
        int current_x;
        step++;
        for (i = 0; i < 4; i++) {
            current_x = process_x + block_width * (step - i);
            if (current_x > (process_x + process_width) || current_x < process_x) {
                continue;
            }
            draw_box(current_x, process_y, block_width, process_height, 0);
        }
    }
    if (jiffies - timestamp >= CONFIG_PROCESS_DURATION * HZ) {
        return;
    }
    schedule_delayed_work(&boot_process_work, CONFIG_PROCESS_DURATION * HZ / block_num_adjust);
}
int boot_process_init(void)
{
#if defined CONFIG_BOOT_PROCESS
    INIT_DELAYED_WORK(&boot_process_work, process_worker);
    schedule_delayed_work(&boot_process_work, HZ);
    printk("Boot process: init\n");
#endif
    return 0;
}
fs_initcall(boot_process_init);
