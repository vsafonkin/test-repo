import socket

addrInfo = socket.getaddrinfo("github.com", None, family=socket.AF_INET6)
print(addrInfo)
