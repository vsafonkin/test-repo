import socket

addrInfo = socket.getaddrinfo("google.com", None)
for item in addrInfo:
    print(item)

