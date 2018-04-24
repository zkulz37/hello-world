<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("hr")%>
<head>
    <title>General Info - Employee</title>

    <script>
 //---------------------------------------------------------
var user;
var v_language = "<%=Session("SESSION_LANG")%>";
var flag=0;
var main_col=0;
var iccard_id=2;
var icname=3;
var ictype=4;
var icamount=5;
var icwork_mon=6;
function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);	
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    user= "<%=session("USER_ID")%>";   
    if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
        datUser_info.Call();     	    
    else
        lstDept_Code.value="ALL";
    grdEmp.GetGridControl().ColFormat(6) = "(#,###.##)";            
    <%=ESysLib.SetGridColumnComboFormatString2( "grdEmp" , 4 , "01|Sick|02|Maternity") %>;  
    <%=ESysLib.SetGridColumnComboFormatString2( "grdImport" , 4 , "01|Sick|02|Maternity") %>;  
 }
  
function OnDataReceive(obj)
{
   if (obj.id=="datDeptData")
   {      
        datGroupData.Call();
   }
   if (obj.id=="datGroupData")
   {
        
        if(tabMain.GetCurrentPageNo()==0)
        {
            lstGrp_Code.SetDataText(txtGroupData.text);
            var obj=lstGrp_Code.GetControl();
            if (obj.options.length ==2)
		        obj.options.selectedIndex=0;
	        else
		        obj.options.selectedIndex=obj.options.length-1;/**/
            
        }
        else
        {
            //alert(1);
            lstGrp_Code1.SetDataText(txtGroupData.text);
            var obj=lstGrp_Code1.GetControl();
            if (obj.options.length ==2)
		        obj.options.selectedIndex=0;
	        else
		        obj.options.selectedIndex=obj.options.length-1;/**/
        }
   }
   if (obj.id=="datImport")
        datEmp.Call("SELECT");
   if (obj.id=="datEmp")
   {
        idRecord.text= grdEmp.rows-1 + " record(s)";
        var ctrl=grdEmp.GetGridControl();
   }
   if (obj.id=="datCheckGroup")
   {
        if( txtCheckGroup.text!="1")
        {
            alert('This group is not in special rule');
            return
        }   
        else
            datEmp.Call("SELECT");
   }         
   
}
 //---------------------------------------------------------
function OnSearch()
{
    datEmp.Call("SELECT");        
}
 
function OnShowPopup()
{
    
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_dept.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:10;dialogTop:260;edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {
        lstDept_Code.value=obj;
        txtUpperDept.text=obj;
        OnChangeDept(lstDept_Code);
    } 
 
}

function OnChangeDept(depObj)
{
    txtDeptData.text=depObj.value;
    datGroupData.Call();
}

function OnChangeGroup(grp)
{
    datTaskData.Call();
}

function OnSave()
{
    if(confirm("Are you sure to save these change(s), Old these data of these Emp(s) will be deleted"))
    {
        datEmp.Call();
    }
}
function OnDelete()
{
    if(confirm("Are you sure to delete ?"))
    {
        grdEmp.DeleteRow();
        //datEmp.Call();
    }
}

