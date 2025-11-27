AUSWEISAPP_VERSION = 52e0547f544da99019edfdb1bdd99a78393bf087
AUSWEISAPP_SITE = https://github.com/Governikus/AusweisApp.git
AUSWEISAPP_SITE_METHOD = git

AUSWEISAPP_LICENSE = EUPL-1.2
AUSWEISAPP_LICENSE_FILES = LICENSE.txt

AUSWEISAPP_SUPPORTS_IN_SOURCE_BUILD = NO

AUSWEISAPP_DEPENDENCIES = \
	host-pkgconf \
	host-qt6tools \
	host-qt6shadertools \
	qt6base \
	qt6declarative \
	qt6svg \
	qt6websockets \
	qt6connectivity \
	qt6scxml \
	neard \
	openssl \
	opensc

AUSWEISAPP_CONF_OPTS = \
	-DBUILD_TESTING=OFF \
	-DQT_DEBUG_FIND_PACKAGE=ON

AUSWEISAPP_CMAKE_BACKEND = ninja

define AUSWEISAPP_INSTALL_INIT_SYSV
	$(INSTALL) -d $(TARGET_DIR)/etc/default
	$(INSTALL) -D -m 0644 $(AUSWEISAPP_PKGDIR)/ausweisapp.default \
		                 $(TARGET_DIR)/etc/default/ausweisapp.default
	$(INSTALL) -D -m 0755 $(AUSWEISAPP_PKGDIR)/S43ausweisapp \
		$(TARGET_DIR)/etc/init.d/S43ausweisapp
endef

define AUSWEISAPP_INSTALL_INIT_SYSTEMD
	$(INSTALL) -d $(TARGET_DIR)/etc/AusweisApp
	$(INSTALL) -D -m 0644 $(AUSWEISAPP_PKGDIR)/ausweisapp.env \
		                 $(TARGET_DIR)/etc/AusweisApp/ausweisapp.env
	$(INSTALL) -D -m 0644 $(AUSWEISAPP_PKGDIR)/ausweisapp.service \
		$(TARGET_DIR)/usr/lib/systemd/system/ausweisapp.service
endef

define AUSWEISAPP_INSTALL_CONF
	$(INSTALL) -d $(TARGET_DIR)/etc/AusweisApp
	$(INSTALL) -D -m 0644 $(AUSWEISAPP_PKGDIR)/AusweisApp2.conf \
		$(TARGET_DIR)/etc/AusweisApp/AusweisApp2.conf
endef

AUSWEISAPP_POST_INSTALL_TARGET_HOOKS += AUSWEISAPP_INSTALL_CONF

$(eval $(cmake-package))
