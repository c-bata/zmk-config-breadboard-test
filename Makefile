CONFIG_DIR = config

SRCS = $(shell find $(CONFIG_DIR) -type f)

TARGET = ./build/zephyr/zmk.uf2

.PHONY: build clean

build: $(TARGET)

$(TARGET): $(SRCS)
	docker exec -w /workspaces/zmk/app -it $(container_name) west build -b seeeduino_xiao_ble -S studio-rpc-usb-uart -- -DSHIELD=konoha -DZMK_CONFIG="/workspaces/zmk-config/config" -DCONFIG_ZMK_STUDIO=y -DCONFIG_ZMK_STUDIO_LOCKING=n

clean:
	docker exec -it $(container_name) rm -rf /workspaces/zmk/app/build