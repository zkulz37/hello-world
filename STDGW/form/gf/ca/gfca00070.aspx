<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>genuwin</title>
  </head>
 <%ESysLib.SetUser("acnt")%>
 
<script>

var lang = "<%=Session("SESSION_LANG")%>";

function BodyInit()
{
  var data;
  grdDetail.AddRow();
  MergeHeaderGrid();
  grdDetail.GetGridControl().WordWrap = true;
  grdDetail.GetGridControl().RowHeight(0) = 300 ;
  System.Translate(document);
  data  = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
  lstCompany.SetDataText(data);
  lstCompany.value = "<%=session("company_pk") %>";
  SetColumnFormat();
}
function SetColumnFormat()
{
    var fg = grdDetail.GetGridControl();
    fg.ColFormat(7) = "###,###.##R";
    fg.ColFormat(8) = "###,###.##R";
    fg.ColFormat(9) = "###,###.##R";
    fg.ColFormat(10) = "###,###.##R";
    fg.ColFormat(11) = "###,###.##R";
    fg.ColFormat(12) = "###,###.##R";
    fg.ColFormat(13) = "###,###.##R";
    fg.ColFormat(14) = "###,###.##R";
}
function SetGridData()
{
   
}

function MergeHeaderGrid()
{
	var fg=grdDetail.GetGridControl(); 	    
        fg.FixedRows = 2
        fg.MergeCells =5	
		fg.MergeRow(0) = true
		
        fg.Cell(0, 0, 3,0, 4)  = "Cost Center"   //fg.Cell(0,row, from_col, row, to_col)	
	    fg.Cell(0, 1, 3, 1) = "Code"
	    fg.Cell(0, 1, 4, 1) = "Name"
	    
	    fg.Cell(0, 0, 5,0, 7)  = "Contract"   //fg.Cell(0,row, from_col, row, to_col)	
	    fg.Cell(0, 1, 5, 1) = "No"
	    fg.Cell(0, 1, 6, 1) = "CCY"
	    fg.Cell(0, 1, 7, 1) = "Amount"
	     
	   
	    
		fg.MergeCol(1) = true
		fg.Cell(0, 0, 1, 1, 1) = "SEQ"	
		fg.MergeCol(2) = true
		fg.Cell(0, 0, 2, 1, 2) = "Month"	
	    fg.MergeCol(8) = true
		fg.Cell(0, 0, 8, 1, 8) = "Accm. Direct Cost Amt."	
		fg.MergeCol(9) = true
		fg.Cell(0, 0, 9, 1, 9) = "Direct Cost Amt."	
	    fg.MergeCol(10) = true
		fg.Cell(0, 0, 10, 1, 10) = "Forecast Cost Amt."	
		fg.MergeCol(11) = true
		fg.Cell(0, 0, 11, 1, 11) = "Progress Ratio"		
		fg.MergeCol(12) = true
		fg.Cell(0, 0, 12, 1, 12) = "Accm. T/O Amt."		
		fg.MergeCol(13) = true
		fg.Cell(0, 0, 13, 1, 13) = "T/O Amt."		
		
		fg.Cell(2, 0, 0, 1, fg.Cols - 1) = 4; 
		fg.Cell(13, 1, 1, 1,fg.Cols - 1) = true; //Format all col merge : Fone = Bold				
   
}
//--------------------------------------------------------------------------------------------
function OnPopUp()
{
    fpath  = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + '' + "&company=" + lstCompany.GetData() + '&dsqlid=ACNT.SP_SEL_PL_POPUP&col_code=' + "PL CODE" + '&col_nm=' + "PL NAME";
     oValue = System.OpenModal( fpath , 600 , 400 , 'resizable:yes;status:yes');
    if ( oValue != null )
    {
        Cost_centerpk.text = oValue[2]; 
        Cost_centerNM.text   = oValue[1];
        Cost_centerID.text   = oValue[0];
    }
 }
//--------------------------------------------------------------------------------------------
function OnProcess()
{
    dat_gfca00070_1.Call();

}
//--------------------------------------------------------------------------------------------
function OnGenerate()
{
     dat_gfca00070_2.Call();
}
//--------------------------------------------------------------------------------------------
function OnCancel()
{
     dat_gfca00070_4.Call();

}
//--------------------------------------------------------------------------------------------
function OnSearch()
{
    dat_gfca00070_3.Call("SELECT");
}
//--------------------------------------------------------------------------------------------
function OnPrint()
{
      var url='';
      url = '/reports/gf/ca/gfca00070.aspx?p_tco_company_pk=' + lstCompany.value + '&p_tr_date=' + dtSMonth.value;
      System.OpenTargetPage( System.RootURL+url , 'newform' ); 
}
//-----------------------------------------------------------------------------------------------
function onChangeD()
{
    dat_gfca00070_5.Call();
}
//-------------------------------------------------------------------------------------------
function onDataReceive(obj)
{
    switch(obj.id)
    {
        case "dat_gfca00070_3":
            MergeHeaderGrid();
        break;
        case "dat_gfca00070_5":
            
        break;
    }
}
//--------------------------------------------------------------------------------------------
</script>
<body style="margin:0; padding:0;">
<!-------------------------------------------------------------------------------------->
<gw:data id="dat_gfca00070_3"  onreceive="onDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid"  function="acnt.sp_sel_gfca00070_3"  > 
            <input bind="grdDetail">                    
                <input bind="lstCompany" /> 
                <input bind="dtSMonth" /> 
            </input> 
            <output bind="grdDetail" /> 
        </dso> 
    </xml> 
