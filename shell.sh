#!/bin/bash

echo "*************************************************************"
echo "You have entered shell access mode."
echo "To exit please enter exit."
echo "If you stuck inside a program, please restart the container."
echo "*************************************************************"

script -B "./.shell_logs/logs" -q

echo "*************************************************************"
echo "You have exited shell access mode."
echo "*************************************************************"