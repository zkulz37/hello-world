<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
       if(grdAR.rows <2)
       {
            grdAR.AddRow();
       } 
        var fg=grdAR.GetGridControl();
		
        fg.FixedRows = 2;
        fg.MergeCells = 5;
		fg.MergeRow(0) = true;

		fg.MergeCol(0) = true;
        fg.Cell(0, 0, 0, 1, 0) = "No";
		fg.MergeCol(1) = true;
		fg.Cell(0, 0, 1, 1, 1) = "Contrat No";
		
		
		fg.Cell(0, 0, 2, 0, 3) = "Partner";  
		fg.Cell(0, 0, 4, 0, 5) = "P/L";
		fg.Cell(0, 0, 6, 0, 7) = "Contract";
		
		fg.Cell(0, 1, 2, 1) = "Code";
		fg.Cell(0, 1, 3, 1) = "Name";
		
		fg.Cell(0, 1, 4, 1) = "Code";
		fg.Cell(0, 1, 5, 1) = "Name";
		
		fg.Cell(0, 1, 6, 1) = "Ccy";
		fg.Cell(0, 1, 7, 1) = "Amount";
		
		fg.MergeCol(8) = true;		
		fg.Cell(0, 0, 8, 1, 8) = "Advance Amount";
		
		fg.MergeCol(9) = true;		
		fg.Cell(0, 0, 9, 1, 9) = "Issue Invoice (NET)";
		
		fg.MergeCol(10) = true;		
		fg.Cell(0, 0, 10, 1, 10) = "Collection money (NET)";
		
		fg.MergeCol(11) = true;		
		fg.Cell(0, 0, 11, 1, 11) = "Total Coll. Amount";
    		
		fg.MergeCol(12) = true;		
		fg.Cell(0, 0, 12, 1, 12) = "Balance Amount";
		
		fg.Cell(2, 0, 0, 1, fg.Cols - 1) = 4;
		fg.Cell(13, 1, 1, 1,fg.Cols - 1) = true; 
		
		fg.ColWidth(0)=500;
		fg.ColWidth(1)=1500;
		fg.ColWidth(2)=1000;
		
		fg.ColWidth(3)=2500;
		fg.ColWidth(4)=1000;
		
		fg.ColWidth(5)=1500;
		fg.ColWidth(6)=500;
		
		fg.ColWidth(7)=1500;
		fg.ColWidth(8)=1500;
		fg.ColWidth(9)=1500;
		fg.ColWidth(10)=1500;
		fg.ColWidth(11)=2000;
		fg.ColWidth(12)=2000;
		
		
		fg.ColFormat(7) = "#,###,###,###,###.##";
		fg.ColFormat(8) = "#,###,###,###,###.##";
		fg.ColFormat(9) = "#,###,###,###,###.##";
		fg.ColFormat(10) = "#,###,###,###,###.##";
		fg.ColFormat(11) = "#,###,###,###,###.##";
		fg.ColFormat(12) = "#,###,###,###,###.##";
		
		fg.ColAlignment(7) = flexAlignRightCenter;
		fg.ColAlignment(8) = flexAlignRightCenter;
		fg.ColAlignment(9) = flexAlignRightCenter;
		fg.ColAlignment(10) = flexAlignRightCenter;
		fg.ColAlignment(11) = flexAlignRightCenter;
		fg.ColAlignment(12) = flexAlignRightCenter;	
}
function SetControlFormat()
{
    txtPL_ID.SetEnable(0);
    txtPL_Nm.SetEnable(0);
    txtPartnerNm.SetEnable(0);
    txtPartnerID.SetEnable(0);
    
    grdAR.GetGridControl().FrozenCols =8;
    grdAR.GetGridControl().ScrollTrack=true; 
    
    var ctrl1 = grdAR.GetGridControl();
    ctrl1.ColFormat(7) = "###,###R";  
    ctrl1.ColFormat(8) = "###,###R";
    ctrl1.ColFormat(9) = "###,###R";
    ctrl1.ColFormat(10) = "###,###R";
    ctrl1.ColFormat(11) = "###,###R";
    ctrl1.ColFormat(12) = "###,###R";  
    
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
    dat_gfqc00030_AR.Call("SELECT"); 
    
}
function OnDataReceive(obj)
{
    if (obj.id=="dat_gfqc00030_AR")
    {  
        SetGridFormat()     
        idRecord1.text="Total rows: " + (grdAR.rows-2);       
    }    
}

