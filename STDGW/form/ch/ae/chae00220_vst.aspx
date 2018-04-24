<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser("hr")%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Import General Information Data</title>
</head>

<script>
var dept,grp,flag=0;
var v_language = "<%=Session("SESSION_LANG")%>";
var _days=0;

function BodyInit()
{          
    if (v_language!="ENG")
        System.Translate(document);	
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";    
    if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
              datUser_info.Call(); /**/
	_days=daysInMonth(idMon.value.substring(5,6),idMon.value.substring(0,4));	
    OnLoad();	
}

function OnDataReceive(obj)
{
	if (obj.id=="datDeptData")
	{
		if(txtHr_level.text=="6")
			txtDeptData.text=txtDeptData.text+"|ALL|Select All";
		lstOrg.SetDataText(txtDeptData.text)    ;		
		obj=lstOrg.GetControl();
		if (obj.options.length ==2)
			obj.options.selectedIndex=0;
		else
			obj.options.selectedIndex=0;            
	}  /**/ 
	if(obj.id=="datImpAnnualMon")
	{
		alert("xong roi");
	}
}      

function OnLoad()
{
	
	tblMaternity.style.height="82%";
	OnChangeMon();
}	

function OnPopup()
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:25;dialogHeight:30;dialogLeft:10;dialogTop:240;edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {
        lstOrg.value=obj;
        txtUpperDept.text=obj;
        datDeptData.Call();
    }   
}

function OnReport()
{   
	
}

function OnSearch()
{
	if(	frmimport.option_P[0].checked)
	{
		datImportAttendance.Call("SELECT");
	}
	
	
}

function OnClick(num)
{
	
}

function OnShowPopup(code)
{
	
	
}

function CheckValidFile(vfile)
{
    var sext;
    sext=vfile.substring(vfile.length-4,vfile.length);
    if (sext!=".xls")
        return false;
    return true;
}

function OnLoadExcel()
{	
	var vfilename = document.all["inputfile"].value;    
	if (!CheckValidFile(vfilename) || vfilename =="")
	{
		alert("Please select excel file");
		return;
	}	
	ImportAttendance();
}

function ImportAttendance()
{
	idGridAtt.ClearData();	
	try
	{
		var vfilename = document.all["inputfile"].value;    
		var myApp = new ActiveXObject("Excel.Application");     
		myApp.Workbooks.Open(vfilename); 
		var workSheet = myApp.ActiveSheet; 
		var maxRow =workSheet.UsedRange.Rows.Count; 		  
		for (var j =2;j <= maxRow; j++) 
		{ 
			idGridAtt.AddRow();
			var irow=idGridAtt.rows-1;			
			idGridAtt.SetGridText(irow,0,workSheet.Cells(j,1).value);			
			for(var t=0;t<31;t++)
			{
				if(_days==28)
				{
					if(t==3 || t==4 || t==5)					
						idGridAtt.SetGridText(irow,t+1,"");
					else if (t>4) 
						idGridAtt.SetGridText(irow,t+1,workSheet.Cells(j,t+2 -3).value); 
					else 
						idGridAtt.SetGridText(irow,t+1,workSheet.Cells(j,t+2 ).value); 
				}
				else if(_days==29)
				{
					if( t==4 || t==5)
						idGridAtt.SetGridText(irow,t+1,"");
					else if (t>4) 
						idGridAtt.SetGridText(irow,t+1,workSheet.Cells(j,t+2 -2).value); 
					else 
						idGridAtt.SetGridText(irow,t+1,workSheet.Cells(j,t+2 ).value);
				}
				else if(_days==30)
				{
					if( t==5)
						idGridAtt.SetGridText(irow,t+1,"");
					else if (t>4) 
						idGridAtt.SetGridText(irow,t+1,workSheet.Cells(j,t+2 -1).value); 
					else 
						idGridAtt.SetGridText(irow,t+1,workSheet.Cells(j,t+2 ).value); 
				}
				else
					idGridAtt.SetGridText(irow,t+1,workSheet.Cells(j,t+2).value);    /**/   
			}
			idGridAtt.SetGridText(irow,32,idMon.value);	
			
		} 
		myApp.Quit();
	}
	catch(e)
	{
		alert("Could not read Excel File. (or) Excel was not installed in the machine you are using or it has incompatible version?"); 
	}
}


function OnSave()
{
	
    datImportAttendance.Call();
	
}

function OnChangeMon()
{
	_days=daysInMonth(idMon.value.substring(4,6),idMon.value.substring(0,4));	
	
	if(_days==28)
	{		
		idGridAtt.GetGridControl().ColHidden(4)=true;
		idGridAtt.GetGridControl().ColHidden(5)=true;
		idGridAtt.GetGridControl().ColHidden(6)=true;
	}
	if(_days==29)
	{	
		idGridAtt.GetGridControl().ColHidden(4)=false;
		idGridAtt.GetGridControl().ColHidden(5)=true;
		idGridAtt.GetGridControl().ColHidden(6)=true;
	}
	if(_days==30)
	{
		idGridAtt.GetGridControl().ColHidden(4)=false;
		idGridAtt.GetGridControl().ColHidden(5)=false;
		idGridAtt.GetGridControl().ColHidden(6)=true;
	}
	if(_days==31)
	{
		idGridAtt.GetGridControl().ColHidden(4)=false;
		idGridAtt.GetGridControl().ColHidden(5)=false;
		idGridAtt.GetGridControl().ColHidden(6)=false;
	}/**/
}

function daysInMonth(month, year) {
    return new Date(year, month, 0).getDate();
}

