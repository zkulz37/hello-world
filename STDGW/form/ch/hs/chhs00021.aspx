<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var lang="<%=Session("Lang")%>";
var arrHolidayDate    = new Array();
var arrHolidayMonth   = new Array();
var arrHolidayYear    = new Array();
var arrHolidayType    = new Array();
var arrHolidayComment = new Array();
var cGrid;
var v_month;
var v_year;
var v_language = "<%=Session("SESSION_LANG")%>";
var v_location = "<%=request.QueryString("p_location")%>"
function BodyInit()
{   

	
	
    if (v_language!="ENG")
        System.Translate(document);
 
 
	txtLocation.text = "<%=request.QueryString("p_location")%>";
	
}
 
//---------------------------------------------------------
function OnDataReceive(obj)
{
    if (obj.id=="dsohr_chhs00020_s_01")
    {
        for(cGrid=1;cGrid<grdCalendar.rows;cGrid++)
        {
           arrHolidayDate[cGrid]  = Number((grdCalendar.GetGridData(cGrid,1)).substr(6,2));
           arrHolidayMonth[cGrid] = Number((grdCalendar.GetGridData(cGrid,1)).substr(4,2));
           arrHolidayYear[cGrid]  = Number((grdCalendar.GetGridData(cGrid,1)).substr(0,4));
           arrHolidayType[cGrid]    = grdCalendar.GetGridData(cGrid,3);
           arrHolidayComment[cGrid] = grdCalendar.GetGridData(cGrid,4);
        }   
       
       for (var i=1;i<cGrid;i++)
       {	
	        SearchDraw(arrHolidayDate[i],arrHolidayMonth[i],arrHolidayYear[i],arrHolidayType[i],arrHolidayComment[i]);
       }   
    
    
    }
 
        
} 
//--------------------------------------------------------------
function OnClickEntry()
{	 
	var p_month=dtMonth.value;
	var p_location=dtMonth.value;
	 
	var url = "/form/ag/bh/agbh00070_popup.aspx?p_month=" + p_month +"&p_location="+p_location;
	var obj;
	obj = System.OpenModal(System.RootURL + url,800,500,"resizable:yes;status:yes"); 
	if (obj != 0)
	  { 	 
		 ;
	  }
	
}
function OnSearch()
{
	dsohr_chhs00021_s_01.Call("SELECT");
}
</script>
<body>
<!------------main control---------------------->
 
<gw:data id="dsohr_chhs00021_s_01" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid"  function="hr_chhs00021_s_01" > 
                <input bind="Grid1">
                    <input bind="lstRoom" /> 
					<input bind="lstLocation" />
					<input bind="dtFrom" />
					<input bind="dtTo" />
                </input> 
                <output bind="Grid1"/>
            </dso> 
        </xml> 
</gw:data> 
 
 