function OnLoadExcel()
{
    if (lstType.value!="ALL")
    {
        grdImport.ClearData();
        var myApp = new ActiveXObject("Excel.Application");     
        var vfilename = document.all["inputfile"].value;    
        if (!CheckValidFile(vfilename) || vfilename =="")
        {
            alert("Please select excel file");
            return;
        }
        try
        {
            myApp.Workbooks.Open(vfilename); 
            var workSheet = myApp.ActiveSheet; 
            var vcard_id,vtotal, vemp_name;
            var maxRow =workSheet.UsedRange.Rows.Count;         
            for (var j =2;j <=maxRow; j++) 
            { 
                vcard_id=workSheet.Cells(j,1).value;                        
                vemp_name=workSheet.Cells(j,2).value;
                vtotal=workSheet.Cells(j,3).value;
                alert(vemp_name);
                if (vcard_id=="" )
                   alert("Please input card id at row " + j);
                else if (vtotal=="")
                    alert("Please input total at row " + j);
                else if (isNaN(vtotal))
                    alert("Please input total colunm by number value at row " + j);            
                else
                {                             
                    grdImport.AddRow();
                    var irow=grdImport.rows-1;
                    grdImport.SetGridText(irow,iccard_id,vcard_id);
                    grdImport.SetGridText(irow,icname,vemp_name);
                    grdImport.SetGridText(irow,ictype,lstType.value);
                    grdImport.SetGridText(irow,icamount,vtotal);
                    grdImport.SetGridText(irow,icwork_mon,dtMonth.text);
                }
            } 
            myApp.Quit();
        }
        catch(e)
        {
            alert("Could not read Excel File. (or) Excel was not installed in the machine you are using or it has incompatible version?"); 
        }
        datImport.Call();
    }
    else
        alert("Please choose one type of insurane");      
}
function CheckValidFile(vfile)
{
    var sext;
    sext=vfile.substring(vfile.length-4,vfile.length);
    if (sext!=".xls")
        return false;
    return true;
}

function OnReport(ptype)
{
    var url = System.RootURL + '/reports/ch/cs/rpt_insurance_template.aspx' ;
    window.open(url);
}

</script>

</head>
<body>
 <gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr.sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="lstDept_Code" />
                </output>
            </dso> 
        </xml> 
</gw:data>
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

<!------------------------------------->
<gw:data id="datGroupData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="hr.sp_pro_group_data_all" > 
                <input>
                   <input bind="txtDeptData" />
                </input> 
                <output>
                    <output bind="txtGroupData" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datEmp" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="2,4,5,6,7" function="hr.sp_sel_ins_ny_amatar"  procedure="hr.sp_upd_ins_ny_amatar" > 
                <input bind="grdEmp" >
                    <input bind="lstDept_Code" />
                    <input bind="lstGrp_Code" />
                    <input bind="dtMonth" />
                    <input bind="lstType" />
                    <input bind="lstTmp" />
                    <input bind="txtTmp" />                    
                </input>
                <output  bind="grdEmp" />
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datImport" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="2,4,5,6,7" function="hr.sp_sel_ins_ny_amatar" procedure="hr.sp_upd_ins_ny_amatar" > 
                <input bind="grdImport" >
                 <input bind="lstDept_Code" />
                    <input bind="lstGrp_Code" />
                    <input bind="dtMonth" />
                    <input bind="lstType" />
                    <input bind="lstTmp" />
                    <input bind="txtTmp" /> 
                </input>
                <output  bind="grdImport" />
            </dso> 
        </xml> 
