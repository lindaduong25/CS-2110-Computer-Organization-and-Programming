/**
 * @file hw7.c
 * @author Linda Duong
 * @brief structs, pointers, pointer arithmetic, arrays, strings, and macros
 * @date 2021-10-xx
 */

// DO NOT MODIFY THE INCLUDE(S) LIST
#include <stdio.h>
#include "hw7.h"
#include "my_string.h"

// Global array of pokemon structs
struct pokemon pokedex[MAX_POKEDEX_SIZE];
int size = 0;

/** catchPokemon
 *
 * @brief creates a new pokemon struct and adds it to the array of pokemon structs, "pokedex"
 *
 *
 * @param "nickname" nickname of the pokemon being created and added
 *               NOTE: if the length of the nickname (including the null terminating character)
 *               is above MAX_NICKNAME_SIZE, truncate nickname to MAX_NICKNAME_SIZE. If the length
 *               is below MIN_NICKNAME_SIZE, return FAILURE.
 *
 * @param "pokedexNumber" pokedexNumber of the pokemon being created and added
 * @param "powerLevel" power level of the pokemon being created and added
 * @param "speciesName" species name of the pokemon being created and added
 * @return FAILURE on failure, SUCCESS on success
 *         Failure if any of the following are true:
 *         (1) "nickname" is less than MIN_NICKNAME_SIZE
 *         (2) a pokemon with the same already exits in the array "pokedex"
 *         (3) adding the new pokemon would cause the size of the array "pokedex" to
 *             exceed MAX_POKEDEX_SIZE
 */
int catchPokemon(const char *nickname, int pokedexNumber, double powerLevel, const char *speciesName)
{
   /* Note about UNUSED_PARAM
   *
   * UNUSED_PARAM is used to avoid compiler warnings and errors regarding unused function
   * parameters prior to implementing the function. Once you begin implementing this
   * function, you can delete the UNUSED_PARAM lines.
   */
  UNUSED_PARAM(nickname);
  UNUSED_PARAM(pokedexNumber);
  UNUSED_PARAM(powerLevel);
  UNUSED_PARAM(speciesName);

  if (my_strlen(nickname) < MIN_NICKNAME_SIZE) {
    return FAILURE;
  }

  if (my_strlen(speciesName) < MIN_SPECIESNAME_SIZE) {
    return FAILURE;
  }

  if (size >= MAX_POKEDEX_SIZE) {
    return FAILURE;
  }

  char truncatedName[MAX_NICKNAME_SIZE];
  my_strncpy(truncatedName, nickname, MAX_NICKNAME_SIZE - 1);
  truncatedName[MAX_NICKNAME_SIZE] = '\0';
  if (my_strlen(nickname) + 1 > MAX_NICKNAME_SIZE) {
    my_strncpy(pokedex[size].nickname, truncatedName, MAX_NICKNAME_SIZE);
  } else {
    my_strncpy(pokedex[size].nickname, nickname, MAX_NICKNAME_SIZE);
  }
  pokedex[size].pokedexNumber = pokedexNumber;
  pokedex[size].powerLevel = powerLevel;
  my_strncpy(pokedex[size].speciesName, speciesName, MAX_SPECIESNAME_SIZE);
  for (int i = 0; i < size; i++) {
    if (my_strncmp(pokedex[size].nickname, pokedex[i].nickname, my_strlen(pokedex[size].nickname)) == 0) {
      return FAILURE;
    }
  }
  size++;
  return SUCCESS;
}

/** updatePokemonNickname
 *
 * @brief updates the nickname of an existing pokemon in the array of pokemon structs, "pokedex"
 *
 * @param "s" pokemon struct that exists in the array "pokedex"
 * @param "nickname" new nickname of pokemon "s"
 *               NOTE: if the length of nickname (including the null terminating character)
 *               is above MAX_NICKNAME_SIZE, truncate nickname to MAX_NICKNAME_SIZE
 * @return FAILURE on failure, SUCCESS on success
 *         Failure if any of the following are true:
 *         (1) the pokemon struct "s" can not be found in the array "pokedex"
 */
int updatePokemonNickname(struct pokemon s, const char *nickname)
{
  // UNUSED_PARAM(s);
  // UNUSED_PARAM(nickname);

  // if array is empty
  if (size == 0) {
    return FAILURE;
  }

  int j = 0;
  if (size == 0) {
    return FAILURE;
  }

  for (int i = 0; i <= size; i++) {
    if ((my_strncmp(s.nickname, pokedex[i].nickname, MAX_NICKNAME_SIZE)) == 0) {
      j = i;
      break;
    } else if ((i == (size - 1)) && (my_strncmp(s.nickname, pokedex[i].nickname, MAX_NICKNAME_SIZE)) != 0)  {
      return FAILURE;
    }
  }
  char truncatedName[MAX_NICKNAME_SIZE];
  my_strncpy(truncatedName, nickname, MAX_NICKNAME_SIZE - 1);
  truncatedName[MAX_NICKNAME_SIZE] = '\0';
  if (my_strlen(nickname) + 1 > MAX_NICKNAME_SIZE) {
    my_strncpy(pokedex[j].nickname, truncatedName, MAX_NICKNAME_SIZE);
    return SUCCESS;
  } else {
    my_strncpy(pokedex[j].nickname, nickname, MAX_NICKNAME_SIZE);
    return SUCCESS;
  }
}

