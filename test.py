import socket

addrInfo = socket.getaddrinfo("jaraco.com", None)
print(addrInfo)
