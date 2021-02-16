import socket

addrInfo = socket.getaddrinfo("jaraco.com", None, family=AF_INET6)
print(addrInfo)
