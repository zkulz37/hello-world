<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser("hr")%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>In - Out Temporary</title>
</head>
<script>
var dept,grp,flag=0;
var v_language = "<%=Session("SESSION_LANG")%>";
var dt_tmp;
var i,j;
var c_from_time = 6;
 c_to_time = 7,
 c_wt = 8,
 c_ot = 9,
 c_nt = 10,
 c_reason = 11,
 c_ws = 4

function BodyInit()
{
    idGrid.GetGridControl().ScrollTrack=true;
    if (v_language!="ENG")
        System.Translate(document);	
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    menu_id.text=System.Menu.GetMenuID();
    idGrid.GetGridControl().ColEditMask(c_from_time)="99:99";
	idGrid.GetGridControl().ColEditMask(c_to_time)="99:99";
  
    if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
              datUser_info.Call(); 
    
    datCheck_View.Call();
}
function OnDataReceive(obj)
{
    if(obj.id == "datCheck_View")
    {
        if(txtFlag_View.text == 'Y')
        {
            ibtnSave.style.display = "none";
            ibtnDelete.style.display = "none";
        }
        
        if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	    {
            datUser_info.Call();     	    
	    }
        check_init =1;
    }
    else if (obj.id=="datIn_Out_Temp")
    {      
        idRecord.text = idGrid.rows - 1 + " record(s).";      
    }
}      

function OnSearch()
{
    datIn_Out_Temp.Call("SELECT");
}

function OnAdd()
{
    var fpath = System.RootURL + "/form/ch/ba/chba00270_01.aspx?";
    var aData=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:60;dialogHeight:30;dialogLeft:80;dialogTop:150;edge:sunken;scroll:yes;unadorned:yes;help:no');
    
    if ( aData != null )
	{  
		var len=aData.length;
		var i;
		for (i=0;i<len-1;i++)		
		{
            idGrid.AddRow();
		    var irow=idGrid.rows-1;
		    aRow=aData[i];
		    idGrid.SetGridText(irow,0,aRow[0]);		// Org
		    idGrid.SetGridText(irow,1,aRow[1]);		// group
		    idGrid.SetGridText(irow,2,aRow[2]);		// emp id
		    idGrid.SetGridText(irow,3,aRow[3]);		// full nm
		    idGrid.SetGridText(irow,4,aRow[4]);	    // work shift
            idGrid.SetGridText(irow,5,aRow[5]);	    // work date
		    idGrid.SetGridText(irow,12,aRow[6]);		// emp_pk
		}
		if(len>0)
		{
		        aRow=aData[len-1];
		        dept=aRow[0];
		        grp=aRow[1];
		        idSearch.value=aRow[2]; //lsttemp
		        idtxtTmp.text=aRow[3]; //temp
		        FromDT.value=aRow[4];//from dt
		        ToDT.value=aRow[4];//to date
		    if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
		    {
		          flag=1;
                  datUser_info.Call();
            }      
            else
            {
                
		        lstOrg.SetDataText("<%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from comm.tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id ")%>" + '|ALL|Select All');    
                lstWG.SetDataText("<%= ESysLib.SetListDataSQL("SELECT pk,workGroup_NM FROM Thr_work_Group WHERE DEL_IF = 0 order by workGroup_NM")%>" + '|ALL|Select All');
		        lstOrg.value=aRow[0]; //dept
		        lstWG.value=aRow[1]; //grp
		       
		    }
		 }   
	}	
 }
 //------------------------------------
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

