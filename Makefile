######################################################################
# User configuration
######################################################################
# Path to nodemcu-uploader (https://github.com/kmpm/nodemcu-uploader)
NODEMCU-UPLOADER=../nodemcu-uploader/nodemcu-uploader.py
# Serial port
PORT=/dev/ttyUSB0
SPEED=115200

NODEMCU-COMMAND=$(NODEMCU-UPLOADER) -b $(SPEED) --start_baud $(SPEED) -p $(PORT) upload

######################################################################
# End of user config
######################################################################
HTTP_FILES := $(wildcard http/*)
LUA_FILES := \
   cfg.htm \
   cfg.lua \
   cfgFile.lua \
   cfgPort.htm \
   cfgSta.lua \
   connect.lua \
   ctl.htm \
   dnsLiar.lua \
   eval.lua \
   fDel.lua \
   fList.lua \
   fLoad.lua \
   fSave.lua \
   fSaveI.lua \
   http.lua \
   ide.htm \
   index.htm \
   init.lua \
   ju.js \
   pState.lua \
   pUpdate.lua \
   ports.json \
   request.lua \
   respFile.lua \
   rs.lua \
   send.lua \
   sendJson.lua \
   uart.htm \

# Print usage
usage:
	@echo "make upload FILE:=<file>  to upload a specific file (i.e make upload FILE:=init.lua)"
	@echo "make upload_http          to upload files to be served"
	@echo "make upload_server        to upload the server code and init.lua"
	@echo "make upload_all           to upload all"
	@echo $(TEST)

# Upload one files only
upload:
	@python $(NODEMCU-COMMAND) $(FILE)

# Upload HTTP files only
upload_http: $(HTTP_FILES)
	@python $(NODEMCU-COMMAND) $(foreach f, $^, $(f))

# Upload httpserver lua files (init and server module)
upload_server: $(LUA_FILES)
	@python $(NODEMCU-COMMAND) $(foreach f, $^, $(f))

# Upload all
upload_all: $(LUA_FILES) $(HTTP_FILES)
	@python $(NODEMCU-COMMAND) $(foreach f, $^, $(f))

