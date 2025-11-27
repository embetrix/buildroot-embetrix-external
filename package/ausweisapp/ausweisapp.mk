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

$(eval $(cmake-package))
