<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>genuwin</title>
</head>

<script>

//"_PK|BANK ACCOUNT|BANK NAME|CURRENCY|SWIFF CODE|BANK ID"

var c_pk=0,c_bank_acc=1,c_bank_name=2,c_currency=3,c_swiff_code=4,c_bank_id=5,c_acc_holder=6;
var l_ref_pk;
function BodyInit()
{
    
     
    lstCompany.value="<%=Request.querystring("p_company_pk")%>";
    l_ref_pk="<%=Request.querystring("p_ref_pk")%>";
    
    idData_CHCS00272_01_01.Call("SELECT");
    
}
function OnDataReceive(obj)
{
   if(obj.id=="idData_CHCS00272_01_02")
   {
     this.close();
   }
   if(obj.id=="idData_CHCS00272_01_01")
   {
       var ctrl = idGrid.GetGridControl();
       for(var i=1;i<ctrl.rows;i++) 
       {
         
         if(idGrid.GetGridData(i,c_pk)==l_ref_pk)
         {
            idGrid.SetCellBgColor(i, c_pk,i, c_acc_holder, 0xCC9900 );
         }
         
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
	    if(confirm("Do you want to confirm this bank account?"))
	    {
	        txt_pk.text=idGrid.GetGridData( ctrl.row , c_pk );
	        txt_bank_account.text=idGrid.GetGridData( ctrl.row , c_bank_acc );
	        txt_bank_name.text=idGrid.GetGridData( ctrl.row , c_bank_name );
	        txt_currency.text=idGrid.GetGridData( ctrl.row , c_currency );
	        txt_swiff_code.text=idGrid.GetGridData( ctrl.row , c_swiff_code );
	        txt_acc_holder.text=idGrid.GetGridData( ctrl.row , c_acc_holder );
	        idData_CHCS00272_01_02.Call();
		 }   
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

    <gw:data id="idData_CHCS00272_01_01" onreceive="OnDataReceive(this)" >
        <xml>
            <dso type="grid" parameter="0,1" function="HR_SEL_CHCS00272_01_01">
                <input bind="idGrid" >
                    <input bind="lstCompany"/>
                </input>
                <output bind="idGrid" />
            </dso>
        </xml>
    </gw:data>

<gw:data id="idData_CHCS00272_01_02" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="process" procedure="HR_sp_pro_CHCS00272_01_02"  > 
                <input>
                    <input bind="txt_pk" />
                    <input bind="txt_bank_account" />
                    <input bind="txt_bank_name" />
                    <input bind="txt_currency" />
                    <input bind="txt_swiff_code" />
                    <input bind="txt_acc_holder" />
                </input> 
                <output>
                    <output bind="txttmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>    
    
<table  border="0" width="100%" height="100%" cellpadding="0" cellspacing="0" >
  <tr> 
    <td width="100%" height="100%">
    	<table width="100%" height="100%" cellpadding=0 cellspacing=0 border=1>
            <tr height="5%">
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
		                </tr>
				    </table>
		        </td>
	    	</tr>
	    	<tr height="90%"> 
	    		<td>
	    			<table class="table" CELLSPACING="0" CELLPADDING="0" width="100%" height="100%">
	    				<tr>
					    	<td class="itable_content" height="80%">   
							<gw:grid   
							    id="idGrid"  
							    header="_PK|BANK ACCOUNT|BANK NAME|CURRENCY|SWIFF CODE|BANK ID|ACCOUNT HOLDER"
							    format="0|0|0|0|0|0|0"
							    aligns="0|0|0|0|0|0|0"  
							    defaults="||||||"  
							    editcol="0|0|0|0|0|0|0"
							    widths="0|2000|4000|1500|1500|3000|2000"
							    styles="width:100%; height:100%"   
							    sorting="T"   
							    oncelldblclick=""/> 					    		    
				            </td>
		            	</tr>
		            </table>
            	<td>
	    	</tr>
	    	
		    <tr height="5%">
				<td>
			    <table class="table" border=1 CELLSPACING="0" CELLPADDING="0" width="100%" height="100%" >
					<tr align="center"> 
					    <td>
					    	<table>
					    	    <tr>
									<td> 
									<gw:icon id="idBtnSelect" img="in" text="Confirm" styles="width:100"  onclick="Select()" />  
									</td> 
									<td> 
									<gw:icon id="idBtnSelect2" img="in" text="Exit" styles="width:100"  onclick="OnCancel()" />  
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
<gw:textbox id="txttmp"     styles="width:100%;height:25" style="display:none"/>
<gw:textbox id="txt_pk"     styles="width:100%;height:25" style="display:none"/>
<gw:textbox id="txt_bank_account"     styles="width:100%;height:25" style="display:none"/>
<gw:textbox id="txt_bank_name"     styles="width:100%;height:25" style="display:none"/>
<gw:textbox id="txt_currency"     styles="width:100%;height:25" style="display:none"/>
<gw:textbox id="txt_swiff_code"     styles="width:100%;height:25" style="display:none"/>
<gw:textbox id="txt_acc_holder"     styles="width:100%;height:25" style="display:none"/>


</body>

</html>
