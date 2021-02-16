import socket

addrInfo = socket.getaddrinfo("google.com", None)
print(addrInfo)
