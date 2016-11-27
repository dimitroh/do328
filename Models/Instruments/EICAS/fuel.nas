var canvasGroup = {};

var canvas_fuel = {
	new: func(canvasGroup)
	{
		var m = { parents: [canvas_fuel] };
		
		var fuelP = canvasGroup;

		var font_mapper = func(family, weight)
		{
			if(family == "'Liberation Sans'" and weight == "normal") {
				return "LiberationFonts/LiberationSans-Regular.ttf";
			}
		};
		
		canvas.parsesvg(canvasGroup, "Aircraft/do328/Models/Instruments/EICAS/fuel.svg", {'font-mapper': font_mapper});
		m["group"] = canvasGroup;
		m["active"] = 0;
		
		var svg_keys = ["indicator_t1","indicator_t2","indicator_t3",
				"indicator_t4","indicator_t5","indicator_t6",
				"readout_t1","readout_t2","readout_t3",
				"readout_t4","readout_t5","readout_t6",
				"warnings"];
		foreach(var key; svg_keys) {
			m[key] = fuelP.getElementById(key);
		}

		for(var n = 1; n<=6; n+=1){
			var center = m["indicator_t"~n].getCenter();
			m["indicator_t"~n].createTransform().setTranslation(-center[0], -center[1]);
			m["indicator_t"~n~"_scale"] = m["indicator_t"~n].createTransform();
			m["indicator_t"~n].createTransform().setTranslation(center[0], center[1]);
		}

		m["warnings"].hide();
		return m;
	},
	slow_update: func()
	{
		var fuel = [	getprop("consumables/fuel/tank[0]/level-lbs"),
				getprop("consumables/fuel/tank[1]/level-lbs"),
				getprop("consumables/fuel/tank[2]/level-lbs"),
				getprop("consumables/fuel/tank[3]/level-lbs"),
				getprop("consumables/fuel/tank[4]/level-lbs"),
				getprop("consumables/fuel/tank[5]/level-lbs")];

		me["readout_t1"].setText(sprintf("%3.0f",fuel[0]));
		me["readout_t2"].setText(sprintf("%3.0f",fuel[1]));
		me["readout_t3"].setText(sprintf("%3.0f",fuel[2]));
		me["readout_t4"].setText(sprintf("%3.0f",fuel[3]));
		me["readout_t5"].setText(sprintf("%3.0f",fuel[4]));
		me["readout_t6"].setText(sprintf("%3.0f",fuel[5]));
		me["indicator_t1_scale"].setScale(1,fuel[0]/187);
		me["indicator_t2_scale"].setScale(1,fuel[1]/1396);
		me["indicator_t3_scale"].setScale(1,fuel[2]/2183);
		me["indicator_t4_scale"].setScale(1,fuel[3]/2183);
		me["indicator_t5_scale"].setScale(1,fuel[4]/1396);
		me["indicator_t6_scale"].setScale(1,fuel[5]/187);

		if(me["active"] == 1) {
			settimer(func me.slow_update(), 0.5);
		}
	},
	show: func()
	{
		me["active"] = 1;
		me.slow_update();
		me["group"].show();
	},
	hide: func()
	{
		me["active"] = 0;
		me["group"].hide();
	}
};
