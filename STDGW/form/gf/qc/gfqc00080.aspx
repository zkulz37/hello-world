<%  ESysLib.SetUser("acnt")%>
<!-- #include file="../../../system/lib/form.inc"  -->
<script>
function BodyInit()
{
    SetGridFormat()
    SetControlFormat();
}
function SetGridFormat()
{
       if(grdAP.rows <2)
       {
            grdAP.AddRow();
       } 
        var fg=grdAP.GetGridControl();
		
        fg.FixedRows = 2;
        fg.MergeCells = 5;
		fg.MergeRow(0) = true;

		fg.MergeCol(0) = true;
        fg.Cell(0, 0, 0, 1, 0) = "No";
		fg.MergeCol(1) = true;
		fg.Cell(0, 0, 1, 1, 1) = "Code Center";
		
		fg.MergeCol(2) = true;
		fg.Cell(0, 0, 2, 1, 2) = "Contrat No";
		
		
		fg.Cell(0, 0, 3, 0, 4) = "Partner";  
		fg.Cell(0, 0, 5, 0, 6) = "P/L";
		fg.Cell(0, 0, 7, 0, 8) = "Contract";
		
		fg.Cell(0, 1, 3, 1) = "Code";
		fg.Cell(0, 1, 4, 1) = "Name";
		
		fg.Cell(0, 1, 5, 1) = "Code";
		fg.Cell(0, 1, 6, 1) = "Name";
		
		fg.Cell(0, 1, 7, 1) = "Ccy";
		fg.Cell(0, 1, 8, 1) = "Amount";
		
		fg.MergeCol(9) = true;		
		fg.Cell(0, 0, 9, 1, 9) = "Advance Amount";
		
		fg.MergeCol(10) = true;		
		fg.Cell(0, 0, 10, 1, 10) = "A/P Amount";
		
		fg.MergeCol(11) = true;		
		fg.Cell(0, 0, 11, 1, 11) = "Paid Amount";
		
		fg.MergeCol(12) = true;		
		fg.Cell(0, 0, 12, 1, 12) = "Total Paid Amount";
		
		fg.MergeCol(13) = true;		
		fg.Cell(0, 0, 13, 1, 13) = "Balance Amount";
		
		fg.MergeCol(14) = true;		
		fg.Cell(0, 0, 14, 1, 14) = "Description";
		fg.Cell(2, 0, 0, 1, fg.Cols - 1) = 4;
		fg.Cell(13, 1, 1, 1,fg.Cols - 1) = true; 
		
		fg.ColWidth(0)=500;
		fg.ColWidth(2)=1500;
		fg.ColWidth(3)=1000;
		
		fg.ColWidth(4)=2200;
		fg.ColWidth(5)=1000;
		
		fg.ColWidth(6)=2000;
		fg.ColWidth(7)=500;
		
		fg.ColWidth(8)=2200;
		fg.ColWidth(9)=1500;
		fg.ColWidth(10)=1500;
		fg.ColWidth(11)=1500;
		fg.ColWidth(12)=2200;
		fg.ColWidth(13)=2000;
		
		
		fg.ColFormat(8) = "#,###,###,###,###.##";
		fg.ColFormat(9) = "#,###,###,###,###.##";
		fg.ColFormat(10) = "#,###,###,###,###.##";
		fg.ColFormat(11) = "#,###,###,###,###.##";
		fg.ColFormat(12) = "#,###,###,###,###.##";
		fg.ColFormat(13) = "#,###,###,###,###.##";
		
		fg.ColAlignment(8) = flexAlignRightCenter;
		fg.ColAlignment(9) = flexAlignRightCenter;
		fg.ColAlignment(10) = flexAlignRightCenter;
		fg.ColAlignment(11) = flexAlignRightCenter;
		fg.ColAlignment(12) = flexAlignRightCenter;
		fg.ColAlignment(13) = flexAlignRightCenter;	
}

