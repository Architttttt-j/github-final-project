#!/usr/bin/env bash

set -euo pipefail

read -r -p "Principal amount: " principal
read -r -p "Annual rate of interest (%): " rate
read -r -p "Time period (years): " time

if ! interest=$(awk -v principal="$principal" -v rate="$rate" -v time="$time" '
    BEGIN {
        number = "^[0-9]+([.][0-9]+)?$"
        if (principal !~ number || rate !~ number || time !~ number) {
            exit 1
        }
        printf "%.2f", principal * rate * time / 100
    }
'); then
    printf '%s\n' "Please enter non-negative numeric values for all fields." >&2
    exit 1
fi

printf 'Simple interest: %s\n' "$interest"
