import sysconfig

have_libreadline = sysconfig.get_config_var("HAVE_LIBREADLINE")
print(have_libreadline)

