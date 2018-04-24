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
var mSelect,mLoaiThe;
function BodyInit()
{
    System.Translate(document); 
	OnSearch();
	
}

function OnSearch()
{
    dsoSearch.Call("SELECT");
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

function OnSelect(oGrid)
{
   var arr_data = new Array();
   var control = oGrid.GetGridControl();
   var rows = control.Rows;
	
	if (control.SelectedRows >0)
	{
		//for (i=0; i<control.SelectedRows ; i++)
		//{
			var row = control.SelectedRow(0);
			
			
             for(var j=0;j<oGrid.cols;j++)
             {
                 arr_data[arr_data.length]= oGrid.GetGridData(row,j);
             }
             
		//}
		window.returnValue =  arr_data;
		window.close();
    }
	
	  else
	  {
	    alert("No data is selected!");
	  }
}


</script>
<body>

<gw:data id="dsoSearch"  onreceive="" > 
    <xml> 
        <dso id="1" type="grid" function="COMM.sp_sel_download_org_posco " > 
            <input bind="idGrid" >
                <input bind="radSearchFlag"/> 
                <input bind="dtStartDate"/> 
                <input bind="dtEndDate"/> 
                <input bind="txtInfor"/> 
            </input> 
            <output bind="idGrid" /> 
        </dso> 
    </xml> 
</gw:data> 

<form id="form1" runat="server">
    	    <table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
            <tr >
	            
		        <td style="width:10%" align="right">Load Date</td>
		        <td style="width:12%">
		            <gw:datebox id="dtStartDate" styles='width:31%'  lang="1" />
		        </td>
		        <td style="width:1%">~</td>
		        <td style="width:12%">
		            <gw:datebox id="dtEndDate" styles='width:31%'  lang="1"  />
		        </td>
		        <td  style="width:25%"> 
	              <gw:radio id="radSearchFlag" value="1" styles="width:100%" onchange="OnSearch()"> 
                        <span value="1">New Org</span> 
                        <span value="2">Modified Org</span> 
                   </gw:radio>
		        </td>   
		        <td style="width:10%" align="right">Search Info</td>
		        <td style="width:20%"><gw:textbox text="" id="txtInfor" /></td>
		        <td style="width:5%"> <gw:imgBtn id="idSearch" img="search" alt="Search"  onclick="OnSearch()" /></td>
		        <td style="width:5%"> <gw:imgBtn id="idSelect" img="select" alt="Select"  onclick="OnSelect(idGrid)" /></td>
	    	</tr>
		    <tr height="100%"> 
	    		<td colspan="9">
	    			<table CELLSPACING="0" CELLPADDING="0" width="100%" height="100%" border="0">
                    <tr>
			    	    <td height="80%">   
					        <gw:grid   
					            <gw:grid id='idGrid'
                                    header='_New|_PK|SEQ|ORG CODE|ORG NAME|ORG LNAME|ORG FNAME|COMPANY|FROM DT|TO DT|_upper_pk|UPPER ORG CODE|Upper Name|_DOWNLOADDATA_TYPE|DOWNLOADDATA DATE|_DOWNLOAD_DATE|_DOWNLOAD_STATUS|DOWNLOAD RTN MESSAGE'
                                    format='0|0|0|0|0|0|0|0|4|4|0|0|0|0|0|0|0|0'
                                    aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                    defaults='|||||||||||||||||'
                                    editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                    widths='0|0|800|1000|1500|1500|1500|1000|1200|1200|0|1000|1500|1000|1000|1000|1000|1000'
                                    sorting='T'
                                    styles='width:100%; height:100%'
                                    oncelldblclick="OnSelect(this)"
                                    acceptnulldate
                                    />
		                </td>
		            </tr>
		            </table>
            	<td>
	    	</tr>
		    </table>  
</form>

<gw:textbox id="txtItemType"              style="display:none"/>
<gw:textbox id="txtItemValue"              style="display:none"/>
<gw:textbox id="txtCompany"              style="display:none"/>

</body>
</html>