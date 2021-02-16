import socket

addrInfo = socket.getaddrinfo("github.com", None)
print(addrInfo)
