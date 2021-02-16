import socket

addrInfo = socket.getaddrinfo("github.com", None, family=AF_INET6)
print(addrInfo)
