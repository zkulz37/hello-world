<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Break Down Register</title>
</head>
<%  ESysLib.SetUser("comm")%>

<script>

var G1_pk           = 0, 
    G1_seq          = 1,
    G1_tco_company_pk = 2,
    G1_hoki         = 3,
    G1_start_dt     = 4,
    G1_start_time   = 5,
    G1_end_dt       = 6,
    G1_end_time     = 7,
    G1_stop_time    = 8,
    G1_stop_reason  = 9,
    G1_tmp          = 10;
var company_pk;    
//===============================================================

function BodyInit()
{
    company_pk    = "<%=Session("COMPANY_PK")%>" ;
    //------------------
	BindingDataList();
	FormatGrid();
	OnSearch();		
}
//===============================================================

function BindingDataList()
{ 
    var data = "";
    data =  "<%=ESysLib.SetListDataSQL("SELECT pk,PARTNER_NAME from  comm.TCO_COMPANY where del_if=0 order by PARTNER_NAME ")%>";
    lstCompany.SetDataText(data);
    
    data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.CODE, a.CODE || ' -'  ||a.CODE_NM FROM Sale.LG_CODE a, Sale.LG_CODE_GROUP b WHERE  b.GROUP_ID='LGMF0050' AND a.LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ")%>"; 
    data = data + "|#;";
    grdBreakDown.SetComboFormat(G1_stop_reason,data);
    data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE || ' -'  ||a.CODE_NM FROM Sale.LG_CODE a, Sale.LG_CODE_GROUP b WHERE  b.GROUP_ID='LGMF0010' AND a.LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ")%>"; 
    lstMachineNO.SetDataText(data);  
}

//===============================================================

function OnSearch()
{
    data_shpr00020.Call('SELECT');
}
//===============================================================
 function FormatGrid()
 {
      var trl ;
      
      trl = grdBreakDown.GetGridControl();
      	
      trl.ColFormat(G1_stop_time )   = "###,###,###,###,###";   
      trl.ColEditMask(G1_start_time) = "99:99";
      trl.ColEditMask(G1_end_time)   = "99:99"; 
      
 }
//===============================================================

function OnNew()
{    
    if(lstCompany.value=='')
    {
        alert('Please select Company first!!!');
        return;
    }
    
    if(lstMachineNO.value=='')
    {
        alert('Please select Company No!!!');
        return;
    }
    
     grdBreakDown.AddRow();
     grdBreakDown.SetGridText(grdBreakDown.rows-1, G1_seq,grdBreakDown.rows-1);
     grdBreakDown.SetGridText(grdBreakDown.rows-1, G1_start_dt,dtnow.value);
     grdBreakDown.SetGridText(grdBreakDown.rows-1, G1_stop_time,1440);
     grdBreakDown.SetGridText(grdBreakDown.rows-1,G1_tco_company_pk, lstCompany.value);
     grdBreakDown.SetGridText(grdBreakDown.rows-1,G1_hoki, lstMachineNO.value);
}
//===============================================================

function OnDelete()
{
    if ( confirm ( "Do you want to delete this break?" ) )
    {
        //grdBreakDown.DeleteRow();
        if ( grdBreakDown.GetGridData( grdBreakDown.row,G1_pk ) == '' ) 
        {
            grdBreakDown.RemoveRow();
        }
        else
        {
            grdBreakDown.DeleteRow();
        }  
    }
}
//===============================================================

function OnUnDelete()
{
    grdBreakDown.UnDeleteRow();
}
//===============================================================

