<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Web" %>
<%@ Import Namespace = "System.Web.Security" %>
<%@ Import Namespace = "System.Security.Principal" %>
<%@ Import Namespace = "System.Runtime.InteropServices" %>
<!-- #include file="../../../system/lib/form.inc" -->

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>genuwin</title>
  
</head>


<script>

function BodyInit()
{
    var compk   = "<%=Request["com_pk"]%>";
    var kind_code = "<%=Request["kind_cd"]%>";
    var comm_code = "<%=Request["comm_cd"]%>";
    
    lstCOMPANY.SetEnable(false);
    txtKIND_CODE.SetEnable(false);
    txtCOMM_CODE.SetEnable(false);
    BindingDataList();
    lstCOMPANY.SetDataText(compk);
    txtKIND_CODE.SetDataText(kind_code);
    txtCOMM_CODE.SetDataText(comm_code);
       
}

function BindingDataList()
{
    var ls_comp = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
        
    lstCOMPANY.SetDataText(ls_comp);
  
    
}
function OnSearch()
{   
    dso_sel_grd_faacc_command.Call("SELECT");
}

function OnClickRow()
{
    var code_data=new Array();
	var ctrl = grid.GetGridControl();
	if(ctrl.SelectedRows == 0)
	{
	   alert("Please Select an Item.");
	   return ;
	}
	else
	{
		//code
		code_data[0] = grid.GetGridData( ctrl.row , 0 );
		//code name
		code_data[1] = grid.GetGridData( ctrl.row , 1 );
		// value1 --> PK
		code_data[2] = grid.GetGridData( ctrl.row , 2 );
			
		window.returnValue = code_data;
		this.close();
	}
}



</script>
<body style="margin:0; padding:0;">
   <gw:data id="dso_sel_grd_faacc_command">
        <xml>
            <dso type="grid" function="ACNT.SP_GET_FAACC_COMMANDCODE">
                <input bind="grid">
                    <input bind="lstCompany"/>
                    <input bind="txtCOMM_CODE"/>
                    <input bind="txtKIND_CODE"/>
                    
                </input>
                <output bind="grid"/>
            </dso>
        </xml>
    </gw:data>
 
<!------------------------------------------------------------------------------------------------------->

<table width="100%" cellpadding="0" cellspacing="0" border="1">
    <tr>
        <td>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td width="10%" align="right"><font color="black" ><b>Company&nbsp; </b></font></td>
                    <td width="80%" colspan="3"><gw:list id="lstCOMPANY" styles='width:100%'> </gw:list></td>
                    <td width="5%"><gw:imgBtn id="ibtnSearch" img="search"    alt="Search"        onclick="OnSearch()" /></td>
                </tr>
                <tr>
                    <td width="15%" align="right"><font color="black" ><b>Kind code&nbsp; </b></font></td>
                    <td width="30%"><gw:textbox id="txtKIND_CODE" styles='width:100%'> </gw:textbox></td>
                    <td width="20%" align="right"><font color="black" ><b>Command code&nbsp; </b></font></td>
                    <td width="35%" colspan="2"><gw:textbox id="txtCOMM_CODE" styles='width:100%'> </gw:textbox></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td width="100%">
            <gw:grid   
		        id="grid"
		        header  ="_pk|Code|Name|Local Name|_Kind"
		        format  ="0|0|0|0|0"  
		        aligns  ="0|0|0|0|0" 
		        defaults="0|0|0|0|0"  
		        editcol ="0|0|0|0|0"  
		        widths  ="0|1500|3500|3500|0"  
		        styles  ="width:100%; height:400"
		        sorting ="T"
		        oncellclick="OnClickRow()"
		    />
        
        </td>
    </tr>
</table>

<!---------------------------------------------------------------------------------------------------->
</body>
</html>