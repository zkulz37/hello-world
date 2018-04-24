<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
</head>
<%  ESysLib.SetUser("acnt")%>

<script>
var arr_data = new Array();
function BodyInit()
{
  
  OnSearch();
}
//----------------------------------------------------------------------------------------------------------------------------------
function OnSearch()
{
  
   
        idData_Dsql_Get_Customer_M_subcontract.Call('SELECT');
  
}
//----------------------------------------------------------------------------------------------------------------------------------
function OnSelectCustomer()
{
   var ctrl = idGrid.GetGridControl();
  
   if(ctrl.Row > 0)
   {
		
		arr_data[0] = idGrid.GetGridData(ctrl.Row,0);  //Pk
		arr_data[1] =idGrid.GetGridData(ctrl.Row,1);   // cust code
		arr_data[2] =idGrid.GetGridData(ctrl.Row,4);   // tax code
		arr_data[3] = idGrid.GetGridData(ctrl.Row,2);  //Cust Name
		arr_data[4] = idGrid.GetGridData(ctrl.Row,3);  //Address Name
		
		
		
	  window.returnValue =  arr_data;
	  window.close();

   }	  
	  
}
function MergeHeaderGrid()
{
  		var fg=idGrid.GetGridControl(); 	    
        fg.FixedRows = 2
        fg.MergeCells =5	
		fg.MergeRow(0) = true
        // Customer
        fg.Cell(0, 0, 1, 0, 2)  = "Vendor"   //fg.Cell(0,row, from_col, row, to_col)		
	    fg.Cell(0, 1, 1, 1) = "Code"
	    fg.Cell(0, 1, 2, 1) = "Name"		   		
		//Address		
		fg.MergeCol(3) = true
		fg.Cell(0, 0, 3, 1, 3) = "Address"	
		//Tax Code
		fg.MergeCol(4) = true
		fg.Cell(0, 0, 4, 1,4 ) = "Tax Code"				
		fg.Cell(2, 0, 0, 1, fg.Cols - 1) = 4; 
		fg.Cell(13, 1, 1, 1,fg.Cols - 1) = true; //Format all col merge : Fone = Bold					
}

function checkKey() 
{
	 var c = String.fromCharCode (event.keyCode); 
	 var x = c.toUpperCase().charCodeAt(0) ; 
	 event.keyCode = x; 
}
//----------------------------------------------------------------------------------------------------------------------------------
</script>
<body>
   
<!----------------------------------------------------------------------------------------------->
    <gw:data id="idData_Dsql_Get_Customer_M_subcontract"    onreceive="MergeHeaderGrid()" > 
        <xml> 
            <dso id="1" type="grid"  function="acnt.sp_sel_gfqc00090_cus_2" >
                <input bind="idGrid"> 
					<input bind="txtCustomerID" />
					<input bind="txtCustomerName" />					
					<input bind="chkAR_YN" />
					<input bind="chkAP_YN" />
					<input bind="txtTaxcode"/>
                </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data> 
<!-------------------------------------------------------------------------------------------------->    
    <gw:data id="idData_Dsql_Get_Customer" onreceive="MergeHeaderGrid()" > 
        <xml> 
            <dso id="1" type="grid"  function="acnt.sp_sel_gfqc00090_cus" >
                <input bind="idGrid"> 
                    <input bind="txtCustomerID" />
					<input bind="txtCustomerName" />					
					<input bind="chkAR_YN" />
					<input bind="chkAP_YN" />
					<input bind="txtTaxcode"/>
                </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data> 

<table  width=100%>
	<tr>
	    <td width=3% align =center ><b>Code</b></td>	
	    <td width=10% align =center><gw:textbox id="txtCustomerID" styles="width:100%" onenterkey="OnSearch()"onkeypress="checkKey()"/></td>		
		<td width=5% align =center><b> Name</b></td>		
	    <td width=25% align =center><gw:textbox id="txtCustomerName" styles="width:100%" onenterkey="OnSearch()"/></td>
		<td width =7% align =center><b>TaxCode</b></td>		
		<td width=10% align =center><gw:textbox id="txtTaxcode"styles="width:100%"  onenterkey="OnSearch()"onkeypress="checkKey()"/></td>		
		<td width=8%  align =center><b>Customer<b></td>		
		<td width=3% align =center><gw:checkbox id="chkAR_YN" defaultvalue="Y|N" value="N" /></td>
		<td width=5%  align =right><b>Vendor<b></td>		
		<td width=3% align =left ><gw:checkbox id="chkAP_YN" defaultvalue="Y|N" value="N" /></td>
		<td width="7%" align="right"><b></b></td>
		<td width=4% align="left"></td>
		<td width=3%><gw:imgBtn id="idSearch" img="search" alt="Search" onclick="OnSearch()" /></td>					
	</tr>	
	<tr>
	    <td colspan=13>
			<gw:grid   
				id="idGrid"  
				header="_Pk|Cust Code|Cust Name|Address|Tax Code"   
				format="0|0|0|0|0"  
				aligns="0|1|0|0|0"  
				defaults="||||"  
				editcol="1|1|1|1|1"  
				widths="0|1300|3350|4200|500"  
				styles="width:100%; height:380"   
				sorting="F"   
				oncelldblclick="OnSelectCustomer()"
                param="0,1,2,3,4"  /> 

	    </td>
	</tr>
</table >
</body>
</html>