<!--------------------main table--------------------------------->
<table id="management" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="tblexp" style="height:100%" border=0 cellpadding="0" cellspacing="0">
					<tr width="100%">
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
					</tr>	
					<!--<tr style="border:0;width:100%;height:5%" valign="center" >
                        <td colspan="5" style="border:0;" align="right" ><a title="Click here to show" onclick="OnShowPopup(1)" href="#tips" >
                            Organization </a>          </td>
                        <td colspan="10"  style="border:0;" align="left" >
                         <gw:list  id="lstOrg_Code" value='ALL' maxlen = "100" styles='width:100%'onchange="" >
                            <data>
                                DATA|1|.GENERAL DIRECTOR|2|...MAIN OFFICE|43|.....BOM|85|.......HCMC RLC|46|.......BUSINESS|152|.......TRADING|49|.......QA|56|.......RD|164|.........SALES SUPPORT|156|.......RETAIL SUPPORT|55|.......MARKETING|58|.......PLANNING 2|50|.......FINANCING|60|.......TREASURY|44|.......QC|106|.........PLANNING 3|105|.........BUSINESS 3|144|...........ICT 2|145|...........HA NOI CARD CENTER|47|.......ANALYSIC|107|.......COLLECTION|146|.........COLLECTION 2|147|.........COLLECTION 3|52|.......HR|84|.........HR TFT|65|.........HR 2|148|.........RECEPTION NORTH|157|.........HRD|158|.........HRM|51|.......GA|149|.......ICT 3|150|.........ICT 4|151|.........ICT 5|153|.......TRADING 2|57|.......RD2|45|.......COMPLIANCE|53|.......INTERNAL AUDIT|62|.......SALES|187|.........EXTERNAL RELATION|111|.........HR NORTH|112|.........GA NORTH|64|.........MARKETING 2|63|.........SALES 2|113|.........ANALYSIC|154|.......SECURITY|155|.......SECURITY 2|48|.......PLANNING|3|...FACTORY|104|.....NORTH|74|.......DONG NAI|81|.......TRAN DUY HUNG|68|.......BAC NINH|75|.......HAI PHONG|82|.......THAI NGUYEN|79|.......PHAM HUNG|83|.......VINH PHUC|77|.......HA NOI|124|.....SOUTH|76|.......HO CHI MINH|66|.......BUSINESS 2|80|.......SONG THAN|71|.......ACC|69|.......BINH DUONG|70|.......BIEN HOA|78|.......PHU MY HUNG|67|.......AN DONG|73|.......GO VAP|72|.......DONG SAI GON|189|...SALE AGENT 2|190|.....SALE AGENT 3|191|.....SALE AGENT 4|192|.....COLLECTION 4|188|.SALE AGENT|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td colspan="5"  style="border:0;" align="right" >Contract Type</td>
                        <td colspan="10"  style="border:0;" align="left" ><gw:list  id="lstContract_type" value='ALL' maxlen = "100" styles='width:100%' >
							<data>DATA|01|PROBATION|02|1 YEAR (1)|03|1 YEAR (2)|04|INDEFINE|ALL|Select All</data>
							</gw:list></td>
                         <td colspan="5"  style="border:0;" align="right" >Work Group</td>
                        <td colspan="9"  style="border:0;" align="left" >
                         <gw:list  id="lstWorkGroup" value='ALL' maxlen = "100" styles='width:100%' >
                            <data>DATA|1|NORMAL|2|DRIVER|ALL|Select All</data></gw:list>
                        </td>
						<td colspan="1" style="border:0;" align="right" ></td>
                        <td colspan="1" style="border:0;" align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch()"/>
                        </td>
                        <td colspan="1" style="border:0" align="right">
                         <gw:imgBtn img="save" id="ibtnSave"    alt="Save"  onclick="OnSave()"/>
                        </td>
                        <td colspan="1" style="border:0" align="right">
                         <gw:imgBtn img="delete" id="ibtnDelete"    alt="Delete"  onclick="OnDelete()"/>
                        </td>
                        <td colspan="1" style="border:0" align="right">
                         <gw:imgBtn img="udelete" id="ibtnUnDelete"    alt="UnDelete"  onclick="OnUnDelete()"/>
                        </td>
                        <td colspan="1" style="border:0;" align="right" >
                    </tr> -->					
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td colspan="4" style="border:0;" align="right" >Địa điểm</td>
                        <td colspan="10"  style="border:0;" align="left" ><gw:list  id="lstLocation" value='01' maxlen = "100" styles='width:100%' >
							<data><%=ESysLib.SetListDataSQL("select location_id,location_name from thr_hs_location a where a.del_if=0 order by location_name ")%></data></gw:list></td>
                        <td colspan="4" style="border:0;" align="right" > Chọn phòng</td>
                        <td colspan="10" style="border:0;" align="left" >
							<gw:list  id="lstRoom" value='ALL' maxlen = "100" styles='width:100%' >
							<data><%=ESysLib.SetListDataSQL("select room_id,room_name from thr_hs_room a where a.del_if=0 order by room_name ")%>|ALL|Tất cả phòng</data>
							</gw:list>
                        </td>
                        <td colspan="5" style="border:0;" align="right">Từ ngày</td>
				        <td  colspan="4" style="border:0;"><gw:datebox id="dtFrom" nullaccept styles="width:100%" lang="1" /></td>
				        <td  colspan="1" style="border:0;" align="center">~</b></td>
				        <td colspan="4" style="border:0;"><gw:datebox id="dtTo" nullaccept styles="width:100%" lang="1" /></td>
						<td  colspan="2" style="border:0;" align="center"><gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch()"/></td>
						
                        <td colspan="5" style="border:0;" align="right"><gw:label id="lblRecord"  text="0 rec(s)" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" />
                        </td>
                        
                        
                    </tr>
                    
                  
                    <tr style="border:1;width:100%;height:80%" valign="top">
                        <td colspan=50 style="width:100%;height:100%;"> 
                            <table width="100%" id="tblMaster" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                                <tr style="border:1;width:100%;height:100%" valign="top">
                                    <td>
                                     <gw:grid   
                                        id="Grid1"  
                                        header="Book-ID|Tên khách|Ngày|Phòng|Tình trạng|SDT|Giá phòng|Đặt cọc|Phí dịch vụ|Ghi chú"   
                                        format="0|0|4|0|0|0|-0|-0|-0|0"  
                                        aligns="0|0|0|0|0|0|0|0|0|0"  
                                        defaults="||||||||||"  
                                        editcol="0|0|0|0|0|0|0|0|0|0"  
                                        widths="2000|1500|1400|1500|1500|1500|1500|1500|1500|1500"  
                                        styles="width:100%; height:100%" 
								        acceptNullDate="T"
                                        sorting="T" 
                                        /> 
                                     </td>
                                 </tr>
                             </table>
                              
                        </td>
                    </tr>
                    
                
            </td>
        </tr>
    </table>
	<gw:textbox id="txtLocation" styles="display:none"/>
</body>
 
</html>

