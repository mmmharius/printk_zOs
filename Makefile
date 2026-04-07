NAME    = printk_zOs.a
CC      = gcc
CFLAGS  = -m32 -Wall -Wextra -Werror -fno-builtin -fno-stack-protector -nostdlib -nodefaultlibs
SRC     = src/printk.c src/ft_puthex.c src/ft_putnbr.c src/ft_putnsigned.c src/ft_putptr.c
OBJ_DIR = obj
OBJ     = $(patsubst src/%.c,$(OBJ_DIR)/%.o,$(SRC))
INCLUDE = -I../includes

GREEN  = \033[0;32m
RED    = \033[0;31m
BLUE   = \033[0;34m
RESET  = \033[0m
BOLD   = \033[1m

define run_cmd
	@printf "  $(BLUE)->$(RESET) %-40s" "$(2)"; \
	if $(1) > /tmp/printk_build.log 2>&1; then \
		printf " $(GREEN)[OK]$(RESET)\n"; \
	else \
		printf " $(RED)[KO]$(RESET)\n"; \
		cat /tmp/printk_build.log; \
		exit 1; \
	fi
endef

define del_path
	@if [ -e "$(1)" ]; then \
		printf "  $(BLUE)->$(RESET) $(RESET)%-40s$(RESET) $(RED)[DELETED]$(RESET)\n" "$(1)"; \
		rm -rf "$(1)"; \
	fi
endef

all: $(NAME)

$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)

$(OBJ_DIR)/%.o: src/%.c | $(OBJ_DIR)
	$(call run_cmd,$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(INCLUDE) -c $< -o $@,cc     $<)

$(NAME): $(OBJ)
	$(call run_cmd,ar rcs $@ $(OBJ),ar     $@)

clean:
	$(call del_path,$(OBJ_DIR))

fclean: clean
	$(call del_path,$(NAME))

re: fclean all

.PHONY: all clean fclean re