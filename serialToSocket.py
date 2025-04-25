import serial
import socket

# Serial port configuration
serial_port = 'COM3'  # Replace with your serial port
baud_rate = 115200

# Socket configuration
host = '127.0.0.1'  # Localhost
port = 12345        # Choose an available port

try:
    # Initialize serial connection
    ser = serial.Serial(serial_port, baud_rate)
    print(f"Serial port {serial_port} opened successfully.")

    # Initialize socket
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.bind((host, port))
    sock.listen(1)
    print(f"Socket listening on {host}:{port}")

    client_socket, client_address = sock.accept()
    print(f"Accepted connection from {client_address}")

    while True:
        if ser.in_waiting > 0:
            data = ser.read(1)
            # print(f"r {data}")
            client_socket.sendall(data)
            # print(f"s {data}")

except serial.SerialException as e:
    print(f"Error opening serial port: {e}")
except socket.error as e:
    print(f"Socket error: {e}")
except KeyboardInterrupt:
    print("Exiting program")
finally:
    if 'ser' in locals() and ser.is_open:
        ser.close()
        print("Serial port closed")
    if 'client_socket' in locals():
        client_socket.close()
    sock.close()
    print("Socket closed")