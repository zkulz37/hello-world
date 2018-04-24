<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Pop Up Get Partner</title>
</head>
<%  ESysLib.SetUser("prod")
  
%>

<script>

var  partner = "<%=request.QueryString("partner_type")%>" ;
var  partner_id = "<%=request.QueryString("partner_id")%>" ;


//-----------------------------------------------------------

function BodyInit()
{
    if ( partner == 'AR' )
    {
        chkAR_YN.value = 'Y'; 
    }
    else if ( partner == 'AP' )    
    {
        chkAP_YN.value = 'Y';
    }
    else
    {
        chkAR_YN.value = 'Y'; 
        chkAP_YN.value = 'Y';
    }
    txtCustomerID.text = partner_id;
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
           <dso id="1" type="grid" function="PROD.SP_SEL_GET_PARTNER_POPUP" > 
                  <input bind="idGrid" > 
                    <input bind="txtCustomerID" /> 
                    <input bind="txtCustomerName" /> 
                    <input bind="chkAR_YN" />
                    <input bind="chkAP_YN" />
					<input bind="chkCO_YN" />
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
            <td width="10%" align="right">
                <b>Vendor<b>
            </td>
            <td width="5%" align="left">
                <gw:checkbox id="chkAR_YN" value="T" />
            </td>
            <td width="10%" align="right">
                <b>Customer<b>
            </td>
            <td width="5%" align="left">
                <gw:checkbox id="chkAP_YN" value="T" />
            </td>
            <td width="10%" align="right">
            </td>
            <td width="5%" align="left">
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
<gw:checkbox id="chkCO_YN" value="F" styles="display:none;" />
</html>