function onPrint()
{
    var url = '/reports/gf/qc/gfqc00070.aspx?p_company_pk=' + lstComp.GetData() + '&p_partner_pk=' + txtPartnerPk.GetData() + '&p_pl_pk=' + txtPL_PK.GetData()+ '&p_dtfrom=' + dtContractDt_Fr.GetData()+ '&p_dtto=' + dtContractDt_To.GetData();
    System.OpenTargetPage( System.RootURL+url , "newform" );
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
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head >
    <title>Untitled Page</title>
</head>
<body bottommargin="0" leftmargin="0" rightmargin="0" topmargin="0">
<gw:data id="dat_gfqc00030_AR"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid"  function="acnt.sp_sel_gfqc00030_1_AR"   > 
            <input bind="grdAR">                    
                <input bind="lstComp" /> 
                <input bind="txtContractNo" />                 
                <input bind="txtPL_PK" />
                <input bind="txtPartnerPk" /> 
                <input bind="dtContractDt_Fr" /> 
                <input bind="dtContractDt_To" />                
            </input> 
            <output bind="grdAR" /> 
        </dso> 
    </xml> 
</gw:data>

<table border="0" cellpadding=0 cellspacing=0 width="100%">
	<tr>
		<td>
		 <fieldset style="width:97%; height: 100%; padding: 2">
            <table border="0" cellpadding=0 cellspacing=0 width="100%" id="table1">
                <tr>
                    <td width="15%">Contract Date</td>
		            <td width="6%" align="left"><gw:datebox id="dtContractDt_Fr" style="width:100%" lang="1"  /></td>
		            <td width="1%" align="left" >~</td>
                    <td width="6%">
                        <gw:datebox id="dtContractDt_To" styles="width:100%" lang="1"  />
                    </td>
                    <td width="33%"></td>
                    <td width="33%"></td>
		            <td align=right style="width:3%" ><gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="onSearch()" /></td>
                    <td align=right style="width:3%"><gw:imgbtn id="btnPrint" img="printer" alt="printer" text="printer" onclick="onPrint()" /></td>
                    
                </tr>
	            <tr>
		            <td width="10%">Company</td>
		            <td width="30%"><gw:list id=lstComp style="width:100%" value="<%=Session("COMPANY_PK")%>">
                       <data><%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>|ALL|Select All</data>
                       </gw:list>
                     </td>
		            <td width="10%"  align=right><a onclick="OnReset()" title="Click here to select partner" href="#tips" style="text-decoration : none; color=#0000FF">Partner</a> &nbsp;</td>
		            <td width="10%"><gw:textbox id="txtPartnerID" style="width:100%" text="" /></td>
		            <td width="30%" colspan="3"><gw:textbox id="txtPartnerNm" style="width:100%" text="" />
                       <gw:textbox id="txtPartnerPk" style="display:none" text="" />
                    </td>
		            <td width="10%"><gw:imgbtn id="reset1" img="Reset" alt="Reset" onclick="txtPL_Nm.text='';txtPL_PK.text='';txtPL_ID.text=''" /></td>
		           
	            </tr>
	             
	            <tr>
		            <td width="10%">Contract No</td>
		            <td width="30%"><gw:textbox id="txtContractNo" styles="width:98%" onenterkey="onSearch()"/></td>
		            <td width="10%" align=right><a onclick="OnReset1()" title="Click here to select P/L" href="#tips" style="text-decoration : none; color=#0000FF">PL</a>&nbsp;</td>
                    <td width=10%><gw:textbox id="txtPL_ID" style="width:100%" text="" /></td>
		            <td width="35%" colspan="3"><gw:textbox id="txtPL_Nm" style="width:100%" text="" />
                     <gw:textbox id="txtPL_PK" style="display:none" text="" />
                    </td>
                    <td width=5% align=left><gw:imgbtn id="reset" img="Reset" alt="Reset" onclick="txtPL_Nm.text='';txtPL_PK.text='';txtPL_ID.text=''" /></td>
	            </tr>
	            </table>
	            </td>
		            </tr>
            
            

    <tr>
            <!--<td align=left><b>A/P</b></td>-->
            <td  align=right>&nbsp;<gw:label id="idRecord1" text="" style="font-family:Tahoma;color:Red" /></td>            
     </tr>
    <tr>
        <td>
            <gw:grid id='grdAR' 
                    header='No|Contrat No|Code|Name|Code|Name|Ccy|Amount|Advance Amount|A/P Amount|Paid Amount|Total Paid Amount|Balance Amount'
                    format='0|0|0|0|0|0|0|0|0|0|0|0|0'
                    aligns='0|0|0|0|0|0|0|3|3|3|3|3|3'
                    defaults='||||||||||||'
                    editcol='0|0|0|0|0|0|0|0|0|0|0|0|0'
                    widths='500|1500|1000|2000|1000|1500|500|1500|1500|1500|1500|2000|2000'
                    sorting='T'
                    acceptNullDate="T"                              
                    styles='width:100%; height:450'                    
                  />
        </td>
    </tr>
</table> 

 
</body>
</html>
