#!/bin/sh

bl_device=/sys/class/backlight/amdgpu_bl1/brightness
echo $(($(cat $bl_device)+10)) | tee $bl_device
