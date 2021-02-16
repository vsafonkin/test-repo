import socket

addrInfo = socket.getaddrinfo("jaraco.com", None)
for item in addrInfo
    print(item)

