<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("prod")%>
<head id="Head1" runat="server">
    <title>Machine Speed Change History</title>
</head>

<script>

    var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
    var  user_code  = "<%=Session("USER_ID")%>" ;
    var  user_name  = "<%=Session("USER_NAME")%>" ;       
 
    var G1_PK                       = 0,
        G1_hoki                     = 1
        G1_Company                  = 2,    
        G1_Change_dt                = 3,
        G1_Enter_dt                 = 4,
        G1_Speed                    = 5,
        G1_Dip_Qty_HR               = 6,
        G1_Max_Capa                 = 7,
        G1_Reqd_Time_1CYL           = 8,
        G1_Prod_Qty_KG              = 9,
        G1_Prod_Qty_1CYL            = 10,
        G1_Prod_Qty_HR              = 11,
        G1_Sol_Consumption          = 12,
        G1_Size                     = 13,
        G1_Status                   = 14,
        G1_CHARGER_PK               = 15,
        G1_Charger                  = 16;
        

 //---------------------------------------------------------
 function BodyInit()
 {
//      OnSearch('grdDetail');
      dtFrom.SetDataText(System.AddDate(dtTo.GetData(),-7));
      BindingDataList();
      FormatGrid();
 }
 
 //---------------------------------------------------------
 function OnSearch()
 {      
       shpb00040.Call("SELECT");
 }
//----------------------------------------------------------
function OnPopUp(obj)
{
    switch(obj)
    {
        case '2':
                    var row=event.row;
                    var col=event.col;
                    if(col==G1_Charger)
                    {
                        var fpath = System.RootURL + "/form/sh/ab/shab00020.aspx?";
	                    var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
                        if (object != null)
                        {                  
                            grdDetail.SetGridText(row,col,object[5]);
                            grdDetail.SetGridText(row,G1_CHARGER_PK,object[0]);
                        }
                    }
                    
        break;  
    }
}
//----------------------------------------------------------
function BindingDataList()
 {    
        var data="";
        data = "<%=ESysLib.SetListDataSQL("SELECT pk,PARTNER_NAME from  comm.TCO_COMPANY where del_if=0 order by PARTNER_NAME ")%>";
        lstCompany.SetDataText(data);
        
        data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGMF0010') FROM DUAL" )%>";    
        lstMachine.SetDataText(data);
        
        data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.code, a.code_nm from sale.lg_code a ,sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0020' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0  " ) %> ";       
        grdDetail.SetComboFormat(G1_Size,data);
        
             
 }
//-----------------------------------------------------------
 function FormatGrid()
 {
      var trl ;
      
      trl = grdDetail.GetGridControl();
      trl.ColFormat(G1_Sol_Consumption )         = "###,###,###,###,###.##";
      //trl.ColFormat(G1_Prod_Qty_HR )         = "###,###,###,###,###.##";
      //trl.ColFormat(G1_Prod_Qty_1CYL )         = "###,###,###,###,###.##";
      //trl.ColFormat(G1_Prod_Qty_KG )         = "###,###,###,###,###.##";
      trl.ColFormat(G1_Reqd_Time_1CYL )         = "###,###,###,###,###.##";
      //trl.ColFormat(G1_Max_Capa )         = "###,###,###,###,###.##";
      //trl.ColFormat(G1_Dip_Qty_HR )         = "###,###,###,###,###.##";
      trl.ColFormat(G1_Speed )         = "###,###,###,###,###.##";
      
      
 }
