# I don't mind auto-load, surprisingly enough.
# If I start debugging, I've probably executed build scripts
# and/or intend to run the program itself locally anyways.
set auto-load safe-path /
set history save on
define hook-quit
save breakpoints .breakpoints
end
