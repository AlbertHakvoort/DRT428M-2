#!/usr/bin/env python3
# see https://minimalmodbus.readthedocs.io/en/stable/apiminimalmodbus.html#minimalmodbus.MODE_RTU
import serial
import minimalmodbus
instrument = minimalmodbus.Instrument(port='/dev/ttyUSB0', slaveaddress=1, mode=minimalmodbus.MODE_RTU, close_port_after_each_call=True, debug=False)
instrument.serial.baudrate = 9600           # Baud
instrument.serial.parity   = serial.PARITY_EVEN
instrument.serial.bytesize = 8
instrument.serial.stopbits = 1
instrument.clear_buffers_before_each_transaction = True # False
instrument.serial.timeout  = 0.30           # 0.05 seconds is too fast
 
try:
     ## Read value 
    print('--- read values: ---')
    print('serial number:  ', instrument.read_register(registeraddress=int(0x0000), number_of_decimals=0))
    print('meter ID:       ', instrument.read_register(registeraddress=int(0x0002), number_of_decimals=0))
    print('baud rate [bps] ', instrument.read_register(registeraddress=int(0x0003), number_of_decimals=0))
    print('CT Rate:        ', instrument.read_register(registeraddress=int(0x0008), number_of_decimals=0))
    print('Combined Code:  ', instrument.read_register(registeraddress=int(0x000B), number_of_decimals=0))
    print('Cycletime: [s]  ', instrument.read_register(registeraddress=int(0x000D), number_of_decimals=0))
  
    print('SW version:             ', instrument.read_float( registeraddress=int(0x0004), number_of_registers=2, functioncode=3, byteorder=minimalmodbus.BYTEORDER_BIG) )
    print('HW version:             ', instrument.read_float( registeraddress=int(0x0006), number_of_registers=2, functioncode=3, byteorder=minimalmodbus.BYTEORDER_BIG) )
    print('L1 Voltage [V]          ', instrument.read_float( registeraddress=int(0x000E), number_of_registers=2, functioncode=3, byteorder=minimalmodbus.BYTEORDER_BIG) )
    print('L2 Voltage [V]          ', instrument.read_float( registeraddress=int(0x0010), number_of_registers=2, functioncode=3, byteorder=minimalmodbus.BYTEORDER_BIG) )
    print('L3 Voltage [V]          ', instrument.read_float( registeraddress=int(0x0012), number_of_registers=2, functioncode=3, byteorder=minimalmodbus.BYTEORDER_BIG) )
    print('grid frequency [Hz]     ', instrument.read_float( registeraddress=int(0x0014), number_of_registers=2, functioncode=3, byteorder=minimalmodbus.BYTEORDER_BIG) ) 
    print('L1 Current [A]          ', instrument.read_float( registeraddress=int(0x0016), number_of_registers=2, functioncode=3, byteorder=minimalmodbus.BYTEORDER_BIG) )
    print('L2 Current [A]          ', instrument.read_float( registeraddress=int(0x0018), number_of_registers=2, functioncode=3, byteorder=minimalmodbus.BYTEORDER_BIG) )
    print('L3 Current [A]          ', instrument.read_float( registeraddress=int(0x001A), number_of_registers=2, functioncode=3, byteorder=minimalmodbus.BYTEORDER_BIG) )
    print('TOTAL Active Power[kW]  ', instrument.read_float( registeraddress=int(0x001C), number_of_registers=2, functioncode=3, byteorder=minimalmodbus.BYTEORDER_BIG) )
    print(' L1    Active Power [kW] ', instrument.read_float( registeraddress=int(0x001E), number_of_registers=2, functioncode=3, byteorder=minimalmodbus.BYTEORDER_BIG) )
    print(' L2    Active Power [kW] ', instrument.read_float( registeraddress=int(0x0020), number_of_registers=2, functioncode=3, byteorder=minimalmodbus.BYTEORDER_BIG) )
    print(' L3    Active Power [kW] ', instrument.read_float( registeraddress=int(0x0022), number_of_registers=2, functioncode=3, byteorder=minimalmodbus.BYTEORDER_BIG) )
    print('TOTAL Active Energy [kWh]', instrument.read_float( registeraddress=int(0x0100), number_of_registers=2, functioncode=3, byteorder=minimalmodbus.BYTEORDER_BIG) )
    print(' L1 Total Active Energy[kWh]', instrument.read_float( registeraddress=int(0x0102), number_of_registers=2, functioncode=3, byteorder=minimalmodbus.BYTEORDER_BIG) )
    print(' L2 Total Active Energy[kWh]', instrument.read_float( registeraddress=int(0x0104), number_of_registers=2, functioncode=3, byteorder=minimalmodbus.BYTEORDER_BIG) )
    print(' L3 Total Active Energy[kWh]', instrument.read_float( registeraddress=int(0x0106), number_of_registers=2, functioncode=3, byteorder=minimalmodbus.BYTEORDER_BIG) )
 
except IOError as e:
    print('ERROR: Failed to read from instrument:\n',e)
 
instrument.serial.close()
 