</gw:data>
<!----------------Process--------------------------------------------------------------->
 <gw:data id="dat_gfca00070_1" onreceive=""> 
        <xml> 
            <dso type="process" parameter="0,1" procedure="ACNT.sp_pro_gfca00070_1" > 
                <input> 
                     <input bind="lstCompany"/>
                     <input bind="dtSMonth"/>
                </input>
                <output>
                     <input bind="txtReturn"/>
                     <input bind="txtReturn"/>
                </output>
            </dso> 
        </xml> 
    </gw:data> 
<!----------------Make Slip--------------------------------------------------------------->
 <gw:data id="dat_gfca00070_2" onreceive=""> 
        <xml> 
            <dso type="process" parameter="0,1" procedure="ACNT.sp_pro_gfca00070_2" > 
                <input> 
                     <input bind="lstCompany"/>
                     <input bind="dtSMonth"/>
                </input>
                <output>
                     <input bind="txtReturn"/>
                     <input bind="txtReturn"/>
                </output>
            </dso> 
        </xml> 
    </gw:data>     
<!-------------------------------------------------------------------------------------->
<!----------------cancel Slip--------------------------------------------------------------->
 <gw:data id="dat_gfca00070_4" onreceive=""> 
        <xml> 
            <dso type="process" parameter="0,1" procedure="ACNT.Sp_Turnover_Cancel" > 
                <input> 
                     <input bind="lstCompany"/>
                     <input bind="dtSMonth"/>
                </input>
                <output>
                     <input bind="txtReturn"/>
                     <input bind="txtReturn"/>
                </output>
            </dso> 
        </xml> 
    </gw:data>     
<!----------------cancel Slip--------------------------------------------------------------->
 <gw:data id="dat_gfca00070_5" onreceive=""> 
        <xml> 
            <dso type="process" parameter="0,1" procedure="ACNT.Sp_Turnover_Cancel" > 
                <input> 
                     <input bind="lstCompany"/>
                     <input bind="dtSMonth"/>
                </input>
                <output>
                     <input bind="txtReturn"/>
                     <input bind="txtReturn"/>
                </output>
            </dso> 
        </xml> 
    </gw:data>         
<!-------------------------------------------------------------------------------------->
 <fieldset style="padding: 2">
<table border="0" cellpadding=0 cellspacing=0 width="100%" id="table1">
	<tr>
		<td width=10% >Company</td>
		<td width="20%"><gw:list id="lstCompany" styles='width:100%' /> </td>
		<td width="10%" align=right>Month</td>
		<td width="10%"><gw:datebox id="dtSMonth"  type=month  lang="<%=session("lang")%>" onchange="onChangeD()" /></td>
		<td width="12%" align=right><a title="Click here to select Cost Center" onclick="OnPopUp()" href="#tips"
                                     style="text-decoration: none; color=#0000ff"><b>Cost Center</b></a></td>
		<td width="10%"><gw:textbox id="Cost_centerID" styles='width:100%' /> <gw:textbox id="Cost_centerpk" styles='width:100%;display:none' /> </td>
		<td width="20%"><gw:textbox id="Cost_centerNM" styles='width:100%' /> </td>
		<td width="1%"><gw:imgBtn id="ibtnReset" img="reset" alt="Reset" Onclick="Cost_centerpk.text='';Cost_centerNM.text='';Cost_centerID.text='';" /></td>
		<td width="1%"><gw:imgBtn id="ibtnSearch" img="search" alt="Search" Onclick="OnSearch()" /></td>
		<td width="1%"><gw:imgBtn id="ibtnProcess" img="auto" alt="Process" Onclick="OnProcess()" /></td>
		<td width="1%"><gw:imgBtn id="ibtnGenerate" img="create" alt="Generate Slip" Onclick="OnGenerate()" /></td>
		<td width="1%"%><gw:imgBtn id="ibtnCancel" img="cancel" alt="Cancel" Onclick="OnCancel()" /></td>
		<td width="1%"%><gw:imgBtn id="ibtnexcel" img="excel" alt="Export to excel" Onclick="OnPrint()" /></td>
	</tr>
</table>
</fieldset>  
<table width="100%" cellpadding=0 border=0 cellspacing=0>
	  
	   <tr>
	    <!--0_pk|1.SEQ|2.project|3.turnover|4.Turnover|5.total|6.material|7.labor|8.out_side_order|9.expenses
	        |10.indirect_costofturnover|11.direct|12.Indirect|13.amount-->
	     <td width=100% colspan=9>
	       <gw:grid   
            id="grdDetail"  
            header="_pk|SEQ|project|turnover|Turnover|total|material|labor|out_side_order|expenses|indirect_costofturnover|direct|Indirect|amount"   
            format="0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
            aligns="2|2|2|2|2|2|1|3|3|3|3|3|3|3"  
            defaults="||||||||||||||"  
            editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
            widths="0|800|800|800|2000|1500|700|1700|1700|1700|1700|1700|1700|2100"  
            styles="width:100%; height:400"   
            sorting="F"   
            />
	     </td>
	   </tr>	   
	</table>	 
	 <gw:textbox id="txtEMonth" styles="width:100%;display:none"/>
	 <gw:textbox id="txtReturn" styles="width:100%;display:none"/>

</body>
</html>
