var config = [

	{
		klassifikationsfil: "ModellingRegimes.rdf.xml",
		topicNameLocator:"description[lang='da'],dct\\:description[xml\\:lang='da']",
		prefix: "dadk",
		tag:"modellingRegime",
		splitLocation: "/ModellingRegimes#",
		kasseoverskrift: "Modelleringsregime",
		boxflex: "ned"
	},			{
		klassifikationsfil:"ModelTypes.rdf.xml",
		topicNameLocator:"description[lang='da'],dct\\:description[xml\\:lang='da']",
		prefix: "dadk",
		tag:"modelType",
		splitLocation: "/ModelTypes#",
		kasseoverskrift: "Modeltype",
		boxflex: "ned"
	},	{
		prefix: "dadk",
		tag:"businessArea",
		kasseoverskrift: "FORMområde",
		boxflex: "ned"
	},			{
		klassifikationsfil:"ModellingLevels.rdf.xml",
		topicNameLocator:"description[lang='da'],dct\\:description[xml\\:lang='da']",
		prefix: "dadk",
		tag:"modellingLevel",
		splitLocation: "/ModellingLevels#",
		kasseoverskrift: "Modelleringsniveau",
		boxflex: "ned"
	},	{
		klassifikationsfil:"data-theme-skos-ap-act.rdf",
		topicNameLocator:"prefLabel[lang='da'],skos\\:prefLabel[xml\\:lang='da']",
		prefix: "dcat",
		tag:"theme",
		splitLocation: "data-theme/",
		kasseoverskrift: "Datatema",
		boxflex: "rod",
		kassetitle: ""
	},			{
		klassifikationsfil:"theme.da.rdf",
		topicNameLocator:"title[lang='da'],dct\\:title[xml\\:lang='da']",
		prefix: "dadk",
		tag:"INSPIRETheme",
		splitLocation: "/theme/",
		kasseoverskrift: "INSPIREtema",
		boxflex: "rod"
	},			{
		prefix: "dcat",
		tag:"keyword",
		kasseoverskrift: "Nøgleord",
		boxflex: "rod"
	}			
];
