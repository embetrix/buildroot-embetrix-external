################################################################################
#
# stm32mp-sign-tool
#
################################################################################

STM32MP_SIGN_TOOL_VERSION = 1.0.1
STM32MP_SIGN_TOOL_SITE = $(call github,embetrix,stm32mp-sign-tool,$(STM32MP_SIGN_TOOL_VERSION))
STM32MP_SIGN_TOOL_LICENSE = GPL-3.0
STM32MP_SIGN_TOOL_LICENSE_FILES = LICENSE
STM32MP_SIGN_TOOL_CMAKE_BACKEND = ninja
HOST_STM32MP_SIGN_TOOL_DEPENDENCIES = host-pkgconf host-openssl

$(eval $(host-cmake-package))
