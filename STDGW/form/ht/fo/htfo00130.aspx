<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Room Ledger Adjust</title>
</head>
<%  ESysLib.SetUser("CRM")%>

<script>
 
var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
var  user_name  = "<%=Session("USER_NAME")%>" ;
    
var G1_Room         = 0,
    G1_Last_Name    = 1,
    G1_First_Name   = 2,
    G1_Check_In     = 3,
    G1_Check_Out    = 4,
    G1_Days         = 5,
    G1_Type         = 6, 
    G1_Avg_Rate     = 7,
    G1_Room_Charge  = 8,
    G1_Total_Due    = 9,
    G1_Advance      = 10,
    G1_FB_Hotel     = 11,
    G1_MiniBar      = 12,
    G1_Laundry      = 13,
    G1_Biz_Center   = 14,
    G1_Others       = 15,
    G1_Nation       = 16,
    G1_Check_In_By  = 17,
    G1_Check_In_Date= 18,
    G1_Check_Out_By = 19,
    G1_Check_Out_Date= 20,
    G1_PK           = 21,
    G1_Rate_Plan    = 22,
    G1_Payment_Method= 23;  
    
var G2_PK           = 0,
    G2_Room_No      = 1,
    G2_Last_Name    = 2, 
    G2_First_Name   = 3,
    G2_Check_In     = 4,
    G2_Adjust_Date  = 5,
    G2_Ex_Rate      = 6,
    G2_Adj_Amt_USD  = 7,
    G2_Adj_Amt_VND  = 8,
    G2_Adj_Reason   = 9,
    G2_Adj_By_PK    = 10,
    G2_Adj_Emp_Name = 11,
    G2_RoomAllocatePK=12, 
	G2_FeeType=13;
   
var arr_FormatNumber = new Array();  
 //===================================================================    

 function BodyInit()
 {
    dtFrom.SetDataText(System.AddDate(dtFrom.GetData(),-15));
    //----------------------
	var data;
    grdRoomAllocate.GetGridControl().FrozenCols = 5;
	data ="#10;ROOM FEE|#20;F&B FEE|#30;GREEN FEE|#40;CADDIE FEE|#50;CART FEE|#60;TELEHONE FEE|#70;MINIBAR FEE"
    grdAdjust.SetComboFormat(G2_FeeType,data);
	SetGridFormat();

	OnSearch('EX-RATE');
 }
 //===================================================================    
 
 function SetGridFormat()
 {
    var ctr = grdAdjust.GetGridControl(); 

    ctr.ColFormat(G2_Ex_Rate)     = "#,###,###,###,###,###";
    ctr.ColFormat(G2_Adj_Amt_USD) = "#,###,###,###,###,###.##";    
    ctr.ColFormat(G2_Adj_Amt_VND) = "#,###,###,###,###,###";

    arr_FormatNumber[G2_Ex_Rate]     = 0;
    arr_FormatNumber[G2_Adj_Amt_USD] = 2;
    arr_FormatNumber[G2_Adj_Amt_VND] = 0;
   
 }
  //===================================================================    
function OnAddNew(pos)
{
    switch (pos)
    {
        case 'ADJUST':
            if ( grdRoomAllocate.row > 0 )
            {
                grdAdjust.AddRow();                            
                grdAdjust.SetGridText( grdAdjust.rows-1, G2_Room_No, grdRoomAllocate.GetGridData(grdRoomAllocate.row,G1_Room) );
                grdAdjust.SetGridText( grdAdjust.rows-1, G2_Last_Name, grdRoomAllocate.GetGridData(grdRoomAllocate.row,G1_Last_Name) );
                grdAdjust.SetGridText( grdAdjust.rows-1, G2_First_Name, grdRoomAllocate.GetGridData(grdRoomAllocate.row,G1_First_Name) );
                
                grdAdjust.SetGridText( grdAdjust.rows-1, G2_Check_In, grdRoomAllocate.GetGridData(grdRoomAllocate.row,G1_Check_In) );
                grdAdjust.SetGridText( grdAdjust.rows-1, G2_Adjust_Date, dtAdjTo.value );

                grdAdjust.SetGridText( grdAdjust.rows-1, G2_Ex_Rate, txtExRate.text );

                grdAdjust.SetGridText( grdAdjust.rows-1, G2_Adj_By_PK,    user_pk );
                grdAdjust.SetGridText( grdAdjust.rows-1, G2_Adj_Emp_Name, user_name );
                
                grdAdjust.SetGridText( grdAdjust.rows-1, G2_RoomAllocatePK, grdRoomAllocate.GetGridData(grdRoomAllocate.row,G1_PK) );                
            }  
            else
            {
                alert("PLS SELECT ONE ROOM ALLOCATE!");
            }      	                                                                            
        break;
    }
}
//=========================================================================

