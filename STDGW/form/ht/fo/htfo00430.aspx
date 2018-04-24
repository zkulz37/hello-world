<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Other Fees</title>
</head>
<%  ESysLib.SetUser("crm")%>

<script>
var G1_PK=0,
	G1_THT_BOOKING_PK=1,
	G1_Date_Cancel_booking=2,
	G1_Last_Name=3,
	G1_First_Name=4,
	G1_RSVno=5,
	G1_Amount_VND=6,
	G1_Ex_Rate=7,
	G1_Amount_USD=8,
	G1_Payment_Method=9,
	G1_Description=10; 

 function BodyInit()
 {    
   txtExRate.text = "<%=ESysLib.SetDataSQL("SELECT crm.sf_get_current_sell_ex_rate(2,'USD') from dual")%>";
   var data = "<%=ESysLib.SetGridColumnDataSQL("SELECT code,NAME FROM comm.tco_commcode WHERE DEL_IF=0 and  parent_code='PTYPE' and use_yn='Y' and code not in('PTYPE-03')")%>";
    idGrid.SetComboFormat(G1_Payment_Method, data);
   dso_other_fee.Call("SELECT");
 }
 function OnSearch()
 {
	dso_other_fee.Call("SELECT");
 }
function OnAddNew()
{
    idGrid.AddRow();
    idGrid.SetGridText(idGrid.rows -1, G1_Ex_Rate , txtExRate.text);
}
function OnDelete()
{
   if ( confirm( "Do you want item this row to delete?" )) 
   {
		idGrid.DeleteRow();dso_other_fee.Call();
   }
}
function ChangeAmtUSD_VND(){
    switch(event.col){
        case G1_Amount_USD:
			var l_Rate =0;//= Number(txtExRate.text);
			var amt_vnd,amt_usd;
			if(idGrid.GetGridData(idGrid.row, G1_PK)!="")
			{
				l_Rate=Number(idGrid.GetGridData(idGrid.row, G1_Ex_Rate));//update data not change ex_rate
			}
			else
			{
				l_Rate=Number(txtExRate.text);//addnew data get ex_rate current
			}
			amt_vnd= Math.round((Number(idGrid.GetGridData(idGrid.row, idGrid.col))*l_Rate*100)/100);
            idGrid.SetGridText(idGrid.row, G1_Amount_VND , amt_vnd);
			//idGrid.SetGridText(idGrid.row, G1_Amount_VND , amt_vnd);
		break;
        case G1_Amount_VND:
			var l_Rate =0;// Number(txtExRate.text);
			if(idGrid.GetGridData(idGrid.row, G1_PK)!="")//update data not change ex_rate
			{
				l_Rate=Number(idGrid.GetGridData(idGrid.row, G1_Ex_Rate));
			}
			else
			{
				l_Rate=Number(txtExRate.text);//addnew data get ex_rate current
			}
			var amt_vnd,amt_usd;
			amt_usd= Math.round((Number(idGrid.GetGridData(idGrid.row, idGrid.col))/l_Rate*100)/100);
            idGrid.SetGridText(idGrid.row, G1_Amount_USD , amt_usd);
        break;
    }
}
function OnSave(){
    if(OnValid()){
        dso_other_fee.Call();
    }
}
function OnValid(){
    for(var x = 1; x < idGrid.rows; x++)
	{
        if(idGrid.GetGridData(x, G1_RSVno) == "")
		{
            alert("Please choose data for column 'RSV#' row => " +x+ " !" ); 
			return false;
        }
		if(idGrid.GetGridData(x, G1_Amount_VND) == ""||idGrid.GetGridData(x, G1_Amount_USD) == "") 
		{
            alert("Please input data for column 'amount(vnd) or amount(usd)' row => " +x+ " !" ); 
			return false;
        }
	}
    return true;
}
function OnDataReceive(obj){
    var total = 0;
    if(idGrid.rows > 1){
        for ( var i=1; i < idGrid.rows; i++)
            total += Number(idGrid.GetGridData( i, G1_Amount_VND));
    }
    txtTotal.text = total + " VND";
}
function Onpopup(obj)
{
	if(obj.col==G1_Last_Name||obj.col==G1_First_Name||obj.col==G1_RSVno)
	{
		var path = System.RootURL + "/form/ht/fo/htfo00430_booking_popup.aspx?";
				var object = System.OpenModal( path ,450 , 500 ,  'resizable:yes;status:yes');
				if ( object != null )
				{
					idGrid.SetGridText(event.row, G1_THT_BOOKING_PK , object[0]);
					idGrid.SetGridText(event.row, G1_Last_Name , object[2]);
					idGrid.SetGridText(event.row, G1_First_Name , object[3]);
					idGrid.SetGridText(event.row, G1_RSVno , object[4]);
				}
	}

}
function OnReport()
{
		 if(idGrid.rows >1)
		 {
			 url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ht/fo/rpt_htfo00430_cancel_booking.rpt&procedure=CRM.sp_sel_htfo00430&parameter="+dtFrom.value+","+dtTo.value;   
			 System.OpenTargetPage(url);  
		 }
}

