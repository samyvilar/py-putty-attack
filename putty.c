#define PUTTY_DO_GLOBALS

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include <limits.h>
#include <assert.h>
#include <time.h>

#include "putty.h"
#include "ssh.h"

int check_phrase(char *putty_file, char *phrase)
{
   Filename file;
   memset(file.path, '\0', FILENAME_MAX);
   memcpy(file.path, putty_file, strlen(putty_file));

   return (ssh2_load_userkey(&file, phrase, NULL) != SSH2_WRONG_PASSPHRASE);
}