<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser("hr")%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var startTime,interval_time;
var dt_tmp;
var opt_value=1;
var user;
var v_language = "<%=Session("SESSION_LANG")%>";
var c_thr_emp_pk=1
    c_emp_id=2;
    c_fullname=3;
    c_department =4;
    c_position=5;
    c_join_dt=6;
    c_year=7;
    c_month=8;
    c_salary_old=9;
    c_issues_dt =10;
    c_grade=11;
    c_inc_per=12;
    c_inc_amt=13;
    c_total_amt =14;
    c_total_per =15;
    c_salary_new =16;
    c_note=17;
	c_job = 18;
    
function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);	
     iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    user= "<%=session("USER_ID")%>";
     
     
			
	if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	{
        datUser_info.Call();     	    
	}
	var t1 = "<%=ESysLib.SetGridColumnDataSQL("select pk,org_nm from comm.tco_org where del_if=0 order by org_nm")%>";
       grdSalary.SetComboFormat(c_department,t1);   //Department
       t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm")%>";
       grdSalary.SetComboFormat(c_position,t1); //position  

}

function clear_Interval(obj)
{
	clearInterval(interval_time);
	obj.text="";
}

//----------------------------------------------------
function OnAdd()
{
    var rowid,k,tmp;
	var url = "/form/ch/cs/chcs00170_search_emp.aspx";
	var aData=new Array();
	aData = System.OpenModal( System.RootURL + url , 900 , 600 , 'resizable:yes;status:yes') ;
	if ( aData != null )
	{  	 
		var len=aData.length;
		var i;
		for (i=0;i<len;i++)		
		{
	            grdSalary.AddRow();
		        var irow=grdSalary.rows-1;
		        aRow=aData[i];
		        
		        grdSalary.SetGridText(irow,c_thr_emp_pk,aRow[0]);		// emp_pk
		        grdSalary.SetGridText(irow,c_emp_id,aRow[1]);		// Emp Id
		        grdSalary.SetGridText(irow,c_fullname,aRow[2]);		// fullName
		        grdSalary.SetGridText(irow,c_department,aRow[3]);		// department
		        grdSalary.SetGridText(irow,c_position,aRow[4]);  //position
		        grdSalary.SetGridText(irow,c_join_dt,aRow[5]);  //position
		        grdSalary.SetGridText(irow,c_salary_old,aRow[6]); //old salary
		        grdSalary.SetGridText(irow,c_issues_dt,aRow[7]); //issues date
				grdSalary.SetGridText(irow,c_job,aRow[8]); 	// job
		}
	}	
}
function OnShowPopup()
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:25;dialogHeight:25;dialogLeft:10;dialogTop:240;edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {
        lstOrg.value=obj
        txtUpperDept.text=obj;
        //datDeptData.Call();
    }
    
}

function onClickOption(n)
{   
    opt_value=n;
    switch(n)
    {
        case 2:
            fromDT.SetEnable(0);
	        toDT.SetEnable(0);
	        Year.SetEnable(1);
			
	        break;
	    case 1:
            fromDT.SetEnable(1);
	        toDT.SetEnable(1);
	        Year.SetEnable(0);
			txtFrom.text = fromDT.value;
			txtTo.text = toDT.value;
	        break;   
	  
    }
}


function OnSearch()
{
   switch(opt_value)
    {
        case 2:
           txtFrom.text=Year.value +"0101"
           txtTo.text=Year.value +"1231"
	        break;
	    case 1:
	        txtFrom.text=fromDT.value
            txtTo.text=toDT.value
	        break;   
    }
    datAdjust.Call("SELECT");
}
//------------------------------------------------------------------------------------
function OnUpdate()
{
    if(confirm("Do you want to save?\nBạn muốn save?"))
        datAdjust.Call();
}



//------------------------------------------------------------------------------------

