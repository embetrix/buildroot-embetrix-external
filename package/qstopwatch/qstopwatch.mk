QSTOPWATCH_VERSION = de9573ec39c6bf51dd3d486d3b42058c01090c05
QSTOPWATCH_SITE = https://github.com/embetrix/qstopwatch.git
QSTOPWATCH_SITE_METHOD = git

QSTOPWATCH_LICENSE = GPL-3.0+
QSTOPWATCH_LICENSE_FILES = LICENSE

QSTOPWATCH_DEPENDENCIES = \
	host-pkgconf \
	qt5tools qt5base

define QSTOPWATCH_INSTALL_TARGET_CMDS
	cp $(@D)/qstopwatch $(TARGET_DIR)/usr/bin/qstopwatch
endef

$(eval $(cmake-package))
