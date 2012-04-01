#! /opt/local/bin/python

import commands
import json

f = open('item_locations.json','r')
json_string = f.read()
urls = json.loads(json_string)
for url in urls:
  s = 'wget {0}'.format(url)
  print s
  #commands.getstatusoutput('wget {0}'.format(url))
