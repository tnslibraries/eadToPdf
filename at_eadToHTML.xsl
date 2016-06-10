<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:ead="urn:isbn:1-931666-22-9" xmlns:ns2="http://www.w3.org/1999/xlink" exclude-result-prefixes="ead ns2">
    <!--
        *******************************************************************
        *                                                                 *
        * VERSION:          2.00                                          *
        *                                                                 *
        * AUTHOR:           Winona Salesky                                *
        *                   wsalesky@gmail.com                            *
        *                                                                 *
        *                                                                 *
        * ABOUT:           This file has been created for use with        *
        *                  the Archivists' Toolkit  July 30 2008.         *
        *                  this file calls lookupLists.xsl, which         *
        *                  should be located in the same folder.          *
        *                                                                 *
        * UPDATED          Mar. 8, 2016 AJ                                *
        *                  Comlpete rewrite of javascript and             *
        *                  Foundation Styles                              *
        *                                                                 *
        *                  Changed ask us link to digital collections     *
        * UPDATED          Dec. 12, 2015 LH                               *
        *                  Changed links containing /speccoll/ in URL to  *
        *                  /archives/                                     *
        *                  Changed ask us link to digital collections     *
        *                  contact form and replaced old header logo      *
        * UPDATED          Oct. 29, 2014 LH                               *
        *                  Fixed links containing /kellen/ in URL         *
        *                  Fixed link to pdf icon                         *
        * UPDATED          Oct. 7, 2014 LH                                *
        *                  Changed Kellen to NS Archives in breadcrumb    *
        * UPDATED          Nov. 7, 2012 WS                                *
        *                  Suppressed component-level names/subjects      *
        * UPDATED          May 31, 2012                                   *
        *                  Fixed bug with multiple instance display       *
        * UPDATED          June 3, 2009                                   *
        *                  Added additional table cell to component       *
        *                  display to address bug ART-1833, also addressed* 
        *                  problematic container heading displays         *          
        *                                                                 *
        * UPDATED          September 24, 2009                             *
        *                  Added address to publication statement         *
        *                  March 23, 2009                                 *
        *                  Added revision description and date,           * 
        *                  and publication information                    *
        *                  March 12, 2009                                 *
        *                  Fixed character encoding issues                *
        *                  March 11, 2009                                 *
        *                  Added repository branding device to header     *
        *                  March 1, 2009                                  *
        *                  Changed bulk date display for unitdates        *
        *                  Feb. 6, 2009                                   *
        *                  Added roles to creator display in summary      * 
        * ADAPTED          April 29, 2011                                 *
        *                  Adapted for Kellen Design Archives             *        
        *                                                                 *
        *******************************************************************
    -->
    
    <xsl:strip-space elements="*"/>
    <xsl:output indent="yes" method="html" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" encoding="utf-8"/>
    <xsl:include href="reports/Resources/eadToPdf/lookupLists.xsl"/>
<!--    <xsl:include href="lookupLists.xsl"/>-->
    
    <xsl:variable name="id" select="/ead:ead/ead:archdesc/ead:did/ead:unitid"/>
    
    <!-- Creates the body of the finding aid.-->
    <xsl:template match="/">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
                <title>
                    <xsl:value-of select="concat(/ead:ead/ead:eadheader/ead:filedesc/ead:titlestmt/ead:titleproper,' ',/ead:ead/ead:eadheader/ead:filedesc/ead:titlestmt/ead:subtitle)"/>                
                </title>
                <xsl:call-template name="metadata"/>
                <xsl:call-template name="css"/>
                <xsl:call-template name="js"/>
            </head>
            <body>
              <!-- ADDED BANNER AJ 4/31 -->
               
<xsl:call-template name="banner"/>
<xsl:call-template name="nav1"/>
              
              <!-- END BANNER AJ 4/31 -->  
                
                <div id="main">
                   <!-- <xsl:call-template name="header"/> -->
                    <div id="contents">
                    <xsl:call-template name="toc"/>                 
                    <div id="content-right">
                        <xsl:apply-templates select="/ead:ead/ead:eadheader"/>
                        <!-- Arranges archdesc into predefined sections, to change order 
                        or groupings, rearrange templates  -->
                        
                        <!-- Summary Information, summary information includes citation -->
                        <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:did"/>
                        <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:bioghist"/>
                        <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:scopecontent"/>
                        <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:arrangement"/>
                        <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:fileplan"/>
                        
                        <!-- Administrative Information  -->
                        <xsl:if test="/ead:ead/ead:archdesc/ead:accessrestrict or
                            /ead:ead/ead:archdesc/ead:userestrict or
                            /ead:ead/ead:archdesc/ead:custodhist or
                            /ead:ead/ead:archdesc/ead:accruals or
                            /ead:ead/ead:archdesc/ead:altformavail or
                            /ead:ead/ead:archdesc/ead:acqinfo or
                            /ead:ead/ead:archdesc/ead:processinfo or
                            /ead:ead/ead:archdesc/ead:appraisal or
                            /ead:ead/ead:archdesc/ead:originalsloc or /ead:ead/ead:eadheader/ead:filedesc/ead:publicationstmt or /ead:ead/ead:eadheader/ead:revisiondesc">
                            <h3 id="adminInfo">Administrative Information</h3>
                            <xsl:if test="/ead:ead/ead:eadheader/ead:filedesc/ead:titlestmt/ead:author">
                                <p>
                                    <xsl:variable name="myAuthor">
                                        <xsl:call-template name="string-replace-all">
                                            <xsl:with-param name="text" select="/ead:ead/ead:eadheader/ead:filedesc/ead:titlestmt/ead:author"/>
                                            <xsl:with-param name="replace" select="'Finding aid prepared'" />
                                            <xsl:with-param name="by" select="'Collection guide written'" />
                                        </xsl:call-template>
                                    </xsl:variable>  
                                    <xsl:value-of select="$myAuthor"/>
                                </p>                
                            </xsl:if>
                            <xsl:apply-templates select="/ead:ead/ead:eadheader/ead:filedesc/ead:publicationstmt"/>
                            <xsl:apply-templates select="/ead:ead/ead:eadheader/ead:revisiondesc"/>
                            <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:accessrestrict"/>
                            <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:userestrict"/>
                            <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:custodhist"/>
                            <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:accruals"/>
                            <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:acqinfo"/>
                            <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:processinfo"/>
                            <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:appraisal"/>
                            <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:altformavail"/>
                            <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:originalsloc"/>
                            <xsl:call-template name="returnTOC"/>
                        </xsl:if>
                        
                        <!-- Related Materials -->
                        <xsl:if test="/ead:ead/ead:archdesc/ead:relatedmaterial">
                            <h3 id="relMat">Related Materials</h3>
                            
                            <!--<xsl:variable name="myrelatedNoteVar">
                                <xsl:call-template name="string-replace-all">
                                    <xsl:with-param name="text" select="/ead:ead/ead:archdesc/ead:relatedmaterial" />
                                    <xsl:with-param name="replace" select="'Related Archival Materials note'" />
                                    <xsl:with-param name="by" select="''" />
                                </xsl:call-template>
                            </xsl:variable>  
                            <p><xsl:value-of select="$myrelatedNoteVar" /></p>-->

                            <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:relatedmaterial"/>
                            
                            <xsl:call-template name="returnTOC"/>
                        </xsl:if>

                      <xsl:if test="/ead:ead/ead:archdesc/ead:separatedmaterial">
                            <h3 id="sepMat">Separated Materials</h3>
                            
                            <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:separatedmaterial"/>
                            
                            <xsl:call-template name="returnTOC"/>
                        </xsl:if>

                        <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:daogrp"/>
                        <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:dao"/>
                        <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:controlaccess"/>
                        <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:otherfindaid"/>
                        <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:phystech"/>
                        <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:odd"/>       
                        <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:bibliography"/>
                        <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:index"/>
                        <xsl:if test="/ead:ead/ead:archdesc/ead:dsc/child::*">
                            <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:dsc"/>    
                        </xsl:if>
                        
                      <div style="display:table-cell; vertical-align:middle">
<p>Collection Guide Last Updated:  <xsl:value-of select="substring(/ead:ead/ead:eadheader/ead:profiledesc/ead:creation/ead:date, 6 ,2)"/>/<xsl:value-of select="substring(/ead:ead/ead:eadheader/ead:profiledesc/ead:creation/ead:date, 9 ,2)"/>/<xsl:value-of select="substring(/ead:ead/ead:eadheader/ead:profiledesc/ead:creation/ead:date, 1 ,4)"/></p></div>

                      <div class="margin-bottom"><p><a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0; float:left; padding-right:5px;vertical-align: middle;" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a>This collection guide is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.</p></div>

                    </div>
                    </div>    
                </div>

                <xsl:call-template name="footer"/>
            </body>
        </html>
    </xsl:template>

    <!-- CSS for styling HTML output. Place all CSS styles in this template.-->
    <xsl:template name="css">
        <link rel="icon" href="http://beta.library.newschool.edu/assets/img/favicon.ico" type="image/ico" sizes="32x32" />
        <link rel="stylesheet" href="http://beta.library.newschool.edu/assets/css/edu_ac.css" type="text/css" media="screen" />
        <link rel="stylesheet" media="screen" type="text/css" href="http://beta.library.newschool.edu/archives/assets/css/at_branding.css" />
        <link type="text/css" media="print" rel="stylesheet" href="http://beta.library.newschool.edu/archives/assets/css/at_print.css" />
<style>
.series {
font-weight: bold;
color: #000000;
}

.containerHeader {text-align:left;}
.collection {
    font-weight:700;
}

#toc dd{margin-bottom:0px;}

</style>

    </xsl:template>

     <xsl:template name="js">

<script src="//use.typekit.net/wnv5wjy.js">&#160;</script>
<script>try{Typekit.load();}catch(e){}</script>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.js">&#160;</script>
<script src="scripts/jquery.js" type="text/javascript" >&#160;</script>
<script type="text/javascript">
    <![CDATA[
    var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
    document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
    ]]>
