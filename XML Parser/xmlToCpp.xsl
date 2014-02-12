<?xml version="1.0" encoding="UTF-8"?>
<!-- xmlToCpp for SwinAdventure -->
<!-- Written by Alex Cummaudo 1744070 -->
<!-- PLEASE EXUSE THE MESSY COMMENTS - WAS TRYING TO KEEP OUTPUT IN LINE!! :) -->
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" omit-xml-declaration="yes" indent="no"/>
<xsl:strip-space elements="*"/>

<!-- CamelCasify for all Classes -->
<xsl:template name="CamelCase">
<xsl:param name="text"/>
<xsl:choose>
    <xsl:when test="contains($text,' ')">
        <xsl:call-template name="CamelCaseWord">
            <xsl:with-param name="text" select="substring-before($text,' ')"/>
        </xsl:call-template>
        <xsl:text> </xsl:text>
        <xsl:call-template name="CamelCase">
            <xsl:with-param name="text" select="substring-after($text,' ')"/>
        </xsl:call-template>
    </xsl:when>
<xsl:otherwise>
    <xsl:call-template name="CamelCaseWord">
        <xsl:with-param name="text" select="$text"/>
    </xsl:call-template>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template name="CamelCaseWord">
<xsl:param name="text"/>
<xsl:value-of select="translate(substring($text,1,1),'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')" /><xsl:value-of select="translate(substring($text,2,string-length($text)-1),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')" />
</xsl:template>

<!-- Declare ROOT element to match against: game -->
<xsl:template match="/game">

// Generated using XML to C++ Processor 
// at bit.ly/SwinAdventure

// Forward Declare all Objects
<!-- Forward declare every obj'ed object via for-each -->
<xsl:for-each select="//*[@obj]">
    
    <!-- Class name, capitalised appropriately: Class *id; -->
    <xsl:call-template name="CamelCase"><xsl:with-param name="text"><xsl:value-of select="name()" /></xsl:with-param></xsl:call-template> *<xsl:value-of select="@obj" /> = nullptr;
</xsl:for-each>

/*
 * CREATE ALL ITEMS
 */
<xsl:for-each select="//item">
<!-- Create a bag using id = new Item({"ref-ids"}, "name", "desc"); -->
<xsl:value-of select="./@obj" /> = new Item({<xsl:for-each select="./ref/id">"<xsl:value-of select="."/>"<!-- ref-id for this bag in quotes --><xsl:if test="position() != last()" >,</xsl:if><!-- insert a comma only if not last ref-id -->
</xsl:for-each>},<!-- Name -->"<xsl:value-of select="./@name"/>",<!-- Desc -->"<xsl:value-of select="./@desc"/>");
</xsl:for-each>

/*
 * CREATE ALL BAGS
 */
<xsl:for-each select="//bag">

// New bag
<!-- Create each bag with every one of its ref-ids -->
<!-- Create a bag using id = new Bag({"ref-ids"}, "name", "desc"); -->
<xsl:value-of select="./@obj" /> = new Bag({<xsl:for-each select="./ref/id">"<xsl:value-of select="."/>"<!-- ref-id for this bag in quotes --><xsl:if test="position() != last()" >,</xsl:if><!-- insert a comma only if not last ref-id -->
</xsl:for-each>},<!-- Name -->"<xsl:value-of select="./@name"/>",<!-- Desc -->"<xsl:value-of select="./@desc"/>");
</xsl:for-each>

/*
 * POPULATE ITEMS IN BAGS
 */
<xsl:for-each select="//bag">
<!-- Only make inventory if we're going to add somehting to it! -->
<xsl:if test="count(./inv/item) >= 1">
<!-- Add each item within the inventory to this bag -->
// Add enclosing items to this bag
Inventory *<xsl:value-of select="./@obj"/>_inv = <xsl:value-of select="./@obj"/>->get_inventory();
</xsl:if>
<xsl:for-each select="./inv/item | ./inv/bag">
    <xsl:value-of select="../../@obj"/>_inv->put(<xsl:value-of select="./@obj"/>);
</xsl:for-each>
</xsl:for-each>

/*
 * CREATE ALL LOCATIONS
 */
<xsl:for-each select="//location">

// New location
<!-- Create a bag using id = new Item({"ref-ids"}, "name", "desc"); -->
<xsl:value-of select="./@obj" /> = new Location({<xsl:for-each select="./ref/id">"<xsl:value-of select="."/>"<!-- ref-id for this bag in quotes --><xsl:if test="position() != last()" >,</xsl:if><!-- insert a comma only if not last ref-id -->
</xsl:for-each>},<!-- Name -->"<xsl:value-of select="./@name"/>",<!-- Desc -->"<xsl:value-of select="./@desc"/>");
</xsl:for-each>

/*
 * CREATE ALL PATHS
 */
<xsl:for-each select="//path">
<!-- Create a bag using id = new Item({"ref-ids"}, "name", "desc", dest, true/false); -->
<xsl:value-of select="./@obj" /> = new Path({<xsl:for-each select="./ref/id">"<xsl:value-of select="."/>"<!-- ref-id for this bag in quotes --><xsl:if test="position() != last()" >,</xsl:if><!-- insert a comma only if not last ref-id -->
</xsl:for-each>},<!-- Name -->"<xsl:value-of select="./@name"/>",<!-- Desc -->"<xsl:value-of select="./@desc"/>", <!--dest--><xsl:value-of select="./@dest"/>, <xsl:value-of select="./@bidir"/>);
</xsl:for-each>

/*
 * POPULATE LOCATION PATHS AND INVENTORIES
 */
 <xsl:for-each select="//location">
<!-- Only make inventory if we're going to add somehting to it! -->
<xsl:if test="count(./inv/item) >= 1">
// Add enclosing items to this location
Inventory *<xsl:value-of select="./@obj"/>_inv = <xsl:value-of select="./@obj"/>->get_inventory();
</xsl:if>
<xsl:for-each select="./inv/item">
<xsl:value-of select="../../@obj"/>_inv->put(<xsl:value-of select="./@obj"/>);
</xsl:for-each>
<xsl:for-each select="./inv/path">
    <xsl:value-of select="../../@obj"/>->add_path(<xsl:value-of select="./@obj"/>);
</xsl:for-each>
</xsl:for-each>

/*
 * POPULATE PLAYER INVENTORY
 */
Inventory *player_inv = _player->get_inventory();
<!-- Add all top-level items in <inv> for player -->
<xsl:for-each select="./player/inv/item | ./player/inv/bag">player_inv->put(<xsl:value-of select="./@obj"/>);
</xsl:for-each>

/*
 * SET THE PLAYER'S INITAL LOCATION
 */
_player->set_location(<xsl:value-of select="./player/@location"/>);
</xsl:template>
</xsl:stylesheet>