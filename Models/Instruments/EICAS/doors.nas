var canvas_group = {};

var canvas_doors = {
	new: func(canvas_group)
	{
		var m = { parents: [canvas_doors] };
		
		var font_mapper = func(family, weight)
		{
			if(family == "Liberation Sans" and weight == "normal") {
				return "LiberationFonts/LiberationSans-Regular.ttf";
			}
		};
		
		canvas.parsesvg(canvas_group, "Aircraft/do328/Models/Instruments/EICAS/doors.svg", {'font-mapper': font_mapper});

		var sk = canvas_group.createChild('group');
		var skInstance = canvas_softkeys.new(sk);
		skInstance.setSoftkeys(["SYSTEM 3/3","OXYGEN","DOORS","","","Next"]);

		return m;
	}
};
