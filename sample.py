import platform
import sys

# print('hello')
# print(platform.system())
# print(platform.release())
# print(platform.version())
print(sys.version_info)

if sys.version_info >= (3, 10):
    print('It is true')