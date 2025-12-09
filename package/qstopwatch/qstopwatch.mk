QSTOPWATCH_VERSION = 105b01e533d6dc4698e65cfd47c5e95b4b0944e7
QSTOPWATCH_SITE = https://github.com/embetrix/qstopwatch.git
QSTOPWATCH_SITE_METHOD = git

QSTOPWATCH_LICENSE = GPL-3.0+
QSTOPWATCH_LICENSE_FILES = LICENSE

QSTOPWATCH_DEPENDENCIES = \
	host-pkgconf \
	host-qt6tools \
	host-qt6shadertools \
	qt6base \
	qt6declarative \
	qt6svg

define QSTOPWATCH_INSTALL_TARGET_CMDS
	cp $(@D)/qstopwatch $(TARGET_DIR)/usr/bin/qstopwatch
endef

define QSTOPWATCH_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 $(QSTOPWATCH_PKGDIR)/S43qstopwatch \
		$(TARGET_DIR)/etc/init.d/S43qstopwatch
endef

define QSTOPWATCH_INSTALL_INIT_SYSTEMD
	$(INSTALL) -d $(TARGET_DIR)/etc/qstopwatch
	$(INSTALL) -D -m 0644 $(QSTOPWATCH_PKGDIR)/qstopwatch.service \
		$(TARGET_DIR)/usr/lib/systemd/system/qstopwatch.service
endef

$(eval $(cmake-package))
