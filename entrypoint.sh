#!/bin/sh

if [ ${#TEAM} -gt 0 ] && [ ${#REPO} -gt 0 ]
then
  python /app/main.py $ACTION --token $TOKEN --names $NAMES --values $VALUES --team $TEAM --templateRepo $TEMPLATE_REPO
else
  python /app/main.py $ACTION --token $TOKEN --names $NAMES --values $VALUES --team $TEAM --templateRepo $TEMPLATE_REPO
fi
