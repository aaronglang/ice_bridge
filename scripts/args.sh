#!/bin/bash

PARAMS=""
while (( "$#" )); do
  case "$1" in
    -s|--ssid)
      SSID=$2
      shift 2
      ;;
    -p|--password)
      PASS=$2
      shift 2
      ;;
    --) # end argument parsing
      shift
      break
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
  esac
done