function SetControlFormat()
{
    txtPL_ID.SetEnable(0);
    txtPL_Nm.SetEnable(0);
    txtPartnerNm.SetEnable(0);
    txtPartnerID.SetEnable(0);
    
    grdAP.GetGridControl().FrozenCols =3;
    grdAP.GetGridControl().ScrollTrack=true; 
    
    var ctrl1 = grdAP.GetGridControl();
    ctrl1.ColFormat(7) = "###,###R";  
    ctrl1.ColFormat(8) = "###,###R";
    ctrl1.ColFormat(9) = "###,###R";
    ctrl1.ColFormat(10) = "###,###R";
    ctrl1.ColFormat(11) = "###,###R";
    ctrl1.ColFormat(12) = "###,###R";  
    
}
function MergeColumn()
{
      
     
      grdAP.GetGridControl().MergeCells  = 1 ;	
      grdAP.GetGridControl().MergeCol(0) = true ;	
      grdAP.GetGridControl().MergeCol(1) = true ;   	
      grdAP.GetGridControl().MergeCol(2) = true ;	
      grdAP.GetGridControl().MergeCol(3) = false ;
      grdAP.GetGridControl().MergeCol(4) = false ;		
      grdAP.GetGridControl().MergeCol(5) = false ;	
      grdAP.GetGridControl().MergeCol(6) = false ;	
      grdAP.GetGridControl().MergeCol(7) = false ;   	
      grdAP.GetGridControl().MergeCol(8) = false ;	
      grdAP.GetGridControl().MergeCol(9) = false ;	
      grdAP.GetGridControl().MergeCol(10) = false ;   	
      grdAP.GetGridControl().MergeCol(11) = false ;	
      grdAP.GetGridControl().MergeCol(12) = false ;
      grdAP.GetGridControl().MergeCol(13) = false ;		
      grdAP.GetGridControl().MergeCol(14) = false ;	
      grdAP.GetGridControl().MergeCol(15) = false ;	/**/
}
function OnShowPopup(index)
{
    switch (index)
    {
        case 0:
            
            var path = System.RootURL + '/form/gf/co/ffbp00031.aspx';
            var object = System.OpenModal( path ,800 , 630 , 'resizable:yes;status:yes');
            if ( object != null )
            {
                if (object[0] != 0)
                {
	                txtPartnerNm.SetDataText(object[2]); 	               
	                txtPartnerPk.SetDataText(object[0]); 
	                txtPartnerID.SetDataText(object[1]);   
                }
            }
         break;
         case 1:
            fpath  = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + '' + "&company=" + lstComp.GetData() + '&dsqlid=ACNT.SP_SEL_PL_POPUP&col_code=' + "PL CODE" + '&col_nm=' + "PL NAME";
                oValue = System.OpenModal( fpath , 600 , 400 , 'resizable:yes;status:yes');
                
                if ( oValue != null )
                {
                    txtPL_PK.text   = oValue[2]; 
                    txtPL_Nm.text   = oValue[1];
                    txtPL_ID.text   = oValue[0];
                }                
          break;
    }
}
function onSearch()
{
    dat_gfqc00030_AP.Call("SELECT"); 
    
}
function OnDataReceive(obj)
{
var i=0 ;
    if (obj.id=="dat_gfqc00030_AP")
    {  
        SetGridFormat();     
        idRecord1.text="Total rows: " + (grdAP.rows-2);       
       MergeColumn(); 
       for(i=2;i<grdAP.rows;i++)
       {
            grdAP.SetGridText(i,0,i-1);
       }
       grdAP.SetGridText(1,9,"");
       grdAP.SetGridText(1,10,"");
       grdAP.SetGridText(1,11,"");
       grdAP.SetGridText(1,12,"");
       grdAP.SetGridText(1,13,"");
       grdAP.SetGridText(1,14,"");
    }    
}
function onPrint(obj)
{
    switch(obj)
    {
        case 1:
            var url = '/reports/gf/qc/gfqc00080.aspx?p_contr_no='+txtContractNo.GetData() + '&p_tac_abplcenter_pk=' + txtPL_PK.GetData() +'&p_tco_buspartner_pk=' + txtPartnerPk.GetData() + '&p_company=' + lstComp.GetData()+ '&p_dtfr=' + dtContractDt_Fr.GetData()+ '&p_dtto=' + dtContractDt_To.GetData();
            System.OpenTargetPage( System.RootURL+url , "newform" );       
        break;
        case 2:
             var url = '/reports/gf/qc/gfqc00030.aspx?p_contract_no=' + txtContractNo.GetData() + '&tac_abplcenter_pk=' + txtPL_PK.GetData() + '&tco_buspartner_pk=' + txtPartnerPk.GetData() + '&from=' + dtContractDt_Fr.GetData() + '&to=' + dtContractDt_To.GetData() + '&company=' + lstComp.GetData();
            System.OpenTargetPage( System.RootURL+url , "newform" );
        break;
    }
     
} 
function OnReset()
{
     
         txtPartnerNm.text="";	               
	     txtPartnerPk.text=""; 
	     txtPartnerID.text="";
}  
function OnReset1()
{
	    txtPL_PK.text="";
        txtPL_Nm.text="";
        txtPL_ID.text=""; 
}  
function OnContract_no()
{
    var ctrl 	= grdAP.GetGridControl();
	var rows    = ctrl.Rows
	rows = rows - 1;
	var rownum  	= ctrl.Row;
	var colnum  	= ctrl.Col;
	if (rownum > 0)		 
	{
                if(grdAP.col=='2')
                {
                              var   fpath  = System.RootURL + "/form/gf/qc/gfqc00080_popup.aspx?contract_no="+ grdAP.GetGridData(grdAP.row,2) + "&company_pk=" + lstComp.GetData() + '&ccy='   + grdAP.GetGridData(grdAP.row,7) + '&PK_ROW=' + grdAP.GetGridData(grdAP.row,15);
                              fpath += '&_row='+grdAP.row ;
                            var wWidth  = 700;
			                var wHeight = 500;
			                var x = Math.round((screen.availWidth - wWidth)/2);
			                var y = Math.round((screen.availHeight - wHeight)/2);
                			//alert(grdAP.row);
			                var features = "toolbar=no,location=no,directories=no,status=no,menubar=no," + 
			                   "scrollbars=no,resizable=no,copyhistory=no,width="+wWidth+",height="+wHeight +
			                   "lef="+ x +",top=" + y;
			                this.name = "gfqc00080";
                            var object = System.OpenModal(fpath, wWidth, wHeight, features,window);
                }
     }
}
function GetRowPK1(row_index)
{
    if((row_index < grdAP.rows) && (row_index > 0))
    {
     
        return grdAP.GetGridData(row_index, 15);
       
    }
    return -1;
     
}
function GetRowContractNo(row_index)
{
    if((row_index < grdAP.rows) && (row_index > 0))
    {
     
        return grdAP.GetGridData(row_index, 2);
       
    }
    return -1;
     
}
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<body bottommargin="0" leftmargin="0" rightmargin="0" topmargin="0">
<gw:data id="dat_gfqc00030_AP"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid"  function="ACNT.sp_sel_gfqc00030_1_ap "   > 
            <input bind="grdAP">   
                <input bind="txtContractNo" />                 
                <input bind="txtPL_PK" />
                <input bind="txtPartnerPk" />  
                <input bind="lstComp" /> 
                <input bind="dtContractDt_Fr" />
                <input bind="dtContractDt_To" /> 
            </input> 
            <output bind="grdAP" /> 
        </dso> 
    </xml> 
