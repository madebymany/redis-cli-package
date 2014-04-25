REDIS_VERSION := 2.8.9
EXTRACT_DIR := redis-$(REDIS_VERSION)
REDIS_CLI := $(EXTRACT_DIR)/src/redis-cli

all: $(REDIS_CLI)
	
redis.tar.gz:
	curl -LSso "$@" "https://github.com/antirez/redis/archive/$(REDIS_VERSION).tar.gz"

$(EXTRACT_DIR): redis.tar.gz
	tar xf "$<"

$(REDIS_CLI): | $(EXTRACT_DIR)
	$(MAKE) -C "$(EXTRACT_DIR)" redis-cli

install:
	install -m 0755 -o root -g root "$(REDIS_CLI)" /usr/bin/redis-cli

.PHONY: all install