</script>

 <!-- 6/9/12 WS: New jquery script to show/hide layers and show/hide all layers -->
    <script type="text/javascript">
           //<![CDATA[
              $(document).ready(function() {
              var showText='More...';
              var hideText='Less...';
                  $('.more').hide();
                  $('.showLink').click( function() {
                    var target = this.id + '-show';
                    var linkid = this.id;
                    // Use ID-selectors to toggle a single element.
                    $('#' + target).toggle();
                    $(this).text($(this).text() == 'More...' ? 'Less..' : 'More...');
                    return false;
                  });
                  
                  $('.showAll').click(function() {
                       $(this).text($(this).text() == '+ Expand all text to enable full keyword searching ' ? '- Hide expanded text to allow for faster scrolling' : '+ Expand all text to enable full keyword searching ');
                       if ($(this).text() == '+ Expand all text to enable full keyword searching ')
                       {
                           $('.showLink').text('More');
                           $('.more').hide();
                       }
                       else
                       {
                           $('.showLink').text('Less');
                           $('.more').show();
                       }
                     });
              });
              //]]>
    </script>
    <script type="text/javascript">
            <xsl:text disable-output-escaping="yes">
                $(function () {
                
                var msie6 = $.browser == 'msie' &amp;&amp; $.browser.version &lt; 7;
                
                if (!msie6) {
                var top = $('#toc').offset().top - parseFloat($('#toc').css('margin-top').replace(/auto/, 0));
                $(window).scroll(function (event) {
                // what the y position of the scroll is
                var y = $(this).scrollTop();
                
                // whether that's below the form
                if (y >= top) {
                // if so, ad the fixed class
                $('#toc').addClass('fixed');
                } else {
                // otherwise remove it
                $('#toc').removeClass('fixed');
                }
                });
                }  
                });
                    
    
        </xsl:text>
        </script>



         </xsl:template>  

    <!-- This template creates a customizable header  -->
    <xsl:template name="header">
        <div id="header"/>
    </xsl:template>

    <!-- HTML meta tags for use by web search engines for indexing. -->
    <xsl:template name="metadata">
        <meta http-equiv="Content-Type" name="dc.title" content="{concat(/ead:ead/ead:eadheader/ead:filedesc/ead:titlestmt/ead:titleproper,' ',/ead:ead/ead:eadheader/ead:filedesc/ead:titlestmt/ead:subtitle)}"/>
        <meta http-equiv="Content-Type" name="dc.author" content="{/ead:ead/ead:archdesc/ead:did/ead:origination}"/>
        <xsl:for-each select="/ead:ead/ead:archdesc/ead:controlaccess/descendant::*">
            <xsl:variable name="myVar">
                <xsl:call-template name="string-replace-all">
                    <xsl:with-param name="text" select="." />
                    <xsl:with-param name="replace" select="'|x'" />
                    <xsl:with-param name="by" select="'--'" />
                </xsl:call-template>
            </xsl:variable>
            <xsl:variable name="myvVar">
                <xsl:call-template name="string-replace-all">
                    <xsl:with-param name="text" select="$myVar" />
                    <xsl:with-param name="replace" select="'|v'" />
                    <xsl:with-param name="by" select="'--'" />
                </xsl:call-template>
            </xsl:variable>
            <xsl:variable name="myyVar">
                <xsl:call-template name="string-replace-all">
                    <xsl:with-param name="text" select="$myvVar" />
                    <xsl:with-param name="replace" select="'|y'" />
                    <xsl:with-param name="by" select="'--'" />
                </xsl:call-template>
            </xsl:variable>
            <xsl:variable name="myzVar">
                <xsl:call-template name="string-replace-all">
                    <xsl:with-param name="text" select="$myyVar" />
                    <xsl:with-param name="replace" select="'|z'" />
                    <xsl:with-param name="by" select="'--'" />
                </xsl:call-template>
            </xsl:variable>         
            <meta http-equiv="Content-Type" name="dc.subject" content="{$myzVar}" />      
        </xsl:for-each>
        <meta http-equiv="Content-Type" name="dc.type" content="text"/>
        <meta http-equiv="Content-Type" name="dc.format" content="manuscripts"/>
        <meta http-equiv="Content-Type" name="dc.format" content="collection guides"/>
    </xsl:template>

    <!-- Creates an ordered table of contents that matches the order of the archdesc 
        elements. To change the order rearrange the if/for-each statements. -->  
    <xsl:template name="toc">      
        <div id="toc">
            <h3>
                <xsl:value-of select="/ead:ead/ead:archdesc/ead:did/ead:unittitle"/>
                <xsl:if test="/ead:ead/ead:archdesc/ead:did/ead:unitdate[@type = 'inclusive']"> <br/>
                <xsl:value-of select="/ead:ead/ead:archdesc/ead:did/ead:unitdate[@type = 'inclusive']"/>
                </xsl:if> 
            </h3>
            <dl>
                <xsl:if test="/ead:ead/ead:archdesc/ead:did">
                    <dt><a href="#{generate-id(.)}">Collection Overview</a></dt>
                </xsl:if>
                <xsl:for-each select="/ead:ead/ead:archdesc/ead:bioghist">
                        <dt>                                
                            <a><xsl:call-template name="tocLinks"/>
                                <xsl:choose>
                                    <xsl:when test="ead:head">
                                        <xsl:value-of select="ead:head"/></xsl:when>
                                    <xsl:otherwise>Biography/History</xsl:otherwise>
                                </xsl:choose>
                            </a>
                        </dt>   
                </xsl:for-each>
                <xsl:for-each select="/ead:ead/ead:archdesc/ead:scopecontent">
                    <dt>                                
                        <a><xsl:call-template name="tocLinks"/>
                            <xsl:choose>
                                <xsl:when test="ead:head">
                                    <xsl:value-of select="ead:head"/></xsl:when>
                                <xsl:otherwise>Scope and Content</xsl:otherwise>
                            </xsl:choose>
                        </a>
                    </dt>   
                </xsl:for-each>
                <xsl:for-each select="/ead:ead/ead:archdesc/ead:arrangement">
                    <dt>                                
                        <a><xsl:call-template name="tocLinks"/>
                            <xsl:choose>
                                <xsl:when test="ead:head">
                                    <xsl:value-of select="ead:head"/></xsl:when>
                                <xsl:otherwise>Arrangement</xsl:otherwise>
                            </xsl:choose>
                        </a>
                    </dt>   
                </xsl:for-each>
                <xsl:for-each select="/ead:ead/ead:archdesc/ead:fileplan">
                    <dt>                                
                        <a><xsl:call-template name="tocLinks"/>
                            <xsl:choose>
                                <xsl:when test="ead:head">
                                    <xsl:value-of select="ead:head"/></xsl:when>
                                <xsl:otherwise>File Plan</xsl:otherwise>
                            </xsl:choose>
                        </a>
                    </dt>   
               </xsl:for-each>
                
                <!-- Administrative Information  -->
                <xsl:if test="/ead:ead/ead:archdesc/ead:accessrestrict or
                    /ead:ead/ead:archdesc/ead:userestrict or
                    /ead:ead/ead:archdesc/ead:custodhist or
                    /ead:ead/ead:archdesc/ead:accruals or
                    /ead:ead/ead:archdesc/ead:altformavail or
                    /ead:ead/ead:archdesc/ead:acqinfo or
                    /ead:ead/ead:archdesc/ead:processinfo or
                    /ead:ead/ead:archdesc/ead:appraisal or
                    /ead:ead/ead:archdesc/ead:originalsloc or /ead:ead/ead:eadheader/ead:filedesc/ead:publicationstmt or /ead:ead/ead:eadheader/ead:revisiondesc">
                    <dt><a href="#adminInfo">Administrative Information</a></dt>
                </xsl:if>
                
                <!-- Related Materials -->
                <xsl:if test="/ead:ead/ead:archdesc/ead:relatedmaterial">
                    <dt><a href="#relMat">Related Materials</a></dt>
                </xsl:if>
                 <xsl:if test="/ead:ead/ead:archdesc/ead:separatedmaterial">
                    <dt><a href="#sepMat">Separated Materials</a></dt>
                </xsl:if>
                <xsl:for-each select="/ead:ead/ead:archdesc/ead:controlaccess">
                    <dt>                                
                        <a><xsl:call-template name="tocLinks"/>
                            <xsl:choose>
                                <xsl:when test="ead:head">
                                    <xsl:value-of select="ead:head"/></xsl:when>
                                <xsl:otherwise>Keywords for Searching Related Subjects</xsl:otherwise>
                            </xsl:choose>
                        </a>
                    </dt>   
                </xsl:for-each>
                <xsl:for-each select="/ead:ead/ead:archdesc/ead:otherfindaid">
                    <dt>                                
                        <a><xsl:call-template name="tocLinks"/>
                            <xsl:choose>
                                <xsl:when test="ead:head">
                                    <xsl:value-of select="ead:head"/></xsl:when>
                                <xsl:otherwise>Other Collection Guides</xsl:otherwise>
                            </xsl:choose>
                        </a>
                    </dt>   
                </xsl:for-each>
                <xsl:for-each select="/ead:ead/ead:archdesc/ead:phystech">
                    <dt>                                
                        <a><xsl:call-template name="tocLinks"/>
                            <xsl:choose>
                                <xsl:when test="ead:head"><xsl:value-of select="ead:head"/></xsl:when>
                                <xsl:otherwise>Technical Requirements</xsl:otherwise>
                            </xsl:choose>
                        </a>
                    </dt>
                </xsl:for-each>
                <xsl:for-each select="/ead:ead/ead:archdesc/ead:odd">
                    <dt>                                
                        <a><xsl:call-template name="tocLinks"/>
                            <xsl:choose>
                                <xsl:when test="ead:head">
                                    <xsl:value-of select="ead:head"/></xsl:when>
                                <xsl:otherwise>Other Descriptive Data</xsl:otherwise>
                            </xsl:choose>
                        </a>
                    </dt>
                </xsl:for-each>
                <xsl:for-each select="/ead:ead/ead:archdesc/ead:bibliography">
                    <dt>                                
                        <a><xsl:call-template name="tocLinks"/>
                            <xsl:choose>
                                <xsl:when test="ead:head">
                                    <xsl:value-of select="ead:head"/></xsl:when>
                                <xsl:otherwise>Bibliography</xsl:otherwise>
                            </xsl:choose>
                        </a>
                    </dt>
                </xsl:for-each>
                <xsl:for-each select="/ead:ead/ead:archdesc/ead:index">
                    <dt>                                
                        <a><xsl:call-template name="tocLinks"/>
                            <xsl:choose>
                                <xsl:when test="ead:head">
                                    <xsl:value-of select="ead:head"/></xsl:when>
                                <xsl:otherwise>Index</xsl:otherwise>
                            </xsl:choose>
                        </a>
                    </dt>
                </xsl:for-each> 
                <xsl:for-each select="/ead:ead/ead:archdesc/ead:dsc">
                    <xsl:if test="child::*">
                        <dt>                                
                            <a><xsl:call-template name="tocLinks"/>
                                <xsl:choose>
                                    <xsl:when test="ead:head">
                                        <xsl:value-of select="ead:head"/></xsl:when>
                                    <xsl:otherwise>Collection Inventory</xsl:otherwise>
                                </xsl:choose>
                            </a>
                        </dt>                
                    </xsl:if>
                    <!--Creates a submenu for collections, record groups and series and fonds-->
                    <xsl:for-each select="child::*[@level = 'collection'] 
                        | child::*[@level = 'recordgrp']  | child::*[@level = 'series'] | child::*[@level = 'fonds']">
                        <dd><a><xsl:call-template name="tocLinks"/>
                            <xsl:choose>
                                <xsl:when test="ead:head">
                                    <xsl:apply-templates select="child::*/ead:head"/>        
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:apply-templates select="child::*/ead:unittitle"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </a></dd>
                        <xsl:for-each select="child::*[@level = 'subcollection'] 
                            | child::*[@level = 'subgrp']  | child::*[@level = 'subseries'] | child::*[@level = 'subfonds']">
                            <dd class="submenu"><a><xsl:call-template name="tocLinks"/>
                                <xsl:choose>
                                    <xsl:when test="ead:head">
                                        <xsl:apply-templates select="child::*/ead:head"/>        
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:apply-templates select="child::*/ead:unittitle"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </a></dd>
                        </xsl:for-each>
                    </xsl:for-each>
                </xsl:for-each>
            </dl>
            <dl>

            <xsl:if test="/ead:ead/ead:archdesc/ead:altformavail">    
            <dd><a class="pdflink"><xsl:attribute name="href">http://digitalarchives.library.newschool.edu/index.php/Detail/collections/<xsl:value-of select="translate(/ead:ead/ead:archdesc/ead:did/ead:unitid,'.','')"/></xsl:attribute>
                <!-- 7/6/11 WS: added /speccoll/kellen to link to pdf icon, icon was not showing up in display -->
                Digital materials <i class="fa fa-external-link">&#160;</i></a>
            </dd>
</xsl:if>
            <dd><a class="pdflink"><xsl:attribute name="href">http://library.newschool.edu/archives/findingaids/pdf/<xsl:value-of select="translate(/ead:ead/ead:archdesc/ead:did/ead:unitid,'.','')"/>.pdf</xsl:attribute>
                <!-- 7/6/11 WS: added /speccoll/kellen to link to pdf icon, icon was not showing up in display -->
               Printable version  <i class="fa fa-file-pdf-o">&#160;</i> </a></dd>
        <dd> <a href="/archives/archives_contact.php">Click here to contact us <i class="fa fa-envelope-o">&#160;</i></a></dd>
