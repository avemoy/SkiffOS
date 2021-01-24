################################################################################
#
# skiff-init-busybox
#
################################################################################

SKIFF_INIT_BUSYBOX_VERSION = 1.33.0
SKIFF_INIT_BUSYBOX_SITE = https://www.busybox.net/downloads
SKIFF_INIT_BUSYBOX_SOURCE = busybox-$(BUSYBOX_VERSION).tar.bz2
SKIFF_INIT_BUSYBOX_LICENSE = GPL-2.0, bzip2-1.0.4
SKIFF_INIT_BUSYBOX_LICENSE_FILES = LICENSE archival/libarchive/bz/LICENSE
SKIFF_INIT_BUSYBOX_CPE_ID_VENDOR = busybox

SKIFF_INIT_BUSYBOX_INSTALL_TARGET = NO
SKIFF_INIT_BUSYBOX_INSTALL_STAGING = NO
SKIFF_INIT_BUSYBOX_INSTALL_IMAGES = YES

SKIFF_INIT_BUSYBOX_CFLAGS = \
	$(TARGET_CFLAGS) -static

SKIFF_INIT_BUSYBOX_LDFLAGS = \
	$(TARGET_LDFLAGS)

# Allows the build system to tweak CFLAGS
SKIFF_INIT_BUSYBOX_MAKE_ENV = \
	$(TARGET_MAKE_ENV) \
	CFLAGS="$(SKIFF_INIT_BUSYBOX_CFLAGS)" \
	CFLAGS_busybox="$(SKIFF_INIT_BUSYBOX_CFLAGS)"; \
	KCONFIG_NOTIMESTAMP=1

SKIFF_INIT_BUSYBOX_MAKE_OPTS = \
	CC="$(TARGET_CC)" \
	ARCH=$(KERNEL_ARCH) \
	PREFIX="$(TARGET_DIR)" \
	EXTRA_LDFLAGS="$(SKIFF_INIT_BUSYBOX_LDFLAGS)" \
	CROSS_COMPILE="$(TARGET_CROSS)" \
	CONFIG_PREFIX="$(TARGET_DIR)"

SKIFF_INIT_BUSYBOX_CONFIG_FILE = $(SKIFF_INIT_BUSYBOX_PKGDIR)/busybox.config
SKIFF_INIT_BUSYBOX_KCONFIG_FILE = $(SKIFF_INIT_BUSYBOX_CONFIG_FILE)
SKIFF_INIT_BUSYBOX_KCONFIG_OPTS = $(SKIFF_INIT_BUSYBOX_MAKE_OPTS)

define SKIFF_INIT_BUSYBOX_BUILD_CMDS
	$(SKIFF_INIT_BUSYBOX_MAKE_ENV) $(MAKE) $(SKIFF_INIT_BUSYBOX_MAKE_OPTS) -C $(@D)
endef

define SKIFF_INIT_BUSYBOX_INSTALL_IMAGES_CMDS
	mkdir -p $(BINARIES_DIR)/skiff-init
	$(INSTALL) -m 755 -D $(@D)/busybox $(BINARIES_DIR)/skiff-init/busybox
endef

$(eval $(kconfig-package))