function OnReport()
{
	txtFrom.text = fromDT.value;
	txtTo.text = toDT.value;
    if(fromDT.value == toDT.value && opt_value==1)
    {   
		var url =System.RootURL + '/reports/ch/cs/rpt_salary_adjust_issues.aspx?l_tco_org_pk='+lstOrg.value+'&l_pos_type='+lstPos.value+'&l_search='+idSearch.value+'&l_input='+idtxtTmp.text+'&l_from='+txtFrom.text+'&l_to='+txtTo.text;
        window.open(url);
        
    }
    else
    {
        alert("Please choose one day to export report!\n Bạn phải chọn 1 ngày cụ thể để xuất báo cáo");
        return;
    }
}
//-------------------------------------------------
function OnDelete()
{
    if(confirm("Delete it?\nBạn muốn xóa?"))
        grdSalary.DeleteRow();
}
//------------------------------------------------
function OnDataReceive(obj)
{
    if(obj.id=="datAdjust")
    {
        idRecord.text=grdSalary.rows-1 + " Records.";
    }
	   
}     
//---------------------------------------------------------------
function OnSetToGrid()
{
    
	if(grdSalary.rows>1)
    {
                var ctrl=grdSalary.GetGridControl();
                if(ctrl.SelectedRows>0)
                {
                    for ( var i =  0 ; i < ctrl.SelectedRows ; i++ )
                    {   
                        var sal_old = Number(grdSalary.GetGridData(ctrl.SelectedRow(i),c_salary_old));
                        var per,s,s1,s2,total_amt,total_per;
                        if(lstSet.value =="1" || lstSet.value =="2")    // set Inc % hoac amt
                        {
                                if(lstSet.value=="1") // inc %
                                {
                                    per = Number(idtxtSet.text)/100;
                                    s1 = per*sal_old
            	                    grdSalary.SetGridText(ctrl.SelectedRow(i), c_inc_per, s1);
            	                    s2 = Number(grdSalary.GetGridData(ctrl.SelectedRow(i), c_inc_amt)); 
            	                   
            	                }
            	                else if(lstSet.value == "2")  // inc amt
            	                {
            	                    amt = Number(idtxtSet.text);
            	                    s1 = amt;
            	                    grdSalary.SetGridText(ctrl.SelectedRow(i), c_inc_amt, s1);
            	                    s2 = Number(grdSalary.GetGridData(ctrl.SelectedRow(i), c_inc_per));  // luu lai inc_per
            	                    
            	                } 
            	                 s = sal_old + s1 + s2  // tinh luong moi 
            	                 grdSalary.SetGridText(ctrl.SelectedRow(i),c_salary_new, s);  // luong moi
            	                 total_amt = s - sal_old;
            	                 grdSalary.SetGridText(ctrl.SelectedRow(i), c_total_amt, total_amt) ;
            	                 total_per = total_amt*100/sal_old ;
            	                 grdSalary.SetGridText(ctrl.SelectedRow(i), c_total_per, total_per) ;  
            	        }
            	        else if(lstSet.value =="3")     // set Grade
            	        {
            	            grdSalary.SetGridText(ctrl.SelectedRow(i), c_grade, idtxtSet.text) ;
            	        }
            	    }
        			
                }
                else
                {
                    if(confirm("Do you want to set all rows?\nBạn có muốn set hết tất cả các dòng ở dưới lưới"))
                    {
                        for ( var i =  1 ; i < ctrl.Rows ; i++ )
                        {
                            var sal_old = Number(grdSalary.GetGridData(i,c_salary_old));
                            var per,s,s1,s2,total_amt,total_per;
                            if(lstSet.value =="1" || lstSet.value =="2")    // set Inc % hoac amt
                            {
                                    if(lstSet.value=="1") // inc %
                                    {
                                        per = Number(idtxtSet.text)/100;
                                        s1 = per*sal_old
            	                        grdSalary.SetGridText(i, c_inc_per, s1);
            	                        s2 = Number(grdSalary.GetGridData(i, c_inc_amt)); 
                	                   
            	                    }
            	                    else if(lstSet.value == "2")  // inc amt
            	                    {
            	                        amt = Number(idtxtSet.text);
            	                        s1 = amt;
            	                        grdSalary.SetGridText(i, c_inc_amt, s1);
            	                        s2 = Number(grdSalary.GetGridData(i, c_inc_per));  // luu lai inc_per
                	                    
            	                    } 
            	                     s = sal_old + s1 + s2  // tinh luong moi 
            	                     grdSalary.SetGridText(i,c_salary_new, s);  // luong moi
            	                     total_amt = s - sal_old;
            	                     grdSalary.SetGridText(i, c_total_amt, total_amt) ;
            	                     total_per = total_amt*100/sal_old ;
            	                     grdSalary.SetGridText(i, c_total_per, total_per) ;  
            	            }
            	            else if(lstSet.value =="3")     // set Grade
            	            {
            	                grdSalary.SetGridText(i, c_grade, idtxtSet.text) ;
            	            }
            	       }
                    }
                }
		idtxtSet.text="";		
    }
}
//-----------------------------------------------
function Numbers(e) 
{ 
  //  var ctrl=idTEL.GetControl(); 
    var keynum; 
    var keychar; 
    var numcheck; 
    keynum =event.keyCode; 
        
    if(window.event) // IE 
    { 
      keynum = e.keyCode; 
    } 
    else if(e.which) // Netscape/Firefox/Opera 
    { 
      keynum = e.which; 
    } 
    keychar = String.fromCharCode(keynum); 
    numcheck = /\d/; 
    return numcheck.test(keychar); 
}
function checknumber(eve)
{
    if(lstSet.value=="1" || lstSet.value =="2")
    return Numbers(eve);
    
}
</script>

