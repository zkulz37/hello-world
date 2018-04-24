<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Web" %>
<%@ Import Namespace = "System.Web.Security" %>
<%@ Import Namespace = "System.Security.Principal" %>
<%@ Import Namespace = "System.Runtime.InteropServices" %>
<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Get Group</title>
</head>
<% ESysLib.SetUser("acnt");
%>

<script>
  var idCompany  = "<%=Request["company"]%>";
function BodyInit()
{
    txtCompany.text = idCompany
	OnSearch();
}
function OnSearch()
{
    fmgf00081.Call("SELECT");
}

function OnCancel()
{
	var code_data=new Array()
	code_data[0] = 0;
	window.returnValue = code_data; 
	this.close();
}
function Select()
{
	
	var code_data=new Array()
	var ctrl = idGrid.GetGridControl();
	
	if(ctrl.SelectedRows == 0)
    {
        alert("Please select an account.");
        return ;
    }
    else
	{
        //pk
        code_data[0] = idGrid.GetGridData( ctrl.row , 0 );
        //code 
        code_data[1] = idGrid.GetGridData( ctrl.row , 1 );
        //name
		code_data[2] = idGrid.GetGridData( ctrl.row , 2 );
		window.returnValue = code_data; 
	   	this.close(); 	
	 }
}

function SelectM()
{
    var code_data=new Array()
	var ctrl = idGrid.GetGridControl();
	var index, rowNo
	index = 1;
	rowNo = 0;
	if(ctrl.SelectedRows == 0)
    {
        alert("Please select an account.");
        return ;
    }
    else
	{
	    for(i=0;i<ctrl.SelectedRows;i++)
		{
		    rowNo = ctrl.SelectedRow(i);
		    code_data[index] = idGrid.GetGridData(rowNo, 0 );
            //group pk
            index ++;
            code_data[index] = idGrid.GetGridData( rowNo, 1 );
            //group code
            index ++;
		    code_data[index] = idGrid.GetGridData( rowNo, 2 );
		    //group name
		    index ++;
		}
	}
	window.returnValue = code_data; 
	this.close(); 	
}

</script>
<body>

<gw:data id="fmgf00081"  onreceive="" > 
    <xml> 
        <dso id="1" type="grid" function="ACNT.sp_sel_fmgf00081" > 
            <input bind="idGrid" > 
                <input bind="txtCompany"/>
                <input bind="txtGroup"/> 
            </input> 
            <output bind="idGrid" /> 
        </dso> 
    </xml> 
</gw:data> 

<form id="form1" runat="server">
    <table  border="0" width="100%" height="100%" cellpadding="0" cellspacing="0" >
    <tr> 
        <td width="100%" height="100%">
    	    <table width="100%" height="100%" cellpadding="0" cellspacing="0" border="1">
            <tr height="5%">
	            <td > 
                    <table CELLSPACING="0" CELLPADDING="0" width="100%" height="100%" border="0">
					<tr>
						<td width="25%" align="right"><b>Group &nbsp;&nbsp;</b></td>
						<td><gw:textbox id="txtGroup" styles="width:90%;height:20" onenterkey="OnSearch()"/></td>
		            </tr> 
				    </table>
		        </td>
	    	</tr>

	    	<tr height="95%"> 
	    		<td>
	    			<table CELLSPACING="0" CELLPADDING="0" width="100%" height="100%" border="0">
                    <tr>
			    	    <td height="80%">   
					        <gw:grid   
					            id="idGrid"  
					            header="_pk|Group Code|Group Name"
					            format="0|0|0"
					            aligns="0|0|0"  
					            defaults="|||"  
					            editcol="0|0|0"  
					            widths="0|2500|2500"  
					            styles="width:100%; height:100%"   
					            sorting="T"   
					            param="0,1,2,3"  
					            oncelldblclick="Select()" />
		                </td>
		            </tr>
		            </table>
            	<td>
	    	</tr>

		    <tr height="5">
				<td>
					<table border="0" CELLSPACING="0" CELLPADDING="0" width="100%" height="100%" >
					<tr align="center"> 
					    <td>
						    <table>
						    <tr>
							    <td><gw:icon id="btnSelect" img="in" text="OK"      styles="width:100"  onclick="Select()" /></td>
							    <td><gw:icon id="btnCancel" img="in" text="EXIT"    styles="width:100"  onclick="OnCancel()" /></td> 
						    </tr>
						    </table>	
					    <td>	
					</tr>
					</table>
				</td>
			</tr>
		    </table>  
        </td>
	</tr>
    </table>
</form>

<gw:textbox id="txtCompany"    style="display:none"/>

</body>
</html>