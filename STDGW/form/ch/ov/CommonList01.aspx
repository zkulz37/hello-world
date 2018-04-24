<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Web" %>
<%@ Import Namespace = "System.Web.Security" %>
<%@ Import Namespace = "System.Security.Principal" %>
<%@ Import Namespace = "System.Runtime.InteropServices" %>

<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>genuwin</title>
</head>
<%ESysLib.SetUser("hr");%>

<script>
var mSelect;
function BodyInit()
{
	var idDsqlid  = "<%=Request["dsqlid"]%>";
	var title  = "<%=Request["popTitle"]%>";
	var header  = "<%=Request["header"]%>";
	var size  = "<%=Request["size"]%>";
	
	txtParam01.text  = "<%=Request["param01"]%>";
	
	
	if(header == "")
	{
		header = "_PK|Item Info 1|Item Info 2|Description";
	}
	if(size == "")
	{
		size = "0|2000|2500|2000";
	}
	
    lblTitle.text = title;
	OnSearch();
}

function OnSearch()
{
    dsoAccountT.Call("SELECT");
}

function OnCancel(clear)
{
	window.returnValue = null; 
	this.close();
}

function SelectAll()
{
	for(i=1; i<idGrid.rows; i++)
	{
		idGrid.SetGridText( i, 0, "-1" );			
	}
}


</script>
<body>

<gw:data id="dsoAccountT"  onreceive="" > 
    <xml> 
        <dso id="1" type="grid" function="<%=Request["dsqlid"]%>" > 
            <input bind="idGrid" >
                <input bind="txtParam01"/> 
            </input> 
            <output bind="idGrid" /> 
        </dso> 
    </xml> 
</gw:data> 

<form id="form1" runat="server">
    <table  border="0" width="100%" height="100%" cellpadding="0" cellspacing="0" >
    <tr> 
        <td width="100%" height="100%">
    	    <table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td align = "center"><gw:label id="lblTitle" styles='font-weight:bold;font-size:15pt;width:100%;border:1px solid #6B9EB8'/></td>
			</tr>
            <tr height="100%"> 
	    		<td>
	    			<table CELLSPACING="0" CELLPADDING="0" width="100%" height="100%" border="0">
                    <tr>
			    	    <td height="80%">   
					        <gw:grid   
					            id="idGrid"  
					            header="<%=Request["header"]%>"
					            format="0|0|0|0"
					            aligns="0|0|0|0"
					            defaults="|||"
					            editcol="0|0|0|0"
					            widths="<%=Request["size"]%>"
					            styles="width:100%; height:100%"   
					            sorting="T"   
					            param="0,1,2,3"  
					            oncelldblclick="" />
		                </td>
		            </tr>
		            </table>
            	<td>
	    	</tr>
		    </table>  
        </td>
	</tr>
    </table>
</form>

<gw:textbox id="txtParam01"              style="display:none"/>

</body>
</html>