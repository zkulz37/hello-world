<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
</head>
<%  ESysLib.SetUser("acnt")%>
<script>

function BodyInit()
{
	idGrid.AddRow();
	MergeCell();
	var today = new Date();
	var strDate ='';
	var thisMonth = today.getMonth() +1;
	if (thisMonth <10)
	{
		strDate = '' + today.getFullYear() +'0' +thisMonth + '01';
	}
	else
	{
		strDate = '' + today.getFullYear()  +today.getMonth() + '01';
	}
	dtFrom_Date.SetDataText(strDate);
	
	
	 data = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM comm.TCO_company  where del_if=0")%>";   
     lstCompany.SetDataText(data);
     lstCompany.value = "<%=Session("COMPANY_PK") %>";
}


function MergeCell()
{
	var fg = idGrid.GetGridControl(); 	    
        fg.FixedRows   = 2;
        fg.MergeCells  = 5;	
		fg.MergeRow(0) = true;
      
	  	fg.Cell(0, 0, 1, 0, 2)  = "Contract";   
	    fg.Cell(0, 1, 1, 1) = "No";
	    fg.Cell(0, 1, 2, 1) = "Date";
        
		fg.MergeCol(3) = true;
		fg.Cell(0, 0, 3, 1, 3) = "Confirm Date";
		
		fg.Cell(0, 0, 5, 0, 6)  = "Customer";   
	    fg.Cell(0, 1, 5, 1) = "Code";
	    fg.Cell(0, 1, 6, 1) = "Name";
		
		fg.Cell(0, 0, 8, 0, 9)  = "Project";   
	    fg.Cell(0, 1, 8, 1) = "Code";
	    fg.Cell(0, 1, 9, 1) = "Name";
	    
		fg.MergeCol(10) = true;
		fg.Cell(0, 0, 10, 1, 10) = "Terms Type";
		
		fg.MergeCol(11) = true;
		fg.Cell(0, 0, 11, 1, 11) = "Contract Ccy";
		
        fg.Cell(0, 0, 12, 0, 14)  = "Amount";   
	    fg.Cell(0, 1, 12, 1) = "Contract";
	    fg.ColFormat(12) 		= "#,###,###,###,###.##";	
	    fg.Cell(0, 1, 13, 1) = "Adjust";
	    fg.ColFormat(13) 		= "#,###,###,###,###.##";	
		fg.Cell(0, 1, 14, 1) = "Final";
		fg.ColFormat(14) 		= "#,###,###,###,###.##";	
		
		fg.Cell(2, 0, 0, 1, fg.Cols - 1) = 4; 
		fg.Cell(13, 1, 1, 1,fg.Cols - 1) = true; //Format all col merge : Fone = Bold		
		
		fg.ColWidth(0)=0;		// PK
		fg.ColWidth(1)=2000;	// CONTRACT NO
		fg.ColWidth(2)=1200;	// CONTRACT DATE
		
		fg.ColWidth(3)=1200;	// CONFIRM DATE
		
		fg.ColWidth(4)=0;		// CUST PK
		fg.ColWidth(5)=1200;	// CUST CODE
		fg.ColWidth(6)=2000;	// CUST NAME
		
		fg.ColWidth(7)= 0;	// TAC_ABPL_PK
		fg.ColWidth(8)=1200;	// PL_CD
	
		fg.ColWidth(9)=2000;	// PL_NM	
		fg.ColWidth(10)=0;	// TERMS_TYPE			
		fg.ColWidth(11)=1200;	// CONTRACT_CCY 
		fg.ColWidth(12)=1500;		// CONTRACT AMT
		
		fg.ColWidth(13)=1200;	// CONTRACT ADJ AMT
		fg.ColWidth(14)=2000;	// CONTRACT FINAL AMT
		
}

function UpperKey() 
{
	 var c = String.fromCharCode (event.keyCode); 
	 var x = c.toUpperCase().charCodeAt(0) ; 
	 event.keyCode = x; 
}

