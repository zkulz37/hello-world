<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Import General Information Data</title>
</head>

<script language="JavaScript" src="../../../system/lib/md5.js"></script>

<script>
    var dept, grp, flag = 0;
    var v_language = "<%=Session("SESSION_LANG")%>";
var _days = 0;
var tmp1, tmp2, imp_seq;
var tes_client_id = "";
function BodyInit() {

    var t1 = tmp = "#Y;Active|#N;In-Active";
    idGridUser.SetComboFormat(5, t1);
    tes_client_id = "<%=Session("APP_DBUSER")%>";
    //alert(tes_client_id);
}

function OnDataReceive(obj) {
    
    if (obj.id == "datUserEntry") 
    {
        idRecord.text = idGridUser.rows - 1 + " record(s)";
    }

}


function OnSearch() {
    datUserEntry.Call("SELECT");
}


function CheckValidFile(vfile) {
    var sext;
    sext = vfile.substring(vfile.length - 4, vfile.length);
    if (sext != ".xls")
        return false;
    return true;
}

function OnReadData() {

    var vfilename = document.all["inputfile"].value;
    
    if (!CheckValidFile(vfilename) || vfilename == "") 
    {
        alert("Please select excel file");
        return;
    }
    if (confirm("Read data from excel file will begin, please wait for a moment, are you sure?")) 
    {
        OnReadData2();        
    }
}

function OnReadData2() {
    idGridUser.ClearData();
    //imp_seq = new Date().getTime();
    //idImp_seq.text = imp_seq;

    try 
    {
        var vfilename = document.all["inputfile"].value;
        var myApp = new ActiveXObject("Excel.Application");
        myApp.Workbooks.Open(vfilename);
        var workSheet = myApp.ActiveSheet;
        var maxRow = workSheet.UsedRange.Rows.Count;
        var j = 3;
        //alert(maxRow)
        while (j <= maxRow) 
        {
            idGridUser.AddRow();
            var irow = idGridUser.rows - 1;            		
            idGridUser.SetGridText(irow, 1, workSheet.Cells(j, 2).value);           
            idGridUser.SetGridText(irow, 2, workSheet.Cells(j, 3).value);
            idGridUser.SetGridText(irow, 3, workSheet.Cells(j, 4).value);
            idGridUser.SetGridText(irow, 4, workSheet.Cells(j, 5).value);
            idGridUser.SetGridText(irow, 5, "Y");              
            idGridUser.SetGridText(irow, 7, b64_md5(workSheet.Cells(j, 5).value));
            idGridUser.SetGridText(irow, 9, tes_client_id);       //company name (database name)
            j += 1;
        }
        myApp.Quit();
        myApp = null;    
        idRecord.text = idGridUser.rows - 1 + " record(s)";
    }
    catch (e) 
    {
        alert("Could not read Excel File. (or) Excel was not installed in the machine you are using or it has incompatible version?");
    }
}


function OnImportData() 
{
    
        if (confirm("Do you want to import?\nBạn đã chắc chắn import?"))
            datImportDuty.Call();
    
}


function OnReport() {
    //string p_dept, p_group, p_from, p_to, p_txtID, p_txtOpt;
    var url = System.RootURL + '/reports/ag/bh/rpt_schedule_duty_sample.aspx';
    window.open(url);
}

