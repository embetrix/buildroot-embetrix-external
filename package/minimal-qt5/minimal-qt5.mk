################################################################################
#
# minimal-qt5
#
################################################################################

MINIMAL_QT5_VERSION = f0f4d1421af6c26aa431854b96563583e0a35eef
MINIMAL_QT5_SITE = https://github.com/embetrix/minimal-qt5.git
MINIMAL_QT5_SITE_METHOD = git

MINIMAL_QT5_LICENSE = GPL-3.0+
MINIMAL_QT5_LICENSE_FILES = LICENSE

MINIMAL_QT5_DEPENDENCIES = \
	host-pkgconf \
	qt5tools qt5base

define MINIMAL_QT5_INSTALL_TARGET_CMDS
	cp $(@D)/minimal-qt5 $(TARGET_DIR)/usr/bin/minimal-qt5
endef

$(eval $(cmake-package))
