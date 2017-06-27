# A simple build script for building projects.
#
# usage: make [CONFIG=debug|release]


SDK = macosx
ARCH = x86_64

CONFIG ?= debug

PRODUCT = 4chan
MODULE_NAME = $(PRODUCT)
SRC = main.swift ./API/*.swift

SWIFTC = swiftc #$(xcrun -f swiftc)
SDK_PATH = $(xcrun --show-sdk-path --sdk $(SDK))

build:
	$(SWIFTC) $(SRC) -o $(PRODUCT)

module:
	mkdir -p $(TARGET_DIR)
	#$(SWIFTC) $(SRC) -emit-executable -sdk $(SDK_PATH) -module-name $(MODULE_NAME) -emit-module -emit-module-path $(TARGET_DIR)/$(MODULE_NAME).swiftmodule -o $(TARGET_DIR)/$(MODULE_NAME)

clean:
	rm -rf $(TARGET_DIR)
