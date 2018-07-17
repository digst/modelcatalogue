var config = [

	{
		klassifikationsfil:"https://data.gov.dk/model/core/modeltype.rdf",
		topicNameLocator:"description[lang='da'],dct\\:description[xml\\:lang='da']",
		prefix: "dadk",
		tag:"modelType",
		splitLocation: "/modeltype#",
		kasseoverskrift: "Modeltype",
		boxflex: "ned"
	},			{	
		prefix: "dadk",
		tag:"businessArea",
		kasseoverskrift: "FORMområde",
		boxflex: "ned"
	},			{	
		klassifikationsfil: "https://data.gov.dk/model/core/modellingregime.rdf",
		topicNameLocator:"description[lang='da'],dct\\:description[xml\\:lang='da']",
		prefix: "dadk",
		tag:"modellingRegime",
		splitLocation: "/modellingregime#",
		kasseoverskrift: "Modelleringsregime",
		boxflex: "ned"
	},			{
		klassifikationsfil:"https://data.gov.dk/model/core/modellinglevel.rdf",
		topicNameLocator:"description[lang='da'],dct\\:description[xml\\:lang='da']",
		prefix: "dadk",
		tag:"modellingLevel",
		splitLocation: "/modellinglevel#",
		kasseoverskrift: "Modelleringsniveau",
		boxflex: "ned"
	},	{
		klassifikationsfil:"../xml/data-theme-skos-ap-act.rdf",
		topicNameLocator:"prefLabel[lang='da'],skos\\:prefLabel[xml\\:lang='da']",
		prefix: "dcat",
		tag:"theme",
		splitLocation: "data-theme/",
		kasseoverskrift: "Datatema",
		boxflex: "rod",
		kassetitle: ""
	},			{
		klassifikationsfil:"../xml/theme.da.rdf",
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
