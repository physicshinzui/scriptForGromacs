#!/bin/bash

function doesExist {
    local file=$1
    if [ ! -e $file ]; then
        echo "$file does not exist. Stopped." 
        exit
    else 
        echo "$file exists. Proceed." 
    fi  
}