</dl>
        </div>
    </xsl:template> 
 
     <!-- Named template for a generic p element with a link back to the table of contents  -->
    <xsl:template name="returnTOC">                     
           <p class="returnTOC"><a href="#N10000">Return to Top »</a></p>
               <hr/> 
    </xsl:template>
        
    <xsl:template name="returnTOCcontainerList">                     
        <p class="returnTOC"><a href="#N10000">Return to Top »</a></p>
    </xsl:template>
    
    <xsl:template match="ead:eadheader">
        <!-- 7/7/11 WS: Added image code from commented out section to ead:header -->
          <xsl:choose>
              <xsl:when test="/ead:ead/ead:archdesc/ead:did/ead:head">
                  <img border="0" style="padding-left:0px; padding-bottom:10px;padding-top:10px;"><xsl:attribute name="src">/archives/findingaids/images/<xsl:value-of select="translate(/ead:ead/ead:archdesc/ead:did/ead:unitid,'.','')"/>.jpg</xsl:attribute></img>
                  <div>
                      <a href="#" class="showAll" style="border:1px solid #000; padding:.5em; font-weight:bold;color:blue">+ Expand all text to enable full keyword searching </a>
                  </div>
                  <h2 id="{generate-id(ead:filedesc/ead:titlestmt/ead:titleproper)}">                   
                    <xsl:value-of select="/ead:ead/ead:archdesc/ead:did/ead:head"/>
                  </h2>
              </xsl:when>
              <xsl:otherwise>
                  <img border="0" style="padding-left:0px; padding-bottom:10px;padding-top:10px;"><xsl:attribute name="src">/archives/findingaids/images/<xsl:value-of select="translate(/ead:ead/ead:archdesc/ead:did/ead:unitid,'.','')"/>.jpg</xsl:attribute></img>
                  <div>
                      <a href="#" class="showAll" style="border:1px solid #000; padding:.5em; font-weight:bold;color:blue">+ Expand all text to enable full keyword searching </a>
                  </div>
                  <h2 id="{generate-id(ead:filedesc/ead:titlestmt/ead:titleproper)}"><b>
                    Guide to the <xsl:apply-templates select="ead:filedesc/ead:titlestmt/ead:titleproper"/>
                 </b> </h2>                  
              </xsl:otherwise>
          </xsl:choose>
        <!-- print subtitle if it exists -->
        <xsl:if test="ead:filedesc/ead:titlestmt/ead:subtitle">
            <h2>
                <xsl:apply-templates select="ead:filedesc/ead:titlestmt/ead:subtitle"/>
            </h2>                
        </xsl:if>
        <h3 style="margin-top">Collection Overview</h3>       
    </xsl:template>
    <xsl:template match="ead:filedesc/ead:titlestmt/ead:titleproper/ead:num"/>
    <xsl:template match="ead:archdesc/ead:did">
        <!-- 7/6/11 NOTE WS:
            This has a h2 nested within the h3.
            Also has some buggy output with ead:titleproper. Moved image code to ead:eadheader template 
            to solve issues            
        <h3>
            <a name="{generate-id(.)}">
                <xsl:choose>
                    <xsl:when test="ead:head">
                        <xsl:value-of select="ead:head"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <img border="0" style="padding-left:0px; padding-bottom:10px;padding-top:10px;"><xsl:attribute name="src">/archives/images/<xsl:value-of select="/ead:ead/ead:archdesc/ead:did/ead:unitid"/>.jpg</xsl:attribute></img>
                        <h2>Guide to the  <xsl:value-of select="/ead:ead/ead:eadheader/ead:filedesc/ead:titlestmt/ead:titleproper"/></h2>
                        <br />Collection Overview
                    </xsl:otherwise>
                </xsl:choose>
            </a>
        </h3>-->
        <!-- Determines the order in wich elements from the archdesc did appear, 
            to change the order of appearance for the children of did
            by changing the order of the following statements. -->
        <dl class="summary"> 
            <xsl:apply-templates select="ead:repository"/>
            <xsl:apply-templates select="ead:origination"/>
            <xsl:apply-templates select="ead:unittitle"/> 
            <!-- <xsl:apply-templates select="ead:unitdate"/> -->
            <!-- <xsl:apply-templates select="ead:unitid"/> -->
            <xsl:apply-templates select="ead:physdesc"/>        
            <xsl:apply-templates select="ead:physloc"/>        
           <!-- <xsl:if test="ead:langmaterial/ead:language[@langcode != 'eng']"> -->
           <xsl:apply-templates select="ead:langmaterial"/>
           <!-- </xsl:if> -->
            <xsl:apply-templates select="ead:materialspec"/>
            <xsl:apply-templates select="ead:container"/>
            <xsl:apply-templates select="ead:abstract"/> 
            <xsl:apply-templates select="ead:note"/>
        </dl>
            <xsl:apply-templates select="../ead:prefercite"/>
        <xsl:call-template name="returnTOC"/>
    </xsl:template>

    <!-- Template calls and formats the children of archdesc/did -->
    <xsl:template match="ead:archdesc/ead:did/ead:repository | ead:archdesc/ead:did/ead:unittitle | ead:archdesc/ead:did/ead:unitid | ead:archdesc/ead:did/ead:origination 
        | ead:archdesc/ead:did/ead:unitdate | ead:archdesc/ead:did/ead:physdesc | ead:archdesc/ead:did/ead:physloc 
        | ead:archdesc/ead:did/ead:abstract | ead:archdesc/ead:did/ead:langmaterial | ead:archdesc/ead:did/ead:materialspec | ead:archdesc/ead:did/ead:container">
        <dt>
            <xsl:choose>          
                <xsl:when test="self::ead:abstract">Summary</xsl:when>
                <xsl:when test="@label">
                    <xsl:value-of select="concat(translate( substring(@label, 1, 1 ),
                        'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' ), 
                        substring(@label, 2, string-length(@label )))"/>
                    <xsl:if test="@type"> [<xsl:value-of select="@type"/>]</xsl:if>
                    
                    <xsl:if test="self::ead:origination">
                        <xsl:choose>
                            <xsl:when test="ead:persname[@role != ''] and contains(ead:persname/@role,' (')">
                                - <xsl:value-of select="substring-before(ead:persname/@role,' (')"/>
                            </xsl:when>
                            <xsl:when test="ead:persname[@role != '']">
                                - <xsl:value-of select="ead:persname/@role"/>  
                            </xsl:when>
                            <xsl:otherwise/>
                        </xsl:choose>
                    </xsl:if>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="self::ead:unitid">ID</xsl:when>
                        <xsl:when test="self::ead:repository">Repository</xsl:when>
                        <xsl:when test="self::ead:unittitle">Title</xsl:when>
						<xsl:when test="self::ead:unitdate">Date</xsl:when>
                        <xsl:when test="self::ead:origination">
                            <xsl:choose>
                                <xsl:when test="ead:persname[@role != ''] and contains(ead:persname/@role,' (')">
                                    Creator - <xsl:value-of select="substring-before(ead:persname/@role,' (')"/>
                                </xsl:when>
                                <xsl:when test="ead:persname[@role != '']">
                                    Creator - <xsl:value-of select="ead:persname/@role"/>  
                                </xsl:when>
                                <xsl:otherwise>
                                    Creator        
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="self::ead:physdesc">Extent</xsl:when>
                        <xsl:when test="self::ead:abstract">Summary</xsl:when>
                        <xsl:when test="self::ead:physloc">Location</xsl:when>
                        <xsl:when test="self::ead:langmaterial">Language</xsl:when>
                        <xsl:when test="self::ead:materialspec">Technical</xsl:when>
                        <xsl:when test="self::ead:container">Container</xsl:when>
                        <xsl:when test="self::ead:note">Note</xsl:when>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </dt>
        <dd><p>
             <!--  Must choose what happens here for title -->
            <xsl:choose>
                <xsl:when test="self::ead:unittitle">
                   <xsl:value-of select="self::ead:unittitle"/><xsl:if test="/ead:ead/ead:archdesc/ead:did/ead:unitdate[@type = 'inclusive']">, </xsl:if><xsl:value-of select="/ead:ead/ead:archdesc/ead:did/ead:unitdate[@type = 'inclusive']"/>
                    <xsl:if test="/ead:ead/ead:archdesc/ead:did/ead:unitdate[@type = 'bulk']">, (<xsl:value-of select="/ead:ead/ead:archdesc/ead:did/ead:unitdate[@type = 'bulk']"/>)       
                    </xsl:if>
                </xsl:when>
                <xsl:otherwise>
                   <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
      </p>  </dd>
    </xsl:template>
    <!-- Template calls and formats all other children of archdesc many of 
        these elements are repeatable within the ead:dsc section as well.-->
    <xsl:template match="ead:bibliography | ead:odd | ead:accruals | ead:arrangement  | ead:bioghist 
        | ead:accessrestrict | ead:userestrict  | ead:custodhist | ead:altformavail | ead:originalsloc 
        | ead:fileplan | ead:acqinfo | ead:otherfindaid | ead:phystech | ead:processinfo | ead:relatedmaterial
        | ead:scopecontent  | ead:separatedmaterial | ead:appraisal | ead:abstract">        
    <!-- ADDED 1/22/11: Added more/less link to show and hide more then one paragraph in a description -->       
        <xsl:choose>
            <xsl:when test="ead:head">
                <!-- 7/13/11 WS: Added choose statement to represe related materials heading -->
                <xsl:choose>
                    <xsl:when test="ead:head[parent::ead:relatedmaterial] | ead:head[parent::ead:separatedmaterial]"/>
                    <xsl:otherwise>
                        <xsl:apply-templates select="ead:head"/>                        
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test="ead:p">
                        <xsl:apply-templates select="ead:p[1]"/>
                        <xsl:if test="count(child::*[not(local-name()='head')]) &gt; 1">
                            <div id="{concat(@id,'More-show')}" class="more">    
                                <xsl:apply-templates select="child::*[not(local-name()='head')][position() &gt; 1]"/>
                            </div>
                            <p><a href="#{concat(@id,'More')}" id="{concat(@id,'More')}" 
                                class="showLink">More...</a></p>
                        </xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="child::*[not(name() ='head')]"/>                        
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="parent::ead:archdesc">
                            <xsl:choose>
                                <xsl:when test="self::ead:bibliography"><h4><xsl:call-template name="anchor"/>Bibliography</h4></xsl:when>
                                <xsl:when test="self::ead:odd"><h4><xsl:call-template name="anchor"/>Other Descriptive Data</h4></xsl:when>
                                <xsl:when test="self::ead:accruals"><h4><xsl:call-template name="anchor"/>Accruals</h4></xsl:when>
                                <xsl:when test="self::ead:arrangement"><h4><xsl:call-template name="anchor"/>Arrangement</h4></xsl:when>
                                <xsl:when test="self::ead:bioghist"><h4><xsl:call-template name="anchor"/>Biography/History</h4></xsl:when>
                                <xsl:when test="self::ead:accessrestrict"><h4><xsl:call-template name="anchor"/>Restrictions on Access</h4></xsl:when>
                                <xsl:when test="self::ead:userestrict"><h4><xsl:call-template name="anchor"/>Restrictions on Use</h4></xsl:when>
                                <xsl:when test="self::ead:custodhist"><h4><xsl:call-template name="anchor"/>Custodial History</h4></xsl:when>
                                <xsl:when test="self::ead:altformavail"><h4><xsl:call-template name="anchor"/>Alternative Form Available</h4></xsl:when>
                                <xsl:when test="self::ead:originalsloc"><h4><xsl:call-template name="anchor"/>Original Location</h4></xsl:when>
                                <xsl:when test="self::ead:fileplan"><h4><xsl:call-template name="anchor"/>File Plan</h4></xsl:when>
                                <xsl:when test="self::ead:acqinfo"><h4><xsl:call-template name="anchor"/>Acquisition Information</h4></xsl:when>
                                <xsl:when test="self::ead:otherfindaid"><h4><xsl:call-template name="anchor"/>Other Collection Guides</h4></xsl:when>
                                <xsl:when test="self::ead:phystech"><h4><xsl:call-template name="anchor"/>Physical Characteristics and Technical Requirements</h4></xsl:when>
                                <xsl:when test="self::ead:processinfo"><h4><xsl:call-template name="anchor"/>Processing Information</h4></xsl:when>
                                <xsl:when test="self::ead:relatedmaterial"><h4><xsl:call-template name="anchor"/>Related Material</h4></xsl:when>
                                <xsl:when test="self::ead:scopecontent"><h4><xsl:call-template name="anchor"/>Scope and Content</h4></xsl:when>
                                <xsl:when test="self::ead:separatedmaterial"><h4><xsl:call-template name="anchor"/>Separated Material</h4></xsl:when>
                                <xsl:when test="self::ead:appraisal"><h4><xsl:call-template name="anchor"/>Appraisal</h4></xsl:when>                        
                            </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <h4><xsl:call-template name="anchor"/>
                            <xsl:choose>
                                <xsl:when test="self::ead:bibliography">Bibliography</xsl:when>
                                <xsl:when test="self::ead:odd">Other Descriptive Data</xsl:when>
                                <xsl:when test="self::ead:accruals">Accruals</xsl:when>
                                <xsl:when test="self::ead:arrangement">Arrangement</xsl:when>
                                <xsl:when test="self::ead:bioghist">Biography/History</xsl:when>
                                <xsl:when test="self::ead:accessrestrict">Restrictions on Access</xsl:when>
                                <xsl:when test="self::ead:userestrict">Restrictions on Use</xsl:when>
                                <xsl:when test="self::ead:custodhist">Custodial History</xsl:when>
                                <xsl:when test="self::ead:altformavail">Alternative Form Available</xsl:when>
                                <xsl:when test="self::ead:originalsloc">Original Location</xsl:when>
                                <xsl:when test="self::ead:fileplan">File Plan</xsl:when>
                                <xsl:when test="self::ead:acqinfo">Acquisition Information</xsl:when>
                                <xsl:when test="self::ead:otherfindaid">Other Collection Guides</xsl:when>
                                <xsl:when test="self::ead:phystech">Physical Characteristics and Technical Requirements</xsl:when>
                                <xsl:when test="self::ead:processinfo">Processing Information</xsl:when>
                                <xsl:when test="self::ead:relatedmaterial">Related Material</xsl:when>
                                <xsl:when test="self::ead:scopecontent">Scope and Content</xsl:when>
                                <xsl:when test="self::ead:separatedmaterial">Separated Material</xsl:when>
                                <xsl:when test="self::ead:appraisal">Appraisal</xsl:when>                       
                            </xsl:choose>
                        </h4>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test="ead:p">
                        <xsl:apply-templates select="ead:p[1]"/>
                        <xsl:if test="count(child::*[not(local-name()='head')]) &gt; 1">
                            <div id="{concat(@id,'More-show')}" class="more">    
                                <xsl:apply-templates select="child::*[not(local-name()='head')][position() &gt; 1]"/>
                            </div>
                            <p><a href="#{concat(@id,'More')}" id="{concat(@id,'More')}" class="showLink">More...</a></p>
                        </xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates/>                        
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
        <!-- If the element is a child of arcdesc then a link to the top is included -->
        <xsl:if test="parent::ead:archdesc">
            <xsl:choose>
                <xsl:when test="self::ead:accessrestrict or self::ead:userestrict or
                    self::ead:custodhist or self::ead:accruals or
                    self::ead:altformavail or self::ead:acqinfo or
                    self::ead:processinfo or self::ead:appraisal or
                    self::ead:originalsloc or  
                    self::ead:relatedmaterial or self::ead:separatedmaterial or self::ead:prefercite"/>
                    <xsl:otherwise>
                         <xsl:call-template name="returnTOC" /> 
                    </xsl:otherwise>
            </xsl:choose>    
        </xsl:if>
    </xsl:template>

    <!-- Templates for publication information  -->
    <xsl:template match="/ead:ead/ead:eadheader/ead:filedesc/ead:publicationstmt">
        <h4>Publication Information</h4>
        <p style=""><xsl:apply-templates select="ead:publisher"/>
            <xsl:if test="ead:date">&#160;-&#160;<xsl:apply-templates select="ead:date"/></xsl:if>
        </p>
          <xsl:if test="ead:address">
            <xsl:apply-templates select="ead:address"/>
        </xsl:if>
    </xsl:template>
    <xsl:template match="ead:address">
        <p>
           <xsl:for-each select="ead:addressline"><xsl:apply-templates select="."/><br/></xsl:for-each>
        </p>
    </xsl:template>
    <!-- Templates for revision description  -->
    <xsl:template match="/ead:ead/ead:eadheader/ead:revisiondesc">
        <h3>Revision Description</h3>
        <p><xsl:if test="ead:change/ead:item"><xsl:apply-templates select="ead:change/ead:item"/></xsl:if><xsl:if test="ead:change/ead:date">&#160;<xsl:apply-templates select="ead:change/ead:date"/></xsl:if></p>        
    </xsl:template>
    
    <!-- Formats controlled access terms -->
    <xsl:template match="ead:controlaccess">
        <xsl:if test="parent::ead:archdesc">
        <xsl:choose>
            <xsl:when test="ead:head"><xsl:apply-templates select="ead:head"/></xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="parent::ead:archdesc"><h3 class="margin-bottom"><xsl:call-template name="anchor"/>Keywords for Searching Related Subjects</h3></xsl:when>
                    <xsl:otherwise><h4 class="margin-bottom">Keywords for Searching Related Subjects</h4></xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="ead:corpname">
            <h4>Corporate Name(s)</h4>
            <ul class="margin-bottom">
                <xsl:for-each select="ead:corpname">
                    <li style="margin-left:20px"><xsl:apply-templates/></li>
                </xsl:for-each>
            </ul>            
        </xsl:if>
        <xsl:if test="ead:famname">
            <h4>Family Name(s)</h4>
            <ul class="margin-bottom ">
                <xsl:for-each select="ead:famname">
                    <li style="margin-left:20px"><xsl:apply-templates/> </li>
                </xsl:for-each>                        
            </ul>
        </xsl:if>
        <xsl:if test="ead:function">
            <h4>Function(s)</h4>
            <ul class="margin-bottom ">
                <xsl:for-each select="ead:function">
                    <li style="margin-left:20px"><xsl:apply-templates/></li>
                </xsl:for-each>                        
            </ul>
        </xsl:if>
        <xsl:if test="ead:genreform">
            <h4>Genre(s)</h4>
            <ul class="margin-bottom">
                <xsl:for-each select="ead:genreform">
                    <li style="margin-left:20px"><xsl:apply-templates/></li>
                </xsl:for-each>
           </ul>     
        </xsl:if>
        <xsl:if test="ead:geogname">
            <h4>Geographic Name(s)</h4>
            <ul class="margin-bottom ">
                <xsl:for-each select="ead:geogname">
                    <li style="margin-left:20px"><xsl:apply-templates/></li>
                </xsl:for-each>                        
            </ul>
        </xsl:if>
        <xsl:if test="ead:occupation">
            <h4>Occupation(s)</h4>
            <ul class="margin-bottom ">
                <xsl:for-each select="ead:occupation">
                    <li style="margin-left:20px"><xsl:apply-templates/></li>
                </xsl:for-each>                        
            </ul>
        </xsl:if>
        <xsl:if test="ead:persname">
            <h4>Personal Name(s)</h4>
            <ul class="margin-bottom ">
                <xsl:for-each select="ead:persname">
                    <li style="margin-left:20px"><xsl:apply-templates/></li>
                </xsl:for-each>                        
            </ul>
        </xsl:if>
        <xsl:if test="ead:subject">
            <h4>Subject(s)</h4>
            <ul style="margin-left:20px" class="margin-bottom">
                <xsl:for-each select="ead:subject">
                <!-- replace MARC subject pipe -->    
                    <li >
                        <xsl:variable name="myVar">
                            <xsl:call-template name="string-replace-all">
                                <xsl:with-param name="text" select="." />
                                <xsl:with-param name="replace" select="'|x'" />
                                <xsl:with-param name="by" select="'--'" />
                            </xsl:call-template>
                        </xsl:variable>
                        <xsl:variable name="myvVar">
                            <xsl:call-template name="string-replace-all">
                                <xsl:with-param name="text" select="$myVar" />
                                <xsl:with-param name="replace" select="'|v'" />
                                <xsl:with-param name="by" select="'--'" />
                            </xsl:call-template>
                        </xsl:variable>
                        <xsl:variable name="myyVar">
                            <xsl:call-template name="string-replace-all">
                                <xsl:with-param name="text" select="$myvVar" />
                                <xsl:with-param name="replace" select="'|y'" />
                                <xsl:with-param name="by" select="'--'" />
                            </xsl:call-template>
                        </xsl:variable>
                        <xsl:variable name="myzVar">
                            <xsl:call-template name="string-replace-all">
                                <xsl:with-param name="text" select="$myyVar" />
                                <xsl:with-param name="replace" select="'|z'" />
                                <xsl:with-param name="by" select="'--'" />
                            </xsl:call-template>
                        </xsl:variable>
                        <xsl:value-of select="$myzVar" />
                        <!-- <xsl:apply-templates/> --> 
                    
                    </li>
                </xsl:for-each>                        
            </ul>
        </xsl:if>
        <xsl:if test="parent::ead:archdesc"><xsl:call-template name="returnTOC"/></xsl:if>
        </xsl:if>
    </xsl:template>

    <!-- Formats index and child elements, groups indexentry elements by type (i.e. corpname, subject...)-->
    <xsl:template match="ead:index">
       <xsl:choose>
           <xsl:when test="ead:head"/>
           <xsl:otherwise>
               <xsl:choose>
                   <xsl:when test="parent::ead:archdesc">
                       <h3><xsl:call-template name="anchor"/>Index</h3>
                   </xsl:when>
                   <xsl:otherwise>
                       <h4><xsl:call-template name="anchor"/>Index</h4>
                   </xsl:otherwise>
               </xsl:choose>    
           </xsl:otherwise>
       </xsl:choose>
       <xsl:apply-templates select="child::*[not(self::ead:indexentry)]"/>
                <xsl:if test="ead:indexentry/ead:corpname">
                    <h4>Corporate Name(s)</h4>
                    <ul class="margin-bottom">
                        <xsl:for-each select="ead:indexentry/ead:corpname">
                            <xsl:sort/>
                            <li><xsl:apply-templates select="."/>: &#160;<xsl:apply-templates select="following-sibling::*"/></li>
                        </xsl:for-each>
                     </ul>   
                </xsl:if>
                <xsl:if test="ead:indexentry/ead:famname">
                    <h4>Family Name(s)</h4>
                    <ul class="margin-bottom">
                        <xsl:for-each select="ead:indexentry/ead:famname">
                            <xsl:sort/>
                            <li><xsl:apply-templates select="."/>: &#160;<xsl:apply-templates select="following-sibling::*"/></li>
                        </xsl:for-each>
                    </ul>    
                </xsl:if>      
                <xsl:if test="ead:indexentry/ead:function">
                    <h4>Function(s)</h4>
                    <ul class="margin-bottom">
                        <xsl:for-each select="ead:indexentry/ead:function">
                            <xsl:sort/>
                            <li><xsl:apply-templates select="."/>: &#160;<xsl:apply-templates select="following-sibling::*"/></li>
                        </xsl:for-each>
                    </ul>
                </xsl:if>
                <xsl:if test="ead:indexentry/ead:genreform">
                    <h4>Genre(s)</h4> 
                    <ul class="margin-bottom">
                        <xsl:for-each select="ead:indexentry/ead:genreform">
                            <xsl:sort/>
                            <li><xsl:apply-templates select="."/>: &#160;<xsl:apply-templates select="following-sibling::*"/></li>
                        </xsl:for-each>           
                    </ul>
                </xsl:if>
                <xsl:if test="ead:indexentry/ead:geogname">
                    <h4>Geographic Name(s)</h4>
                    <ul class="margin-bottom">
                        <xsl:for-each select="ead:indexentry/ead:geogname">
                            <xsl:sort/>
                            <li><xsl:apply-templates select="."/>: &#160;<xsl:apply-templates select="following-sibling::*"/></li>
                        </xsl:for-each>
                    </ul>                    
                </xsl:if>
                <xsl:if test="ead:indexentry/ead:name">
                    <h4>Name(s)</h4>
                    <ul class="margin-bottom">
                        <xsl:for-each select="ead:indexentry/ead:name">
                            <xsl:sort/>
                            <li><xsl:apply-templates select="."/>: &#160;<xsl:apply-templates select="following-sibling::*"/></li>
                        </xsl:for-each>
                    </ul>    
                </xsl:if>
                <xsl:if test="ead:indexentry/ead:occupation">
                    <h4>Occupation(s)</h4> 
                    <ul class="margin-bottom">
                        <xsl:for-each select="ead:indexentry/ead:occupation">
                            <xsl:sort/>
                            <li><xsl:apply-templates select="."/>: &#160;<xsl:apply-templates select="following-sibling::*"/></li>
                        </xsl:for-each>
                    </ul>
                </xsl:if>
                <xsl:if test="ead:indexentry/ead:persname">
                    <h4>Personal Name(s)</h4>
                    <ul class="margin-bottom">
                        <xsl:for-each select="ead:indexentry/ead:persname">
                            <xsl:sort/>
                            <li><xsl:apply-templates select="."/>: &#160;<xsl:apply-templates select="following-sibling::*"/></li>
                        </xsl:for-each>
                    </ul>
                </xsl:if>
                <xsl:if test="ead:indexentry/ead:subject">
                    <h4>Subject(s)</h4> 
                    <ul class="margin-bottom">
                        <xsl:for-each select="ead:indexentry/ead:subject">
                            <xsl:sort/>
                            <li><xsl:apply-templates select="."/>: &#160;<xsl:apply-templates select="following-sibling::*"/></li>
                        </xsl:for-each>
                    </ul>
                </xsl:if>
                <xsl:if test="ead:indexentry/ead:title">
                    <h4>Title(s)</h4>
                    <ul class="margin-bottom">
                        <xsl:for-each select="ead:indexentry/ead:title">
                            <xsl:sort/>
                            <li><xsl:apply-templates select="."/>: &#160;<xsl:apply-templates select="following-sibling::*"/></li>
                        </xsl:for-each>
                    </ul>
                </xsl:if>         
       <xsl:if test="parent::ead:archdesc"><xsl:call-template name="returnTOC"/></xsl:if>
   </xsl:template>
    <xsl:template match="ead:indexentry">
        <dl class="indexEntry">
            <dt><xsl:apply-templates select="child::*[1]"/></dt>
            <dd><xsl:apply-templates select="child::*[2]"/></dd>    
        </dl>
    </xsl:template>
    <xsl:template match="ead:ptrgrp">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- Linking elements. -->
    <xsl:template match="ead:ptr">
        <xsl:choose>
            <xsl:when test="@target">
                <a href="#{@target}"><xsl:value-of select="@target"/></a>
                <xsl:if test="following-sibling::ead:ptr">, </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="ead:ref">
        <xsl:choose>
            <xsl:when test="@target">
                <a href="#{@target}">
                    <xsl:apply-templates/>
                </a>
                <xsl:if test="following-sibling::ead:ref">, </xsl:if>
            </xsl:when>
            <xsl:when test="@ns2:href">
                <a href="#{@ns2:href}">
                    <xsl:apply-templates/>
                </a>
                <xsl:if test="following-sibling::ead:ref">, </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>    
    <xsl:template match="ead:extptr">
        <xsl:choose>
            <xsl:when test="@href">
                <a href="{@href}"><xsl:value-of select="@title"/></a>
            </xsl:when>
            <xsl:when test="@ns2:href"><a href="{@ns2:href}"><xsl:value-of select="@title"/></a></xsl:when>
            <xsl:otherwise><xsl:value-of select="@title"/></xsl:otherwise>
        </xsl:choose> 
    </xsl:template>
    <xsl:template match="ead:extref">
        <xsl:choose>
            <xsl:when test="@href">
                <a href="{@href}"><xsl:value-of select="."/></a>
            </xsl:when>
            <xsl:when test="@ns2:href"><a href="{@ns2:href}"><xsl:value-of select="."/></a></xsl:when>
            <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
        </xsl:choose> 
    </xsl:template>
    
    <!--Creates a hidden anchor tag that allows navigation within the finding aid. 
    In this stylesheet only children of the archdesc and c0* itmes call this template. 
    It can be applied anywhere in the stylesheet as the id attribute is universal. -->
    <xsl:template match="@id">
        <xsl:attribute name="id"><xsl:value-of select="."/></xsl:attribute>
    </xsl:template>
    <xsl:template name="anchor">
        <xsl:choose>
            <xsl:when test="@id">
                <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="id"><xsl:value-of select="generate-id(.)"/></xsl:attribute>
            </xsl:otherwise>
            </xsl:choose>
    </xsl:template>
    <xsl:template name="tocLinks">
        <xsl:choose>
            <xsl:when test="self::*/@id">
                <xsl:attribute name="href">#<xsl:value-of select="@id"/></xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="href">#<xsl:value-of select="generate-id(.)"/></xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
 
    <!--Bibref, choose statement decides if the citation is inline, if there is a parent element
    or if it is its own line, typically when it is a child of the bibliography element.-->
    <xsl:template match="ead:bibref">
        <xsl:choose>
            <xsl:when test="parent::ead:p">
                <xsl:choose>
                    <xsl:when test="@ns2:href">
                        <a href="{@ns2:href}"><xsl:apply-templates/></a>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <p> 
                    <xsl:choose>
                        <xsl:when test="@ns2:href">
                            <a href="{@ns2:href}"><xsl:apply-templates/></a>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates/>
                        </xsl:otherwise>
                    </xsl:choose>
                </p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
   
    <!-- Formats prefered citiation -->
    <xsl:template match="ead:prefercite">
        <div class="citation">
            <xsl:choose>
                <xsl:when test="ead:head"><xsl:apply-templates/></xsl:when>
                <xsl:otherwise><h3>Preferred Citation</h3><xsl:apply-templates/></xsl:otherwise>
            </xsl:choose>
        </div>
    </xsl:template>

    <!-- Applies a span style to address elements, currently addresses are displayed 
        as a block item, display can be changed to inline, by changing the CSS -->
    <xsl:template match="ead:address">

        <p> <div class="address">
            
            <xsl:for-each select="child::*">
               
                <xsl:apply-templates/>
                
                <xsl:choose>
                    <xsl:when test="ead:lb"/>
                    <xsl:otherwise><br/></xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>            
        </div> </p>    
    </xsl:template>
    <!-- ADDED 1/14/11: Added mailto link -->
    <xsl:template match="ead:addressline">
        <xsl:choose>
            <xsl:when test="contains(.,'@')">
                <a href="mailto:{.}"><xsl:value-of select="."/></a><br/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="."/><br/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
       
    <!-- ADDED 1/9/11: Suppresses related materials and seperated materials headings -->
    <xsl:template match="ead:head[parent::ead:relatedmaterial] | ead:head[parent::ead:separatedmaterial]"/>   
    <!-- Formats headings throughout the finding aid -->
    <xsl:template match="ead:head[parent::*/parent::ead:archdesc]">
        <xsl:choose>
            <xsl:when test="parent::ead:accessrestrict or parent::ead:userestrict or
                parent::ead:custodhist or parent::ead:accruals or
                parent::ead:altformavail or parent::ead:acqinfo or
                parent::ead:processinfo or parent::ead:appraisal or
                parent::ead:originalsloc or  
                parent::ead:relatedmaterial or parent::ead:separatedmaterial or parent::ead:prefercite">
                <h4>
                    <xsl:choose>
                        <xsl:when test="parent::*/@id">
                            <xsl:attribute name="id"><xsl:value-of select="parent::*/@id"/></xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="id"><xsl:value-of select="generate-id(parent::*)"/></xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:apply-templates/>
                </h4> 
            </xsl:when>
            <xsl:otherwise>
                <h3>
                    <xsl:choose>
                        <xsl:when test="parent::*/@id">
                            <xsl:attribute name="id"><xsl:value-of select="parent::*/@id"/></xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="id"><xsl:value-of select="generate-id(parent::*)"/></xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:apply-templates/>
                </h3>                
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="ead:head">
        <!-- ADDED 12/22/10 - suppresses blank headings -->
        <xsl:choose>
            <xsl:when test=".='--'"/>
            <xsl:when test=".='__'"/>
            <xsl:when test=".='_'"/>
            <xsl:otherwise>
                <h4><xsl:apply-templates/></h4>        
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Digital Archival Object -->
    <xsl:template match="ead:daogrp">
        <xsl:choose>
            <xsl:when test="parent::ead:archdesc">
                <h3><xsl:call-template name="anchor"/>
                    <xsl:choose>
                    <xsl:when test="@ns2:title">
                       <xsl:value-of select="@ns2:title"/>
                    </xsl:when>
                    <xsl:otherwise>
                        Digital Archival Object
                    </xsl:otherwise>
                    </xsl:choose>
                </h3>
            </xsl:when>
            <xsl:otherwise>
                <h4><xsl:call-template name="anchor"/>
                    <xsl:choose>
                    <xsl:when test="@ns2:title">
                       <xsl:value-of select="@ns2:title"/>
                    </xsl:when>
                    <xsl:otherwise>
                        Digital Archival Object
                    </xsl:otherwise>
                </xsl:choose>
                </h4>
            </xsl:otherwise>
        </xsl:choose>   
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="ead:dao">
        <xsl:choose>
            <xsl:when test="child::*">
                <!-- <xsl:apply-templates/> <a href="{@ns2:href}">[<xsl:value-of select="@ns2:href"/>]</a> -->
               <!--  <xsl:apply-templates/> --> <span class="dao"><a href="{@ns2:href}"><xsl:value-of select="@ns2:title"/>&#160;<i class="fa fa-external-link">&#160;</i>
           </a></span><br />
            </xsl:when>
            <xsl:otherwise>
              <span class="dao">  

                <a href="{@ns2:href}">
                    <!-- <xsl:value-of select="@ns2:href"/> --><xsl:value-of select="@ns2:title"/>
                </a></span><br />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="ead:daoloc">
     <span class="dao">   <a href="{@ns2:href}">
            <!-- <xsl:value-of select="@ns2:title"/> --><xsl:value-of select="@ns2:title"/>
        </a></span><br />
    </xsl:template>
    
    <!--Formats a simple table. The width of each column is defined by the colwidth attribute in a colspec element.-->
    <xsl:template match="ead:table">
        <xsl:for-each select="tgroup">
            <table >
                <tr>
                    <xsl:for-each select="ead:colspec">
                        <td width="{@colwidth}"/>
                    </xsl:for-each>
                </tr>
                <xsl:for-each select="ead:thead">
                    <xsl:for-each select="ead:row">
                        <tr>
                            <xsl:for-each select="ead:entry">
                                <td valign="top">
                                    <strong>
                                        <xsl:value-of select="."/>
                                    </strong>
                                </td>
                            </xsl:for-each>
                        </tr>
                    </xsl:for-each>
                </xsl:for-each>
                <xsl:for-each select="ead:tbody">
                    <xsl:for-each select="ead:row">
                        <tr>
                            <xsl:for-each select="ead:entry">
                                <td valign="top">
                                    <xsl:value-of select="."/>
                                </td>
                            </xsl:for-each>
                        </tr>
                    </xsl:for-each>
                </xsl:for-each>
            </table>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="ead:unitdate">
        <xsl:if test="preceding-sibling::*">&#160;</xsl:if>
        <xsl:choose>
            <xsl:when test="@type = 'bulk'">
                (<xsl:apply-templates/>)                            
            </xsl:when>
            <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="ead:date">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="ead:unittitle">
        <xsl:choose>
           <xsl:when test="child::ead:unitdate[@type='bulk']">
               <xsl:apply-templates select="node()[not(self::ead:unitdate[@type='bulk'])]"/>
               <xsl:apply-templates select="ead:date[@type='bulk']"/>

            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
 
    <!-- Following five templates output chronlist and children in a table -->
    <xsl:template match="ead:chronlist">
       <div align="center" style="padding-top:10px;"> <table class="chronlist">
            <xsl:apply-templates/>
       </table></div>
    </xsl:template>
    <xsl:template match="ead:chronlist/ead:listhead">
        <tr>
            <th>
                <xsl:apply-templates select="ead:head01"/>
            </th>
            <th>
                <xsl:apply-templates select="ead:head02"/>
            </th>
        </tr>
    </xsl:template>
    <xsl:template match="ead:chronlist/ead:head">
        <tr>
            <th colspan="2">
                <xsl:apply-templates/>
            </th>
        </tr>
    </xsl:template>
    <xsl:template match="ead:chronitem">
        <tr>
            <xsl:attribute name="class">
                <xsl:choose>
                    <xsl:when test="(position() mod 2 = 0)">odd</xsl:when>
                    <xsl:otherwise>even</xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <td style="padding-right:10px;"><xsl:apply-templates select="ead:date"/></td>
            <td style="padding-left:10px;"><xsl:apply-templates select="descendant::ead:event"/></td>
        </tr>
    </xsl:template>
    <xsl:template match="ead:event">
        <xsl:choose>
            <xsl:when test="following-sibling::*">
                <xsl:apply-templates/><br/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>

    <!-- ADDED 12/22/10 - Remove .0 from extent also remove '(s)' when extent is 1  -->
    <xsl:template match="ead:extent">        
        <xsl:variable name="textSingle">
            <xsl:choose>
                <xsl:when test="contains(.,'(s)')">
                    <xsl:value-of select="concat(substring-before(.,'(s)'),substring-after(.,'(s)'))"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="."/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="textMulti">
            <xsl:choose>
                <xsl:when test="contains(.,'(s)')">
                    <xsl:value-of select="concat(substring-before(.,'(s)'),'s',substring-after(.,'(s)'))"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="."/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="starts-with(.,'1 ') or starts-with(.,'1.0 ')">
                <xsl:choose>
                    <xsl:when test="contains(.,'.0')">
                        <xsl:value-of select="concat(substring-before($textSingle,'.0'),substring-after($textSingle,'.0'),' ')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat(substring-before(.,'.0'),substring-after(.,'.0'),' ')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="contains(.,'.0')">
                <xsl:value-of select="concat(substring-before($textMulti,'.0'),substring-after($textMulti,'.0'))"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$textMulti"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Output for a variety of list types -->
    <xsl:template match="ead:list">
        <xsl:if test="ead:head"><h4><xsl:value-of select="ead:head"/></h4></xsl:if>
        <xsl:choose>
            <xsl:when test="descendant::ead:defitem">
                <dl>
                    <xsl:apply-templates select="ead:defitem"/>
                </dl>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="@type = 'ordered'">
                        <ol style="padding-top:6px;">
                            <xsl:attribute name="class">
                                <xsl:value-of select="@numeration"/>
                            </xsl:attribute>

                            <xsl:apply-templates/>
                        </ol>
                    </xsl:when>
                    <xsl:when test="@numeration">
                        <ol style="padding-top:6px;">
                            <xsl:attribute name="class">
                                <xsl:value-of select="@numeration"/>
                            </xsl:attribute>
                            <xsl:apply-templates/>
                        </ol>
                    </xsl:when>
                    <xsl:when test="@type='simple'">
                        <ul>
                            <xsl:attribute name="class">simple</xsl:attribute>
                            <xsl:apply-templates select="child::*[not(ead:head)]"/>
                        </ul>
                    </xsl:when>
                    <xsl:otherwise>
                        <ul>
                            <xsl:apply-templates/>
                        </ul>        
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="ead:list/ead:head"/>
    <xsl:template match="ead:list/ead:item">
        <li><xsl:apply-templates/></li>
    </xsl:template>
    <xsl:template match="ead:defitem">
        <dt><xsl:apply-templates select="ead:label"/></dt>
        <dd><xsl:apply-templates select="ead:item"/></dd>
    </xsl:template>
 
    <!-- Formats list as tabel if list has listhead element  -->         
    <xsl:template match="ead:list[child::ead:listhead]">
        <table>
            <tr>
                <th><xsl:value-of select="ead:listhead/ead:head01"/></th>
                <th><xsl:value-of select="ead:listhead/ead:head02"/></th>
            </tr>
            <xsl:for-each select="ead:defitem">
                <tr>
                    <td><xsl:apply-templates select="ead:label"/></td>
                    <td><xsl:apply-templates select="ead:item"/></td>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>

    <!-- Formats notestmt and notes -->
    <xsl:template match="ead:notestmt">
        <h4>Note</h4>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="ead:note">
         <xsl:choose>
             <xsl:when test="parent::ead:notestmt">
                 <xsl:apply-templates/>
             </xsl:when>
             <xsl:otherwise>
                 <xsl:choose>
                     <xsl:when test="@label"><h4><xsl:value-of select="@label"/></h4><xsl:apply-templates/></xsl:when>
                     <xsl:otherwise><h4>Note</h4><xsl:apply-templates/></xsl:otherwise>
                 </xsl:choose>
             </xsl:otherwise>
         </xsl:choose>
     </xsl:template>
    
    <!-- Child elements that should display as paragraphs-->
    <xsl:template match="ead:legalstatus">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    <!-- Puts a space between sibling elements -->
    <xsl:template match="child::*">
        <xsl:if test="preceding-sibling::*">&#160;</xsl:if>
        <xsl:apply-templates/>
    </xsl:template>
    <!-- Generic text display elements -->
    <xsl:template match="ead:p">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    <xsl:template match="ead:lb"><br/></xsl:template>
    <xsl:template match="ead:blockquote">
        <blockquote><xsl:apply-templates/></blockquote>
    </xsl:template>
    
    <xsl:template match="ead:emph"><em><xsl:apply-templates/></em></xsl:template>
    
    <!--Render elements -->
    <xsl:template match="*[@render = 'bold'] | *[@altrender = 'bold'] ">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if><strong><xsl:apply-templates/></strong>
    </xsl:template>
    <xsl:template match="*[@render = 'bolddoublequote'] | *[@altrender = 'bolddoublequote']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if><strong>"<xsl:apply-templates/>"</strong>
    </xsl:template>
    <xsl:template match="*[@render = 'boldsinglequote'] | *[@altrender = 'boldsinglequote']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if><strong>'<xsl:apply-templates/>'</strong>
    </xsl:template>
    <xsl:template match="*[@render = 'bolditalic'] | *[@altrender = 'bolditalic']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if><strong><em><xsl:apply-templates/></em></strong>
    </xsl:template>
    <xsl:template match="*[@render = 'boldsmcaps'] | *[@altrender = 'boldsmcaps']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if><strong><span class="smcaps"><xsl:apply-templates/></span></strong>
    </xsl:template>
    <xsl:template match="*[@render = 'boldunderline'] | *[@altrender = 'boldunderline']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if><strong><span class="underline"><xsl:apply-templates/></span></strong>
    </xsl:template>
    <xsl:template match="*[@render = 'doublequote'] | *[@altrender = 'doublequote']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if>"<xsl:apply-templates/>"
    </xsl:template>
    <xsl:template match="*[@render = 'italic'] | *[@altrender = 'italic']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if><em><xsl:apply-templates/></em>
    </xsl:template>
    <xsl:template match="*[@render = 'singlequote'] | *[@altrender = 'singlequote']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if>'<xsl:apply-templates/>'
    </xsl:template>
    <xsl:template match="*[@render = 'smcaps'] | *[@altrender = 'smcaps']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if><span class="smcaps"><xsl:apply-templates/></span>
    </xsl:template>
    <xsl:template match="*[@render = 'sub'] | *[@altrender = 'sub']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if><sub><xsl:apply-templates/></sub>
    </xsl:template>
    <xsl:template match="*[@render = 'super'] | *[@altrender = 'super']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if><sup><xsl:apply-templates/></sup>
    </xsl:template>
    <xsl:template match="*[@render = 'underline'] | *[@altrender = 'underline']">
        <xsl:if test="preceding-sibling::*"> &#160;</xsl:if><span class="underline"><xsl:apply-templates/></span>
    </xsl:template>
    <!-- 
        <value>nonproport</value>        
    -->

    <!-- *** Begin templates for Container List *** -->
    <xsl:template match="ead:archdesc/ead:dsc">
        <!--<xsl:message select="'here'"/>-->
        <xsl:choose>
            <xsl:when test="ead:head">
                <xsl:apply-templates select="ead:head"/>
            </xsl:when>
            <xsl:otherwise>
                <h3 class="margin-bottom"><xsl:call-template name="anchor"/>Collection Inventory</h3>
            </xsl:otherwise>
        </xsl:choose>
        <!-- Creates a table for container lists, defaults to 5 cells, for up to 4 container lists.  -->
        <!-- parentContainers containerList-->           
        <table class="containerList" cellpadding="0" cellspacing="0" border="0">
            <!-- Call children of dsc -->
            <xsl:apply-templates select="*[not(self::ead:head)]"/>
            <tr>
                <td/>
                <td style="width: 15%;"/>
                <td style="width: 15%"/>
                <td style="width: 15%;"/>
                <td style="width: 15%;"/>
            </tr>
      </table>
    </xsl:template>
    
    <!--This section of the stylesheet creates a div for each c01 or c 
        It then recursively processes each child component of the c01 by 
        calling the clevel template. 
        Edited 12/26/10: Added parameter to indicate clevel margin, parameter is called by clevelMargin variable
    -->
    <xsl:template match="ead:c">
        <xsl:call-template name="clevel">
            <xsl:with-param name="level">01</xsl:with-param>
        </xsl:call-template>
        <xsl:for-each select="ead:c">
            <xsl:call-template name="clevel">
                <xsl:with-param name="level">02</xsl:with-param>
            </xsl:call-template>
            <xsl:for-each select="ead:c">
                <xsl:call-template name="clevel">
                    <xsl:with-param name="level">03</xsl:with-param>
                </xsl:call-template>    
                <xsl:for-each select="ead:c">
                    <xsl:call-template name="clevel">
                        <xsl:with-param name="level">04</xsl:with-param>
                    </xsl:call-template>
                    <xsl:for-each select="ead:c">
                        <xsl:call-template name="clevel">
                            <xsl:with-param name="level">05</xsl:with-param>
                        </xsl:call-template>
                        <xsl:for-each select="ead:c">
                            <xsl:call-template name="clevel">
                                <xsl:with-param name="level">06</xsl:with-param>
                            </xsl:call-template> 
                            <xsl:for-each select="ead:c">
                                <xsl:call-template name="clevel">
                                    <xsl:with-param name="level">07</xsl:with-param>
                                </xsl:call-template>
                                <xsl:for-each select="ead:c">
                                    <xsl:call-template name="clevel">
                                        <xsl:with-param name="level">08</xsl:with-param>
                                    </xsl:call-template>
                                    <xsl:for-each select="ead:c">
                                        <xsl:call-template name="clevel">
                                            <xsl:with-param name="level">09</xsl:with-param>
                                        </xsl:call-template>    
                                    </xsl:for-each>
                                </xsl:for-each>
                            </xsl:for-each>
                        </xsl:for-each>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:for-each>
        <!-- ADDED 1/22/11: Return to top only after series -->
        <xsl:if test="self::*[@level='series']">
            <tr>
                <td colspan="5">
                    <xsl:call-template name="returnTOCcontainerList"/> 
                </td>
            </tr>    
        </xsl:if>
    </xsl:template>
    <xsl:template match="ead:c01">
        <xsl:call-template name="clevel"/>
        <xsl:for-each select="ead:c02">
            <xsl:call-template name="clevel"/>
            <xsl:for-each select="ead:c03">
                <xsl:call-template name="clevel"/>
                <xsl:for-each select="ead:c04">
                    <xsl:call-template name="clevel"/>
                    <xsl:for-each select="ead:c05">
                        <xsl:call-template name="clevel"/>
                        <xsl:for-each select="ead:c06">
                            <xsl:call-template name="clevel"/>
                            <xsl:for-each select="ead:c07">
                                <xsl:call-template name="clevel"/>
                                <xsl:for-each select="ead:c08">
                                    <xsl:call-template name="clevel"/>
                                    <xsl:for-each select="ead:c09">
                                        <xsl:call-template name="clevel"/>
                                        <xsl:for-each select="ead:c10">
                                            <xsl:call-template name="clevel"/>
                                            <xsl:for-each select="ead:c11">
                                                <xsl:call-template name="clevel"/>
                                                <xsl:for-each select="ead:c12">
                                                    <xsl:call-template name="clevel"/>
                                                </xsl:for-each>
                                            </xsl:for-each>
                                        </xsl:for-each>
                                    </xsl:for-each>
                                </xsl:for-each>
                            </xsl:for-each>
                        </xsl:for-each>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:for-each>
        <!-- ADDED 1/22/11: Return to top only after series -->
        <xsl:if test="self::*[@level='series']">
            <tr>
                <td colspan="5">
                    <xsl:call-template name="returnTOCcontainerList"/> 
                </td>
            </tr>    
        </xsl:if>
        
    </xsl:template>
    <!--This is a named template that processes all c0* elements  -->
