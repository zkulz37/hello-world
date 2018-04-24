<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("acnt")%>
<head id="Head1" runat="server">
    <title>Allocate - Account Code</title>
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
    BindingData();
}
//---------------------------------------------------------------------
function BindingData()
{
    txtAccountCode.text = '';
    txtAccountName.text = '';
    OnSearch();
}
//---------------------------------------------------------------------
function OnSearch()
{
    fmgf00092.Call('SELECT');
}    
//---------------------------------------------------------------------
function Select()
{	
	var code_data=new Array() ;	
	var ctrl = grdAccount.GetGridControl();
    var i , j, index=0;
    //code
    for(i = 1; i < grdAccount.rows; i++)
    {
        if( grdAccount.GetGridData(i, 4)== -1 )
        {
            var arr = new Array();
            for(j = 0; j < grdAccount.cols; j++)
            {
                arr[arr.length] =  grdAccount.GetGridData(i, j);                      
            }
            code_data[code_data.length] = arr;            
        }
    }
    if(code_data != null )
    {
    	window.returnValue = code_data; 
   }
   	this.close(); 	
}
//---------------------------------------------------------------------
function OnCancel()
{
	var code_data=new Array()
	code_data[0] = 0;
	window.returnValue = code_data; 
	this.close();
}
//---------------------------------------------------------------------
</script>

<body>
<!-------------------------------------------------------------------------->
    <gw:data id="fmgf00092" onreceive=""> 
        <xml> 
            <dso id="1" type="grid" function="ACNT.sp_sel_fmgf00092" > 
                <input bind="grdAccount" >   
                    <input bind="txtAccountCode"/>
                    <input bind="txtAccountName"/>
                    <input bind="lstCompany"/>                                      
                </input>
                <output  bind="grdAccount" />
            </dso> 
        </xml> 
    </gw:data>
<!-------------------------------------------------------------------------->

<table style="height:100%; width:100%" border="1" >
    <tr style="height:15%">
        <td>
            <table style="width:100%; ">
                <tr>                    
                    <td style="width:40%;" align="right"><b>Company</b></td>
                    <td style="width:60%" align="left"><gw:list id="lstCompany" styles="width:100%; "/></td>
                </tr>
                <tr>
                    <td style="width:40%" align="right"><b>Account Code</b></td>
                    <td style="width:60%" align="left"><gw:textbox id="txtAccountCode" styles="width:100%; " onenterkey="OnSearch()" /></td>                    
                </tr>
                <tr>                
                    <td style="width:40%" align="right"><b>Account Name</b></td>
                    <td style="width:60%" align="left"><gw:textbox id="txtAccountName" styles="width:100%; " onenterkey="OnSearch()" /></td>                                                            
                </tr>                    
            </table>
        </td>
    </tr>
    <tr style="height:80%; " >
        <td>
            <table style="width:100%; height:100% ">
                <tr>
                    <td>
                            <gw:grid id="grdAccount" header="Acc.Code|Acc.Name|Acc.Local|_TAC_ABACCTCODE_PK|Chk"
                                format="0|0|0|0|3" aligns="0|0|0|0|1" defaults="||||" editcol="0|1|1|1|1"
                                widths="1000|3500|3500|0|700" styles="width:100%; height:100% " sorting="T"                                
                                acceptNullDate="T" />                                                
                    </td>
                </tr>                
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <table style="width:100%; ">
                <tr>
				    <td><gw:icon id="btnSelect" img="in" text="OK" styles="width:100"  onclick="Select()" /></td>
				    <td><gw:icon id="btnCancel" img="in" text="EXIT" styles="width:100"  onclick="OnCancel()" /></td> 
                </tr>
            </table>
        </td>
    </tr>
</table>
</body>
</html>
