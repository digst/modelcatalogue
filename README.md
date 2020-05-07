# modelcatalogue (FDA Modelkataloget)
Dette repositorium indeholder implementeringen af det fællesoffentlige katalog over begrebs- og datamodeller

## Om FDA Modelkataloget
FDA Modelkataloget leverer et katalog over begrebs- og datamodeller udarbejdet i offentligt regi og som er registret med henblik på videndeling og genbrug. Derudover indeholder dette katalog også oplysninger om en række anerkendte internationale modeller som kan have en bred anvendelse i dansk administrativ og fællesoffentlig kontekst. 

**Link til Modelkatalog:** 
https://data.gov.dk/catalogue/models 

Ydeligere beskrivelse vedrørende kataloget kan findes her: 
https://arkitektur.digst.dk/node/610 

## Overordnet arkitekturbeskrivelse
FDA Modelkataloget realiserer et behov for webudstilling af et fællesoffentligt katalog over begrebs- og datamodeller. 

Løsningen består af metadata om modeller (modeldatasæt) samt en transformationsapplikation der konverterer datasættet serialiseret som RDF/XML til HTML.

## Modelmetadataindhold
Modelmetadata distribueres i et maskinlæsbart format (en RDF/XML-fil) på følgende link: https://data.gov.dk/catalogue/models/xml/modelkatalog.rdf.xml

## Datamodellen modelDCAT-AP
Den bagvedliggende datamodel for Modelkataloget udgøres af anvendelsesprofilen modelDCAT-AP som er udarbejdet som en profil af den internationale datakatalogstandard DCAT-AP. https://github.com/digst/modelDCAT-AP