<xsl:template name="clevel">
        <!-- Establishes which level is being processed in order to provided indented displays. 
            Indents handled by CSS margins-->
        <xsl:param name="level" />
        <xsl:variable name="clevelMargin">
            <xsl:choose>
                <xsl:when test="$level = 01">c01</xsl:when>
                <xsl:when test="$level = 02">c02</xsl:when>
                <xsl:when test="$level = 03">c03</xsl:when>
                <xsl:when test="$level = 04">c04</xsl:when>
                <xsl:when test="$level = 05">c05</xsl:when>
                <xsl:when test="$level = 06">c06</xsl:when>
                <xsl:when test="$level = 07">c07</xsl:when>
                <xsl:when test="$level = 08">c08</xsl:when>
                <xsl:when test="$level = 09">c09</xsl:when>
                <xsl:when test="$level = 10">c10</xsl:when>
                <xsl:when test="$level = 11">c11</xsl:when>
                <xsl:when test="$level = 12">c12</xsl:when>
                <xsl:when test="../ead:c">c</xsl:when>
                <xsl:when test="../ead:c01">c01</xsl:when>
                <xsl:when test="../ead:c02">c02</xsl:when>
                <xsl:when test="../ead:c03">c03</xsl:when>
                <xsl:when test="../ead:c04">c04</xsl:when>
                <xsl:when test="../ead:c05">c05</xsl:when>
                <xsl:when test="../ead:c06">c06</xsl:when>
                <xsl:when test="../ead:c07">c07</xsl:when>
                <xsl:when test="../ead:c08">c08</xsl:when>
                <xsl:when test="../ead:c08">c09</xsl:when>
                <xsl:when test="../ead:c08">c10</xsl:when>
                <xsl:when test="../ead:c08">c11</xsl:when>
                <xsl:when test="../ead:c08">c12</xsl:when>
            </xsl:choose>
        </xsl:variable>
        <!-- Establishes a class for even and odd rows in the table for color coding. 
            Colors are Declared in the CSS. -->
        <xsl:variable name="colorClass">
            <xsl:choose>
                <xsl:when test="ancestor-or-self::*[@level='file' or @level='item']">
                    <xsl:choose>
                        <xsl:when test="(position() mod 2 = 0)">odd</xsl:when>
                        <xsl:otherwise>even</xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>      
        <!-- Processes the all child elements of the c or c0* level -->  
        <xsl:for-each select=".">
            <xsl:choose>
                <!--Formats Series and Groups  -->
                <xsl:when test="@level='subcollection' or @level='subgrp' or @level='series' 
                    or @level='subseries' or @level='collection'or @level='fonds' or 
                    @level='recordgrp' or @level='subfonds' or @level='class' or (@level='otherlevel' and not(child::ead:did/ead:container))">
                    <xsl:if test="ead:did/ead:container">
                        <tr class="containerTypes"> 
                            <td class="containerHeaderTitle">
                                <xsl:attribute name="colspan">
                                    <xsl:choose>
                                        <xsl:when test="count(ead:did[ead:container][1]/ead:container) = 1">4</xsl:when>
                                        <xsl:otherwise>3</xsl:otherwise>
                                    </xsl:choose>
                                </xsl:attribute>
                               <!--  <xsl:text>Title</xsl:text> -->
                                 <xsl:text></xsl:text>
                            </td>
                            <xsl:choose>
                                <xsl:when test="count(ead:did/ead:container) = 1">
                                    <td class="containerHeader">
                                        <xsl:value-of select="ead:did/ead:container/@type"/>
                                    </td>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:variable name="container1" select="ead:did/ead:container[@label][1]"/>
                                    <xsl:variable name="container2" select="ead:did/ead:container[string(@parent) = string($container1/@id)]"/>
                                    <td class="containerHeader">
                                        <xsl:value-of select="string($container1/@type)"/>
                                    </td>
                                    <td class="containerHeader">
                                        <xsl:value-of select="string($container2/@type)"/>
                                    </td>
                                </xsl:otherwise>
                            </xsl:choose> 
                        </tr>
                    </xsl:if>
                    <tr>
                        <xsl:attribute name="class">
                            <xsl:choose>
                                <xsl:when test="@level='subcollection' or @level='subgrp' or @level='subseries' or @level='subfonds'">subseries</xsl:when>
                                <xsl:otherwise>series</xsl:otherwise>
                            </xsl:choose>    
                        </xsl:attribute>
                        <xsl:choose>    
                            <xsl:when test="ead:did/ead:container">
                                <td class="{$clevelMargin}">
                                    <!-- 6/7/12 WS: Fix for extra spaces between instances add rowspan-->                                        
                                    <xsl:if test="count(ead:did/ead:container[@id]) &gt; 1">
                                        <xsl:attribute name="rowspan"><xsl:value-of select="count(ead:did/ead:container[@id])"/></xsl:attribute>
                                    </xsl:if>
                                    <xsl:choose>                                
                                        <xsl:when test="count(ead:did/ead:container) &lt; 1">
                                            <xsl:attribute name="colspan">
                                                <xsl:text>5</xsl:text>
                                            </xsl:attribute>
                                        </xsl:when>
                                        <xsl:when test="count(ead:did/ead:container) = 1">
                                            <xsl:attribute name="colspan">
                                                <xsl:text>4</xsl:text>
                                            </xsl:attribute>
                                        </xsl:when>
                                        <xsl:when test="count(ead:did/ead:container) = 2">
                                            <xsl:attribute name="colspan">
                                                <xsl:text>3</xsl:text>
                                            </xsl:attribute>
                                             <xsl:attribute name="colspan">
                                                <xsl:text>3</xsl:text>
                                            </xsl:attribute>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:attribute name="colspan">
                                                <xsl:text>3</xsl:text>
                                            </xsl:attribute>
                                        </xsl:otherwise>
                                    </xsl:choose>    
                                    <xsl:call-template name="anchor"/>
                                    <xsl:apply-templates select="ead:did" mode="dsc"/>
                                    <xsl:choose>
                                        <xsl:when test="child::*[not(ead:did) and not(self::ead:did)]">
                                            <div class="seriesNote">
                                                <xsl:apply-templates select="child::*[not(ead:did) and not(self::ead:did)]"/>
                                            </div>
                                        </xsl:when>
                                    </xsl:choose>
                                </td>

                                <!-- creates header for multiple instance rows -->
                                <xsl:for-each select="ead:did[ead:container][1]/ead:container[position() &lt;= 2]">    
                                    <td class="container">    
                                    <xsl:apply-templates select="."/>       
                                    </td>    
                                </xsl:for-each>
                            </xsl:when>
                           
