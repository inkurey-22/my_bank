# Compiler
CC = cobc

# Directories
SRCDIR = src
BINDIR = bin

# Files
SOURCES = $(wildcard $(SRCDIR)/*.cbl)
EXECUTABLE = $(BINDIR)/my_bank

# Rules
all: $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	@mkdir -p $(BINDIR)
	$(CC) -Wall -Wextra -x -o $@ $(SOURCES)

run: all
	$(EXECUTABLE)

clean:
	rm -rf $(EXECUTABLE)

fclean: clean

re: fclean all

.PHONY: all clean fclean re