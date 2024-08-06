# This is a minimal set of ANSI/VT100 color codes
END		=	"\e[0m"
BOLD	=	"\e[1m"
ITALIC	=	"\e[3m"
DIM		=	"\e[2m"
RDIM	=	"\e[22m"

# Colors
GREEN	=	"\e[32m"
PURPLE	=	"\e[35m"
BLUE	=	"\e[36m"
LYELLOW	=	"\e[93m"



## 		OPTIONS 	##

TARGET				= 	liblogger.a
SOURCE_DIR			=	.
OBJECT_DIR			=	objects
HEADER_DIR			=	.
MKDIR				=	mkdir -p
RM					=	rm -rf
PRINT				=	echo

vpath %.c $(SOURCE_DIR)



## PRINTING ##

BUILD_DONE		=	${BOLD}${GREEN}		"=== Building\t\t\t\t"${ITALIC}"DONE !"			${END}
BUILD_PROGRESS	=	${BOLD}${LYELLOW}	"=== Building\t\t\t\t"${ITALIC}"IN PROGRESS"	${END}
CLEAN_BIN		= 	${BOLD}${GREEN}		"=== Cleaning binary\t\t\t\t"${ITALIC}"DONE"	${END}
CLEAN_OBJ		= 	${BOLD}${GREEN}		"=== Cleaning object\t\t\t\t"${ITALIC}"DONE !"	${END}
COMPILING		= 	${BOLD}${PURPLE}	"=== Compiling $<"								${END}



## COMPILER OPTIONS ##

CC			=	gcc
AR			= 	ar rc
CFLAGS		+=	-W -Wall -Wextra
CFLAGS		+=	-I ${HEADER_DIR}
LDFLAGS		=
DEBUG		=	-g3 -p -ggdb3 -DNDEBUG

# Prevents GCC optimizations
RELEASE =  -O0 -fno-builtin



## 	SOURCES FILES 	##

SRC		=	logger.c



## 	OBJECT FILES 	##

OBJ		=	${SRC:%.c=${OBJECT_DIR}/%.o}

${OBJECT_DIR}/%.o : %.c
	@$(MKDIR) $(dir $@)
	@$(CC) -c $< -o $@ ${CFLAGS}
	@$(PRINT) ${COMPILING}



##		RECIPES		##

.PHONY: all re clean fclean
.PHONY: debug redebug

all: CFLAGS += $(RELEASE)
all: ${TARGET}

clean:
	@$(RM) ${OBJECT_DIR}
	@$(PRINT) ${CLEAN_OBJ}

fclean: clean
	@$(RM) ${TARGET}
	@$(RM) *.out
	@$(PRINT) ${CLEAN_BIN}

re: fclean all

debug: CFLAGS += $(DEBUG)
debug: all

redebug: fclean debug

-include $(OBJ:%.o=%.d)



##	FILE GENERATOR	##

$(TARGET): $(OBJ)
	@$(PRINT) ${BUILD_PROGRESS}
	@$(AR) $@ $^
	@$(PRINT) ${BUILD_DONE}