//--------------------------------------------------------------
 function CheckInput()
 {   
    var  row, col 
        
    row = event.row ;
    col = event.col ;    
    
    if ( col == G1_Speed  || col == G1_Dip_Qty_HR || col == G1_Max_Capa || col == G1_Reqd_Time_1CYL || col == G1_Prod_Qty_KG || col == G1_Prod_Qty_1CYL || col == G1_Prod_Qty_HR || col == G1_Sol_Consumption )
    {      
        var dQuantiy;
        
        dQuantiy =  grdDetail.GetGridData(row,col);
        
        if (Number(dQuantiy))
        {   
            if (dQuantiy >0)
            {
                grdDetail.SetGridText(row,col,parseFloat(dQuantiy+"").toFixed(5));
            }
            else
            {
                alert(" Value must greater than zero !!");
                grdDetail.SetGridText(row,col,"")
            }
        }
        else
        {
            grdDetail.SetGridText(row,col,"")
        }
    }
}
//--------------------------------------------------------------
function OnNew()
{
    grdDetail.AddRow();
    grdDetail.SetGridText(grdDetail.rows-1,G1_hoki,lstMachine.value);
    grdDetail.SetGridText(grdDetail.rows-1,G1_Company,lstCompany.value);
}
//------------------------------------------------------------
function OnSave()
{
    if(CheckDataIsValid())
    {
        shpb00040.Call();
    }    
}
//-------------------------------------------------------------
function OnDelete()
{
    var ctrl = grdDetail.GetGridControl();

	var row  = ctrl.row;
		
	if ( row < 0 ) 
	{			
			alert("Please select one row to delete .");
	}			
	else 
	{
		if ( grdDetail.GetGridData( ctrl.row, 0 ) == "" ) 
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
}
//------------------------------------------------------------------------------
function OnUnDelete()
{
    grdDetail.UnDeleteRow()
}
//------------------------------------------------------------------------------
function OnDataReceive(obj)
{
    lblRecord.text = (grdDetail.rows -1) + " record(s)."; 
}
//------------------------------------------------------------------------------
function CheckDataIsValid()
{
    for(var i=1;i<grdDetail.rows;i++)
    {
        if(grdDetail.GetGridData(i,G1_Enter_dt)=="")
        {
            alert("Please input Apply Date row "+ i);
            return false;
        } 
        else if(grdDetail.GetGridData(i,G1_Speed)=="")
        {
            alert("Please input Speed row "+ i);
            return false;
        } 
        else if(grdDetail.GetGridData(i,G1_Dip_Qty_HR)=="")
        {
            alert("Please input Dip.Qty/Hr row "+ i);
            return false;
        } 
        else if(grdDetail.GetGridData(i,G1_Prod_Qty_KG)=="")
        {
            alert("Please input Prod.Qty/Kg row "+ i);
            return false;
        } 
    }
   return true;
}
//-----------------------------------------------------------------------------------------
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="shpb00040" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
            <dso id="1" type="grid" user="prod" function="prod.sp_sel_shpb00040" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16" procedure="prod.sp_upd_shpb00040"> 
                <input bind="grdDetail"> 
                    <input bind="lstCompany" />
                    <input bind="lstMachine" /> 
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%">
        <tr style="height: 2%">
            <td style="width: 10%" align="right">
                <b>Company</b>
            </td>
            <td style="width: 25%" align="right">
                <gw:list id="lstCompany" styles='width:100%' />
            </td>
            <td style="width: 15%;white-space:nowrap" align="right">
                <b>Machine No</b>
            </td>
            <td style="width: 20%" align="right">
                <gw:list id="lstMachine" styles='width:100%' onchange="OnSearch()" />
            </td>
            <td style="width: 10%" align="right">
                <b>Period</b>
            </td>
            <td style="white-space: nowrap">
                <gw:datebox id="dtFrom" mode="01" lang='1' onchange="OnSearch()" />
                ~
                <gw:datebox id="dtTo" mode="01" lang='1' onchange="OnSearch()" />
            </td>
            <td style="width: 20%" align="right">
                <gw:label id="lblRecord" styles="color:blue" text="record" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch()" />
            </td>
            <td style="width: 1%">
                <gw:imgbtn img="new" alt="New" onclick="OnNew()" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="delete" alt="Delete" id="btnDelete" onclick="OnDelete()" />
            </td>
            <td style="width: 1%">
                <gw:imgbtn img="udelete" alt="UnDelete" onclick="OnUnDelete()" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="save" alt="Save" id="btnSave" onclick="OnSave()" />
            </td>
        </tr>
        <tr style="height: 98%">
            <td colspan="12">
                <gw:grid id='grdDetail' header='_PK|_hoki|_tco_company|Change Date|Apply Date|Speed|Dip.Qty/HR|Max Capa|Reqd Time/1CYL|Prod. Qty/KG|Prod.Qty/1CYL|Prod.Qty/HR|Sol.Consumption|Size|Status|_CHARGER_PK|Charger'
                    format='0|0|0|4|4|1|1|1|1|1|1|1|1|0|3|0|0' aligns='0|0|0|0|3|3|3|3|3|3|3|3|3|3|1|3|0'
                    defaults='||||||||||||||-1||' editcol='0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|0|0' widths='1500|0|0|1200|1200|1200|1500|1500|1500|1500|1500|1500|1700|1500|1500|1500|1500'
                    sorting='F' styles='width:100%; height:100%'acceptnulldate="T" oncelldblclick="OnPopUp('2')" onafteredit="CheckInput()" />
            </td>
        </tr>
    </table>
    <!------------------------------------------->
</body>
<gw:textbox id="txtGroupPK" style="display: none" />
</html>
