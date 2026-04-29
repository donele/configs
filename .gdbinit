# ----- Output behavior -----
set pagination off
set confirm off
set verbose off

# ----- C++ readability -----
set print pretty on
set print object on
set print elements 0
set print demangle on
set print asm-demangle on
set print static-members on
set print vtbl on

# ----- Show more useful info -----
set backtrace limit 50
set history save on
set history filename ~/.gdb_history

# ----- Show source automatically -----
set listsize 20

# ----- Disassemble nicely -----
set disassembly-flavor intel

# ----- Stop on C++ exceptions -----
catch throw
catch catch

# ----- Automatically display instruction when stepping -----
display/i $pc
