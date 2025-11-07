#!/usr/bin/env bash

# Minimal lib.sh for traiage.sh
# Only includes functions actually used by the triage script

set -euo pipefail

# Avoid sourcing this script multiple times
if [[ ${SCRIPTS_LIB_IS_SOURCED:-0} == 1 ]]; then
	return
fi
SCRIPTS_LIB_IS_SOURCED=1

# Check if required commands are available
dependency_check() {
	local dep=$1
	command -v "$dep" >/dev/null
}

# Check multiple dependencies and fail if any are missing
dependencies() {
	local fail=0
	for dep in "$@"; do
		if ! dependency_check "$dep"; then
			log "ERROR: The '$dep' dependency is required, but is not available."
			fail=1
		fi
	done

	if [[ "$fail" == 1 ]]; then
		log
		error "One or more dependencies are not available, check above log output for more details."
	fi
}

# Check if required environment variables are set
requiredenvs() {
	local fail=0
	for env in "$@"; do
		if [[ "${!env:-}" == "" ]]; then
			log "ERROR: The '$env' environment variable is required, but is not set."
			fail=1
		fi
	done

	if [[ "$fail" == 1 ]]; then
		log
		error "One or more required environment variables are not set, check above log output for more details."
	fi
}

# log prints a message to stderr
log() {
	echo "$*" 1>&2
}

# error prints an error message and returns an error exit code
error() {
	log "ERROR: $*"
	exit 1
}