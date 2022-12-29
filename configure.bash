#!/usr/bin/env bash
. .env
JAR_BIN=$(which jar)
JAVAC_BIN=$(which javac)
JAVA_FILES=$(find $MAIN_PATH -type f -name '*.java')
ROOT_PATH=$(realpath .)

LIPMS=$(cat $NAME.lipm)
LIBS=""
for LIPM in ${LIPMS[@]}
do
  JAR_FILE=../$LIPM/$LIPM.jar
  if [ -f "$JAR_FILE" ]; then
    JAR_FILE=$(realpath "$JAR_FILE")
    LIBS="$LIBS:$JAR_FILE"
  fi
done
LIBS=$(echo $LIBS|cut -d ":" -f 2-)
JAVAS=""
for JAVA_FILE in ${JAVA_FILES[@]}
do
  JAVAS="$JAVAS $JAVA_FILE"
done

if [[ "$LIBS" == "" ]]; then
  echo "$JAVAC_BIN --release 8 -sourcepath $MAIN_PATH $JAVAS"
  echo "$JAVAC_BIN --release 8 -sourcepath $MAIN_PATH $JAVAS" > build.sh
  $JAVAC_BIN --release 8 -sourcepath $MAIN_PATH $JAVAS
else
  echo "$JAVAC_BIN --release 8 -sourcepath $MAIN_PATH -cp $LIBS$JAVAS"
  echo "$JAVAC_BIN --release 8 -sourcepath $MAIN_PATH -cp $LIBS$JAVAS" > build.sh
  $JAVAC_BIN --release 8 -sourcepath $MAIN_PATH -cp $LIBS$JAVAS
fi

cd $MAIN_PATH/
CLASS_FILES=$(find . -type f -name '*.class')
CLASSES=""
for CLASS_FILE in ${CLASS_FILES[@]}
do
  CLASS_FILE=$(echo $CLASS_FILE|cut -d / -f 2-)
  CLASSES="$CLASSES '$CLASS_FILE'"
done
eval "rm $CLASSES"

cd $ROOT_PATH
echo "cd $MAIN_PATH" >> build.sh
echo "$JAR_BIN cf $ROOT_PATH/$NAME.jar$CLASSES" >> build.sh
echo "rm $CLASSES" >> build.sh
echo "cd $ROOT_PATH" >> build.sh
