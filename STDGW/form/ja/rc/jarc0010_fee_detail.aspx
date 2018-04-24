<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Pop Up Get Fee Detail</title>
</head>
<%  ESysLib.SetUser("crm")
  
%>

<script>

  
//-----------------------------------------------------------

function BodyInit()
{
    var pk = "<%=Request.querystring("customFeeDPK")%>";   
    var cardNum = "<%=Request.querystring("cardNum")%>";   
    var invoiceNo = "<%=Request.querystring("invoiceNo")%>";   
    txtCustomFeePK.text = pk
    txtRefNo.text = invoiceNo
    txtCardNo.text = cardNum
    txtRefNo.SetEnable(false)
    txtCardNo.SetEnable(false)
    data_jarc0010.Call("SELECT");
}

//-----------------------------------------------------------

function OnSearch()
{
    data_jarc0010.Call("SELECT");
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
		        var arrTemp=new Array();
		        for(j=0; j < idGrid.cols -1; j++)
	        	{
            		arrTemp[arrTemp.length] = idGrid.GetGridData(rowNo , j );
            		
            	} 
              code_data[index] = arrTemp;
              index ++;
		}
	}
	window.returnValue = code_data; 
	this.close(); 	
}

//-----------------------------------------------------------

</script>

<body>
    <!------------------------------------------------------------------------>
    <gw:data id="data_jarc0010" onreceive=""> 
        <xml> 
           <dso id="1" type="grid" function="CRM.sp_sel_jarc0010_6" > 
                  <input bind="idGrid" > 
                    <input bind="txtCustomFeePK" />                    
                  </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------>
    <table style="height: 100%; width: 100%">
        <tr style="height: 1%">
            <td style="width: 15%" align="right">
                Ref No
            </td>
            <td style="width: 30%">
                <gw:textbox id="txtRefNo" styles="width:100%"  onenterkey="OnSearch()" />
                 <gw:textbox id="txtCustomFeePK" styles="width:100%;display:none"   />
            </td>
            <td style="width: 15%" align="right">
                Card Num
            </td>
            <td style="width: 30%">
                <gw:textbox id="txtCardNo" styles="width:100%" onenterkey="OnSearch()" />
            </td>
           
            <td style="width: 5%" align="right">
               
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn id="idSearch" img="search" alt="Search" onclick="OnSearch()" />
            </td>           
        </tr>
        <!------------------------------------------------------------------------>
        <tr style="height: 99%">
            <td colspan="9">
                <gw:grid id='idGrid'
                header='_PK|Item Code|Item Name|Quantity|Unit|Unit Price|Amount|Discount|Vat(%)|Vat Amount|Pay Amount|Card No'
                format='0|0|0|0|0|1|1|1|1|1|1|0'
                aligns='0|0|0|0|0|0|0|0|0|0|0|0'
                check='|||||||||||'
                editcol='0|0|0|0|0|0|0|0|0|0|0|0'
                widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|0'
                sorting='T'
                autosize='T' 
                styles='width:100%; height:100%'
                />
               
               
            </td>
        </tr>
        <!------------------------------------------------------------------------>
    </table>
</body>
</html>
