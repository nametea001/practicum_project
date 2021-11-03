import usb

####################################


RQ_SET_SERVO_1_OPEN = 0
RQ_SET_SERVO_1_CLOSE = 1
RQ_SET_SERVO_2_OPEN = 2
RQ_SET_SERVO_2_CLOSE = 3
RQ_SET_READ_ULTRA_1 = 4
RQ_SET_READ_ULTRA_2 = 5
RQ_SET_READ_ULTRA_3 = 6
RQ_SET_READ_ULTRA_4 = 7


def find_mcu_boards():
    '''
    Find all Practicum MCU boards attached to the machine, then return a list
    of USB device handles for all the boards

    >>> devices = find_mcu_boards()
    >>> first_board = McuBoard(devices[0])
    '''
    boards = [dev for bus in usb.busses()
              for dev in bus.devices
              if (dev.idVendor, dev.idProduct) == (0x16c0, 0x05dc)]
    return boards

####################################


class McuBoard:
    '''
    Generic class for accessing Practicum MCU board via USB connection.
    '''

    ################################
    def __init__(self, dev):
        self.device = dev
        self.handle = dev.open()

    ################################
    def usb_write(self, request, data=[], index=0, value=0):
        '''
        Send data output to the USB device (i.e., MCU board)
           request: request number to appear as bRequest field on the USB device
           index: 16-bit value to appear as wIndex field on the USB device
           value: 16-bit value to appear as wValue field on the USB device
        '''
        reqType = usb.TYPE_VENDOR | usb.RECIP_DEVICE | usb.ENDPOINT_OUT
        self.handle.controlMsg(
            reqType, request, data, value=value, index=index)

    ################################
    def usb_read(self, request, length=1, index=0, value=0):
        '''
        Request data input from the USB device (i.e., MCU board)
           request: request number to appear as bRequest field on the USB device
           length: number of bytes to read from the USB device
           index: 16-bit value to appear as wIndex field on the USB device
           value: 16-bit value to appear as wValue field on the USB device

        If successful, the method returns a tuple of length specified
        containing data returned from the MCU board.
        '''
        reqType = usb.TYPE_VENDOR | usb.RECIP_DEVICE | usb.ENDPOINT_IN
        buf = self.handle.controlMsg(
            reqType, request, length, value=value, index=index)
        return buf


####################################
class PeriBoard:

    ################################
    def __init__(self, mcu):
        self.mcu = mcu

    def set_servo_1_open(self):
        self.mcu.usb_write(RQ_SET_SERVO_1_OPEN)
        return 0

    def set_servo_1_close(self):
        self.mcu.usb_write(RQ_SET_SERVO_1_CLOSE)
        return 0

    def set_servo_2_open(self):
        self.mcu.usb_write(RQ_SET_SERVO_2_OPEN)
        return 0

    def set_servo_2_close(self):
        self.mcu.usb_write(RQ_SET_SERVO_2_CLOSE)
        return 0

    def read_distance_1(self):
        value = self.mcu.usb_read(RQ_SET_READ_ULTRA_1)
        return value[0]

    def read_distance_2(self):
        value = self.mcu.usb_read(RQ_SET_READ_ULTRA_2)
        return value[0]

    def read_distance_3(self):
        value = self.mcu.usb_read(RQ_SET_READ_ULTRA_3)
        return value[0]

    def read_distance_4(self):
        value = self.mcu.usb_read(RQ_SET_READ_ULTRA_4)
        return value[0]    
