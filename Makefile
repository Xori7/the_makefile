#Config
GAME_NAME = seven
SRC = src
BUILD = build
OBJ = obj
TEST = test
#_Config

CC = clang
C_FLAGS = -g -Wall

LIBS = -L$(VULKAN_SDK)/Lib -lvulkan-1

INCLUDES = -I$(VULKAN_SDK)/Include 

SRC_FILES = $(wildcard $(SRC)/*.c) $(wildcard $(SRC)/**/*.c) $(wildcard $(SRC)/**/**/*.c) $(wildcard $(SRC)/**/**/**/*.c) $(wildcard $(SRC)/**/**/**/**/*.c)

OBJ_FILES = $(patsubst $(SRC)/%.c, $(BUILD)/$(OS)/$(OBJ)/%.o, $(SRC_FILES))

TARGET = $(BUILD)/$(OS)/$(GAME_NAME)

all: $(TARGET)

$(TARGET): $(OBJ_FILES) | $(BUILD)/$(OS)
	$(CC) $(C_FLAGS) -o $@ $^ $(LIBS)

$(BUILD)/$(OS)/$(OBJ)/%.o: $(SRC)/%.c | $(BUILD)/$(OS)/$(OBJ)
	$(CC) -c $< $(C_FLAGS) $(INCLUDES) -o $@

$(BUILD)/$(OS): 
	mkdir -p $(BUILD)/$(OS)

$(BUILD)/$(OS)/$(OBJ): 
	mkdir -p $(BUILD)/$(OS)/$(OBJ)

clean: 
	rm -r $(BUILD)/*

run: all
	./$(TARGET)


.PHONY : all clean

