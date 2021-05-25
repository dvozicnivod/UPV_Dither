# -*- coding: utf-8 -*-
"""
Created on Sat May 15 16:44:25 2021

@author: lazar.janicijevic
"""

serialPort = "COM5"
BR = 460800
num_packets = int(100000/4 + 1);
timeout = 5;

import serial
import time
import matplotlib.pyplot as plt
import numpy as np
        
    
ser = serial.Serial(serialPort, BR, timeout=10)
ser.set_buffer_size(rx_size = 128000, tx_size = 128000)
ser.flush()
print('Waiting for serial packets!')

ser_data = ser.read(num_packets);

if (len(ser_data)<num_packets):
    print('Timed out')
else:
    print('Received packets')
    data = np.array([int(ser_data[i]) for i in range(len(ser_data))])
    
#plt.close('all')
    
    plt.figure()
    plt.plot(data)
ser.close()
