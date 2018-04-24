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

function BodyInit()
{          
    if (v_language!="ENG")
        System.Translate(document);	
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";    
    if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
              datUser_info.Call(); /**/
		
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
			idGridAtt.SetGridText(irow,1,workSheet.Cells(j,2).value);	 //name	
			for(var t=0;t<123;t++)
				idGridAtt.SetGridText(irow,t+2,workSheet.Cells(j,t+3).value);    //WT 1      
			idGridAtt.SetGridText(irow,126,idMon.value);	
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
            <dso  type="grid" parameter="0,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,2425,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,	59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,	111,112,113,114,115,116,117,118,119,120,121,122,123,124,125" function="hr.sp_sel_imp_att_mon" procedure="hr.sp_pro_imp_att_mon">
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
						<gw:datebox id="idMon" type="month" lang="<%=Session("Lang")%>" />
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
				        id="idGridAtt"   header="EmpID|FullName|WT_1|OT_1|NT_1|HT_1|WT_2|OT_2|NT_2|HT_2|WT_3|OT_3|NT_3|HT_3|WT_4|OT_4|NT_4|HT_4|WT_5|OT_5|NT_5|HT_5|WT_6|OT_6|NT_6|HT_6|WT_7|OT_7|NT_7|HT_7|WT_8|OT_8|NT_8
|HT_8|WT_9|OT_9|NT_9|HT_9|WT_10|OT_10|NT_10|HT_10|WT_11|OT_11|NT_11|HT_11|WT_12|OT_12|NT_12|HT_12|WT_13|OT_13|NT_13|HT_13|WT_14|OT_14|NT_14|HT_14|WT_15|OT_15|NT_15|HT_15|WT_16
|OT_16|NT_16|HT_16|WT_17|OT_17|NT_17|HT_17|WT_18|OT_18|NT_18|HT_18|WT_19|OT_19|NT_19|HT_19|WT_20|OT_20|NT_20|HT_20|WT_21|OT_21|NT_21|HT_21|WT_22|OT_22|NT_22|HT_22|WT_23|OT_23|NT_23
|HT_23|WT_24|OT_24|NT_24|HT_24|WT_25|OT_25|NT_25|HT_25|WT_26|OT_26|NT_26|HT_26|WT_27|OT_27|NT_27|HT_27|WT_28|OT_28|NT_28|HT_28|WT_29|OT_29|NT_29|HT_29|WT_30|OT_30|NT_30|HT_30
|WT_31|OT_31|NT_31|HT_31|WORK_MON"   
				format="0|0|0|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0	|0|0"
				aligns="1|0|1|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1|1"
				defaults="||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
				editcol="0|0|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1	|1|1"
				widths="1000|2500|700|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700	|700|0" 
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