<!-- reads major heading and prints major info -->
                            <xsl:otherwise>
                                <td colspan="5" class="{$clevelMargin}">
                                    <xsl:call-template name="anchor"/>
                                    <xsl:apply-templates select="ead:did" mode="dsc"/>
                                    <div class="seriesNote"><xsl:apply-templates select="child::*[not(ead:did) and not(self::ead:did)]"/></div>
                                </td>
                            </xsl:otherwise>
                        </xsl:choose>
                    </tr>
                    <xsl:if test="ead:did[ead:container][1]/ead:container[position() &gt; 2]">
                        <!-- 7/14/11 WS: added choose statement to deal appropriately with multiple instances -->
                        <xsl:for-each select="ead:did[ead:container][1]/ead:container[@id][position() &gt;= 2]">
                            <xsl:variable name="containerID" select="@id"/>
                            <tr>
                                <xsl:attribute name="class">
                                    <xsl:choose>
                                        <xsl:when test="@level='subcollection' or @level='subgrp' or @level='subseries' or @level='subfonds'">subseries</xsl:when>
                                        <xsl:otherwise>series</xsl:otherwise>
                                    </xsl:choose>    
                                </xsl:attribute>
                                <!--6/7/12 WS: Added styles to line up instances correctly and remove top border -->
                                <td class="container" style="border:none;padding-top:0;padding-left: 12px;">
                                    <xsl:apply-templates select="."/>
                                </td>
                                <td style="border:none;padding-top:0;padding-left: 12px;">
                                    <xsl:value-of select="../ead:container[@parent = $containerID]"/>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </xsl:if>
                    
                <!-- ADDED 1/4/11: Adds container headings if series/subseries is followed by a file -->                   
                    <xsl:choose>
                        <xsl:when test="child::*[@level][1]/@level='subcollection' or child::*[@level][1]/@level='subgrp' or child::*[@level][1]/@level='subseries' or child::*[@level][1]/@level='subfonds'"/>                        
                        <xsl:when test="child::*[@level][1]/@level='file' or child::*[@level][1]/@level='item' or (child::*[@level][1]/@level='otherlevel'and child::*[@level][1]/child::ead:did/ead:container)">
                            <xsl:choose>
                                <xsl:when test="count(child::*[@level][1]/ead:did/ead:container/@id) &gt; 1"/>
                                <xsl:when test="count(child::*[@level][1]/ead:did/ead:container/@parent) &gt; 1">
                                    <tr class="containerTypes"> 
                                        <td class="containerHeaderTitle">
                                            <xsl:attribute name="colspan">
                                                <xsl:choose>
                                                    <xsl:when test="count(ead:did[ead:container][1]/ead:container) = 1">4</xsl:when>
                                                    <xsl:otherwise>3</xsl:otherwise>
                                                </xsl:choose>
                                            </xsl:attribute>
                                           <!--  <xsl:text>Title</xsl:text> -->
                                           <xsl:text></xsl:text>
                                        </td>
                                        <xsl:variable name="container1" select="child::*[@level][1]/ead:did/ead:container[@label][1]"/>
                                        <xsl:variable name="container2" select="child::*[@level][1]/ead:did/ead:container[string(@parent) = string($container1/@id)]"/>
                                        <td class="containerHeader">
                                            <xsl:value-of select="string($container1/@type)"/>
                                        </td>
                                        <td class="containerHeader">
                                            <xsl:value-of select="string($container2/@type)"/>
                                        </td>
                                    </tr>          
                                </xsl:when>
                                <xsl:otherwise>
                                    <tr class="containerTypes"> 
                                        <td class="containerHeaderTitle">
                                            <xsl:attribute name="colspan">
                                                <xsl:choose>
                                                    <xsl:when test="count(child::*[@level][1]/ead:did[ead:container][1]/ead:container) = 1">4</xsl:when>
                                                    <xsl:otherwise>3</xsl:otherwise>
                                                </xsl:choose>
                                            </xsl:attribute>
                                            <!--  <xsl:text>Title</xsl:text> -->
                                            <xsl:text></xsl:text>
                                        </td>
                                        <xsl:choose>
                                            <xsl:when test="child::*[ead:did/ead:container/@label][1]">
                                                <xsl:variable name="firstParentID">
                                                    <xsl:value-of select="string(child::*/ead:did/ead:container[@label][1]/@id)"/>
                                                </xsl:variable>
                                                <xsl:for-each select="child::*/ead:did/ead:container[@parent = $firstParentID] | child::*/ead:did/ead:container[@id = $firstParentID]">
                                                    <td class="containerHeader"><xsl:value-of select="@type"/></td>
                                                </xsl:for-each>
                                            </xsl:when>
                                            <xsl:when test="child::*[ead:did/ead:container][1]">
                                                <xsl:for-each select="child::*[ead:did/ead:container][1]/ead:did/ead:container">    
                                                    <td class="containerHeader">    
                                                        <xsl:value-of select="@type"/>
                                                    </td>                                    
                                                </xsl:for-each>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <td class="containerHeader">Box</td>
                                                <td class="containerHeader">Folder</td>
                                            </xsl:otherwise>
                                        </xsl:choose>    
                                    </tr>                                   
                                </xsl:otherwise>
                            </xsl:choose>
                       </xsl:when>                        
                        <xsl:otherwise/>
                    </xsl:choose>                    
                </xsl:when>      
                
                <!--Items/Files with multiple formats linked using parent and id attributes -->
                <!-- EDITIED 3/28/11: Changed container headings to suit Kellen Archives specifications -->
                <xsl:when test="count(child::*/ead:container/@id) &gt; 1">
                    <xsl:variable name="container" select="string(ead:did/ead:container[1]/@type)"/>
                    <xsl:variable name="sibContainer" select="string(preceding-sibling::*[1]/ead:did/ead:container[1]/@type)"/>
                   
                    <!-- When all container types match, sort instances -->
                    
                    <xsl:for-each select="child::*/ead:container[@id]">                
                    <!-- ADDED 3/14/10: Sorts containers alpha numerically -->
                    <xsl:sort select="."/>
                    <xsl:variable name="id" select="@id"/>
                    <xsl:variable name="containerSib" select="count(../ead:container[@parent = $id] | ../ead:container[@id = $id])"/>
                    
                        <!-- Tests to see if first container is different from preceding did container -->
                        <xsl:if test="position()=1">
                            <tr class="containerTypes"> 
                                <td class="containerHeaderTitle">
                                    <xsl:attribute name="colspan">
                                        <xsl:choose>
                                            <xsl:when test="count(../ead:container) = 1">4</xsl:when>
                                            <xsl:otherwise>3</xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:attribute>
                                    <!--  <xsl:text>Title</xsl:text> -->
                                    <xsl:text></xsl:text>
                                </td>
                                <xsl:choose>
                                    <xsl:when test="count(../ead:container) &gt; 1">
                                        <xsl:variable name="container1" select="."/>
                                        <xsl:variable name="container2" select="../ead:container[@parent = $id]"/>
                                        <td class="containerHeader">
                                            <xsl:value-of select="string($container1/@type)"/>
                                        </td>
                                        <td class="containerHeader">
                                            <xsl:value-of select="string($container2/@type)"/>
                                        </td>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:for-each select="following-sibling::*[ead:did/ead:container][1]/ead:did/ead:container">
                                            <td class="containerHeader">    
                                                <xsl:value-of select="@type"/>
                                            </td>      
                                        </xsl:for-each>
                                    </xsl:otherwise>
                                </xsl:choose>  
                            </tr>
                        </xsl:if>

                        <!-- Item lists are printed here -->
                        <tr>
                            <xsl:if test="position()!=1">
                                <xsl:attribute name="class">parentIDLevel</xsl:attribute>
                            </xsl:if>
                            <xsl:if test="position()=1">
                                <td class="{$clevelMargin}" colspan="3">
                                    <xsl:attribute name="rowspan">
                                        <xsl:value-of select="count(../ead:container[@id])"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="valign"><xsl:text>top</xsl:text></xsl:attribute>
                                    <xsl:apply-templates select="../../ead:did" mode="dsc"/>
                                    <xsl:apply-templates select="../../ead:did/not[ead:unittitle]" mode="dsc"/>   
                                    <xsl:choose>
                                        <xsl:when test="../../child::*[not(self::ead:did) and 
                                                    not(self::ead:c) and not(self::ead:c02) and not(self::ead:c03) and
                                                    not(self::ead:c04) and not(self::ead:c05) and not(self::ead:c06) and not(self::ead:c07)
                                                    and not(self::ead:c08) and not(self::ead:c09) and not(self::ead:c10) and not(self::ead:c11) and not(self::ead:c12)]">
                                            <div class="generalNote">
                                                <xsl:apply-templates select="../../*[not(self::ead:did) and 
                                                            not(self::ead:c) and not(self::ead:c02) and not(self::ead:c03) and
                                                            not(self::ead:c04) and not(self::ead:c05) and not(self::ead:c06) and not(self::ead:c07)
                                                            and not(self::ead:c08) and not(self::ead:c09) and not(self::ead:c10) and not(self::ead:c11) and not(self::ead:c12)]"/>  
                                            </div>                                    
                                        </xsl:when>
                                    </xsl:choose>                            
                                   <!--  <xsl:if test="../../descendant-or-self::ead:dao"> 
                                        <xsl:for-each select="../../descendant-or-self::ead:dao"> -->
                                 
                                    <xsl:if test="../../self::ead:dao"> 
                                        <xsl:for-each select="../../self::ead:dao">

                                           <!-- Digital Object  -->  
                                      <xsl:apply-templates select="."/>
                                        </xsl:for-each>
                                    </xsl:if> 
                                    
                                </td>
                            </xsl:if>
                            <td class="container">
                                <xsl:apply-templates select="."/>
                            </td>
                            <xsl:if test="count(../ead:container) &gt; 1">
                                <td class="container">
                                    <xsl:value-of select="../ead:container[@parent = $id]"/>
                                </td>                                
                            </xsl:if>
                        </tr>
                    </xsl:for-each> 
                </xsl:when>

                <!-- Items/Files--> 
                <!-- EDITIED 1/4/11: Changed container headings to suit Kellen Archives specifications -->
                <xsl:when test="@level='file' or @level='item' or (@level='otherlevel'and child::ead:did/ead:container)">
                    <!-- Variables to  for Conainer headings, used only if headings are different from preceding heading -->
                    <xsl:variable name="container" select="string(ead:did/ead:container[1]/@type)"/>
                    <xsl:variable name="container2" select="string(ead:did/ead:container[2]/@type)"/>
                    <xsl:variable name="container3" select="string(ead:did/ead:container[3]/@type)"/>
                    <xsl:variable name="container4" select="string(ead:did/ead:container[4]/@type)"/>
                    <!-- Counts contianers for current and preceding instances and if different inserts a heading -->
                    <xsl:variable name="containerCount" select="count(ead:did/ead:container)"/>
                    <xsl:variable name="sibContainerCount" select="count(preceding-sibling::*[1]/ead:did/ead:container)"/>
                    <!-- Variable estabilishes previouse container types for comparisson to current container. -->
                    <xsl:variable name="sibContainer" select="string(preceding-sibling::*[1]/ead:did/ead:container[1]/@type)"/>
                    <xsl:variable name="sibContainer2" select="string(preceding-sibling::*[1]/ead:did/ead:container[2]/@type)"/>
                    <xsl:variable name="sibContainer3" select="string(preceding-sibling::*[1]/ead:did/ead:container[3]/@type)"/>
                    <xsl:variable name="sibContainer4" select="string(preceding-sibling::*[1]/ead:did/ead:container[4]/@type)"/>
                    <!-- Tests to see if current container type is different from previous container type, if it is a new row with container type headings is outout -->
                    
                            <xsl:choose>
                                <xsl:when test="not(preceding-sibling::*/@level)">
                                    <xsl:choose>
                                        <xsl:when test="parent::ead:dsc">
                                            <tr class="containerTypes"> 
                                                <td class="containerHeaderTitle">
                                                    <xsl:attribute name="colspan">
                                                        <xsl:choose>
                                                            <xsl:when test="count(ead:did[ead:container][1]/ead:container) = 1">4</xsl:when>
                                                            <xsl:otherwise>3</xsl:otherwise>
                                                        </xsl:choose>
                                                    </xsl:attribute>
                                                <!--  <xsl:text>Title</xsl:text> -->
                                                    <xsl:text></xsl:text>
                                                </td>
                                                <xsl:choose>
                                                    <xsl:when test="ead:did/ead:container[1]">
                                                        <xsl:for-each select="ead:did/ead:container">    
                                                            <td class="containerHeader">    
                                                                <xsl:value-of select="@type"/>
                                                            </td>                                    
                                                        </xsl:for-each>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:for-each select="following-sibling::*[ead:did/ead:container][1]/ead:did/ead:container">
                                                            <td class="containerHeader">    
                                                                <xsl:value-of select="@type"/>
                                                            </td>          
                                                        </xsl:for-each>
                                                    </xsl:otherwise>
                                                </xsl:choose>    
                                            </tr>
                                        </xsl:when>
                                    </xsl:choose>
                                </xsl:when>
                                <xsl:when test="not(ead:did/ead:container)"/>
                                <xsl:otherwise>
                                    <xsl:choose>
                                        <xsl:when test="$container != $sibContainer">
                                            <tr class="containerTypes"> 
                                                    <td class="containerHeaderTitle">
                                                        <xsl:attribute name="colspan">
                                                            <xsl:choose>
                                                                <xsl:when test="count(ead:did[ead:container][1]/ead:container) = 1">4</xsl:when>
                                                                <xsl:otherwise>3</xsl:otherwise>
                                                            </xsl:choose>
                                                        </xsl:attribute>
                                                        <xsl:attribute name="style">
                                                        <xsl:text>vertical-align:top;</xsl:text>
                                                        </xsl:attribute>    
                                                       <!-- <xsl:text>Title </xsl:text> -->
                                                        <xsl:text></xsl:text>
                                                    </td>
                                                    <xsl:for-each select="ead:did/ead:container">     
                                                        <td class="containerHeader">    
                                                            <xsl:value-of select="@type"/>
                                                        </td>                                                                                                                                                  
                                                    </xsl:for-each>
                                            </tr>
                                        </xsl:when>
                                        <xsl:otherwise/>
                                    </xsl:choose>
                                </xsl:otherwise>
                           </xsl:choose>
                            
                    <tr> 
                        <td class="{$clevelMargin}">
                            <xsl:choose>
                                <xsl:when test="count(ead:did/ead:container) &lt; 1">
                                    <xsl:attribute name="colspan">
                                        <xsl:text>5</xsl:text>
                                    </xsl:attribute>
                                </xsl:when>
                                <xsl:when test="count(ead:did/ead:container) = 1">
                                    <xsl:attribute name="colspan">
                                        <xsl:text>4</xsl:text>
                                    </xsl:attribute>
                                </xsl:when>
                                <xsl:when test="count(ead:did/ead:container) = 2">
                                    <xsl:attribute name="colspan">
                                        <xsl:text>3</xsl:text>
                                    </xsl:attribute>
                                </xsl:when>
                                <xsl:when test="count(ead:did/ead:container) = 3">
                                    <xsl:attribute name="colspan">
                                        <xsl:text>2</xsl:text>
                                    </xsl:attribute>
                                </xsl:when>
                                <xsl:otherwise/>
                            </xsl:choose>                            
                            <xsl:apply-templates select="ead:did" mode="dsc"/>
                             <div class="generalNote">
                                    <xsl:apply-templates select="*[not(self::ead:did) and
                                        not(self::ead:c) and not(self::ead:c02) and not(self::ead:c03) and
                                        not(self::ead:c04) and not(self::ead:c05) and not(self::ead:c06) and not(self::ead:c07)
                                        and not(self::ead:c08) and not(self::ead:c09) and not(self::ead:c10) and not(self::ead:c11) and not(self::ead:c12)]"/>
                                </div>  
                        </td>
                        <!-- Containers -->    
                        <xsl:for-each select="ead:did/ead:container">    
                            <td class="container">    
                                <xsl:apply-templates select="."/>     
                            </td>    
                        </xsl:for-each>
                    </tr>  
                        
                 <!--   <xsl:if test="child::*[not(self::ead:did) and not(self::ead:dao) and
                            not(self::ead:c) and not(self::ead:c02) and not(self::ead:c03) and
                            not(self::ead:c04) and not(self::ead:c05) and not(self::ead:c06) and not(self::ead:c07)
                            and not(self::ead:c08) and not(self::ead:c09) and not(self::ead:c10) and not(self::ead:c11) and not(self::ead:c12)]">
                        <tr> 
                            <td class="{$clevelMargin}" colspan="5">
                                <div>
                                    <xsl:apply-templates select="*[not(self::ead:did) and
                                        not(self::ead:c) and not(self::ead:c02) and not(self::ead:c03) and
                                        not(self::ead:c04) and not(self::ead:c05) and not(self::ead:c06) and not(self::ead:c07)
                                        and not(self::ead:c08) and not(self::ead:c09) and not(self::ead:c10) and not(self::ead:c11) and not(self::ead:c12)]"/>  test 1
                                </div>                                    
                                
                            </td>
                        </tr>                                                        
                    </xsl:if> -->
                </xsl:when>
                <xsl:otherwise>
                    <tr class="{$colorClass}"> 
                        <td class="{$clevelMargin}" colspan="5">
                            <xsl:apply-templates select="ead:did" mode="dsc"/> test 2
                            <xsl:apply-templates select="*[not(self::ead:did) and 
                                not(self::ead:c) and not(self::ead:c02) and not(self::ead:c03) and
                                not(self::ead:c04) and not(self::ead:c05) and not(self::ead:c06) and not(self::ead:c07)
                                and not(self::ead:c08) and not(self::ead:c09) and not(self::ead:c10) and not(self::ead:c11) and not(self::ead:c12)]"/>  
                        </td>
                    </tr>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