function OnGetCust()
{
	var url 	= System.RootURL + "/form/gf/qc/gfqc00090_popup_customer.aspx?ap_yn=Y";
	            var aValue  = System.OpenModal( url, 850, 500, 'resizable:yes;status:yes');	 
	            if ( aValue != null )  
	            {
		            txtCust_Pk.text   = aValue[0];//cust Pk
		            txtCust_Code.text = aValue[1];//cust code
		            txtCust_Name.text = aValue[3];//cust name 	 	
	            }  
}

function OnResetCust()
{
	txtCust_Pk.SetDataText('');
	txtCust_Code.SetDataText('');
	txtCust_Name.SetDataText('');
}


function OnGetProject()
{
	 var url 	= System.RootURL + "/form/gf/qc/gfqc00090_popup_project.aspx?";
	            var aValue  = System.OpenModal( url, 400, 500, 'resizable:yes;status:yes');	 
	            if ( aValue != null )  
	            {
		            txtProject_Pk.text   = aValue[2];
		            txtProject_Code.text = aValue[0];
		            txtProject_Name.text = aValue[1]; 	
	            }  
}

function OnResetProject()
{
	txtProject_Pk.SetDataText('');
	txtProject_Code.SetDataText('');
	txtProject_Name.SetDataText('');
}

function OnDBClick()
{
	if (event.row >= 2)
	{
		var aReturnValue = new Array();
		var as_pk   = "";
	
		as_pk = idGrid.GetGridData(event.row, 0);// Get PK
		
		aReturnValue[0]  = as_pk;
	
		window.returnValue = aReturnValue;
		window.close();
	}
	
		
}

function onSearch()
{
	dso_search.Call("SELECT");
}

function onContractEnter()
{
    if (event.keyCode !=13)
    {
    var c = String.fromCharCode (event.keyCode); 
	var x = c.toUpperCase().charCodeAt(0) ; 
	event.keyCode = x; 
	}
	else
	{
	    onSearch();
	}
}

function OnPrint()
{
    if(confirm("Are you sure you want to print ?" ))
	{
		var tmp = new Date();
		var url = System.RootURL + '/reports/acnt/bf/wabf023001_rpt.xls?com=' + lstCompany.GetData() + '&cust=' + txtCust_Pk.GetData() + '&contract=' + txtContract_No.GetData() + '&project=' + txtProject_Pk.GetData() +'&dtDateFrom=' +dtFrom_Date.GetData()+'&dtDateTo='+dtTo_Date.GetData() + '&curdate='+tmp.toString() ;
		
		System.OpenTargetPage(url,'newform');
	}
}
</script>



<body>
	<gw:data id="dso_search"  onreceive="MergeCell()" > 
        <xml> 
            <dso id="1" type="grid"  function="acnt.sp_sel_gfqc00090_search" >
                <input bind="idGrid"> 
                    <input bind="lstCompany" /> 
                    <input bind="txtContract_No" /> 
                    <input bind="txtCust_Pk" /> 
                    <input bind="txtProject_Pk" /> 
                    <input bind="dtFrom_Date" /> 
                    <input bind="dtTo_Date" /> 
                </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data> 

