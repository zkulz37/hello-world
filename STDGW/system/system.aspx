<%@ Page Language="C#"%>
<html xmlns:gw>
<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<LINK REL="SHORTCUT ICON" HREF="">
<title> <%= Application["APP_NAME"] %> </title>
<LINK href="default.css" rel="stylesheet" />
<style>

@media all 
{
	gw\:textbox  {  behavior: url(controls/textbox.htc) ;  }
	gw\:button  {  behavior: url(controls/button.htc) ;  }
	gw\:icon {  behavior: url(controls/icon.htc) ;  }
}
</style>
<SCRIPT LANGUAGE="JavaScript" SRC="lib/system.js"></script>
<SCRIPT LANGUAGE="JavaScript" SRC="lib/common.js"></script>
<SCRIPT LANGUAGE="JavaScript" SRC="lib/appsystem.js"></script>
<SCRIPT LANGUAGE="JavaScript" SRC="lib/globalVar.js"></script>
</head>
<script>

RootURL = location.pathname;

var index = RootURL.lastIndexOf ( "/"  );

SystemURL = RootURL.substr( 0, index );
RootURL = RootURL.substr( 0, index - 7);
HostURL = "http://" + document.location.host ;

SysImgPath = SystemURL + "/images";
var logger;
var lastLog;

function Init()
{
	
	idSystemFrm.document.location.href = "../login.aspx";
	
	lastLog = 	top.frames("lastLog");
	lastLog.document.write ( '<html><LINK href="default.css" rel="stylesheet" ><body>' );

	HideProgress();
}
//	for debug window script
//
var debug_height = 0;
var debug_remain = "";
function showdebug()
{
	var obj = document.all( "idDebugDiv" );

	if ( obj.style.display == "none" ) 
	{
		ondebugclick();
	}

}
//lastLog.
function ondebugclick()
{
	var obj = document.all( "idDebugDiv" );
	
	if ( obj.style.display == "none" ) 
	{
		obj.style.display = "block";
	}
	else
	{
		obj.style.display = "none";
	}
	
}
function ViewSource()
{
   
   var url = System.Menu.GetPageURL();
   if( url !="" ){
   	    window.open( SystemURL + "/ViewSource.aspx?file_name="+url );
    }
}
function Size( delta )
{

	var obj = document.all( "idDebugTable" );
	
	delta = obj.height * 1 + delta;
	
	if ( delta  > 20 ) 
		obj.height = delta;

}

function DebugLog()
{
	var obj = document.all( "idBtnLog" ); 

	if ( obj.mode == "stop" )
	{
		obj.mode = "start";
		obj.SetDataText(  "<nobr>Start Logging</nobr>" );
		logger = null;
	}
	else
	{
		obj.mode = "stop";
		obj.SetDataText(   "<nobr>Stop Logging</nobr>" );
		logger = 	top.frames("debugLog");		
		logger.document.write ( '<LINK href="default.css" rel="stylesheet" />' );
	}
}

function OpenSDE()
{
	window.open( SystemURL + "/sde/sdemainfrm.aspx" );
}

function GoHome()
{
	OpenPage( SystemURL + "/Main.aspx" );
}

function DeleteLog()
{
	top.frames("debugLog").document.close();
	top.frames("debugLog").document.write ( '<LINK href="default.css" rel="stylesheet" />' );
}

function GoTutorial()
{
	OpenPage( RootURL + "/form/_samples/tutorial.aspx" );
}

function callLogout() {
	System.AppLogout();
}