</xsl:template>

    <!--ADDED 12/22/10: Removes text '(small flat)' from container display -->
    <xsl:template match="ead:did/ead:container">
        <xsl:choose>
            <xsl:when test="contains(.,'(small flat)')">
                <xsl:value-of select="concat(substring-before(.,'(small flat)'),substring-after(.,'(small flat)'))"/>
            </xsl:when>
            <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!--ADDED 12/27/10: Adds javascript to collection notes in dsc to collaps and expand note -->
    <xsl:template match="ead:c/ead:scopecontent">
        <xsl:apply-templates select="ead:p[1]"/>
        <xsl:if test="count(child::*[not(local-name()='head')]) &gt; 1">
        <div id="{concat(@id,'More-show')}" class="more">    
            <xsl:apply-templates select="child::*[not(local-name()='head')][position() &gt; 1]"/>
        </div>
            <p><a href="#{concat(@id,'More')}" id="{concat(@id,'More')}" class="showLink">More...</a></p>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="ead:c/ead:abstract">
        <xsl:apply-templates select="ead:p[1]"/>
        <xsl:if test="count(child::*[not(local-name()='head')]) &gt; 1">
            <div id="{concat(@id,'More-show')}" class="more">    
                <xsl:apply-templates select="child::*[not(local-name()='head')][position() &gt; 1]"/>
            </div>
            <p><a href="#{concat(@id,'More')}" id="{concat(@id,'More')}" class="showLink">More...</a></p>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="ead:did" mode="dsc">
        <xsl:choose>
            <xsl:when test="../@level='subcollection' or ../@level='subgrp' or ../@level='series' 
                or ../@level='subseries'or ../@level='collection'or ../@level='fonds' or 
                ../@level='recordgrp' or ../@level='subfonds'">    
               <p class="unittitle">
                    <xsl:call-template name="component-did-core"/>
               </p>
            </xsl:when>
            <!--Otherwise render the text in its normal font.-->
            <xsl:otherwise>
                <xsl:call-template name="component-did-core"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="component-did-core">
        <!--Inserts unitid and a space if it exists in the markup.-->
        <xsl:if test="ead:unitid">
            <xsl:apply-templates select="ead:unitid"/>
            <xsl:text>&#160;</xsl:text>
        </xsl:if>
        <!--Inserts origination and a space if it exists in the markup.-->
        <xsl:if test="ead:origination">
            <xsl:apply-templates select="ead:origination"/>
            <xsl:text>&#160;</xsl:text>
        </xsl:if>
        <!--This choose statement selects between cases where unitdate is a child of unittitle and where it is a separate child of did.-->
        <xsl:choose>
            <!--This code processes the elements when unitdate is a child of unittitle.-->
            <xsl:when test="ead:unittitle/ead:unitdate">
                <xsl:apply-templates select="ead:unittitle"/>
            </xsl:when>
            <!--This code process the elements when unitdate is not a child of untititle-->
            <xsl:otherwise>
                <xsl:apply-templates select="ead:unittitle"/>
                <xsl:text>&#160;</xsl:text>
                <xsl:for-each select="ead:unitdate[not(self::ead:unitdate[@type='bulk'])]">
                    <xsl:apply-templates/>
                    <xsl:text>&#160;</xsl:text>
                </xsl:for-each>
                <xsl:for-each select="ead:unitdate[@type = 'bulk']">
                    (<xsl:apply-templates/>)
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="ead:physdesc">
            <xsl:text>&#160;</xsl:text>
            <xsl:apply-templates select="ead:physdesc"/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="banner">
