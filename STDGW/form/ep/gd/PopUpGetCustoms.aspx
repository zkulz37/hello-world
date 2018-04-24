<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Pop Up Get Partner</title>
</head>
<%  ESysLib.SetUser("comm")
  
%>

<script>

var  partner = "<%=request.QueryString("partner_type")%>" ;

//-----------------------------------------------------------

function BodyInit()
{
    System.Translate(document);  // Translate to language session
    
    var data="";
    data = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('CODC0010','','') FROM DUAL")%>|-1|Select All"; 
    cboPartnertype.SetDataText(data);
    
    if (partner!='')
        cboPartnertype.value=partner;
    else
        cboPartnertype.value=-1;
    
    cboPartnertype.SetEnable(false);
    dsoGetCustomer.Call("SELECT");
}

//-----------------------------------------------------------

function OnSearch()
{
    dsoGetCustomer.Call("SELECT");
}

//-----------------------------------------------------------

function OnSelect()
{
    var code_data=new Array()
	var ctrl = idGrid.GetGridControl();
	var index, rowNo
	
	index =0;
	rowNo = 0 ;
	
	if(ctrl.SelectedRows == 0)
    {
           return ;
    }
    else
	{
	    for(i=0; i < ctrl.SelectedRows; i++)
		{	  
		        rowNo = ctrl.SelectedRow(i)
		        for(j=0; j < idGrid.cols -1; j++)
	        	{
            		code_data[index] = idGrid.GetGridData(rowNo , j );
            		index ++;
            	}        
		}
	}
	window.returnValue = code_data; 
	this.close(); 	
}

//-----------------------------------------------------------

</script>

<body>
    <gw:data id="dsoGetCustomer" onreceive=""> 
    <xml> 
           <dso id="1" type="grid" function="IMEX.sp_sel_get_customs_popup" > 
                  <input bind="idGrid" > 
                    <input bind="txtCustomerID" /> 
                    <input bind="txtCustomerName" /> 
                    <input bind="cboPartnerType" />
                  </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>
    <table width="100%">
        <tr>
            <td width="10%" align="right">
                <b>Partner</b>
            </td>
            <td width="15%">
                <gw:textbox id="txtCustomerID" styles="width:100%" csstype="mandatory" onenterkey="OnSearch()" />
            </td>
            <td width="20%">
                <gw:textbox id="txtCustomerName" styles="width:100%" csstype="mandatory" onenterkey="OnSearch()" />
            </td>
            <td width="15%" align="right">
                <b>Partner Type<b>
            </td>
            <td width="25%" align="left">
                <gw:list id="cboPartnertype" styles="width:100%;"></gw:list>
            </td>
            <td width="1%" align="right">
                <b><b>
            </td>
            <td width="1%" align="left">                
            </td>
            <td width="1%" align="right">
            </td>
            <td width="1%" align="left">
            </td>
            <td width="5%" align="right">
                <gw:imgbtn id="idSearch" img="search" alt="Search" onclick="OnSearch()" />
            </td>
            <td width="5%" align="right">
                <gw:imgbtn id="idSelect" img="select" alt="Select" onclick="OnSelect()" />
            </td>
        </tr>
        <tr>
            <td colspan="11">
                <gw:grid id="idGrid" header="_c.PK|Cust ID|Cust Name|Local Name|_FOREIGN_NM|_PARTNER_TYPE|_TAX_CODE|ADDRESS|_ADD_2|_ADD_3|_PHONE_NO|_EMAIL|_FAX|_WEBSITE|_SALE_PRESENT|_COM_YN|_CUS_YN|_CUS_ACTIVE_YN|_VEN_YN|_VEN_ACT_YN|_ACT_YN|_VALID_F|_VALID_T|_DESCRIPT"
                    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                    defaults="||||||||||||||||||||||||" editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                    widths="0|1000|3000|4000|0|0|0|4000|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" styles="width:100%; height:500"
                    sorting="T" param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23"
                    oncelldblclick="OnSelect()" />
            </td>
        </tr>
    </table>
</body>
</html>
