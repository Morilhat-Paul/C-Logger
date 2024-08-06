/*
** PAUL MORILHAT, 2024
** Logger
** File description:
** logger
*/

#ifndef LOGGER_H_
    #define LOGGER_H_

    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    #define INFO_FILE "INFO.log"
    #define DEBUG_FILE "DEBUG.log"
    #define ERROR_FILE "ERROR.log"
    #define LOG_BUFFER_SIZE 1024
    #define TIMESTAMP_FORMAT "%Y-%m-%d %H:%M:%S"
    #define TIMESTAMP_SIZE 20

typedef enum log_level_s {
    INFO = 0,
    DEBUG,
    ERROR
} log_level_t;

typedef struct logger_s {
    void (*log)(const char *format, ...);
    void (*error)(const char *format, ...);
    void (*debug)(const char *format, ...);
} logger_t;

static void log_message(const char *format, ...);
static void log_error(const char *format, ...);
static void log_debug(const char *format, ...);

extern logger_t logger;

#endif /* LOGGER_H */