</script>
<body>
    <gw:data id="dso_other_fee" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10" function="crm.sp_sel_htfo00430" procedure = "crm.sp_upd_htfo00430">
                <input bind="idGrid" >
                    <input bind="dtFrom"/>
					<input bind="dtTo"/>
                </input>
                <output bind="idGrid"/>
            </dso>
        </xml>
    </gw:data>
    <!---------------------------------------------------------------->
    <table style="background: #BDE9FF; height: 100%; width: 100%">
        <tr style="height: 6%" valign="top">
            <td style="background: white;">
                <table style="height: 100%; width: 100%">
                    <tr style="height: 2%" valign="top">
                        <td>
                            <table style="height: 100%; width: 100%">
                                <tr>
									<td width="15%" align="right">Booking Cancel Date:</td>
									<td width="20%" align="right">
										<gw:datebox id="dtFrom" lang="1" onchange="OnSearch()" />
                                                        ~
                                        <gw:datebox id="dtTo" lang="1" onchange="OnSearch()" />   
									</td>
									<td width="2%" align="right"></td> 
                                    <td style="width: 20%">
                                        Ex. RATE : <gw:textbox id="txtExRate" type="number" format="###,###,###,###" styles="text-align:right;width:50%;color:red" readonly="true" /><b style="color: Red; font-weight: bold">(VND)</b>
                                    </td>
                                    <td style="width: 21%">
                                        Total : <gw:textbox id="txtTotal" type="number" format="###,###,###,###" styles="text-align:right;width:50%;color:red" readonly="true" /><b style="color: Red; font-weight: bold">(VND)</b>
                                    </td>
									<td width="10%" align="right"></td>
									<td width="3%">
										<gw:imgbtn id="btnSearch" img="search" width="100%" img="in" text="Search" onclick="OnSearch()" />
									</td>
									
                                    <td style="width: 3%">
                                        <gw:imgbtn img="new" alt="New" id="idBtnAdd" styles='width:100%' onclick="OnAddNew()" /> 
                                    </td>
                                    <td style="width: 3%">
                                        <gw:imgbtn img="save" alt="Save" id="idBtnUpdate" styles='width:100%' onclick="OnSave()" />
                                    </td>
                                    <td style="width: 3%">
                                        <gw:imgbtn img="delete" alt="Delete" id="idBtnDelete" styles='width:100%' onclick="OnDelete()" />
                                    </td>
									<td width="3%" align="right">
										<gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnReport()" />
									</td>	
									
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 98%" valign="top">
                        <td>
                            <gw:grid id="idGrid" 
                                header      ="_PK|_THT_BOOKING_PK|Date|Last Name|First Name|RSV#|Amount(VND)|Ex.Rate|Amount(USD)|Payment Method|Description"
                                format      ="0|0|0|0|0|0|-0|-0|-2|0|0" 
                                aligns      ="0|0|0|0|0|0|0|0|0|0|0" 
                                defaults    ="||||||||||" 
                                editcol     ="0|0|0|0|0|0|1|0|1|1|1" 
                                widths      ="0|0|0|0|0|0|0|0|0|0|0" 
                                styles      ="width:100%; height:100%" 
                                sorting     ="T" 
                                autosize    ="T"  
								onafteredit="ChangeAmtUSD_VND()"
								oncelldblclick="Onpopup(this)"	
                                />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txtMasterPK"    styles="width:100%; display:none" />
    <gw:textbox id="txtTempValue"   styles="width:100%; display:none" />
    <gw:textbox id="txt_room_allocate_pk" styles="width:100%; display:none" />
</body>
</html>