/** swapPokemon
 *
 * @brief swaps the position of two pokemon structs in the array of pokemon structs, "pokedex"
 *
 * @param "index1" index of the first pokemon struct in the array "pokedex"
 * @param "index2" index of the second pokemon struct in the array "pokedex"
 * @return FAILURE on failure, SUCCESS on success
 *         Failure if any of the following are true:
 *         (1) "index1" and/or "index2" are negative numbers
 *         (2) "index1" and/or "index2" are out of bounds of the array "pokedex"
 */
int swapPokemon(int index1, int index2)
{
  UNUSED_PARAM(index1);
  UNUSED_PARAM(index2);
  // checking if index 1 and index 2 are negative numbers
  if (index1 < 0 || index2 < 0) {
    return FAILURE;
  }
  // checking for out of bounds
  if (index1 > size - 1 || index2 > size - 1) {
    return FAILURE;
  }
  // deep copy, shallow copying is bad
  // nickname
  // char tempNickname[MAX_NICKNAME_SIZE];
  // my_strncpy(tempNickname, pokedex[index1].nickname, MAX_NICKNAME_SIZE);
  // my_strncpy(pokedex[index1].nickname, pokedex[index2].nickname, MAX_NICKNAME_SIZE);
  // my_strncpy(pokedex[index2].nickname, tempNickname, MAX_NICKNAME_SIZE);
  // // pokedex number
  // int tempNumber = pokedex[index1].pokedexNumber;
  // pokedex[index1].pokedexNumber = pokedex[index2].pokedexNumber;
  // pokedex[index2].pokedexNumber = tempNumber;
  // // powerlevel
  // double tempLevel = pokedex[index1].powerLevel;
  // pokedex[index1].powerLevel = pokedex[index2].powerLevel;
  // pokedex[index2].powerLevel = tempLevel;
  // // speciesName
  // char tempSpeciesName[MAX_NICKNAME_SIZE];
  // my_strncpy(tempSpeciesName, pokedex[index1].speciesName, MAX_SPECIESNAME_SIZE);
  // my_strncpy(pokedex[index1].speciesName, pokedex[index2].speciesName, MAX_SPECIESNAME_SIZE);
  // my_strncpy(pokedex[index2].speciesName, tempSpeciesName, MAX_SPECIESNAME_SIZE);

  struct pokemon poke1;
  struct pokemon poke2;
  poke1 = pokedex[index1];
  poke2 = pokedex[index2];
  pokedex[index1] = poke2;
  pokedex[index2] = poke1;
  return SUCCESS;
}

/** releasePokemon
 *
 * @brief removes pokemon in the array of pokemon structs, "pokedex", that has the same nickname
 *
 * @param "s" pokemon struct that exists in the array "pokedex"
 * @return FAILURE on failure, SUCCESS on success
 *         Failure if any of the following are true:
 *         (1) the pokemon struct "s" can not be found in the array "pokedex"
 */
int releasePokemon(struct pokemon s)
{
  UNUSED_PARAM(s);

  // empty array
  if (size == 0) {
    return FAILURE;
  }
  int i = 0;
  int j = 0;
  for (i = 0; i <= size; i++) {
    if ((my_strncmp(s.nickname, pokedex[i].nickname, MAX_NICKNAME_SIZE)) == 0) {
      j = i;
      break;
    } else if ((i == (size - 1)) && (my_strncmp(s.nickname, pokedex[i].nickname, MAX_NICKNAME_SIZE)) != 0)  {
      return FAILURE;
    }
  }

  for (int k = j; k <= size; k++) {
    pokedex[k] = pokedex[k+1];
  }
  size--;
  return SUCCESS;
}

/** comparePokemon
 *
 * @brief compares the two pokemons' pokedex number and names (using ASCII)
 *
 * @param "s1" pokemon struct that exists in the array "pokedex"
 * @param "s2" pokemon struct that exists in the array "pokedex"
 * @return negative number if s1 is less than s2, positive number if s1 is greater
 *         than s2, and 0 if s1 is equal to s2
 */
int comparePokemon(struct pokemon s1, struct pokemon s2)
{
  UNUSED_PARAM(s1);
  UNUSED_PARAM(s2);
  if (s1.pokedexNumber == s2.pokedexNumber) {
    return (my_strncmp(s1.nickname, s2.nickname, MAX_NICKNAME_SIZE));
  }
  if (s1.pokedexNumber < s2.pokedexNumber) {
    return -1;
  }
  if (s1.pokedexNumber > s2.pokedexNumber) {
    return 1;
  }
  // else s1 = s2
  return 0;
}

/** sortPokemon
 *
 * @brief using the comparePokemon function, sort the pokemons in the array of
 * pokemon structs, "pokedex," by the pokedex number and nicknames
 *
 * @param void
 * @return void
 */
void sortPokemon(void)
{
  for (int i = 0; i <= size; i++) {
    for(int j = 0; j < (size - i - 1); j++) {
      if (comparePokemon(pokedex[j], pokedex[j+1]) > 0) {
        swapPokemon(j, j + 1);
      }
    }
  }
}