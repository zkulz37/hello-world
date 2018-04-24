<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
</head>
<script>

var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
    grdEmployee.GetGridControl().ScrollTrack=true;
    if (v_language!="ENG")
        System.Translate(document);
	txtDept_PK.text="<%=request.QueryString("dept_pk")%>";
	txtGrp_PK.text="<%=request.QueryString("grp_pk")%>";
	txtDate.text="<%=request.QueryString("sdate")%>";
	txtUpperDept_PK.text="<%=request.QueryString("upper_dept_pk")%>";
	txtNation.text="<%=request.QueryString("nation")%>";
	datDailyNT.Call("SELECT");
}


//-------------------------------------------------
function OnDataReceive()
{
    lblRecord.text=grdEmployee.rows-1 + " record(s)";
    var fg=grdEmployee.GetGridControl(); 	  
    fg.MergeCells =3	;
    fg.MergeCol(0) =true	;
    fg.MergeCol(1) =true	;
}
//----------------------------
function onPrint(obj)
{
    obj.GetGridControl().PrintGrid("Employee List",true,1,0,360);//PrintGrid [ DocName As String ], [ hien thi dialog may in As Boolean ], [ kieu in dung hay ngang As Integer ], [ canh trai phai As Long ], [ canh tren duoi As Long ]
}
</script>
<body>
<gw:data id="datDailyNT" onreceive="OnDataReceive()" > 
        <xml> 
            <dso  type="grid"  function="HR_SEL_10010014_daily_nt"> 
                <input bind="grdEmployee" >
                    <input bind="txtUpperDept_PK" />
                    <input bind="txtDept_PK" />
                    <input bind="txtGrp_PK" />
                    <input bind="txtDate" />
                    <input bind="txtNation" />
                    
                </input>
                <output  bind="grdEmployee" />
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------------------------>
<table align = top style='margin-left:10px'  cellspacing=0 cellpadding=0 border=0 style="width:100%;height:100%;">
<tr>
	<td> 	
	    <table width="100%" height=7% cellspacing=0 cellpadding=0 >		
			<tr>
				<td colspan=2 align ="center" width=100%><b style="color:#FF0066; font-size:15"> THE LIST OF EMPLOYEES</b></td>
  			</tr>
  			<tr>
  			    <td  width="50%" align="right"><gw:imgBtn img="printer" id="ibtnPrint"   alt="Print"  onclick="onPrint(grdEmployee)"/></td>
				<td width="50%" align ="right" width=100%><b><gw:label id="lblRecord" text="" maxlen = "100" styles="color:#black;width:90%;font-weight: bold;font-size:12"></gw:label></b></td>
  			</tr>
		</table>
		<table width="100%" height=93% border=1 cellspacing=0 cellpadding=0 >		
			<tr>
				<td align = top height=100% >					
					<gw:grid   
                        id="grdEmployee"  
                        header="Department|Group|Emp Id|Full Name|Shift"
                        format="0|0|0|0|0"  
                        aligns="0|0|1|0|1"  
                        defaults="|||||"  
                        editcol="0|0|0|0|0"  
                        widths="1500|1500|1000|2400|2000"  
                        styles="width:100%; height:100%" 
                        sorting="T"  
                        /> 
  				</td>
  			</tr>
		</table>
	</td>		
</tr>	

</table>
<gw:textbox id="txtGrp_PK"  styles="display:none"/>
<gw:textbox id="txtDept_PK"  styles="display:none"/>
<gw:textbox id="txtUpperDept_PK"  styles="display:none"/>
<gw:textbox id="txtDate" styles="display:none"/>
<gw:textbox id="txtNation" styles="display:none"/>
</body>
</html>
