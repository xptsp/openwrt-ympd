#
# Copyright (C) 2020 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ympd
PKG_VERSION:=1.2.3
PKG_RELEASE:=$(PKG_SOURCE_VERSION)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/pacruz/ympd
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=b22b3c44e50eb3c3e8addf06e93653010b6cdcda
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_MAINTAINER:=Douglas Orend <doug.orend2@gmail.com>

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/ympd
    TITLE:=ympd
    SECTION:=utils
    CATEGORY:=Utilities
    URL:=http://ympd.org
    DEPENDS:=+libmpdclient +libpthread +libopenssl
endef

define Package/ympd/description
    MPD Web GUI - written in C, utilizing Websockets and Bootstrap/JS
endef

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)


TARGET_CFLAGS += "-std=gnu99"
TARGET_LDFLAGS += -lpthread -lmpdclient

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	cd $(PKG_BUILD_DIR)
	tar xzf $(DL_DIR)/$(PKG_SOURCE) -C $(BUILD_DIR)
	mkdir -p $(PKG_BUILD_DIR)/build
	cd $(PKG_BUILD_DIR)/build
endef

define Package/ympd/install
	mkdir -p $(1)/usr/bin/
	mkdir -p $(1)/etc/config/
	mkdir -p $(1)/etc/init.d/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/ympd $(1)/usr/bin/
	$(INSTALL_BIN) ./etc/init.d/ympd $(1)/etc/init.d/
	$(INSTALL_DATA) ./etc/config/ympd $(1)/etc/config/

endef

$(eval $(call BuildPackage,ympd))
