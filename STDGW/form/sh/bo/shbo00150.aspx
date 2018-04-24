<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("prod")%>
<head id="Head1" runat="server">
    <title>Colorant Batch No.Register</title>
</head>

<script>

    var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
    var  user_code  = "<%=Session("USER_ID")%>" ;
    var  user_name  = "<%=Session("USER_NAME")%>" ;       

    var G1_PK                           = 0,
        G1_Issue_Date                   = 1,
        G1_Instructed_Date              = 2,
        G1_Batch_No                     = 3,
        G1_Type_No                      = 4,
        G1_Tr_Op                        = 5,
        G1_Batch_Qty                    = 6,
        G1_Remark                       = 7;
        

 //---------------------------------------------------------
 function BodyInit()
 {
      d= new Date();
      dtFrom.SetDataText(System.AddDate(dtTo.GetData(),(-1)*d.getDate() +1 ));
      FormatGrid();      
      BindingDataList();
      dtFrom.SetDataText(System.AddDate(dtTo.GetData(),-7));
      shbo00150.Call("SELECT");
 }
 
 //---------------------------------------------------------
 function OnSearch()
 {      
       shbo00150.Call("SELECT");
 }
//----------------------------------------------------------
function OnAddNew(pos)
 {
      switch (pos)         
      {		                
        case 'grdDetail' :
            grdDetail.AddRow();
            grdDetail.SetGridText(grdDetail.rows-1,1,dtFrom.GetData());
        break;
      }  
 }
//----------------------------------------------------------
 function OnDelete()
 {
		if ( grdDetail.GetGridData( grdDetail.row, G1_PK ) == "" ) 
	    {						
				grdDetail.RemoveRow();					
		}			
		else 
		{
			if ( confirm( "Do you want to mark this row to delete?" ) ) 
			{
				grdDetail.DeleteRow();
			}
		}
 }
//----------------------------------------------------------
 function FormatGrid()
 {
      var trl ;
      
      trl = grdDetail.GetGridControl();
      	
      trl.ColFormat(G1_Batch_Qty )     = "###,###,###,###,###.###";
      trl.ColFormat(G1_Tr_Op )         = "###,###,###,###,###.###";
      
 }
//----------------------------------------------------------
function OnUnDelete()
 {
        grdDetail.UnDeleteRow();
 }
//----------------------------------------------------------
function BindingDataList()
{ 
    var data="";
    data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.F_LOGISTIC_CODE('LGMF0010') FROM DUAL" )%>"; 
	lstMachineNo.SetDataText(data);
}
//---------------------------------------------------------
function OnPrint()
{
    if(rdoSTATUS.value=='1')
    {
        var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/bo/rpt_shbo00150_1.rpt&export_pdf=Y&procedure=PROD.sp_rpt_shbo00150_1&parameter=" + dtFrom.value + "," + dtTo.value+ "," + lstMachineNo.value ;              
	    System.OpenTargetPage(url);
    }
    else
    {
        var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/bo/rpt_shbo00150_2.rpt&export_pdf=Y&procedure=PROD.sp_rpt_shbo00150_2&parameter=" + dtFrom.value + "," + dtTo.value+ "," + lstMachineNo.value ;              
	    System.OpenTargetPage(url);
    }
     
}
//------------------------------------------------------------------------------
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="shbo00150"> 
        <xml>                                                               
            <dso id="1" type="grid" user="prod" function="PROD.sp_sel_shbo00150" > 
                <input bind="grdDetail" > 
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
                    <input bind="lstMachineNo" />
                    <input bind="rdoSTATUS" />
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%">
        <tr style="height: 7%">
            <td style="width: 5%" align="right">
                <b>Type</b>
            </td>
            <td style="width: 20%; white-space: nowrap" align="right">
                <gw:radio id="rdoSTATUS" value="1" styles='height:22' onchange="OnSearch()">
							<span value="1">Norm</span>
							<span value="2">BOX</span>
				</gw:radio>
            </td>
            <td style="width: 20%; white-space: nowrap" align="right">
                <b>Instructed Period</b>
            </td>
            <td style="width: 15%; white-space: nowrap" align="right">
                <gw:datebox id="dtFrom" lang="<%=Application("Lang")%>" mode="01" onchange="OnSearch()" />
                ~
                <gw:datebox id="dtTo" lang="<%=Application("Lang")%>" mode="01" onchange="OnSearch()" />
            </td>
            <td style="width: 15%; white-space: nowrap" align="right">
                <b>Machine No</b>
            </td>
            <td style="width: 20%" align="right">
                <gw:list id="lstMachineNo" styles="width: 100%" onchange="OnSearch()"/>
            </td>
            <td style="width: 10%" align="right">
            </td>
            <td style="width: 1%" align="right">
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="search" alt="New" id="btnSearch" onclick="OnSearch()" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn id="btnPrint" img="printer" alt="Print" text="Print" onclick="OnPrint()" />
            </td>
        </tr>
        <tr style="height: 98%">
            <td colspan="10">
                <gw:grid id='grdDetail' header='Iss No|Iss Date|Reg Dt|Product Name|Lot No.|Customer Name|Production Qty|Type Text|Remark|Deleted'
                    format='0|4|4|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|0|0|0|1' defaults='|||||||||'
                    editcol='0|0|0|0|0|0|0|0|0|0' widths='1000|1200|1200|2000|1500|2000|1500|1000|1500|1000'
                    sorting='T' styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
    <!------------------------------------------->
</body>
<gw:textbox id="txtGroupPK" style="display: none" />
</html>
