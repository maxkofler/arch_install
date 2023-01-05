#!/bin/sh

DPI=155

# Scaling on main window manager:
echo "Setting scaling in ~/.Xresources to $DPI dpi"
echo "Xft.dpi: $DPI" >> ~/.Xresources

# Scaling lightdm
echo "Setting scaling in /etc/lightdm/lightdm-gtk-greeter.conf to $DPI dpi"
echo "xft-dpi=$DPI" >> /etc/lightdm/lightdm-gtk-greeter.conf

