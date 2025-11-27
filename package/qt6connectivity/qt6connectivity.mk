################################################################################
#
# qt6connectivity
#
################################################################################

QT6CONNECTIVITY_VERSION = $(QT6_VERSION)
QT6CONNECTIVITY_SITE = $(QT6_SITE)
QT6CONNECTIVITY_SOURCE = qtconnectivity-$(QT6_SOURCE_TARBALL_PREFIX)-$(QT6CONNECTIVITY_VERSION).tar.xz
QT6CONNECTIVITY_INSTALL_STAGING = YES
QT6CONNECTIVITY_SUPPORTS_IN_SOURCE_BUILD = NO

QT6CONNECTIVITY_CMAKE_BACKEND = ninja

QT6CONNECTIVITY_LICENSE = \
	GPL-2.0 or GPL-3.0 or LGPL-3.0, \
	GPL-3.0 with Qt GPL exception 1.0 (sdpscanner), \
	BSD-3-Clause (build system, examples), \
	Apache-2.0 (examples), \
	GPL-3.0, GFDL-1.3 no invariants (docs)

QT6CONNECTIVITY_LICENSE_FILES = \
	LICENSES/Apache-2.0.txt \
	LICENSES/BSD-3-Clause.txt \
	LICENSES/GFDL-1.3-no-invariants-only.txt \
	LICENSES/GPL-2.0-only.txt \
	LICENSES/GPL-3.0-only.txt \
	LICENSES/LGPL-3.0-only.txt \
	LICENSES/Qt-GPL-exception-1.0.txt

QT6CONNECTIVITY_CONF_OPTS = \
	-DQT_HOST_PATH=$(HOST_DIR) \
	-DBUILD_WITH_PCH=OFF \
	-DQT_BUILD_EXAMPLES=OFF \
	-DQT_BUILD_TESTS=OFF

QT6CONNECTIVITY_DEPENDENCIES = \
	qt6base

QT6CONNECTIVITY_DEPENDENCIES += $(if $(BR2_PACKAGE_BLUEZ5_UTILS),bluez5_utils)

$(eval $(cmake-package))