function OnDelete(pos)
{
    switch (pos)
    {
        case 'ADJUST':
			if(grdAdjust.row > 0)
				if(confirm('Are you sure to delete?'))
					grdAdjust.DeleteRow();
					data_htfo00130_1.Call();
        break;
    }    
}
//===================================================================    
 function OnSearch(pos)
 {
    switch (pos)
    {
        case 'EX-RATE':       
            pro_htfo00130.Call();
        break;
        
        case 'ADJUST':
            txtRoomAlloPK.text = '' ;            
            data_htfo00130_1.Call("SELECT");
        break;
    
	    case 'ALLOCATE':
	        if ( chkCheckOut.value == 'N' )
            {
	            id_date.style.display = 'none';
            }
            else
            {
	            id_date.style.display = '';
            } 
                  
            data_htfo00130.Call("SELECT");	    
	    break;
    }    
 }
 
 //===================================================================    

 function OnDataReceive(obj)
 {
	if ( obj.id== 'data_htfo00130')
	{
		if (grdRoomAllocate.rows > 1)	
		{
				grdRoomAllocate.Subtotal( 1, 2, -1, '9!10!11!12!13!14!15');
				lblRows.text = grdRoomAllocate.rows-2;
		}	    
	}
	else if ( obj.id== 'pro_htfo00130' )
	{
	    OnSearch('ALLOCATE');
	}
 }
 
//=========================================================================

function OnSave(pos)
{
    switch (pos)
    {
        case 'ADJUST':
            if(CheckValidate())
			{
				data_htfo00130_1.Call();
			}
        break;
    }    
}

//=========================================================================

function CheckInput()
{   
    var col, row
    
    col = event.col
    row = event.row  
    
    if ( col == G2_Adj_Amt_USD || col == G2_Adj_Amt_VND || col == G2_Ex_Rate )
    {
        var dQuantiy
        
        dQuantiy =  grdAdjust.GetGridData(row,col) ;
        
        if (Number(dQuantiy))
        {   
            if (dQuantiy >0)
            {
                grdAdjust.SetGridText(row,col, System.Round( dQuantiy, arr_FormatNumber[col] ));
            }            
        }
        else
        {
            grdAdjust.SetGridText(row,col,"") ;
        }     
    }
    
    if ( col == G2_Adj_Amt_USD || col == G2_Ex_Rate )
    {
        var dQuantiy;
        
        dQuantiy = grdAdjust.GetGridData(row,G2_Adj_Amt_USD) * grdAdjust.GetGridData(row,G2_Ex_Rate);
        grdAdjust.SetGridText(row,G2_Adj_Amt_VND, System.Round( dQuantiy, arr_FormatNumber[G2_Adj_Amt_VND] ));
    }

}
function OnReport()
{
      if(grdAdjust.rows > 1)
	  {
			if(grdAdjust.row !='-1')
			{
				var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ht/fo/htfo00130_adjust_voucher.rpt&procedure=CRM.sp_sel_htfo00130_rpt&parameter="+grdAdjust.GetGridData(grdAdjust.row,G2_PK);    
				System.OpenTargetPage(url); 
				//var url =System.RootURL + '/reports/ht/fo/htfo00130.aspx?p_pk='+grdAdjust.GetGridData(grdAdjust.row,G2_PK);
				//window.open(url, "_blank");	 
			}
			else
			{
				alert("Please,choose guest adjusted to print.");
			}			
	  }
}
function CheckValidate()
{
	for(var i=1;i<grdAdjust.rows;i++)
          {
            if(grdAdjust.GetGridData(i,G2_Adj_Amt_VND) == "")
             {
                alert("Please input adjust amount at row "+ i);
                return false;
             }
			if(grdAdjust.GetGridData(i,G2_Adj_Reason) == "")   
             {
                alert("Please input reason at row "+ i);
                return false;
             }
             if(grdAdjust.GetGridData(i,G2_FeeType) == "")
             {
                alert("Please input fee type at row "+ i);
                return false;
             }
          }
          return true;
}
</script>

