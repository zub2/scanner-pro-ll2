#!/bin/sh

# While this driver probably works for some Ricoh and perhaps also other multifunction
# printers, I'm using is for Philips MFD 6020. So I'm downloading it from their
# website.
# The URL could easily change. If so, just go to philips.com and search for
# the printer, then search for Software and Drivers.
UPSTREAM_URL='http://download.p4c.philips.com/files/l/lff6020_inb/lff6020_inb_dlx_eng.zip'

wget "$UPSTREAM_URL"
