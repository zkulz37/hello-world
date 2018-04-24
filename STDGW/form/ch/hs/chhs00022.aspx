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
	Grid1.GetGridControl().FrozenCols =5;
}
 
//---------------------------------------------------------
function OnDataReceive(obj)
{
    if (obj.id=="dsohr_chhs00022_s_01")
    {
        var fg=Grid1.GetGridControl(); 	  
            fg.MergeCells =3	;
            fg.MergeCol(0) =true	;
			fg.MergeCol(1) =true	;
            fg.MergeCol(2) =true	;
			fg.MergeCol(3) =true	;
			fg.MergeCol(4) =true	;
            
    
    
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
	dsohr_chhs00022_s_01.Call("SELECT");
}
</script>
<body>
<!------------main control---------------------->
 
<gw:data id="dsohr_chhs00022_s_01" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid"  function="hr_chhs00022_s_01" > 
                <input bind="Grid1">
                    <input bind="lstRoom" /> 
					<input bind="lstLocation" />
					<input bind="dtFrom" />
					<input bind="dtTo" />
					<input bind="chkALL" />
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
						
						<td  colspan="2" style="border:0;" align="center"><gw:checkbox id="chkALL" onclick="OnSearch()" /></td>
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
                                        header="Mã Phòng|Tên Phòng|Ngày|Mã đặt chổ|Tên Khách|SDT|Từ ngày|Đến ngày|Checkin YN|Checkout YN|Ghi chú|Giá phòng|Đặt cọc|Dịch vụ thêm|Còn lại|thr_hs_book_m_pk"   
                                        format="0|0|4|0|0|0|4|4|0|0|0|-0|-0|-0|-0|0"  
                                        aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
                                        defaults="||||||||||||||||"  
                                        editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
                                        widths="1500|1500|1200|1500|2000|1200|1200|1200|1200|1200|2500|1500|1500|1500|1500|1500"  
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

