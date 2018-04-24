<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Housekeeping Assignment</title>
</head>
<%  ESysLib.SetUser("CRM")%>

<script>
var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
var  user_name  = "<%=Session("USER_NAME")%>" ;

function BodyInit()
{
	BindingDataList();
	dsoTaskPlan.Call("SELECT");
}
function BindingDataList()
{ 
       var data ="#OC;OC|#OD;OD|#VC;VC|#VD;VD|#OOO;OOO"; // status
        grdHkpAssignment.SetComboFormat(2,data);//
		data ="#VIP1;VIP1|#VIP2;VIP2|#VIP3;VIP3|#;"; // VIP
		grdHkpAssignment.SetComboFormat(9,data);//VIP
}
function OnSearch()
{
	dsoTaskPlan.Call("SELECT");
}
function OnNew()
{
	grdHkpAssignment.AddRow();
	grdHkpAssignment.SetGridText(grdHkpAssignment.rows-1, 7, user_pk);//pk
	grdHkpAssignment.SetGridText(grdHkpAssignment.rows-1,8, user_name);//full name
}
function CheckValidate()
{
    for(var i=1;i<grdHkpAssignment.rows;i++)
          {
            if(grdHkpAssignment.GetGridData(i,1) == "")
             {
                alert("Please input date at row "+ i);       
                return false;
             }
             if(grdHkpAssignment.GetGridData(i,3) == "")
             {
                alert("Please input description at row "+ i);       
                return false;
             }
             if(grdHkpAssignment.GetGridData(i,4) == "")
             {
                alert("Please input room no at row "+ i);       
                return false;
             }
          }
          return true;
}
function OnSave()
{
    dsoTaskPlan.Call();
}
function OnDelete()
{
    if(grdHkpAssignment.GetGridData(grdHkpAssignment.row,0) == "")
    {
        grdHkpAssignment.RemoveRowAt(grdHkpAssignment.row);
    }
    else
    {
        if (confirm('Are you sure delete data ?'))
        {
	        grdHkpAssignment.DeleteRow();
	        dsoTaskPlan.Call();
	    }
    }
}
function OnDataReceive(obj)
{
	if(obj.id=='dsoTaskPlan')
	{
		txtCount.text=grdHkpAssignment.rows-1 + " item(s).";
	}
		
}
function PopupRoomNumber(obj)
{
    if(obj.col==3 || obj.col==4)
    {
       var path = System.RootURL + "/form/ht/fo/htfo00300_room_popup.aspx?";
        var object = System.OpenModal( path ,500 , 300 ,  'resizable:yes;status:yes');
        if ( object != null )
        {
            grdHkpAssignment.SetGridText(grdHkpAssignment.row, 4, object[0]);//room no
			grdHkpAssignment.SetGridText(grdHkpAssignment.row,2, object[2]);//room status
			grdHkpAssignment.SetGridText(grdHkpAssignment.row,3, object[1]);//room type
			
        }  
    }
	else if(obj.col==6)
    {
		var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
            var obj_emp = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

            if ( obj_emp != null )
            {
                grdHkpAssignment.SetGridText(grdHkpAssignment.row, 5, obj_emp[0]);//pk
			    grdHkpAssignment.SetGridText(grdHkpAssignment.row,6, obj_emp[2]);//full name
				
            }
	}
	else if(obj.col == 8)
    {
		var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
            var obj_emp = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

            if ( obj_emp != null )
            {
                grdHkpAssignment.SetGridText(grdHkpAssignment.row, 7, obj_emp[0]);//pk
			    grdHkpAssignment.SetGridText(grdHkpAssignment.row,8, obj_emp[2]);//full name
				
            }
	}
}
function OnNotEdit()
{
	if(grdHkpAssignment.col=='2')
	{
		grdHkpAssignment.rows=-1;
	}
} 
function Onprint()
{
	if(grdHkpAssignment.rows >1)
	{
		var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ht/fo/rpt_htfo00300.rpt&procedure=crm.sp_sel_htfo00300&parameter="+dtFrom.value+","+dtTo.value+","+txtStaff.text;   
		  System.OpenTargetPage(url); 
	}
}
</script>
<body>
<gw:data id="dsoTaskPlan" onreceive="OnDataReceive(this)">
	<xml> 
		<dso type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10" function="CRM.sp_sel_htfo00300" procedure="CRM.sp_upd_htfo00300">
			<input bind="grdHkpAssignment">
				<input bind="dtFrom" />
				<input bind="dtTo" />
				<input bind="txtStaff" />
			</input> 
			<output bind="grdHkpAssignment" /> 
		</dso> 
	</xml> 
</gw:data>
<table style="height: 100%; width: 100%; background: #BDE9FF" border="0">
	<tr style="width: 100%; height: 1%">
		<td style="width: 100%; background: white" valign="top" >			
			<table style="width: 100%" border="0">
				<tr >
					<td style="width: 5%" align="right" >Date</td>
					<td style="width: 30%" >
						<gw:datebox id="dtFrom" lang="1" styles="width:51%" onchange="OnSearch()" />
						~
						<gw:datebox id="dtTo" lang="1"  styles="width:49%" onchange="OnSearch()" />
					</td>
					<td style="width: 10%" align="right" >Staff</td>
					<td style="width: 15%" >
						<gw:textbox id="txtStaff" styles="width: 100%" onenterkey="OnSearch()" />
					</td>
					<td style="width: 6%" >Total:</td>
					<td style="width: 22%" ><gw:label id="txtCount" />
</td>
					<td style="width: 3%" >
						<gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
					</td>
					<td style="width: 3%" >
						<gw:imgbtn img="new" alt="New" id="btnAddNew" onclick="OnNew()" />   
					</td>
					<td style="width: 3%" >
						<gw:imgbtn img="delete" alt="Delete" id="btnDelete" onclick="OnDelete()" />
					</td>
					<td style="width: 3%" >
						<gw:imgbtn img="save" alt="Save" id="btnSave" onclick="OnSave()" />
					</td>
					<td style="width: 3%" >
						<gw:imgbtn img="printer" alt="print" id="btnSayhve" onclick="Onprint()" />
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr style="width: 100%; height: 30%; background: white">
		<td style="width: 100%">
			<gw:grid id="grdHkpAssignment" 
			header="_PK|Date|Status|Type|RM#|_employee_pk|Staff|_Inspector_pk|Inspector|VIP|Remark" 
			format="0|4|0|0|0|0|0|0|0|0|0" 
			aligns="0|0|0|0|0|0|0|0|0|0|0" 
			editcol="1|1|0|0|0|1|1|1|1|1|1" 
			defaults="||||||||||" 
			styles="width:100%;height:100%"
			autosize='T' debug='false'
			oncelldblclick="PopupRoomNumber(this)"  />
		</td>
	</tr>
</table>
</body>
<!--------------------------------------------------------------------------------------->
</html>
