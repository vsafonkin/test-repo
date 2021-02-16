import socket

addrInfo = socket.getaddrinfo("jaraco.com", None, family=socket.AF_INET6)
print(addrInfo)