function OnSave()
{
    datIn_Out_Temp.Call();
}
function OnDelete()
{
    if(confirm("Delete it?\nBạn muốn xóa?"))
    {
        idGrid.DeleteRow();
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
       
    }
    
}
/*
function OnReport(num)
{
    if(num==2)
    {
        var url =System.RootURL + '/reports/ch/cs/rpt_salary_adjustment.aspx?p_from='+FromDT.value+'&p_to='+ToDT.value+'&p_adj_type='+lstType.value+'&org_type='+lstWG.value+'&p_tco_org_pk='+lstOrg.value+'&p_search_by='+idSearch.value+'&p_search_temp='+idtxtTmp.text+'&p_nation='+lstNation.value;        
    }
    if(num==3)
    {
        var url = System.RootURL + '/reports/ch/cs/rpt_salary_adjustment_summary.aspx?p_from='+FromDT.value+'&p_to='+ToDT.value+'&p_adj_type='+lstType.value+'&org_type='+lstWG.value+'&p_tco_org_pk='+lstOrg.value+'&p_search_by='+idSearch.value+'&p_search_temp='+idtxtTmp.text+'&p_nation='+lstNation.value;        
    }
    window.open(url);
}
*/
function On_AfterEdit()
{
    var tmpIN,tmpOUT;
    ws=idGrid.GetGridData(event.row,c_ws);
    lstWS_temp.value=ws;
    idWS.text=lstWS_temp.GetText();
	cIdx=event.col;
    if (cIdx==c_from_time)
	{
        
	    tmpIN=idGrid.GetGridData(event.row,cIdx)	    
		if(tmpIN.length==0)
		{
			idGrid.SetGridText(event.row,cIdx,"")
			//return;
		}
		if((tmpIN.length!=4)&&(tmpIN.length!=""))
		{
			alert("Input In time is not correct type.(type: hh:mm)\nKiểu giờ in nhập không đúng")
			idGrid.SetGridText(event.row,cIdx,'')
			return;
		}
		if((Number(tmpIN.substr(0,2))>=24)||(Number(tmpIN.substr(0,2))<0))
		{
			alert("Input In time(Hour) is not correct type.(00<= hh <= 23)\nKiểu giờ in phải >=00 và <=23")
			idGrid.SetGridText(event.row,cIdx,'')
			return;
		}
		if((Number(tmpIN.substr(2,2))>=60)||(Number(tmpIN.substr(2,2))<0))
		{
			alert("Input In time(Minute) is not correct type.(00<= hh < 59)\nKiểu phút phải >=00 và <=59")
			idGrid.SetGridText(event.row,cIdx,'')
			return;
		}
		if(tmpIN.length>0)
		{
		    tmpIN=tmpIN.substr(0,2)+":"+tmpIN.substr(2,2)
		    idGrid.SetGridText(event.row,cIdx,tmpIN)
		}
	
	}
	if (cIdx==c_to_time)
	{
	    tmpOUT=idGrid.GetGridData(event.row,cIdx)
	    
		if(tmpOUT.length==0)
		{
			idGrid.SetGridText(event.row,cIdx,"")
			//return;
		}
		if((tmpOUT.length!=4)&&(tmpOUT.length>0))
		{
			alert("Input Out time is not correct type.(type: hh:mm)\nKiểu giờ out không đúng(hh:mm)")
			idGrid.SetGridText(event.row,cIdx,'')
			return;
		}
		if((Number(tmpOUT.substr(0,2))>=24)||(Number(tmpOUT.substr(0,2))<0))
		{
			alert("Input Out time(Hour) is not correct type.(00<= hh <= 23)\nKiểu giờ out phải >=00 và <=23")
			idGrid.SetGridText(event.row,cIdx,'')
			return;
		}
		if((Number(tmpOUT.substr(2,2))>=60)||(Number(tmpOUT.substr(2,2))<0))
		{
			alert("Input Out time(Minute) is not correct type.(00<= hh < 60)\nKiểu phút phải >=00 và <=59")
			idGrid.SetGridText(event.row,cIdx,'')
			return;
		}
		if(tmpOUT.length>0)
		{
		    tmpOUT=tmpOUT.substr(0,2)+":"+tmpOUT.substr(2,2)
		    idGrid.SetGridText(event.row,cIdx,tmpOUT);
		}
 	}
    
}

function On_click()
{
    var ws;
	dt_tmp=idGrid.GetGridData(event.row,event.col)//luu tru gia tri vua click
	ws=idGrid.GetGridData(event.row,c_ws)
	lstWS_temp.value=ws;
	idWS.text=lstWS_temp.GetText();
	
}
</script>

<body>
<!------------main control---------------------->
<gw:data id="datCheck_View" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="process" procedure="HR.sp_pro_check_view"  > 
                <input>
                    <input bind="iduser_pk" />
                    <input bind="menu_id" />
                </input> 
                <output>
                    <output bind="txtFlag_View" />
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

<gw:data id="datIn_Out_Temp" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="5,6,7,8,9,10,11,12" function="HR.sp_sel_in_out_temp" procedure="HR.sp_upd_in_out_temp"> 
                <input bind="idGrid" >
                    <input bind="lstOrg" />
                    <input bind="lstWG" />
                    <input bind="idSearch" />
                    <input bind="idtxtTmp" />
                    <input bind="FromDT" />
                    <input bind="ToDT" />
                    <input bind="lstNation" />
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
</gw:data>


