var config = [

	{
		klassifikationsfil:"../xml/ModelTypes.rdf.xml",
		topicNameLocator:"description[lang='en'],dct\\:description[xml\\:lang='en']",
		prefix: "dadk",
		tag:"modelType",
		splitLocation: "/ModelTypes#",
		kasseoverskrift: "Model type",
		boxflex: "ned"
	},			{	
		prefix: "dadk",
		tag:"businessArea",
		kasseoverskrift: "Business area",
		boxflex: "ned"
	},			{	
		klassifikationsfil: "../xml/ModellingRegimes.rdf.xml",
		topicNameLocator:"description[lang='en'],dct\\:description[xml\\:lang='en']",
		prefix: "dadk",
		tag:"modellingRegime",
		splitLocation: "/ModellingRegimes#",
		kasseoverskrift: "Modelling regimes",
		boxflex: "ned"
	},			{
		klassifikationsfil:"../xml/ModellingLevels.rdf.xml",
		topicNameLocator:"description[lang='en'],dct\\:description[xml\\:lang='en']",
		prefix: "dadk",
		tag:"modellingLevel",
		splitLocation: "/ModellingLevels#",
		kasseoverskrift: "Modelling levels",
		boxflex: "ned"
	},	{
		klassifikationsfil:"../xml/data-theme-skos-ap-act.rdf",
		topicNameLocator:"prefLabel[lang='en'],skos\\:prefLabel[xml\\:lang='en']",
		prefix: "dcat",
		tag:"theme",
		splitLocation: "data-theme/",
		kasseoverskrift: "Data theme",
		boxflex: "rod",
		kassetitle: ""
	},			{
		klassifikationsfil:"../xml/theme.da.rdf",
		topicNameLocator:"title[lang='en'],dct\\:title[xml\\:lang='en']",
		prefix: "dadk",
		tag:"INSPIRETheme",
		splitLocation: "/theme/",
		kasseoverskrift: "INSPIREtheme",
		boxflex: "rod"
	},			{
		prefix: "dcat",
		tag:"keyword",
		kasseoverskrift: "Keywords",
		boxflex: "rod"
	}			
];
