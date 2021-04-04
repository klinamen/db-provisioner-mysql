#!/usr/bin/env bash
set -e

HOST=${HOST:? HOST environemnt variable must be set!}
USERNAME=${USERNAME:? USERNAME environemnt variable must be set!}
PASSWORD=${PASSWORD:? PASSWORD environemnt variable must be set!}

PORT=${PORT:-3306}
TIMEOUT=${TIMEOUT:-30}
SCRIPT_DIR=${SCRIPT_DIR:- /sql}
DATABASE=${DATABASE:-}

./wait-for-it.sh $HOST:$PORT -t $TIMEOUT

COUNT=0

echo "Initialization of database '$DATABASE': START"
for script in `ls $SCRIPT_DIR`;
do
    echo "--- script '$script' on database '$DATABASE': START"
    mysql -h$HOST -P$PORT -u$USERNAME -p$PASSWORD $DATABASE < $SCRIPT_DIR/$script
    echo "--- script '$script' on database '$DATABASE': END"
    COUNT=$COUNT+1
done
echo "Initialization of database '$DATABASE': END"

echo "Total scripts executed: $COUNT"