<!--------------------main table--------------------------------->
<table style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
	<tr>
	    <td>
	        <table style="width:100%;height:12%" cellpadding="0" cellspacing="0" valign="top" border="0" >	
	            <tr style="height:6%;border:0">	
		            <td align=right colspan=4 style="width:8%" ><a title="Click here to show organization" onclick="OnShowPopup()" href="#tips" >Organization</a></td>
		            <td align=right colspan=10 style="width:20%"><gw:list  id="lstOrg" value="ALL"  maxlen = "100" styles='width:100%' onchange="" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from comm.tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data>
                        </gw:list>
                    </td>
		            <td align=right colspan=5 style="width:10%">Work Group</td>
		            <td align=right colspan=6 style="width:12%">
		                <gw:list  id="lstWG" value="ALL" maxlen = "100" styles='width:100%'>
                         <data><%=ESysLib.SetListDataSQL("SELECT A.PK,A.workgroup_nm FROM thr_work_group A WHERE A.DEL_IF=0 ORDER BY a.workgroup_id")%>|ALL|Select All</data></gw:list>
                    </td>
                    <td align=right colspan=2 style="width:6%">Search by</td>
		            <td align=left colspan=2 style="width:8%"><gw:list  id="idSearch" onchange="ChangeSearch()" value="1" styles="width:98%" onChange="">
                                            <data>|1|Emp ID|2|Card ID|3|Name</data></gw:list></td>
		            <td align=right colspan=10 style="width:6%"><gw:textbox id="idtxtTmp" maxlen = "50" styles="width:100%" /></td>
                    <td align=left style="width:2%;border:0"></td>
                    <td align=right style="width:2%"><gw:button id="ibtnAdd" alt="Add New" img="new" text="Add" onclick="OnAdd()" /></td>
		            <td align=right style="width:2%"><gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="Search" onclick="OnSearch()" /></td>
		            <td align=right style="width:2%"><gw:imgBtn id="ibtnSave" alt="Save" img="save" text="Save" onclick="OnSave()" /></td>
		            <td align=right style="width:2%"><gw:imgBtn id="ibtndel" alt="Delete" img="delete" text="Delete" onclick="OnDelete()" /></td>
		            <td align=right style="width:2%"><gw:imgBtn id="ibtnRpt" alt="Report" img="excel" text="Report" onclick="OnReport()" /></td>
                </tr>	
                <tr style="height:6%;border:0">	
		            <td align=right colspan=2>From</td>
		            <td align=left colspan=4><gw:datebox id="FromDT" value="" maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
		            <td align=right colspan=2>To</td>
		            <td align=left colspan=4 ><gw:datebox id="ToDT" value="" maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
		            <td align=right colspan=3 style="width:6%">Nation</td>
		            <td align=right colspan=4 style="width:10%"><gw:list id="lstNation" value="01"  maxlen = "100" styles='width:100%' >
                        <data>
                            <%=ESysLib.SetListDataSQL("select code, code_nm from vhr_hr_code v where v.ID='HR0009'")%>|ALL|Select All
                        </data>
                        </gw:list>
                    </td>
                    <td align=center colspan=18 ><b><gw:label id="idWS" text="" styles="width:100%;color:red" ></gw:label></b></td>
		            <td align=center colspan=6 style="color:Red;"><gw:label id="idRecord" text="0 record(s)" styles="width:100%;color:red" ></gw:label>
		            </td>
                </tr>	
            
                
	        </table>
	        <table id="tblMain" style="width:100%;height:88%" border=1 cellpadding="0" cellspacing="0">
	            <tr style="width:100%;height:100%">
	                <td id="tdMaster" style="width:100%">
	                    <gw:grid   
				        id="idGrid"  
				        header="Organization|Workgroup|Emp ID|Full Name|WS|Work Date|From Time|To Time|WT|OT|NT|Reason|_emp_pk"   
				        format="0|0|0|0|0|4|0|2|0|0|0|0|0"  
				        aligns="0|0|1|0|1|1|1|1|1|1|1|0|0"  
				        defaults="|||||||||||||"  
				        editcol="1|0|0|0|1|1|1|1|1|1|1|1|0"  
				        widths="2000|1200|1200|2500|500|1200|1000|1000|500|500|500|2000|0"  
				        styles="width:100%; height:100% "   
				        sorting="T" 
				        acceptnulldate  
                        onafteredit="On_AfterEdit()"
				        oncellclick     = "On_click()"/>
	                </td>
	            </tr>
	        </table>
	    </td>
	</tr>
</table>

   <gw:textbox id="iduser_pk" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
    <gw:textbox id="txtDeptData" styles="display:none"/>
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtGroupData" styles="display:none"/>
    <gw:textbox id="menu_id" text="" styles="display:none"  />
    <gw:textbox id="txtFlag_View" text="" styles="display:none"  />
    <gw:list  id="lstWS_temp" value="ALL"  maxlen = "100" styles='display:none' >
                            <data><%=ESysLib.SetListDataSQL("SELECT PK,shift||'-'||remark FROM thr_work_shift WHERE DEL_IF = 0 and use_yn='Y'  order by shift")%>|ALL|WS-Select All</data></gw:list>
</body>
</html>