<body>
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
<gw:data id="datGroupData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="hr.sp_pro_group_data_all"  > 
                <input>
                    <input bind="lstOrg" /> 
                </input> 
                <output>
                    <output bind="txtGroupData" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------------>
<gw:data id="datFind_Report" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_find_report" > 
                <input>
                    <input bind="txtReport_tmp" /> 
                </input> 
                <output>
                    <output bind="txtReport_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!--------------------------------------------------------------->
<gw:data id="datAdjust" onreceive="OnDataReceive(this)"  > 
        <xml> 
           <dso  type="grid"  function="hr.sp_sel_emp_adj" procedure="hr.sp_upd_emp_adj" parameter="0,1,2,3,4,5,6,9,10,11,12,13,14,15,16,17,18" > 
                <input bind="grdSalary">
                    <input bind="lstOrg" /> 
                    <input bind="lstPos" /> 
                    <input bind="idSearch" /> 
                    <input bind="idtxtTmp" />
                    <input bind="txtFrom" />
                    <input bind="txtTo" />
                </input> 
                <output bind="grdSalary"/>
            </dso> 
        </xml> 
</gw:data>
<table style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
	<table style="width:100%;height:15%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
	<tr style="height:7%;border:1">	
		<td colspan=2 align=right style="width:10%;border:1;color=Black" ><input type="radio" name="option_P"  value="2" onclick="onClickOption(2)" >Year</td>
		<td colspan=2 align=left style="width:10%;border:1"><gw:datebox id="Year"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" type=year /></td>
		<td align=right style="width:5%;border:1"></td>
		<td colspan=2 align=right style="width:10%;border:0"><input type="radio" name="option_P" value="1" checked onclick="onClickOption(1)" >From</td>
		<td colspan=2 align=right style="width:10%;border:0"><gw:datebox id="fromDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
		<td align=right style="width:5%;border:0">To </td>
		<td colspan=2 align=right style="width:10%;border:0"><gw:datebox id="toDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
		<td align=right style="width:5%;border:0"></td>
        <td align=right colspan=2 style="width:10%;border:0"> </td>
		<td align=left colspan=2 style="width:10%;border:0"></td>
		<td align=right style="width:3%;border:0" ><gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="Search" onclick="OnSearch()" /></td>
		<td align=right style="width:3%;border:0"><gw:imgBtn img="new" id="ibtnAdd"   alt="Add"  onclick="OnAdd()"/></td>
		<td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnSave" alt="Save" img="save" text="Save" onclick="OnUpdate()" /></td>
		<td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnDelete" alt="Delete" img="delete" text="Delete" onclick="OnDelete()" /></td>
		<td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnRpt" alt="Report" img="excel" text="Report" onclick="OnReport()" /></td>
		<td align=right style="width:3%;border:0"></td>
    </tr>	
    <tr style="height:7%;border:1">	
		<td align=right style="width:5%;border:0" ><a title="Click here to show department" onclick="OnShowPopup()" href="#tips" style="text-decoration : none; color=#0000FF">Organization</a></td>
		<td colspan=3 align=right style="width:15%;border:0"><gw:list  id="lstOrg"  maxlen = "100" styles='width:100%' onchange="" value="ALL" >
                <data>
                    <%=ESysLib.SetListDataSQL("SELECT A.PK,A.ORG_NM FROM COMM.TCO_ORG A WHERE A.DEL_IF=0 ORDER BY NVL(A.SEQ,9999)")%>|ALL|Select All
                </data>
            </gw:list>
        </td>
		<td align=right style="width:5%;border:0">Search</td>
		<td colspan=3 align=right style="width:15%;border:0"><gw:list  id="idSearch" value="1" styles="width:95%" onChange="">
                <data>|1|Emp ID|2|Name</data></gw:list>
        </td>
        <td colspan=4 align=right style="width:25%;border:0"><gw:textbox id="idtxtTmp" maxlen = "20" styles="width:97%" onenterkey="OnSearch()" />
        </td>
        <td  colspan=1 align=right style="width:5%;border:0">Position</td>
        <td colspan=4 align=right style="width:20%;border:0"><gw:list  id="lstPos"  maxlen = "100" styles='width:100%' value="ALL" >
                            <data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm")%>|ALL|Select All</data></gw:list>
        </td>
        <td align=right colspan=2 style="width:6%;border:0"></td>
         <td align=right colspan=3 style="width:9%;border:0">
         </td>
         <td align=right style="width:3%;border:0"></td>
    </tr>	
    <tr style="height:7%;border:1">	
		<td align=right style="width:5%;border:0" >Choose Set</td>
		<td colspan=3 align=right style="width:15%;border:0">
		    <gw:list  id="lstSet" value="4" styles="width:95%" onChange="">
                <data>|1|Increase %|2|Increase Amt|3|Grade|4|Choose...</data></gw:list>
        </td>
		<td colspan=2 align=right style="width:5%;border:0"><gw:textbox id="idtxtSet" maxlen = "20" styles="width:97%" onkeypress="return checknumber(event)" /></td>
		<td colspan=2 align=left style="width:15%;border:0"><gw:icon id="idBtnSet"  styles='width:50%' img="in"  text="Set"  onclick="OnSetToGrid()"/>
        </td>
        <td colspan=4 align=right style="width:25%;border:0">
        </td>
        <td  colspan=1 align=right style="width:5%;border:0"></td>
        <td colspan=4 align=right style="width:20%;border:0">
        </td>
        <td align=right colspan=2 style="width:6%;border:0"></td>
         
         <td colspan=4 align=right style="width:3%;border:0"><gw:label id="idRecord" text="0 record(s)" styles="width:100%" ></gw:label></td>
    </tr>	
	</table>
	<table id="tbl" style="width:100%;height:85%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
		<tr style="height:100%">
			<td id="master" width="100%">
				<gw:grid
					id="grdSalary"
					header="_PK|_THR_EMP_PK|EMP_ID|FULL NAME|DEPARTMENT|POSITION|JOIN DATE|YEAR|MONTH|SALARY OLD|ISSUES DATE|GRADE|INCREASE %|INCREASE AMT|TOTAL AMT|TOTAL %|SALARY NEW|NOTE|_JOB"
					format="0|0|0|0|0|0|4|1|1|1|4|0|1|1|1|1|1|0|0"
					aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
					defaults="||||||||||||||||||"
					editcol="0|0|0|0|0|0|0|0|0|0|0|1|0|0|0|0|0|1|0"
					widths="0|0|1000|2500|1000|1000|1200|500|500|1500|1500|700|1500|1500|1500|1000|1500|500|500"
					styles="width:100%;height:100%"
					sorting="T"
					/>
			</td>
		</tr>	
	</table>
</table>

	<gw:textbox id="txtResult" styles="display:none"/>
    <gw:textbox id="txtDeptData" styles="display:none"/>
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtGroupData" styles="display:none"/>
    <gw:textbox id="txtFrom" styles="display:none"/>
    <gw:textbox id="txtTo" styles="display:none"/>
    <gw:textbox id="iduser_pk" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
    <gw:list  id="lstWS_temp" value="ALL"  maxlen = "100" styles='display:none' >
                            <data><%=ESysLib.SetListDataSQL("SELECT PK,shift||'-'||remark FROM thr_work_shift WHERE DEL_IF = 0 and use_yn='Y'  order by shift")%>|ALL|WS-Select All</data></gw:list>
    <gw:textbox id="txtReport_tmp" styles="display:none"/>
                               
	
</body>
</html>

