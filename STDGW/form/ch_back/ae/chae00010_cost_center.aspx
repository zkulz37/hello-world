<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>genuwin</title>
</head>

<script>

function BodyInit()
{
    
     
    lstCompany.value="<%=Request.querystring("company_pk")%>";
    id.text="<%=Request.querystring("id")%>";
    idData_Dsql_Cost_Center.Call("SELECT");
    
}
function OnDataReceive(obj)
{
    if(obj.id=="idData_Dsql_Cost_Center")
    {
            for(var i=1;i<idGrid.rows;i++)
                if(id.text==idGrid.GetGridData(i,4))
                {
                    idGrid.SetCellBgColor(i, 0,i, 5, 0x3366FF );
                    idGrid.SetCellBold(i,0,i,5,true);    
                 }   
    }
}
function OnSearch()
{
    
	idData_Dsql_Cost_Center.Call("SELECT");
}

function Select()
{
	var code_data=new Array();
	var ctrl = idGrid.GetGridControl();
	if(ctrl.SelectedRows == 0)
	{
	   alert("Please Select an Item.");
	   return ;
	}
	else
	{
		//pk
		code_data[0] = idGrid.GetGridData( ctrl.row , 4 );
		//code name
		code_data[1] = idGrid.GetGridData(ctrl.row,1)+' - '+ idGrid.GetGridData( ctrl.row , 3 );		
		window.returnValue = code_data;
		this.close();
	}
}

function OnCancel()
{
//	var code_data=new Array()
//	    code_data[0] = 0;
//		window.returnValue = code_data; 
		this.close();
}
</script>
<body>

    <gw:data id="idData_Dsql_Cost_Center" onreceive="OnDataReceive(this)" >
        <xml>
            <dso type="grid" parameter="0,1" function="HR_SEL_COST_CENTER">
                <input bind="idGrid" >
                    <input bind="id_Plcode"/>
                    <input bind="id_Pl_nm"/>
                    <input bind="id_Center_code"/>
                    <input bind="id_Center_nm" />
					<input bind="lstCompany"/>
                </input>
                <output bind="idGrid" />
            </dso>
        </xml>
    </gw:data>
    
<table  border="0" width="100%" height="100%" cellpadding="0" cellspacing="0" >
  <tr> 
    <td width="100%" height="100%">
    	<table width="100%" height="100%" cellpadding=0 cellspacing=0 border=1>
            <tr height="15%">
	            <td class="itable_title">
			        <table class="table" CELLSPACING="0" CELLPADDING="0" width="100%" height="100%">
						<tr>
						    <td class="table_title" width="15%" align="right"><b>Company</b></td>
						    <td class="table_title" width="20%" align="right"><gw:list  id="lstCompany" value=" " styles='width:100%'>
                                <data>
                                    <%=ESysLib.SetListDataSQL("select a.pk,a.PARTNER_NAME from tco_company a where a.del_if=0 and nvl(a.ACTIVE_YN,'N')='Y'")%>
                                </data>
                                </gw:list>
                            </td>
						    <td class="table_title" width="15%" align="right"><b>PL Code</b></td>
							<td class="table_content" width="15%"><gw:textbox id="id_Plcode" styles="width:100%;height:25" onenterkey="OnSearch()"/></td>
							<td class="table_title" width="15%" align="right"><b>PL Name</b></td>
							<td class="table_content" width="20%"><gw:textbox id="id_Pl_nm" styles="width:100%;height:25" onenterkey="OnSearch()"/></td>
		                </tr>
		                <tr>
		                    <td class="table_title"  align="right"><b>Center Code</b></td>
						    <td class="table_title"  align="right"><gw:textbox id="id_Center_code" styles="width:100%;height:25" onenterkey="OnSearch()"/></td>
							<td class="table_title"  align="right">Center Name</td>
							<td class="table_content" colspan=3><gw:textbox id="id_Center_nm" styles="width:100%;height:25" onenterkey="OnSearch()"/></td>
						</tr>  
				    </table>
		        </td>
	    	</tr>
	    	
	    	<tr height="80%"> 
	    		<td>
	    			<table class="table" CELLSPACING="0" CELLPADDING="0" width="100%" height="100%">
	    				<tr>
					    	<td class="itable_content" height="80%">   
							<gw:grid   
							    id="idGrid"  
							    header="PL CODE|PL NAME|CENTER CODE|CENTER NAME|_center_pk"
							    format="0|0|0|0"  
							    aligns="0|0|0|0"  
							    defaults="|||"  
							    editcol="0|0|0|0|0"
							    widths="1500|4000|1500|4000|0"  
							    styles="width:100%; height:100%"   
							    sorting="T"   
							    param="0,1,2,3,4" 
							    oncelldblclick="Select()"/> 					    		    
				            </td>
		            	</tr>
		            </table>
            	<td>
	    	</tr>
	    	
		    <tr height="5">
				<td>
			    <table class="table" border=1 CELLSPACING="0" CELLPADDING="0" width="100%" height="100%" >
					<tr align="center"> 
					    <td>
					    	<table>
					    	    <tr>
									<td> 
									<gw:icon id="idBtnSelect" img="in" text="OK" styles="width:100"  onclick="Select()" />  
									</td> 
									<td> 
									<gw:icon id="idBtnSelect2" img="in" text="EXIT" styles="width:100"  onclick="OnCancel()" />  
									</td> 
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

<gw:textbox id="txtItem"    styles="width:100%;height:25" style="display:none"/>
<gw:textbox id="txtVal"     styles="width:100%;height:25" style="display:none"/>
<gw:textbox id="id"     styles="width:100%;height:25" style="display:none"/>
</body>

</html>