function OnSave()
{  
    data_shpr00020.Call();    
}
//===============================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case 'data_shpr00020_1':
            if(Number(txtRtnValue.text) <0)
            {
                alert("Finish time must be greater than Break time!!!");
                grdBreakDown.SetGridText(grdBreakDown.row,G1_tmp,txtRtnValue.text);
                return;
            }
            grdBreakDown.SetGridText(grdBreakDown.row,G1_stop_time,txtRtnValue.text);
            grdBreakDown.SetGridText(grdBreakDown.row,G1_tmp,txtRtnValue.text);
            
        break;
    }    
}
//====================================================================================
function OnValidateData()
{
    for(var i =1;i<grdBreakDown.rows;i++)
    {
        if(Number(grdBreakDown.GetGridData(i,G1_tmp))<0)
        {
            alert("Finish time must be greater than Break time!!!");
            return false;
        }
    }
    return true;
}
//=====================================================================================
 function CheckInput()
 {
    var col, row
    col = event.col
    row = event.row        
    
    if ( col == G1_start_time || col == G1_end_time )
	{
		tmpIN = grdBreakDown.GetGridData(event.row,col)
		
		if ( tmpIN.length == 0 )
		{
			grdBreakDown.SetGridText(event.row, col, "")
			
		}
		if( ( tmpIN.length !=4 ) && ( tmpIN.length !=0 ) )
		{
			alert("Input In time is not correct type.(type: hh:mm)\nKiểu giờ in nhập không đúng")
			grdBreakDown.SetGridText(event.row,col,'')
			return;
		}
		if((Number(tmpIN.substr(0,2))>=24)||(Number(tmpIN.substr(0,2))<0))
		{
			alert("Input In time(Hour) is not correct type.(00<= hh <= 23)\nKiểu giờ in phải >=00 và <=23")
			grdBreakDown.SetGridText(event.row,col,'')
			return;
		}
		if((Number(tmpIN.substr(2,2))>=60)||(Number(tmpIN.substr(2,2))<0))
		{
			alert("Input In time(Minute) is not correct type.(00<= hh < 59)\nKiểu phút phải >=00 và <=59")
			grdBreakDown.SetGridText(event.row,col,'')
			return;
		}
		if(tmpIN.length>0)
		{
		    tmpIN=tmpIN.substr(0,2)+":"+tmpIN.substr(2,2)
		    grdBreakDown.SetGridText(event.row,col,tmpIN)
		}    
	}
      
    if ( col == G1_start_dt || col == G1_start_time || col == G1_end_dt || col == G1_end_time )
    {                
    //------------------------------------------                
        var start_dt,start_time, end_dt, end_time ;
 
        start_dt = grdBreakDown.GetGridData(row,G1_start_dt);
        start_time = grdBreakDown.GetGridData(row,G1_start_time);
        end_dt = grdBreakDown.GetGridData(row,G1_end_dt); 
        end_time = grdBreakDown.GetGridData(row,G1_end_time); 
        
        if (start_time=='' && end_dt=='' && end_time =='' )
        {   
            grdBreakDown.SetGridText(row, G1_stop_time,1440);
        }
        else 
        {
            if (start_time=='' || end_dt=='' || end_time =='' )
            {
                grdBreakDown.SetGridText(row,G1_stop_time,"");
            } 
            else
            {
                txtStartDT.text     = start_dt;
                txtStartTime.text   = start_time;
                txtEndDT.text       = end_dt;
                txtEndTime.text     = end_time;
                data_shpr00020_1.Call();
            }
        }
    //------------------------------------------        
    } 
 }
//===============================================================
</script>

<body>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="data_shpr00020" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="3" type="grid" parameter="0,2,3,4,5,6,7,8,9" function="prod.sp_sel_shpr00020_1" procedure="prod.sp_upd_shpr00020_1">
                <input bind="grdBreakDown" >
                    <input bind="lstCompany" />
                    <input bind="dtBreakMonth" />
                    <input bind="lstMachineNO" />
                </input>
                <output bind="grdBreakDown" />
            </dso>
        </xml>
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="data_shpr00020_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="prod.sp_pro_shpr00020_2" > 
                <input>
                    <input bind="txtStartDT" /> 
                    <input bind="txtStartTime" /> 
                    <input bind="txtEndDT" /> 
                    <input bind="txtEndTime" /> 
                </input> 
                <output>
                    <output bind="txtRtnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <table style="height: 100%; width: 100%" border="1">
        <tr style="height: 1%">          
            <td style="width: 100%">
                <table style="height: 100%; width: 100%">
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            Company
                        </td>
                        <td style="width: 70%; white-space: nowrap" colspan =3>
                            <gw:list id="lstCompany" styles='width:100%' onchange="OnSearch()" />
                        </td>
                        <td style="width: 21%">
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                            
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td style="width: 5%" align="right">
                            Month
                        </td>
                        <td style="width: 20%; white-space: nowrap">
                            <gw:datebox id="dtBreakMonth" type="month" lang="1" onchange="OnSearch()"/>
                        </td>
                        <td style="width: 15%;white-space: nowrap" align="right">
                            Machine No.</td>
                        <td style="width: 35%;white-space: nowrap" align="right">
                            <gw:list id="lstMachineNO" styles='width:100%' onchange="OnSearch()" />
                        </td>    
                        <td style="width: 21%" align=right>
                            <gw:imgbtn img="search" alt="Search" onclick="OnSearch()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="new" alt="New" onclick="OnNew()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="delete" alt="Delete" onclick="OnDelete()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="udelete" alt="UnDelete" onclick="OnUnDelete()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="save" alt="Save" onclick="OnSave()" />
                        </td>
                    </tr>
                 </table>  
            </td> 
        </tr>
        <tr style="height: 98%">
            <td >
                <gw:grid id="grdBreakDown" 
                    header='_pk|Seq|_tco_company_pk|_hoki|Break Date|Time|Finished Date|Time|DownTime(Min)|Reason|_tmp'
                    format='0|0|0|0|4|0|4|0|0|2|0' aligns='0|1|0|0|0|1|0|1|3|0|0' defaults='||||||||||'
                    editcol='0|0|0|0|1|1|1|1|1|1|' widths='0|600|0|0|1400|1000|1400|1000|1500|2000|0'
                    acceptnulldate="T"  onafteredit="CheckInput()"
                    sorting='T' styles="width:100%;height:100%" />
            </td>
        </tr>
    </table>
</body>
<gw:datebox id="dtnow" style="display:none" lang="1" />
<gw:textbox id="txtStartDT" styles="display:none" />
<gw:textbox id="txtStartTime" styles="display:none" />
<gw:textbox id="txtEndDT" styles="display:none" />
<gw:textbox id="txtEndTime" styles="display:none" />
<gw:textbox id="txtRtnValue" styles="display:none" />
<!--------------------------------------------------------------------------------------->
</html> 