function OnAdd()
{
    var fpath = System.RootURL + "/form/ch/ae/chae00010_search_emp2.aspx";
    var obj = System.OpenModal(fpath, 900, 600, 'resizable:yes;status:yes;');
    if (obj != null) 
    {
        txt_emp_pk.text = obj[0];
        idEmp_id.text = obj[1];
        txtFullName.text = obj[2];

        //alert(txtFullName.text);

        idGridUser.AddRow();
		var irow=idGridUser.rows-1;
        //alert(irow);
		idGridUser.SetGridText(irow,1,obj[1]);		//emp id
		idGridUser.SetGridText(irow,2,obj[2]);		//full name
        idGridUser.SetGridText(irow,3,obj[1]);       //user id
        idGridUser.SetGridText(irow,5,"Y");       //user status
        idGridUser.SetGridText(irow, 8, obj[0]);       //emp pk
        idGridUser.SetGridText(irow, 9, tes_client_id);       //company name (database name)
        
    }
    else 
    {
        idEmp_id.text = "";
        txt_emp_pk.text = "";
    }    
}
function OnUpdate()
{  
    var _ok=true ;
    for(var i=1;i<=idGridUser.rows-1;i++)
    {        
        if(idGridUser.GetGridData(i,1)=="")
        {
            alert("EmpID cannot be null at row: " + i );
            idGridUser.SetCellBgColor(i, 0 ,i, 11, 0x3366FF );
            idGridUser.SetCellBold(i,0,i,11,true);
            _ok = false;
            return;
        }
        else
            idGridUser.SetCellBgColor(i, 0 ,i, 11, 0xFFFFFF );
        
        if(idGridUser.GetGridData(i,3)=="")
        {
            alert("UserID cannot be null at row: " + i );
            idGridUser.SetCellBgColor(i, 0 ,i, 11, 0x3366FF );
            idGridUser.SetCellBold(i,0,i,11,true);
            _ok = false;
            return;
        }
        else
            idGridUser.SetCellBgColor(i, 0 ,i, 11, 0xFFFFFF );
        
        if(idGridUser.GetGridData(i,4)=="")
        {
            alert("Password cannot be null at row: " + i );
            idGridUser.SetCellBgColor(i, 0 ,i, 11, 0x3366FF );
            idGridUser.SetCellBold(i,0,i,11,true);
            _ok = false;
            return;
        }
        else
            idGridUser.SetCellBgColor(i, 0 ,i, 11, 0xFFFFFF );
        
        if(idGridUser.GetGridData(i,5)=="")
        {
            alert("Status cannot be null at row: " + i );
            idGridUser.SetCellBgColor(i, 0 ,i, 11, 0x3366FF );
            idGridUser.SetCellBold(i,0,i,11,true);
            _ok = false;
            return;
        }
        else
		{
            idGridUser.SetCellBgColor(i, 0 ,i, 8, 0xFFFFFF );
			idGridUser.SetCellBold(i,0,i,11,false);
		}
    }

    if(_ok==true) 
        datUserEntry.Call();
}
   
function OnAfterEditCell()
{
    idGridUser.SetGridText(idGridUser.row,7,b64_md5(idGridUser.GetGridData(idGridUser.row,4))) ;  
}

function OnDelete()
{
    if(confirm("Are you sure to delete?"))
        idGridUser.DeleteRow();
}

function OnSampleReport()
{
    url =System.RootURL + '/reports/ag/bh/rpt_sample_import_user.aspx';
    window.open(url);
}

function OnSetUserStatus()
{
    var ctrl = idGridUser.GetGridControl();
    
    if (ctrl.SelectedRows>0)
    {
	    for ( var i =  0 ; i < ctrl.SelectedRows ; i++ )
		{
			var row = ctrl.SelectedRow(i);
			if ( row > 0 )
			{		
				idGridUser.SetGridText(row,5,lstStatus2.value);
			}
		}
	}
	/*else
	{
	    for ( var i =  1 ; i < ctrl.rows ; i++ )
				    obj_grd.SetGridText(i,obj_col,tmp);
	}/**/
}

</script>

<body>
<!------------main control---------------------->

    <!--
<gw:data id="datGet_Period" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sp_pro_get_sal_period" > 
                <input >
                    <input bind="idMon" /> 
                    <input bind="idLst_period" />
                </input>
                <output >
                    <output bind="idMon_fr" /> 
                    <output bind="idMon_to" /> 
                    <output bind="idnum_day" />
                    <output bind="idClose_flag" />  
                </output>
            </dso> 
        </xml> 
</gw:data>
-->

<gw:data id="datUserEntry" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" parameter="0,1,2,3,4,5,6,7,8,9" function="SP_SEL_80020240_USER_MANAGE" procedure="SP_UPD_80020240_USER_MANAGE">
                <input bind="idGridUser" >
					<input bind="lstLocation" />
					<input bind="lstSelectUser" />
					<input bind="txtText" />
					<input bind="lstStatus" />                                       
                </input>                 
                <output bind="idGridUser" />                
            </dso> 
        </xml> 
</gw:data> 
<!--------------------main table--------------------------------->

