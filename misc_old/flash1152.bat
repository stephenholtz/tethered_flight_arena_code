avrdude -p atxmega128a1 -P COM6 -b 115200 -c avr109 -e -U flash:w:panelcontroller.hex
pause