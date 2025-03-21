#!/bin/bash

CONTAINER_DB_NAME="mysqldb"
CONTAINER_APP_NAME="springbootapp"

STATUS=$(docker inspect --format='{{.State.Health.Status}}' $CONTAINER_NAME)

if [ "$STATUS" == "unhealthy" ]; then
    echo "⚠️ WARNING: $CONTAINER_NAME is UNHEALTHY!"
else
    echo "✅ $CONTAINER_NAME is $STATUS"
fi

APP_STATUS=$(docker inspect --format='{{.State.Health.Status}}' $CONTAINER_APP_NAME)

if [ "$APP_STATUS" == "unhealthy" ]; then
    echo "⚠️ WARNING: $CONTAINER_APP_NAME is UNHEALTHY!"
else
    echo "✅ $CONTAINER_APP_NAME is $APP_STATUS"
fi
