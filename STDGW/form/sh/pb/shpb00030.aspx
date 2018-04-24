<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("prod")%>
<head id="Head1" runat="server">
    <title>Max Capacity</title>
</head>

<script>

    var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
    var  user_code  = "<%=Session("USER_ID")%>" ;
    var  user_name  = "<%=Session("USER_NAME")%>" ;       

    var G1_PK                       = 0,
        G1_Capa_Date                = 1,
        G1_Machine_No               = 2,
        G1_Size                     = 3,
        G1_Max_capacity             = 4,
        G1_Prod_Qty_Hr              = 5;
        
        

 //---------------------------------------------------------
 function BodyInit()
 {
      shpb00030.Call("SELECT");
      BindingDataList();
      FormatGrid();
 }
 
 //---------------------------------------------------------
 function OnSearch()
 {      
       shpb00030.Call("SELECT");
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
      	
      trl.ColFormat(G1_Max_capacity )         = "###,###,###,###,###";
      trl.ColFormat(G1_Prod_Qty_Hr )         = "###,###,###,###,###";
      
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

        data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.code, a.code_nm from sale.lg_code a ,sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0020' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0  " ) %> ";       
        grdDetail.SetComboFormat(G1_Size,data);
        
        data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.code,a.code_nm from sale.lg_code a ,sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0010' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0  " ) %> ";       
        grdDetail.SetComboFormat(G1_Machine_No,data);
          
        data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGMF0010') FROM DUAL" )%>||Select All";    
        lstMachine.SetDataText(data);
        lstMachine.value="";
             
 }
//---------------------------------------------------------
function OnSave()
{
    shpb00030.Call();
}
//------------------------------------------------------------------------------
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="shpb00030"> 
        <xml>                                                               
            <dso id="1" type="grid" user="prod" function="prod.sp_sel_shpb00030" parameter="0,1,2,3,4,5" procedure="prod.sp_upd_shpb00030"> 
                <input bind="grdDetail" > 
                    <input bind="lstMachine" /> 
                    <input bind="dtFrom" />
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%">
        <tr style="height: 2%">
            <td style="width: 10%" align="center">
                <b>Date</b>
            </td>
            <td style="width: 15%" align="right">
                <gw:datebox id="dtFrom" lang="<%=Application("Lang")%>" mode="01" />
            </td>
            <td style="width: 20%" align="right">
                <b>Machine No</b>
            </td>
            <td style="width: 30%" align="right">
                <gw:list id="lstMachine" styles='width:100%' />
            </td>
            <td style="width: 45%" align="right">
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch()" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="new" alt="New" id="btnAddNew" onclick="OnAddNew('grdDetail')" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="delete" alt="Delete" id="btnDelete" onclick="OnDelete()" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="udelete" alt="Un Delete" id="btnUnDelete" onclick="OnUnDelete()" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="save" alt="Save" id="btnSave" onclick="OnSave('grdDetail')" />
            </td>
        </tr>
        <tr style="height: 98%">
            <td colspan="10">
                <gw:grid id='grdDetail' header='_PK|Capa Date|Machine No|Size|Max capacity|Prod.Qty\Hr'
                    format='0|4|0|0|1|1' aligns='0|0|0|3|3|3' defaults='||||||' editcol='0|0|0|1|1|1'
                    widths='0|1500|2000|1500|1500|1000' sorting='F' styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
    <!------------------------------------------->
</body>
<gw:textbox id="txtGroupPK" style="display: none" />
</html>
