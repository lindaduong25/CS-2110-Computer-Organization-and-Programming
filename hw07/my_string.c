/**
 * @file my_string.c
 * @author Linda Duong
 * @brief Your implementation of these famous 3 string.h library functions!
 *
 * NOTE: NO ARRAY NOTATION IS ALLOWED IN THIS FILE
 *
 * @date 2021-06-xx
 */

// DO NOT MODIFY THE INCLUDE(s) LIST
#include <stddef.h>
#include "hw7.h"

/**
 * @brief Calculate the length of a string
 *
 * @param s a constant C string
 * @return size_t the number of characters in the passed in string
 */
size_t my_strlen(const char *s)
{
  /* Note about UNUSED_PARAM
   *
   * UNUSED_PARAM is used to avoid compiler warnings and errors regarding unused function
   * parameters prior to implementing the function. Once you begin implementing this
   * function, you can delete the UNUSED_PARAM lines.
   */
  UNUSED_PARAM(s);

  size_t strlen = 0;
  int i = 0;
  while (*(s + i) != '\0') {
    strlen++;
    i++;
  }
  return strlen;
}

/**
 * @brief Compare two strings
 *
 * @param s1 First string to be compared
 * @param s2 Second string to be compared
 * @param n First (at most) n bytes to be compared
 * @return int "less than, equal to, or greater than zero if s1 (or the first n
 * bytes thereof) is found, respectively, to be less than, to match, or be
 * greater than s2"
 */
int my_strncmp(const char *s1, const char *s2, size_t n)
{
  /* Note about UNUSED_PARAM
   *
   * UNUSED_PARAM is used to avoid compiler warnings and errors regarding unused function
   * parameters prior to implementing the function. Once you begin implementing this
   * function, you can delete the UNUSED_PARAM lines.
   */
  UNUSED_PARAM(s1);
  UNUSED_PARAM(s2);
  UNUSED_PARAM(n);

  size_t i = 0;
  while (i <= n) {
    if (*(s1 + i) - *(s2 + i) == 0) {
      i++;
    } else {
        if (*(s1 + i) - *(s2 + i) > 0) {
          return 1;
        }
        return -1;
      }
    }
    return 0;
}

/**
 * @brief Copy a string
 *
 * @param dest The destination buffer
 * @param src The source to copy from
 * @param n maximum number of bytes to copy
 * @return char* a pointer same as dest
 */
char *my_strncpy(char *dest, const char *src, size_t n)
{
  /* Note about UNUSED_PARAM
   *
   * UNUSED_PARAM is used to avoid compiler warnings and errors regarding unused function
   * parameters prior to implementing the function. Once you begin implementing this
   * function, you can delete the UNUSED_PARAM lines.
   */
  UNUSED_PARAM(dest);
  UNUSED_PARAM(src);
  UNUSED_PARAM(n);

  size_t i = 0;
  for (i = 0; i < n; i++) {
    *(dest + i) = *(src + i);
  }
  return dest;
  //return NULL;
}