<form name="frmimport" id="form2"  > 
<table style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
	<tr>
	    <td>
	        <table style="width:100%;height:12%" cellpadding="0" cellspacing="0" valign="top" border="0" >	

				<tr style="height:2%">
                <td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td>
                <td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td>
                <td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td>
                <td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td>
                <td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td>
                <td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td>
                <td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td>
                <td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td>
                <td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td>
                <td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td><td width=1%></td>
                </tr>

                <tr>
                    <td colspan="50" align="right"><FONT SIZE="4">Company</FONT></td>
                    <td colspan="50" align="left">
                        <gw:list  id="lstLocation"  maxlen = "100" styles='width:30%' onchange="" >
                            <data>
                                <%= ESysLib.SetListDataSQL("select a.pk,a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') and nvl(a.p_pk,0)=0 order by a.pk ")%>
                            </data>
                        </gw:list> 
                    </td>                    
                    
				</tr>


				<tr>
                    <td colspan="10" align="right">Select</td>
                    <td colspan="10" align="left">
                            <gw:list id="lstSelectUser" styles="width:100%;">
                                <data>|01|User ID</data>                    
                            </gw:list>
                    </td>
                    <td colspan="20" align="right">
                        <gw:textbox id="txtText" align="left" styles="width:100%" onenterkey="OnSearch()" />
                    </td>
                    <td colspan="10" align="right">Status</td>
                    <td colspan="30" align="left" styles="width:100%" >
                            <gw:list id="lstStatus" styles="width:50%;" value="Y">
                                <data>|Y|Active|N|In-Active|ALL|Select All</data>                    
                            </gw:list>
                    </td>
                    <td colspan="2">&nbsp;</td>
                    <td colspan="2">&nbsp;</td>
                    <td colspan="2"><gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch()"/></td>
                    <td colspan="2">&nbsp;</td>
                    <td colspan="2"><gw:imgBtn img="new" alt="Add" id="btnAdd" onclick="OnAdd()" /></td>                    
                    <td colspan="2">&nbsp;</td>
                    <td colspan="2"><gw:imgBtn img="delete" alt="Delete"  id="btnDelete" onclick="OnDelete()" /></td>
                    <td colspan="2">&nbsp;</td>
                    <td colspan="2"><gw:imgBtn img="save" alt="Save" id="btnUpdate" onclick="OnUpdate()" /></td>
                    <td colspan="2">&nbsp;</td>
                    
				</tr>

                <tr>
                    <td colspan="10" align="right">Excell file</td>
                    <td colspan="30" align="left">
                        <input id="inputfile" type="file" name="pic" size="60"  style='width:100%' accept="text/csv,text/xls">
                    </td>
                    <td colspan="2"><gw:imgBtn id="ibtnRptSample" alt="Sample Report" img="excel" text="Sample Report" onclick="OnSampleReport()" /></td>
                    <td colspan="8"> </td>
                    <td colspan="10" align="left">
                        <gw:icon id="idBtnProcess" img="in" text="Read Data" alt="Read Excel File" onclick="OnReadData()" />

                    </td>
                    <td colspan="5" align="left" styles="width:100%" >
                        <gw:icon id="ibtnUpdate" img="in" styles="display:none" text="Import Data" alt="Import from excel" onclick="OnImportData()" />    
                    </td>
                    <td colspan="7" align="right" styles="width:100%" >
                        Set User Status   
                    </td>
                    <td colspan="13" align="right" styles="width:100%" >
                        <gw:list id="lstStatus2" styles="width:100%;" value="Y">
                                <data>|Y|Active|N|In-Active</data>                    
                        </gw:list>
                    </td>
                    <td colspan="5" align="left" styles="width:100%" >
                        <gw:icon id="ibtnSetStatus" img="in" styles="" text="Set" alt="Set" onclick="OnSetUserStatus()" />    
                    </td>
                    <td colspan="10"><b><gw:label id="idRecord" styles="color:blue"></gw:label></b></td>
                    
                    
				</tr>
                <tr style="height:6%;border:1">
				    
					<td align=right ></td>									
					<td align=left colspan=4></td>
					<td align=center colspan=2 ></td>
					<td align=center >
					<td align=center colspan=3></td>
				</tr>                                
	        </table>
	        <table id="tbl" style="width:100%;height:88%" border=1 cellpadding="0" cellspacing="0">
	            <tr style="width:100%;height:100%">
	                <td id="tdMaster" style="width:100%">
	                    <gw:grid   
				        id="idGridUser" header="_PK|Emp ID|Full Name|User ID|Reset Password|Status|Register Date|_MD5_Password|_thr_emp_pk|_COMPANY_ID/TES_CLIENT|Join date|Left date"   
				        format="0|0|0|0|0|0|0|0|0|0|4|4"
				        aligns="1|1|0|1|1|1|1|1|0|0|1|1"
				        defaults="||||||||||||"
			            editcol="0|0|0|1|1|1|1|1|0|0|0|0"
				        widths="0|2000|3500|2000|2000|2000|3000|2000|0|0|1200|1200" 
				        styles="width:100%; height:100% "   
				        sorting="T"   
				        acceptNullDate
				        oncelldblclick=""
                        onafteredit="OnAfterEditCell()"
				        oncellclick = ""/>
	                </td>
	            </tr>
	        </table>  
		<gw:textbox id="idnum_day" styles="display:none"/>
		<gw:textbox id="idClose_flag" styles="display:none"/>
		<gw:textbox id="idResult" styles="display:none"/>
		<gw:textbox id="idImp_seq" styles="display:none"/>
		
        <gw:textbox id="txt_emp_pk" styles="display:none"/>
		<gw:textbox id="idEmp_id" styles="display:none"/>
        <gw:textbox id="txtFullName" styles="display:none"/>
		
		</td>	
		</tr>
</table>
	
</form>
   
</body>
</html>
