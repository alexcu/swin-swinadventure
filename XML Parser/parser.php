<?php 

/**
 * Parses the given XML string with its associative 
 * XSL file, returning a string representation of
 * the HTML
 * @param xml - xml string to parse
 * @return result - HTML respresentation from XSLT process
 */
function parse_xml_from_str($xmlStr, $fileXSL)
{   
    // 1. Load the XML file into a new DOM obj
    $xmlObj = new DOMDocument('1.0');
    $xmlObj->formatOutput = true;
    $xmlObj->loadXML("$xmlStr");
    
    // 2. Load the XSL file into a new DOM obj
    $xslObj = new DOMDocument('1.0');
    $xslObj->load("$fileXSL");
    
    // 3. Create an XSLT parser
    $xsltParser = new XSLTProcessor;
    
    // 4. Load the XSL DOM object into the processor
    $xsltParser->importStyleSheet($xslObj);
    
    // 5. Transform XML document using the XSLT parser
    //    who parses using the XSL stylesheet
    //    Return the parsed results...
    return $xsltParser->transformToXML($xmlObj);
}

if (isset($_POST["input"]))
{
    $input = $_POST["input"];
    mail("1744070@student.swin.edu.au", "Someone Used SwinAdventure Parser!",
         "Here's what they inputted: $input");
    if ($input != "")
        echo parse_xml_from_str($input, "xmlToCpp.xsl");
    else echo "Supply a string!";
}
?>