<div id="banner">
  <div id="site_lockup">

              <h1 class="u_name">
            <a href="http://www.newschool.edu/">
              <span class="font-width-1">T</span><span class="font-width-3">h</span><span class="font-width-1">e</span><span class="font-width-1">&#160;</span><span class="font-width-2">N</span><span class="font-width-1">e</span><span class="font-width-3">w</span><span class="font-width-1">&#160;</span><span class="font-width-1">S</span><span class="font-width-1">c</span><span class="font-width-3">h</span><span class="font-width-2">o</span><span class="font-width-2">o</span><span class="font-width-3">l</span>
            </a>
          </h1>

          <div class="bottom-stripe" id="stripe-1"><div class="bottom-stripe-inner">&#160;</div></div>
          <div class="bottom-stripe" id="stripe-2"><div class="bottom-stripe-inner">&#160;</div></div>

          <h1 class="sitename">
<a href="http://library.newschool.edu">Libraries <span class="hide-for-small-only"><xsl:text disable-output-escaping="yes">&amp;</xsl:text> Archives</span><span class="show-for-small-only mobile-logo"><br /><xsl:text disable-output-escaping="yes">&amp;</xsl:text> Archives</span></a>
</h1>

  </div>
  <a name="N10000">&#160;</a>
</div>
    </xsl:template>
    
  <xsl:template name="nav1">   
    <div id="nav1">
  <div id="page_info" class="" >
     <div class="inner-wrapper" id="">
        <ul class="breadcrumbs"> 
          <!-- RENDER BREADCRUMBS HERE --> 
          <li><a href="http://library.newschool.edu" title="The New School Libraries">Home</a></li>
          <li><a href="http://library.newschool.edu/archives/index.php" title="Archives">Archives <xsl:text disable-output-escaping="yes">&amp;</xsl:text> Special Collections</a></li>
          <li class=""><a href="http://library.newschool.edu/archives/browse_collections.php">Browse the Collections</a></li>
          <li class="unavailable">
          <a href="">Collection Guide</a></li>

          </ul>
        <div class="hide-for-small">
          <div id='pageheading'>
            <h2>Collection Guide</h2>
          </div>
