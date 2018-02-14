#!/bin/bash

cat fdata.json | jq '.people | sort_by(.name) | {"people":.}'  > /Users/simeonkakpovi/Documents/hu_webmaster/husb_live_version/go/about/faculty/fdata.json