</gw:data>
   <table name="Manage Ratio"  style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
         <tr style=" height:5%; border:1">	                
                <td align=right style="width:9%; border:0 " ><a title="Click here to show department" onclick="OnShowPopup()" href="#tips" style="text-decoration : none; color=#0000FF"><font size=2>Department</font></a></td>
		        <td align=right style="width:12%;border:0">
		            <gw:list  id="lstDept_Code"  maxlen = "100" styles='width:100%' onchange="OnChangeDept(lstDept_Code)" >
                    <data>
                        <%=ESysLib.SetListDataSQL("select a.pk,a.dept_nm from comm.tco_dept a where a.del_if=0 connect by prior  a.pk=a.p_pk start with nvl(a.p_pk,0)=0")%>|ALL|Select All
                    </data>
                    </gw:list>
                </td>                
                <td colspan=1 align=right style="width:5%;border:0">
		            <font size=2>Group</font>
                </td>
                <td  align=right style="width:14%;border:0">
		            <gw:list  id="lstGrp_Code" value='ALL'  maxlen = "40" styles='width:100%' >
                    <data>
                        <%=Esyslib.SetListDataSQL("SELECT pk,Group_NM FROM Thr_Group WHERE DEL_IF = 0 and use_yn='Y'  order by seq, Group_NM" )%>|ALL|Select All
                    </data>
                    </gw:list>
                </td>           
                <td colspan=1 align=right style="width:8%;border:0">
		            <font size=2>Month</font>
                </td>
                <td colspan=1 align=right style="width:10%;border:0">
		           <gw:datebox id="dtMonth"  text=""  lang="<%=Session("Lang")%>" type="month" />
                </td>
                <td colspan=1 align=right style="width:8%;border:0">
		            <font size=2>Search by</font>
                </td>
                <td colspan=1 align=right style="width:8%;border:0">
		            <gw:list  id="lstTmp"  styles='width:100%' onchange="" >
                    <data>
                        |1|Emp ID|2|Name|3|Card Num
                    </data>
                    </gw:list>
                </td>
                <td colspan=6 align=left style="width:25%;border:0">
		            <gw:textbox  id="txtTmp"   styles='width:80%' onenterkey="OnSearch()" />                    
                </td>
            </tr>	
            <tr style=" height:4%; border:1">
                <td  style="border:0"  align="right">Type</td>
                <td  style="border:0; width:10%">
                    <gw:list  id="lstType" value='ALL'  maxlen = "40" styles='width:100%;' onchange="" >
                    <data>|01|Sick|02|Maternity|ALL|Select All
                    </data>
                    </gw:list></td>
                <td colspan=1 align=right style="border:0">
		            <font size=2>Path</font>
                </td>      
                <td colspan="4" style="border:0;" align=left>
                  <input id="inputfile" type="file" name="pic" size="40" accept="image/jpg">
                </td>   
                <td  align=center style="border:0">
		            <gw:icon img="in" id="ibtnSampleReport"   text="Template"  onclick="OnReport(1)"/>
                </td>  
                <td  align=center style="width:10%;border:1;color:red" >
                    <font size=2><i><gw:label id="idRecord" text="0 record(s)" styles="width:100%" ></gw:label></i></font>
                </td>
                <td align=left style="width:3%;border:0">
                    <gw:imgBtn img="process" id="ibtnProcess"   alt="Insert from Excell"  onclick="OnLoadExcel()"/>
                </td>
                <td align=left style="width:3%;border:0">
                    <gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="Search" onclick="OnSearch()" />
                </td>		        
		        <td align=left style="width:3%;border:0">
                    <gw:imgBtn id="ibtnSave" alt="Save" img="Save" text="Save" onclick="OnSave()" />
                </td>	
                <td align=left style="width:3%;border:0">
                    <gw:imgBtn id="ibtnDelete" alt="Delete" img="Delete" text="Delete" onclick="OnDelete()" />
                </td>
                <td align=left style="width:3%;border:0">
                    <gw:imgBtn id="ibtnReport" alt="Sample Report" styles="display:none" img="excel" text="Sample Report" onclick="OnReport(2)" />
                </td>

            </tr>                                      
		    <tr style="height:85%; width:100%">
			    <td id="master" width="100%" colspan="16">
				    <gw:grid id='grdEmp'
                        header='GROUP_NM|EMP_ID|ID_NUM|FULL_NAME|INS_TYPE|AMOUNT|WORK_MON|PK'
                        format='0|0|0|0|2|1|0|0'
                        aligns='0|1|1|0|1|0|1|0'
                        defaults='|||||||'
                        editcol='0|0|0|0|1|1|0|1'
                        widths='1545|1155|1140|2895|1530|1665|1680|1000'
                        sorting='T'
                        styles='width:100%; height:460'
                        />
			    </td>
		    </tr>	
</table>       
 

     
</body>
<gw:textbox id="iduser_pk" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>        
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtDeptData" styles="display:none"/>     
     <gw:textbox id="txtGroupData" styles="display:none"/>
     <gw:grid id='grdImport'
                        header='GROUP_NM|EMP_ID|ID_NUM|FULL_NAME|INS_TYPE|AMOUNT|WORK_MON|PK'
                        format='0|0|0|0|2|1|0|0'
                        aligns='0|1|1|0|1|0|1|0'
                        defaults='|||||||'
                        editcol='0|0|0|0|1|1|0|1'
                        widths='1545|1155|1140|2895|1530|1665|1680|1000'
                        sorting='T'
                        styles='width:100%; height:460;display:none'
                        />
</html>

