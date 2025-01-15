#!/usr/bin/env bash

# customize these
WGET=wget
ICS2ORG=/home/xtremejames1//nixos/dotfiles/scripts/ical2org
ICSFILE1=/home/xtremejames1/calendar/calendar.ics
ICSFILE2=/home/xtremejames1/calendar/classes.ics
ORGFILE1=/home/xtremejames1/org/calendar.org
ORGFILE2=/home/xtremejames1/org/classes.org
URL1=https://calendar.google.com/calendar/ical/xtremejames1%40gmail.com/private-108adfb0e40d02687d03b95232cf4de4/basic.ics
URL2=https://calendar.google.com/calendar/ical/1baa48545a73fd64e9d1a2b04f72be51b1560310ad587a0fcdf689470d8b1c08%40group.calendar.google.com/private-5ba5799a170fac9282a4f022515bcbdb/basic.ics

# no customization needed below

$WGET -O $ICSFILE1 $URL1
$ICS2ORG < $ICSFILE1 > $ORGFILE1

$WGET -O $ICSFILE2 $URL2
$ICS2ORG < $ICSFILE2 > $ORGFILE2
