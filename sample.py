import platform
import sys

# print('hello')
# print(platform.system())
# print(platform.release())
# print(platform.version())
# print(sys.version_info)

if sys.version_info >= (3, 10) and platform.system() == 'Linux' and '18.04' in platform.version():
    print('It is true')