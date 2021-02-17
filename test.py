import socket

addrInfo = socket.getaddrinfo("localhost", None)
for item in addrInfo:
    print(item)

