<!-- Popup dung de get customer tuong tu popupgetpartnet.aspx -->
<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>genuwin</title>
</head>
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<script>
var _selected = false;

function BodyInit()
{  
    System.Translate(document);
    var l_company_pk = "<%=Request.querystring("company_pk")%>";
	txtCompany_pk.SetDataText(l_company_pk);
}
function OnSearch1()
{
    datGetCustomer.Call("SELECT");
}

function DblClick()
{
        var code_data=new Array()
	    var ctrl = idGrid.GetGridControl();
        code_data[0] = idGrid.GetGridData( ctrl.row , 0 ); //pk
		code_data[1] = idGrid.GetGridData( ctrl.row , 1 );// Project Code
		code_data[2] = idGrid.GetGridData( ctrl.row , 2 ); //3.Project Name
		code_data[3] = idGrid.GetGridData( ctrl.row , 3 ); //3.Project Name
		code_data[4] = idGrid.GetGridData( ctrl.row , 4 ); //3.Project Name

		code_data[5] = idGrid.GetGridData( ctrl.row , 5 ); //3.Project Name
		code_data[6] = idGrid.GetGridData( ctrl.row , 6 ); //pk
		code_data[7] = idGrid.GetGridData( ctrl.row , 7 );// Project Code
		code_data[8] = idGrid.GetGridData( ctrl.row , 8 ); //3.Project Name
		code_data[9] = idGrid.GetGridData( ctrl.row , 9 ); //3.Project Name
		code_data[10] = idGrid.GetGridData( ctrl.row , 10 ); //3.Project Name

		code_data[11] = idGrid.GetGridData( ctrl.row , 11 );// Project Code
		code_data[12] = idGrid.GetGridData( ctrl.row , 12 ); //3.Project Name
		code_data[13] = idGrid.GetGridData( ctrl.row , 13 ); //3.Project Name
		code_data[14] = idGrid.GetGridData( ctrl.row , 14 ); //3.Project Name

		code_data[15] = idGrid.GetGridData( ctrl.row , 15 ); //3.Project Name
		code_data[16] = idGrid.GetGridData( ctrl.row , 16 ); //pk
		code_data[17] = idGrid.GetGridData( ctrl.row , 17 );// Project Code
		code_data[18] = idGrid.GetGridData( ctrl.row , 18 ); //3.Project Name
		code_data[19] = idGrid.GetGridData( ctrl.row , 19 ); //3.Project Name

		code_data[20] = idGrid.GetGridData( ctrl.row , 20 ); //pk
		code_data[21] = idGrid.GetGridData( ctrl.row , 21 );// Project Code
		code_data[22] = idGrid.GetGridData( ctrl.row , 22 ); //3.Project Name
		code_data[23] = idGrid.GetGridData( ctrl.row , 23 ); //3.Project Name
		code_data[24] = idGrid.GetGridData( ctrl.row , 24 ); //3.Project Name
		code_data[25] = idGrid.GetGridData( ctrl.row , 25 ); //3.Project Name
		window.returnValue = code_data; 
	   	this.close(); 	
}    
function OnResetCust()
{
    txtCustomerName.text = "";
    txtCustomerID.text = "";
}

</script>
<body style="margin:0; padding:0;">

    
    <gw:data id="datGetCustomer" >
	<xml>
		<dso type="grid" function="ac_sel_60080030_partner_popup" >
			<input bind="idGrid">
				 <input bind="txtCustomerID"/>
				 <input bind="txtCustomerName"/>
				 <input bind="chkAR_YN" />
				<input bind="chkAP_YN" />
				<input bind="chkCO_YN" />
				<input bind="txtTaxCode" />
				<input bind="txtCompany_pk" />
			</input>
			<output bind="idGrid"/>
		</dso>
	</xml>
  </gw:data>

    <table  style="width:100%;height:100%" cellpadding="0" cellspacing="0">
	<tr style="height:2%">
        <td>
            <fieldset style="padding:0">
                <table width="100%" cellpadding="1" cellspacing="1">
                    <tr>
                            <td width=5%>Partner</td>
                            <td width=50%>
		    <table width=100% border = 0 cellpadding= 0 cellspacing= 0 >
		    <tr>
		        <td width=25%><gw:textbox id="txtCustomerID"    	csstype="mandatory"   styles="width:100%" onenterkey="OnSearch1()"  /></td>
				  <td width=50%><gw:textbox id="txtCustomerName"    	csstype="mandatory"  styles="width:100%" onenterkey="OnSearch1()"  /></td>
				  <td width=25%><gw:textbox id="txtTaxCode"    	styles="width:100%" onenterkey="OnSearch1()" /></td>
        		<td ><gw:imgBtn id="btnResetCust" img="reset" alt="Reset"         onclick="OnResetCust()"/></td>
		    </tr>
		    </table>
		</td>
		                    <td width=5%></td>
		                    <td width=10%>Vendor</td>
		                    <td width=5%><gw:checkbox id="chkAR_YN" defaultvalue="Y|N" value="Y" /></td>
		                    <td width=10%>Customer</td>
		                    <td width=5%><gw:checkbox id="chkAP_YN" defaultvalue="Y|N" value="N" /></td>
		                    <td width=10%>Company</td>
		                    <td width=5%><gw:checkbox id="chkCO_YN" defaultvalue="Y|N" value="N" /></td>		
		                    <td width=5%><gw:imgBtn id="idSearch" img="search" alt="Search" onclick="OnSearch1()" /></td>	
		                    <td width=5%><gw:imgBtn id="idSelect" img="select" alt="Select" onclick="DblClick()" /></td>		
                    </tr>
                </table>
            </fieldset>
        </td>
	    			
	</tr>
	<tr style="height:98%">
	    <!--0_c.PK|1.Cust ID|2.Cust Name|3.Local Name|4_FOREIGN_NM|5_PARTNER_TYPE|6.TAX CODE|7.SERIAL NO|8.FORM NO|9.ADDRESS|10_ADD_2|11_ADD_3|12_PHONE_NO|13_EMAIL|14_FAX|15_WEBSITE|16_SALE_PRESENT|17_COM_YN|18_CUS_YN|19_CUS_ACTIVE_YN|20_VEN_YN|21_VEN_ACT_YN|22_ACT_YN|23_VALID_F|24_VALID_T|25_DESCRIPT--->
	    <td >
			
			<gw:grid   
			id="idGrid"  
			header="_c.PK|Cust ID|Cust Name|Local Name|_FOREIGN_NM|_PARTNER_TYPE|TAX CODE|SERIAL NO|FORM NO|ADDRESS|_ADD_2|_ADD_3|_PHONE_NO|_EMAIL|_FAX|_WEBSITE|_SALE_PRESENT|_COM_YN|_CUS_YN|_CUS_ACTIVE_YN|_VEN_YN|_VEN_ACT_YN|_ACT_YN|_VALID_F|_VALID_T|_DESCRIPT"   
			format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
			aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
			defaults="||||||||||||||||||||||||||"  
			editcol="1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1"  
			widths="0|1000|3000|4000|0|0|1550|1000|1000|1000|4000|0|0|0|0|0|0|0|0|0|0|0|0|0"  
			styles="width:100%; height:100%"   
			sorting="T"   
			acceptNullDate
			oncelldblclick= "DblClick()" /> 
	    </td>
	</tr>
</table >
<gw:textbox id="txtCompany_pk"    	  styles="width:100%;display:none"  />
</body>
</html>
