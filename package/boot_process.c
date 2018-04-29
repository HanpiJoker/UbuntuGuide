#include <linux/fb.h>
#include <linux/init.h>
#include <linux/string.h>
#include <linux/uaccess.h>
#include <linux/linux_logo.h>
#include <linux/slab.h>
#include <linux/workqueue.h>

#define CONFIG_DISPLAY_FB 0
#define CONFIG_BOOT_ANIMOTION
#define CONFIG_PROCESS_DURATION 15
#define MAX_SIZE 4

static struct delayed_work boot_animotion_work;

static inline unsigned safe_shift(unsigned d, int n)
{
	return n < 0 ? d >> -n : d << n;
}

static void send_logo_to_array (const struct linux_logo *logo_array[])
{
    logo_array[0] = &logo_linux_clut224;
    logo_array[1] = &logo_linux_1_clut224;
    logo_array[2] = &logo_linux_2_clut224;
    logo_array[3] = &logo_linux_3_clut224;
}

static void fb_set_logo_truepalette(struct fb_info *info, const struct linux_logo *logo, u32 *palette)
{
	static const unsigned char mask[] = { 0,0x80,0xc0,0xe0,0xf0,0xf8,0xfc,0xfe,0xff };
	unsigned char redmask, greenmask, bluemask;
	int redshift, greenshift, blueshift;
	int i;
	const unsigned char *clut = logo->clut;

	/*
	 * We have to create a temporary palette since console palette is only
	 * 16 colors long.
	 */
	/* Bug: Doesn't obey msb_right ... (who needs that?) */
	redmask   = mask[info->var.red.length   < 8 ? info->var.red.length   : 8];
	greenmask = mask[info->var.green.length < 8 ? info->var.green.length : 8];
	bluemask  = mask[info->var.blue.length  < 8 ? info->var.blue.length  : 8];
	redshift   = info->var.red.offset   - (8 - info->var.red.length);
	greenshift = info->var.green.offset - (8 - info->var.green.length);
	blueshift  = info->var.blue.offset  - (8 - info->var.blue.length);

    printk("clutsize = %d*****************\n", logo->clutsize);
    printk("logo_width = %d*****************\n", logo->width);
    printk("clut = %d*****************\n", clut[0]);
	for (i = 0; i < logo->clutsize; i++) {
		palette[i+32] = (safe_shift((clut[0] & redmask), redshift) |
				 safe_shift((clut[1] & greenmask), greenshift) |
				 safe_shift((clut[2] & bluemask), blueshift));
		clut += 3;
	}
    clut = NULL;
}

static void draw_logo(const struct linux_logo  *logo)
{
	u32 *palette = NULL;
    u32 *saved_palette = NULL;
    struct fb_info* fb;
    struct fb_image process;

    fb = registered_fb[CONFIG_DISPLAY_FB];

    process.dx = (fb->var.xres - logo->width) / 2;
    process.dy = (fb->var.yres - logo->height) / 2;
    process.width = logo->width;
    process.height = logo->height;
    process.data = logo->data;
    process.depth = 8;

    palette = kmalloc(256 * 4, GFP_KERNEL);
    if (palette == NULL)
        return;

    fb_set_logo_truepalette(fb, logo, palette);
    saved_palette = fb->pseudo_palette;
    fb->pseudo_palette = palette;
    fb->fbops->fb_imageblit(fb, &process);

	if (saved_palette != NULL)
		fb->pseudo_palette = saved_palette;

    kfree(palette);
}

static void animotion_worker(struct work_struct* work)
{
    static unsigned long timestamp;
    const struct linux_logo  *logo;
    const struct linux_logo *logo_array[MAX_SIZE];
    int num = 0;

    /* logo = kmalloc(sizeof(struct linux_logo), GFP_KERNEL); */
    
    /* memcpy(logo, &logo_linux_clut224, sizeof(logo_linux_clut224)); */

    if (registered_fb[CONFIG_DISPLAY_FB] == NULL) {
        printk("Boot process: fb dev not inited, boot process not start!\n");
        return;
    }
    /* fisrt call process_worker, set timestamp as jiffies */
    if (!timestamp) {
        timestamp = jiffies;
        /* send_logo_to_array(logo_array); */
        draw_logo(&logo_linux_2_clut224);
    } else {
        /* linux_logo = logo_array[num++]; */
        draw_logo(logo);
    }
    if (jiffies - timestamp >= CONFIG_PROCESS_DURATION * HZ) {
        return;
    }
    schedule_delayed_work(&boot_animotion_work, CONFIG_PROCESS_DURATION * HZ / 4);
}
int boot_animotion_init(void)
{
#if defined CONFIG_BOOT_ANIMOTION
    INIT_DELAYED_WORK(&boot_animotion_work, animotion_worker);
    schedule_delayed_work(&boot_animotion_work, HZ);
    printk("Boot process: init\n");
#endif
    return 0;
}
fs_initcall(boot_animotion_init);
