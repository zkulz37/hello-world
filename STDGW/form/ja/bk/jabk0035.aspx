<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Booking Sheet</title>
    <%  ESysLib.SetUser("crm")%>
</head>
<script>
function BodyInit(){InitData(); OnSearch();}
function InitData(){
    var data = "";
    data = "<%=ESysLib.SetListDataSQL(" SELECT  pk, COURSE_ID || ' - ' || COURSE_NAME from crm.tgm_golf_course where del_if = 0 and ACTIVE_YN='Y' order by COURSE_ID ")%>"+"||";
    lstCourse.SetDataText(data); 
    lstCourse.value = '<%=Request.QueryString("golf_type")%>';
    lstCourse.SetEnable(false);
    dtDate.value = '<%=Request.QueryString("day")%>';
    dtDate.SetEnable(false);
}
function OnSearch(){
	dso_jabk0035.Call("SELECT");
}

function OnDataReceive(obj){
	if(obj.id=='dso_jabk0035'){
		txtCount.text = grdData.rows - 1 + " record(s)";
	}	
	HighLightColor();
    		
}
function HighLightColor(){
	for(var i=1;i<grdData.rows;i++){
		if(grdData.GetGridData(i, 0) == "Y"){
			grdData.SetCellBgColor(i, 0, i, grdData.cols-1,0XEE82EE);
		}
	}
}
function OnSelect(){
    if(event.col == 1){
	    if(grdData.GetGridData(event.row,0) == 'Y') 
		{
		   if(!confirm('This teetime has blocked by tournament. Do you want to book again ???')){
				return;
		   }
		   
		}
        if(grdData.GetGridData(event.row,2) == ''){
            var code_data=new Array() ;
            code_data[0] = grdData.GetGridData(event.row , 1);
            code_data[1] = dtDate.value;
	        window.returnValue = code_data; 
	        this.close(); 
        }
        else alert("Already have book at " + grdData.GetGridData(event.row,1) + " !");
    }
}
</script>  
<body>
	<gw:data id="dso_jabk0035" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="crm.sp_sel_jabk0035"> 
                <input bind="grdData" > 
                     <input bind="dtDate" /> 
                     <input bind="txtAMPM" />
                     <input bind="lstCourse" /> 
                </input> 
                <output bind="grdData" />  
            </dso> 
        </xml> 
    </gw:data>
    <table style="width: 100%; height: 100%">  
		<tr style="height: 100%" valign="top">
            <td>
                <table style="width: 100%; height: 100%" border="0">
					<tr style=" height: 2%">
						<td style="width: 5%;" align="center">Date</td>
						<td width="7%" align="left"><gw:datebox id="dtDate" type="date" lang="1" onchange="OnSearch()" /></td>
						<td style="width: 5%;" align="center">Course</td>
						<td style="width: 30%;" align="center"><gw:list id="lstCourse" styles="width:100%" onchange="OnSearch()" /></td>
						<td style="width: 7%;" align="center">Total : </td>
						<td style="width: 13%;" align="center"><gw:label id="txtCount" /></td>
						<td style="width: 3%;"><gw:imgBtn id="ibtnSearch" img="search"    alt="Search"    onclick="OnSearch()" /></td>
					<td style="width: 20%;"></td>
					</tr>
                    <tr style="height: 98%">
                        <td colspan="8">
                            <gw:grid id="grdData" 
                                header  ="_Block|T.O.Time|Player A|_Member No|_CD#|Player B|_Member No|_CD#|Player C|_Member No|_CD#|Player D|_Member No|_CD#" 
                                format  ="0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                aligns  ="1|1|0|1|1|0|1|1|0|1|1|0|1|1" 
                                defaults="|||||||||||||" 
                                editcol ="0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                widths  ="700|850|2000|1100|700|2000|1100|700|2000|1100|700|2000|1100|700" 
                                sorting ='T'
                                styles  ="width:100%; height:100%" 
                               oncelldblclick ="OnSelect()"
                                />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txtAMPM" style="display:none" />
</body>
</html>