</gw:data>
<table border="0" cellpadding=0 cellspacing=0 style="width:100%;height:100%">
	<tr style="width:100%;height:8%">
	    <td>
	        <fieldset style=" height: 100%; padding: 2">
            <table border="0" cellpadding=0 cellspacing=0 width="100%" id="table1">
	            <tr>
	                <td width="13%" align="right">Company&nbsp;</td>
		                    <td width="35%"><gw:list id="lstComp" style="width:100%" value="<%=Session("COMPANY_PK")%>">
                               <data><%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>|ALL|Select All</data>
                               </gw:list>
                         </td>
                        <td width="12%"  align=right><a onclick="OnShowPopup(0)" title="Click here to select partner" href="#tips" style="text-decoration : none; color=#0000FF">Partner</a> &nbsp;</td>
		                    <td width="40%">
		                        <table style="width:100%" cellpadding="0" cellspacing="0">
		                               <tr>
		                                      <td width="30%"><gw:textbox id="txtPartnerID" style="width:100%"  /></td> 
		                                      <td width="70%" ><gw:textbox id="txtPartnerNm" style="width:100%"  /></td>
		                                     <td ><gw:imgbtn id="ResetPaner" img="Reset" alt="Reset" onclick="OnReset()" /></td> 
		                                    <td><gw:textbox id="txtPartnerPk" style="display:none" text="" /></td> 
		                               </tr>
		                        </table> 
		                    </td>
		               <td ><gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="onSearch()" /></td>
                    <td ><gw:imgbtn id="btnPrint" img="excel" alt="printer" text="printer" onclick="onPrint(1)" /></td>
                    
                    
                </tr>
                <tr>
		                     <td  align="right">Contract Date&nbsp;</td>
		                   <td  >
		                        <table style="width:100%" cellpadding="0" cellspacing="0">
		                             <tr>
		                                    <td width="37%"><gw:datebox id="dtContractDt_Fr" style="width:100%" lang="1"  /></td>
		                                   <td width="16%" align="center">~</td>
                                        <td width="37%"><gw:datebox id="dtContractDt_To" styles="width:100%" lang="1"  /></td>
		                             </tr> 
		                        </table> 
		                   </td>
		                    <td  align="right"><a onclick="OnShowPopup(1)" title="Click here to select P/L" href="#tips" style="text-decoration : none; color=#0000FF">PL</a>&nbsp;</td>
                        <td >
                              <table style="width:100%" cellpadding="0" cellspacing="0">
                                  <tr>
                                        <td width="30%"><gw:textbox id="txtPL_ID" style="width:100%"  /></td>
                                        <td width="70%" ><gw:textbox id="txtPL_Nm" style="width:100%"  /></td>
                                        <td ><gw:imgbtn id="ResetPan" img="Reset" alt="Reset" onclick="OnReset(1)" /></td> 
                                        <td><gw:textbox id="txtPL_PK" style="display:none"  /></td>
                                  </tr>
                              </table>
                        </td>
                        <td></td>
                        <td ><gw:imgbtn id="btnPrint1" img="excel" alt="printer" text="printer" onclick="onPrint(2)" /></td>
	            </tr>
	            <tr>
		                <td  align="right">Contract No&nbsp;</td>
		                <td ><gw:textbox id="txtContractNo" styles="width:100%" onenterkey="onSearch()"/></td>
	            </tr>
            </table>
            </fieldset>
	    </td>
	</tr>
    <tr style="height:2%">
     
            <td colspan="7" align="right">&nbsp;<gw:label id="idRecord1" text="" style="font-family:Tahoma;color:Red" /></td>            
     </tr>
    <tr style="width:100%;height:90%">
        <td><gw:grid id='grdAP' 
                    header='No|Cost Center|Contrat No|Code|Name|Code|Name|Ccy|Amount|Advance Amount|A/P Amount|Paid Amount|Total Paid Amount|Balance Amount|Description|pk'
                    format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    aligns='1|0|0|0|0|0|0|3|3|3|3|3|3|0|0|0'
                    defaults='|||||||||||||||'
                    editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    widths='500|2000|1500|1000|2000|1000|1500|500|1500|1500|1500|1500|2000|2000|2500|0'
                    sorting='T'
                    acceptNullDate="T"                              
                    styles='width:100%; height:100%'
                    oncelldblclick="OnContract_no()"
                    />
        </td>
    </tr>
</table>   
  
  
</body>
</html>
