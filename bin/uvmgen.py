#!/usr/bin/env python3

import os
import json
from mako.template import Template
from mako.lookup import TemplateLookup

template_paths = ['../mytemplate']
replace_var = {"modname" : "cambridge"}
mylookup = TemplateLookup(directories=template_paths, module_directory='/tmp/mako_modules')

class datamodel():
    def __init__(self):
        self.modname = "cambridge"
        self.protocols = ["ahb","usb","jtag"]
cam = datamodel()
def serve_template(template_name, target_name, dm):
    mytemplate = mylookup.get_template(template_name)
    target_path = os.path.split(target_name)[0]
    if not os.path.exists(target_path):
        os.makedirs(target_path)
    with open (target_name , 'w') as f:
        f.write(mytemplate.render(datamodel=dm))
    print("*** Generate Target File < " + target_name + " > is Done!")
sv_path = "/root/Project/UVM_GEN/verification/tb/agent/"
serve_template('base_test.sv.mako', '../work/base_test.sv', cam)
serve_template('env.sv.mako', '../work/env.sv', cam)
#serve_template('mako_transaction.sv',sv_path + 'my_transaction.sv', **replace_var)
#with open () as f：
#    json.load(f)