<table width="100%"  border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="100%"  border="1" cellpadding="0" cellspacing="2">
      <tr>
        <td><table width="100%"  border="0" cellpadding="0" cellspacing="1">
          <tr>
            <td align="right" width="7%" id=up class=topleft><span style="font-weight: bold">Company&nbsp;&nbsp;</span></td>
            <td width="13%">
				<gw:list id="lstCompany"  styles='width:100%;display:'> 
					
				</gw:list >
			</td>
            <td colspan="6" rowspan="2">
				<table width="100%" cellpadding="0" cellspacing="0">
				<tr>
					 <td align="right" width="8%"><span style="font-weight: bold"><a title="Click here to select Customer" onclick="OnGetCust()" href="#tips"
                                     style="text-decoration: none; color=#0000ff"><b>&nbsp;Customer&nbsp;&nbsp;</b></a></span></td>
					<td width="13%">
					<gw:textbox id="txtCust_Pk" styles="display:none" />
					<gw:textbox id="txtCust_Code" onkeypress="UpperKey()" onchange="" styles="width:100%" />
					</td>
				<td width="25%"><gw:textbox id="txtCust_Name" onkeypress="UpperKey()" onchange="" styles="width:100%" /></td>
				<td width="2%"></td>
				<td width="2%"><gw:imgbtn id="ibtnReset_Cust" img="reset" alt="Reset" onclick="OnResetCust()" /></td>
				
				<td align="left" width="18%"><span style="font-weight: bold">&nbsp;&nbsp;&nbsp;&nbsp;Contract No.&nbsp;&nbsp; </span></td>
					<td align="left" width="32%"  colspan="3" >
					    <table border="0" cellpadding="0" cellspacing="0" width="100%">
					    <tr>
					        <td width="80%"><gw:textbox id="txtContract_No" onkeypress="onContractEnter()" onchange="" styles="width:100%" /></td>
					       <td width="2%" align="left">&nbsp;</td>  
					       <td width="8%" align="left"><gw:imgbtn id="ibtnSearch" img="search"  alt="Search" onclick="onSearch()"/></td> 
					       <td width="2%" align="left">&nbsp;</td> 
					       <td width="8%" align="left"><gw:imgBtn id="ibtnPrint" 	img="printer" alt="Print" 	onclick="OnPrint()" /></td> 
					    </tr>
					     </table>
					</td>					
					</tr>
				<tr>
                <td align="right" width="8%"><span style="font-weight: bold"><a title="Click here to select Project" onclick="OnGetProject()" href="#tips"
                                     style="text-decoration: none; color=#0000ff"><b>&nbsp;Project&nbsp;&nbsp;</b></a></span></td>
				<td >
					<gw:textbox id="txtProject_Pk" styles="display:none" />
					<gw:textbox id="txtProject_Code" onkeypress="UpperKey()" onchange="" styles="width:100%" />
				</td>
				<td ><gw:textbox id="txtProject_Name" onkeypress="UpperKey()" onchange="" styles="width:100%" /></td>
				<td width="2%"></td>
				<td width="2%"><gw:imgbtn id="ibtnReset_Project" img="reset" alt="Reset" onclick="OnResetProject()" /></td>
					
					
					<td align="right"  width="18%"><span style="font-weight: bold">Confirm Date From&nbsp;&nbsp;</span></td>
				<td  width="15%"><gw:datebox id="dtFrom_Date" lang="1" styles="width:75%"></gw:datebox></td>
				<td align="left"  width="2%"><span style="font-weight: bold">~</span></td>
				<td  width="15%"><gw:datebox id="dtTo_Date" lang="1" styles="width:75%"></gw:datebox></td>
							
					</tr>
				</table>
			</td>
          </tr>
          <tr>
            <td colspan="2">&nbsp;</td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td>
			<gw:grid   
				id="idGrid"  
				header="pk|contractno|contractdate|confirmdate|custpk|custcd|custnm|termstype|ccy|amt|adjamt|finalamt|plpk|plcd|plnm"   
				format="0|0|0|0|0|0|0|0|0|1|1|1|1|1|"  
				aligns="0|0|0|0|0|0|0|2|2|2|2|3|3|3|3"  
				defaults="||||||||||||||"  
				editcol="1|1|1|1|1|1|1|1|1|1|1|1|1|1|1"  
				widths="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
				styles="width:100%; height:380"   
				sorting="T" 
				oncelldblclick = "OnDBClick()"  
				param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14"  /> 

		</td>
      </tr>
    </table></td>
  </tr>
</table>
</body>
</html>



