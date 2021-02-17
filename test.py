import socket

addrInfo = socket.getaddrinfo("amazon.com", None)
for item in addrInfo:
    print(item)

