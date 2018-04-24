<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("acnt")%>
<head id="Head1" runat="server">
    <title>Group Cost Product Manufactured Loading</title>
</head>

<script>
//---------------------------------------------------------------------
 var  user_pk   = "<%=Session("EMPLOYEE_PK")%>"  ;
 var  user_name = "<%=Session("USER_NAME")%>"  ; 
//---------------------------------------------------------------------	        
function BodyInit()
{  
    var ls_data     = "<%=ESysLib.SetListDataSQL("SELECT to_char(PK), PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    lstCompany.SetDataText(ls_data);
}
//---------------------------------------------------------------------
function BindingData()
{
}
//---------------------------------------------------------------------
function OnSearch()
{
    fmgf00091.Call('SELECT');
}
//---------------------------------------------------------------------
function OnDoubleClick()
{
    var code_data=new Array()
    
    var ctrl = grdPMGroup.GetGridControl();
    
    var index, rowNo ;
    index = 0 ;
    rowNo = 0 ;
    if( ctrl.SelectedRows == 0 )
    {
           return ;
    }
    else
    {
        for( i=0 ; i<ctrl.SelectedRows ; i++ )
	    {	  
            rowNo = ctrl.SelectedRow(i) ;
            
            for( j=0 ; j<grdPMGroup.cols ; j++ )
            {
                code_data[index] = grdPMGroup.GetGridData(rowNo , j );
                index ++;
            } 
            
	    }
    }
    window.returnValue = code_data; 
    this.close(); 	    
}
//---------------------------------------------------------------------
</script>

<body>
<!-------------------------------------------------------------------------->
    <gw:data id="fmgf00091" onreceive=""> 
        <xml> 
            <dso id="1" type="grid" function="ACNT.sp_sel_fmgf00091" > 
                <input bind="grdPMGroup" >   
                    <input bind="lstCompany"/>
                    <input bind="txtGroup"/>                    
                </input>
                <output  bind="grdPMGroup" />
            </dso> 
        </xml> 
    </gw:data>
<!-------------------------------------------------------------------------->

<table style="height:100%; width:100%" border="1" >
    <tr style="height:10%">
        <td>
            <table style="width:100%; ">
                <tr>                    
                    <td style="width:15%;" align="right"><b>Company</b></td>
                    <td style="width:30%" align="left"><gw:list id="lstCompany" styles="width:100%; "/></td>
                    <td style="width:15%" align="right"><b>Group</b></td>
                    <td style="width:30%" align="left"><gw:textbox id="txtGroup" styles="width:100%; " onenterkey="OnSearch()" /></td>                    
                    <td style="width:10%; " align="right"><gw:imgbtn id="btnSearch" text="Search" alt="Search" img="search" onclick="OnSearch()" /></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr style="height:90%; " >
        <td>
            <table style="width:100%; height:100% ">
                <tr>
                    <td>
                            <gw:grid id="grdPMGroup" 
							header="_tac_pmitemgroup_pk|Group Code|Group Name"
                                format="0|0|0" aligns="0|0|0" defaults="||" editcol="0|1|1"
                                widths="0|3000|6000" styles="width:100%; height:100% " sorting="T"
                                oncelldblclick="OnDoubleClick()"
                                acceptNullDate="T" />                                                
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</body>
</html>