</div>
</div>
</div>
</div>
  </xsl:template>

          <xsl:template name="footer">
<div id="footer-wrapper"><div id="universal_footer_interim"></div></div>
<script type="text/javascript">
    $.getJSON( "http://www.newschool.edu/php/footer.php?v=absolute<xsl:text disable-output-escaping="yes">&amp;</xsl:text>callback=?", function(data) {
          $("#footer-wrapper").html(data.html);
      });
</script> 

<script type="text/javascript">
(function($) {
  var thePage = $("body");
  thePage.html(thePage.html().replace(/archivist@newschool.edu/ig, '<a href="mailto:archivist@newschool.edu">archivist@newschool.edu</a>')); 
})(jQuery)
</script>
    </xsl:template>
    
    <!-- borrowed from http://geekswithblogs.net/Erik/archive/2008/04/01/120915.aspx. I would normally use replace in xslt 2.0, but...
        #  text         : main string you are parsing
        #  replace : the string fragment to be replaced
        #  by           :  the replacement string

    -->
    
    <xsl:template name="string-replace-all">
        <xsl:param name="text" />
        <xsl:param name="replace" />
        <xsl:param name="by" />
        <xsl:choose>
            <xsl:when test="contains($text, $replace)">
                <xsl:value-of select="substring-before($text,$replace)" />
                <xsl:value-of select="$by" />
                <xsl:call-template name="string-replace-all">
                    <xsl:with-param name="text"
                        select="substring-after($text,$replace)" />
                    <xsl:with-param name="replace" select="$replace" />
                    <xsl:with-param name="by" select="$by" />
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$text" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
