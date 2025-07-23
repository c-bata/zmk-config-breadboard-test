CONFIG_DIR = config

SRCS = $(shell find $(CONFIG_DIR) -type f)

TARGET = ../zmk/app/build/zephyr/zmk.uf2
container_name = $(shell docker ps --format '{{.Image}} {{.Names}}' | grep zmk | awk '{print $$2}')

.PHONY: build clean

build: $(TARGET)

$(TARGET): $(SRCS)
	docker exec -w /workspaces/zmk/app -it $(container_name) west build -b seeeduino_xiao_ble -S zmk-usb-logging -S studio-rpc-usb-uart -- -DSHIELD=coder -DZMK_CONFIG="/workspaces/zmk-config/config" -DCONFIG_ZMK_STUDIO=y -DCONFIG_ZMK_STUDIO_LOCKING=n -DOVERLAY_CONFIG="/workspaces/zmk-config/config/coder.config"

clean:
	docker exec -it $(container_name) rm -rf /workspaces/zmk/app/build