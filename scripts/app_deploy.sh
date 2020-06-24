#!/bin/bash

test ${ROCKET_URL_SERVER:?Env var ROCKET_URL_SERVER not defined}

test ${ROCKET_USER:?Env var ROCKET_USER not defined}

test ${ROCKET_PASS:?Env var ROCKET_PASS not defined}

test ${APP_PATH:?Env var APP_PATH not defined}

deploy_app() {
  cd "${APP_PATH}"
  echo "Deploying rocketchat app from ${APP_PATH} to server: ${ROCKET_URL_SERVER}"
  
  npm install

  output=$(rc-apps deploy --url "${ROCKET_URL_SERVER}" --username "${ROCKET_USER}" --password "${ROCKET_PASS}" --update 2>&1 | grep Error)
 
  case $output in
    *"Missing"*)
        echo "This path: "${APP_PATH}" seems not like a Rocketchat App project. Are you in the right folder ?"
        exit 2 ;;
    *"App that does not currently exist."*)
        rc-apps deploy --url "${ROCKET_URL_SERVER}" --username "${ROCKET_USER}" --password "${ROCKET_PASS}" 
        exit 0 ;;
    *"User does not have the permissions"*)
        echo "user: "${ROCKET_USER}" cannot make deployment in this server" 
        exit 2 ;;
    *"Invalid username and password"*)
        echo "Invalid rocketchat user credentials !"
        exit 2 ;;
    *"Error"*)
        echo $output
        exit 2 ;;
    *)
      echo "App was deployed into Rocketchat Server"
      exit 0 ;;
  esac
}

deploy_app


