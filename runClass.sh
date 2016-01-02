#!/bin/bash
# 
BASE=$(dirname "$0")/
BASE=$(cd "$BASE" && pwd)
CP="$BASE/bin/"
for JAR in $BASE/lib/*.jar; do
  CP="$CP:$JAR"
done

if test "$1" = "-h"; then
  echo "Usage: ./runClass.sh full.class.name (args..)"
  echo "    or ./runClass.sh -l (search)"
  echo " " Run the script from the project root directory
  echo " " -l lists all available Java applications, optionally filtering
  echo " " " " by the given search parameter
  exit 1
fi

if test -z "$1" -o "$1" = "-l"; then
  test -n "$1" && shift
  ( cd $BASE/src/; grep -l -r "public static void main" . ) | 
    sed -e "s!/!.!g" -e 's/\.java$//' -e 's/^\.\./ /' | sort |
  	if test -z "$1"; then cat; else grep -i "$1"; fi
  exit 1
fi

# When the class is given as a file name, that is converted into a class name by:
# * removing leading "src/", if present
# * removing trailing  ".java", if present
# * replacing any "/" chars with "."
CLASS=$(echo $1 | sed -e "s%^src/%%" -e "s%^bin/%%" -e "s%\\.java\$%%" -e "s%\\.class\$%%" -e "s%/%.%g")
shift

exec java $JAVA_ARGS -classpath "$CP" "$CLASS" "$@"

