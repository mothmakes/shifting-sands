options = [];
logicArea = noone;

options[0] = instance_create_layer(x,y,"GUI",obj_radialGateOption);
options[0].gateType = gateTypes.OR;
options[0].sprite = spr_orGate;
options[1] = instance_create_layer(x,y,"GUI",obj_radialGateOption);
options[1].gateType = gateTypes.AND;
options[1].sprite = spr_andGate;
options[2] = instance_create_layer(x,y,"GUI",obj_radialGateOption);
options[2].gateType = gateTypes.NOT;
options[2].sprite = spr_notGate;

circularDistribute(options,80);

closestOption = noone;

global.PAUSED = true;

selectedType = gateTypes.UNDEFINED;