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
<% ESysLib.SetUser("acnt");
%>

<script>
function BodyInit()
{
    var idCommNm  = "<%=Request["comm_nm"]%>"; 
    var idCommCd  = "<%=Request["comm_code"]%>" ; 
    var idDsqlid  = "<%=Request["dsqlid"]%>" ;
    var idCommNm2 = "<%=Request["comm_nm2"]%>" ;
    var idval1  =  "<%=Request["val1"]%>" ;
    var idval2  =  "<%=Request["val2"]%>" ;
    var idval3  =  "<%=Request["val3"]%>" ;
	var idComp_PK  =  "<%=Request["comp_pk"]%>" ;
	var idWH_PK  =  "<%=Request["WH_PK"]%>" ;
	var idUser = "<%=Request["user_id"]%>" ;
	var idLang = "<%=Request["language"]%>" ;
    
    txtCode.text = idCommCd ;
	txtName.text = idCommNm ;
	txtName2.text = idCommNm2;
	txtleaf.text = 'Y';
	txtuser.text = idUser ;
	txtLang.text = idLang ;
	
	txtCompanyPK.text = idComp_PK ;
	
	OnSearch();
}
function OnSearch()
{
    dsoAccountT.Call("SELECT");
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
        //code
        code_data[0] = idGrid.GetGridData( ctrl.row , 0 );
        //code nm
        code_data[1] = idGrid.GetGridData( ctrl.row , 1 );
        //code nm2
		code_data[2] = idGrid.GetGridData( ctrl.row , 2 );
		//pk
		code_data[3] = idGrid.GetGridData( ctrl.row , 3 );
		//value
		code_data[4] = idGrid.GetGridData( ctrl.row , 4 );
		
		code_data[5] = idGrid.GetGridData( ctrl.row , 5 );
		
		code_data[6] = idGrid.GetGridData( ctrl.row , 6 );
		
		code_data[7] = idGrid.GetGridData( ctrl.row , 7 );
		
		code_data[8] = idGrid.GetGridData( ctrl.row , 8 );
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
            //code nm
            index ++;
            code_data[index] = idGrid.GetGridData( rowNo, 1 );
            //code nm2
            index ++;
		    code_data[index] = idGrid.GetGridData( rowNo, 2 );
		    //pk
		    index ++;
		    code_data[index] = idGrid.GetGridData( rowNo, 3 );
		    //value
		    index ++;
		    code_data[index] = idGrid.GetGridData( rowNo, 4 );
		    index ++;
		    code_data[index] = idGrid.GetGridData( rowNo, 5 );
		    index ++;
		    code_data[index] = idGrid.GetGridData( rowNo, 6 );
		    index ++;
		    code_data[index] = idGrid.GetGridData( rowNo, 7 );
		    index ++;
		    code_data[index] = idGrid.GetGridData( rowNo, 8 );
            index ++;				    
        }
	}
	window.returnValue = code_data; 
	this.close(); 	
}

</script>
<body>

<gw:data id="dsoAccountT"  onreceive="" > 
    <xml> 
        <dso id="1" type="grid" function="<%=Request["dsqlid"]%>" > 
            <input bind="idGrid" > 
                <input bind="txtCode"/> 
                <input bind="txtName"/> 
				<input bind="txtleaf"/>
				<input bind="txtCompanyPK"/>
                <input bind="txtWHPK"/>                
                <input bind="txtUseYN"/>
				<input bind="txtLang"/>
				<input bind="txtuser"/>
            </input> 
            <output bind="idGrid" /> 
        </dso> 
    </xml> 
</gw:data> 

<form id="form1" runat="server">
    <table  border="0" width="100%" height="100%" cellpadding="0" cellspacing="0" >
    <tr> 
        <td width="100%" height="100%">
    	    <table width="100%" height="100%" cellpadding=0 cellspacing=0 border=1>
            <tr height="15%">
	            <td > 
                    <table CELLSPACING="0" CELLPADDING="0" width="100%" height="100%">
					<tr>
						<td width="25%" align="right"><b>Account Code&nbsp;&nbsp;</b></td>
						<td><gw:textbox id="txtCode" styles="width:90%;height:20" onenterkey="OnSearch()"/></td>
		            </tr>
		            <tr>
						<td width="25%" align="right"><b>Account Name&nbsp;&nbsp;</b></td>
						<td><gw:textbox id="txtName" styles="width:90%;height:20" onenterkey="OnSearch()"/></td>
					</tr>  
		            <tr>
						<td width="25%" align="right"><b>Upper Account Name&nbsp;&nbsp;</b></td>
						<td><gw:textbox id="txtName2" styles="width:90%;height:20" onenterkey="OnSearch()"/></td>
					</tr>		        
				    </table>
		        </td>
	    	</tr>

	    	<tr height="80%"> 
	    		<td>
	    			<table CELLSPACING="0" CELLPADDING="0" width="100%" height="100%">
                    <tr>
			    	    <td height="80%">   
					    <gw:grid   
					        id="idGrid"  
					        header="Account Code|Account Name|Upper Account Name|_PK|_value|_|_|_|_"
					        format="0|0|0|0|0|0|0|0|0"
					        aligns="0|0|0|0|0|0|0|0|0"  
					        defaults="||||||||"  
					        editcol="0|0|0|0|0|0|0|0|0"  
					        widths="1800|2500|2500|0|0|0|0|0|0"  
					        styles="width:100%; height:100%"   
					        sorting="T"   
					        param="0,1,2,3,4,5,6,7,8"  
					        oncelldblclick="Select()" />
		                </td>
		            </tr>
		            </table>
            	<td>
	    	</tr>

		    <tr height="5">
				<td>
					<table border=1 CELLSPACING="0" CELLPADDING="0" width="100%" height="100%" >
					<tr align="center"> 
					    <td>
						    <table>
						    <tr>
							    <td><gw:icon id="btnSelect" img="in" text="OK" styles="width:100"  onclick="Select()" /></td>
							    <td><gw:icon id="btnCancel" img="in" text="EXIT" styles="width:100"  onclick="OnCancel()" /></td> 
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

<gw:textbox id="txtleaf" text="Y" style="display:none"/>
<gw:textbox id="txtUseYN" text="Y" style="display:none"/>
<gw:textbox id="txtuser"              style="display:none"/>
<gw:textbox id="txtLang"              style="display:none"/>
<gw:textbox id="txtCompanyPK"              style="display:none"/>
<gw:textbox id="txtWHPK"              style="display:none"/>
</body>
</html>