<body>
 <!---------------------------------------------------------------->
    <gw:data id="pro_htfo00130" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="crm.sp_pro_htfo00130" > 
                <input>
                    <input bind="txtExRate" /> 
                </input> 
                <output>
                    <output bind="txtExRate" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!----------------------------------------------------------------------->
    <gw:data id="data_htfo00130" onreceive="OnDataReceive(this)"> 
        <xml>
           <dso  type="grid"  function="CRM.sp_sel_htfo00130" >
                <input  bind="grdRoomAllocate">
                    <input bind="txtRoomNo" /> 
                    <input bind="dtFrom" />
                    <input bind="chkCheckOut" />
                </input> 
                <output bind="grdRoomAllocate" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!----------------------------------------------------------------------->
    <gw:data id="data_htfo00130_1" onreceive="OnDataReceive(this)"> 
        <xml>
           <dso  type="grid"   parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13" function="crm.sp_sel_htfo00130_1"  procedure="crm.sp_upd_htfo00130_1">
                <input  bind="grdAdjust">
                    <input bind="txtRoomAlloPK" />
					<input bind="dtAdjFr" />
					<input bind="dtAdjTo" />
					<input bind="txtRoomGuest" />
                </input> 
                <output bind="grdAdjust" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!----------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="0">
        <tr style="height: 50%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr style="height: 2%">
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Room#/Guest Name:
                        </td>
                        <td width="20%" align="right">
                            <gw:textbox id="txtRoomNo" styles="width: 100%" onenterkey="OnSearch()" />
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="left">
                            Check Out
                            <gw:checkbox id="chkCheckOut" styles="color:blue" defaultvalue="Y|N" value="N" onclick="OnSearch('ALLOCATE')">
                            </gw:checkbox>
                        </td>
                        <td style="width: 30%; white-space: nowrap" align="center" id="id_date">
                            From:
                            <gw:datebox id="dtFrom" lang="1" styles="width:100%" />
                        </td>
                        <td style="width: 10%; white-space: nowrap">
                            Total Room:
                        </td>
                        <td style="width: 20%">
                            <gw:label id="lblRows" />
                        </td>
                        <td style="width: 8%; white-space: nowrap" align="center">
                            <gw:imgbtn id="ibtnSearch1" img="search" alt="Search" onclick="OnSearch('ALLOCATE')" />
                        </td>
                        <td style="width: 1%" align="left">
                             
                        </td>
                        <td style="width: 1%" align="left">
                             
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="11">
                            <gw:grid id='grdRoomAllocate' 
                                header='Room|Last Name|First Name|Check In|Check Out|Days|Type|Avg Rate|Room Charge|Total Due|Advance|F&B Hotel|MiniBar|Laundry|Biz Center|Others|Nation|Check In By|Check In Date|Check Out By|Check Out Date|_PK|Rate Plan|Payment Method'
                                format='0|0|0|4|4|0|0|-0|-0|-0|-0|-0|-0|-0|-0|0|0|0|0|0|0|0' 
                                aligns='0|0|0|1|1|3|1|3|3|3|3|3|3|3|3|0|0|0|0|0|0|0'
                                editcol='0|0|0|4|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
                                widths='1200|1500|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|0|0|0'
                                sorting='T' autosize='T' acceptnulldate="T" styles='width:100%; height:100%'
                                oncellclick="txtRoomAlloPK.text=grdRoomAllocate.GetGridData(grdRoomAllocate.row,G1_PK);data_htfo00130_1.Call('SELECT');" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 50%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr style="height: 2%">
                        <td align="right" style="width: 10%; white-space: nowrap">
                            Adj Date
                        </td>
                        <td style="width: 20%; white-space: nowrap">
                            <gw:datebox id="dtAdjFr" lang="1" styles="width:100%" onchange="OnSearch('ADJUST')"  />
                            ~
                            <gw:datebox id="dtAdjTo" lang="1" styles="width:100%" onchange="OnSearch('ADJUST')" />
                        </td>
                        <td style="width: 10%" align="right">
                            Room/Guest
                        </td>
                        <td style="width: 20%" align="right">
                            <gw:textbox id="txtRoomGuest" styles="width: 100%" onenterkey="OnSearch('ADJUST')" />
                        </td>
                        <td width="33%" align="center">
                        </td>
                        <td style="width: 1%" align="left">
                            <gw:imgbtn id="ibtnSearch" img="search" alt="Search" onclick="OnSearch('ADJUST')" />
                        </td>
                        <td style="width: 1%" align="left">
                            <gw:imgbtn id="ibtnAddNew" img="new" alt="new" onclick="OnAddNew('ADJUST')" />
                        </td>
                        <td style="width: 1%" align="left">
                            <gw:imgbtn id="ibtnDelete" img="delete" alt="delete" onclick="OnDelete('ADJUST')" />
                        </td>
                        <td style="width: 1%" align="left">
                            <gw:imgbtn id="ibtnSave" img="save" alt="Save" onclick="OnSave('ADJUST')" />
                        </td>
						<td style="width: 3%" align="left">
							<gw:imgbtn id="ibtnReport1" img="printer" alt="Report" onclick="OnReport()" />
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="10">
                            <gw:grid id='grdAdjust' header='_PK|Room No|Last Name|First Name|Check In|Adjust Date|_Ex-Rate|_AdjAmt(USD)|Adj Amt (VND)|Adj Reason|_Adj_By_PK|Adj Name|_Room_Allocate_PK|Fee Type'
                                format='0|0|0|0|4|4|-2|-2|-0|0|0|0|0|0' 
                                aligns='0|0|0|0|1|1|3|3|3|0|0|0|0|0' 
                                check='|||||||||||||'
                                editcol='0|0|0|0|0|0|1|1|1|1|0|0|0|' 
                                widths='0|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                sorting='T' autosize='T' acceptnulldate='F' styles='width:100%; height:100%' onafteredit="CheckInput()"  />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txtRoomAlloPK" styles='width:100%;display:none' />
    <gw:textbox id="txtExRate" styles='width:100%;display:none' />
    <!------------------------------------------------------------------>
</body>
</html>