function checkSysAdmin( val ) {
	if (val == "Y") {
		imgDebug.style.display = "";
	} 
	else 
	{
		imgDebug.style.display = "none";	
	}
}
function ShowProgress()
{ 
    //window.document.body.style.cursor="wait";
    var obj = document.all("divProgress");
    obj.style.left = getWidth()- 50;
    obj.style.display = "";
}
function HideProgress()
{  
   var obj = document.all("divProgress");
     obj.style.display = "none";
}
function ShowProgress2()
{ 
    //window.document.body.style.cursor="wait";
    var obj = document.all("divProgress");
    obj.style.left = 0;//getWidth()/2 - 50;
    obj.style.top = 0;//getHeight()/2 -50;
    obj.style.display = "";
}
function HideProgress2()
{  
   var obj = document.all("divProgress");
     obj.style.display = "none";
}
function getHeight(){
     var height;
     /*Mozila IE 7, IE 6, OldIE*/
     if (typeof window.innerHeight != 'undefined')
        height = window.innerHeight;
     else if (typeof document.documentElement != 'undefined' && typeof document.documentElement.clientHeight != 'undefined' && document.documentElement.clientHeight != 0)
       height = document.documentElement.clientHeight;
     else height = document.getElementsByTagName('body')[0].clientHeight;
     return height;
}
function getWidth(){
     var width;
     /*Mozila IE 7, IE 6, OldIE*/
     if (typeof window.innerWidth != 'undefined')
        width = window.innerWidth;
     else if (typeof document.documentElement != 'undefined' && typeof document.documentElement.clientWidth != 'undefined' && document.documentElement.clientWidth != 0)
       width = document.documentElement.clientWidth;
     else width = document.getElementsByTagName('body')[0].clientWidth;
     return width;
}

</script>

<body style="margin:0 0 0 0; padding:0 0 0 0; overflow:hidden" onload="Init()">
<table width="100%" height="100%" cellpadding=0 cellspacing=0 border=0 > 
	<tr>
    <td style="position:relative"> 
      <img id="imgDebug" src="images/debug.gif" style="cursor:hand;position:absolute;left:2;top:2;display:none" align="right" onclick="ondebugclick()" /> 
      <div id="divProgress"  style="position:absolute;left:600;top:35;background-color:Red; display:none; z-index:1"><img src="images/loadgraphic.gif" /></div>
      <div id="idDebugDiv" style="display:none;border-width:0 0 2 0 ; border-color:black ; border-style:solid"> 
      <form id="idfrm" target="hiddenframe" style="position:absolute" method="POST"></form>
        <table  id="idDebugTable" width="100%" height="130" style="table-layout :fixed" align="center">
          <tr>
            <td style="background-color:blue; color:white" width="50%" algin="center"> 
              <table>
                <tr> 
                  <td width="100%" style="background-color:blue; color:white"  align="center"><b>Result Window </b></td>
                  <td> 
                      <table>
						<tr>
							<td> <gw:icon   onclick="GoTutorial()" > Tutorial </gw:icon></td>
							<td> <gw:icon   onclick="OpenSDE()" > SDE </gw:icon></td>
							<td> <gw:icon   onclick="Size(-100)" > <nobr> SizeUp </nobr></gw:icon></td>
							<td> <gw:icon   onclick="Size(+100)" > <nobr> SizeDown </nobr></gw:icon> </td>
							<td> <gw:icon   onclick="ViewSource()" > <nobr>Source</nobr></gw:icon></td>
							<td> <gw:icon   onclick="ondebugclick()" > <nobr> Close </nobr></gw:icon></td>
						</tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>
            <td style="background-color:blue; color:white" width="50%" align="center"> 
              <table>
                <tr> 
                  <td width="100%" style="background-color:blue; color:white"  align="center"><b>Debug Window </b></td>
                  <td> 
					<table>
						<tr>
							<td> 
							<gw:icon  id="idBtnLog"  onclick="DebugLog()"  mode="start" ><nobr>Start Logging</nobr> </gw:icon > 
							</td>
							<td> <gw:icon  id="idBtnDelete"  onclick="DeleteLog()" ><nobr> Delete Logging </nobr></gw:icon> </td>
						</tr>
                    </table>
                   </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr>
            <td width="50%" height="100%"> 
               <iframe id="lastLog"  style=" width:100%;height:100%; border:1 solid blue" frameborder="0" ></iframe> 
            </td>
            <td style="background-color:white" width="50%"> 
               <iframe id="debugLog"   style=" width:100%;height:100%; border:1 solid blue" frameborder="0"  > </iframe> 
            </td>
          </tr>
        </table>
      </div>
    </td>
  </tr>
  <tr>
     <td height="100%">
		<iframe id="idSystemFrm" src=""   frameborder="0" name="content" style="width:100%;height:100%" ></iframe>
	</td>
  </tr>
  <input type="hidden" id="testID"/>
</table>	
</body>
</html>