</script>

<body>
<!------------main control---------------------->
<gw:data id="datDeptData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="comm.sp_pro_dept_data_all" > 
                <input>
                    <input bind="txtUpperDept" /> 
                </input> 
                <output>
                    <output bind="txtDeptData" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr.sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="lstOrg" />
                </output>
            </dso> 
        </xml> 
</gw:data>



<gw:data id="datImportAttendance" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" parameter="0,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33" function="hr.sp_sel_imp_att_mon" procedure="hr.sp_pro_imp_att_mon">
                <input bind="idGridAtt" >
					<input bind="lstOrg" />
					<input bind="lstWG" />
					<input bind="lstStatus" />
					<input bind="lstTemp" />
					<input bind="txtTemp" />
					<input bind="idMon" />
                </input>                 
                <output bind="idGridAtt" />                
            </dso> 
        </xml> 
</gw:data>
<!--------------------main table--------------------------------->

<form name="frmimport" id="form2"  > 
<table style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
	<tr>
	    <td>
	        <table style="width:100%;height:18%" cellpadding="0" cellspacing="0" valign="top" border="0" >	
				<tr style="height:6%;border:0">	
					<td align=center colspan=2 style="width:4%" >
						<a title="Click here to show Organization" onclick="OnPopup()" href="#tips" >Oganization</a>
					</td>
		            <td align=left colspan=11 style="width:22%" >
						<gw:list  id="lstOrg" value='ALL' maxlen = "100" styles='width:100%'onchange="OnChangeOrg()" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,a.org_nm from comm.tco_org a where a.del_if=0 order by a.seq")%>|ALL|Select All
                            </data>
                        </gw:list></td>					            	
					<td align=center colspan=3 style="width:6%" >W-Group</td>
		            <td align=left colspan=10 style="width:20%" >
						<gw:list  id="lstWG" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("select a.PK,a.WORKGROUP_NM from thr_work_group a where a.del_if=0 order by a.WORKGROUP_NM")%>|ALL|Select All</data>
						</gw:list>
					</td>					
			
					<td align=right colspan=4 style="width:8%" >Status</td>
		            <td align=left colspan=6 style="width:12%" >
						<gw:list  id="lstStatus" value='ALL' maxlen = "100" styles='width:100%'>
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0022' order by code_nm")%>|ALL|Select All
                            </data>
                        </gw:list>
					</td>
			
					<td align=right colspan=3 style="width:6%" >Search by</td>
		            <td align=center colspan=5 style="width:10%" >
						<gw:list  id="lstTemp" value="2" styles='width:100%' onchange=""> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Personal ID|5|Old Code</data> 
						</gw:list>
					</td>
					<td align=left colspan=5 style="width:10%" >
						<gw:textbox id="txtTemp" onenterkey   ="OnSearch()" styles="width:95%"/>
					</td>
					<td align=center colspan=1 style="width:2%" ></td>
		            								
				</tr>

				<tr style="height:6%;border:0">
					<td align=center colspan=2 style="width:4%" >
											</td>
		            <td align=left colspan=11 style="width:22%" >
						</td>					            	
					<td align=center colspan=3 style="width:6%" >Work Month</td>
		            <td align=left colspan=8 style="width:20%" >
						<gw:datebox id="idMon" type="month" lang="<%=Session("Lang")%>" onchange="OnChangeMon()" />
					</td>															          
					<td align=right colspan=6 style="width:12%" >Excell file</td>									
					<td align=left colspan=20 style="width:40%" ><input id="inputfile" type="file" name="pic" size="60"  accept="text/csv,text/xls"></td>
					<td align=left colspan=1 style="width:2%" ><gw:imgBtn img="process" id="ibtnProcess"   alt="Insert from Excell to Grid"  onclick="OnLoadExcel()"/></td>
					<td align=left colspan=1 style="width:2%" ><gw:imgBtn id="ibtnUpdate" alt="Save" img="save" text="Save" onclick="OnSave()" /></td>
		          <!-- -->
					
				</tr>
				                                
	        </table>
			
	        <table id="tblMaternity" style="width:100%;height:88%" border=1 cellpadding="0" cellspacing="0">
	            <tr style="width:100%;height:100%">
	                <td id="tdMaster" style="width:100%">
	                    <gw:grid   
				        id="idGridAtt"   header="EmpID|26|27|28|29|30|31|01|02|03|04|05|06|07|08|09|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|WORK_MON"   
				format="0|0|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0|0|0	"
				aligns="1|1|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1|1|1	"
				defaults="||||||||||||||||||||||||||||||||"
			   editcol="0|1|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	"
				widths="1000|700|700|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|1200	" 
				        styles="width:100%; height:100% "   
				        sorting="T"   
				        acceptNullDate
				        oncelldblclick=""
				        oncellclick = ""/>
	                </td>
	            </tr>
	        </table>  
		<gw:textbox id="iduser_pk" styles="display:none"/>
		<gw:textbox id="txtHr_level" styles="display:none"/>
		<gw:textbox id="txtDeptData" styles="display:none"/>
		<gw:textbox id="txtUpperDept" styles="display:none"/>
		<gw:textbox id="txtGroupData" styles="display:none"/>
		<gw:textbox id="txtMonth" styles="display:none"/>
		<gw:textbox id="txtAleDays" styles="display:none"/>
		<gw:textbox id="txtEmpID" styles="display:none"/>
		<gw:textbox id="txtResult" styles="display:none"/>
		</td>	
		</tr>
</table>
	
</form>
   
</body>
</html>
