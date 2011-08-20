# KML
# 2011-08-06
#
# based on Ruby/Arduino interface example at 
#  http://www.arduino.cc/playground/Interfacing/Ruby

require 'rubygems'
require 'serialport'

#params for serial port
# port_str = "/dev/tty.usbserial-A900cesN"  # MacBook
port_str = "/dev/ttyUSB0"  # kitchen ubuntu box
baud_rate = 9600
data_bits = 8
stop_bits = 1
parity = SerialPort::NONE

sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)

sp.putc(1);

sp.close

