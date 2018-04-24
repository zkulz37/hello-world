<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser("hr")%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var startTime,interval_time
var v_language = "<%=Session("SESSION_LANG")%>";
var value_before=0;
var flag=0;
var col=0;
var row=0;
var _days=0;
var tmp1,tmp2;
var flag_open=0;
var col_f=1;//col ngay dau tien
var col_e=31; //col ngay cuoi cung
function BodyInit()
{   
    
    if (v_language!="ENG")
        System.Translate(document);	
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>"; 
    <%=ESysLib.SetGridColumnComboFormat( "grdWork" , 2 , "select pk, shift||'-'||remark from thr_work_shift a where a.del_if=0 and a.use_yn='Y' and nvl('" + session("COMPANY_PK") + "',a.tco_company_pk)=a.tco_company_pk order by shift") %>;        
    <%=ESysLib.SetGridColumnComboFormat( "grdWork" , 5 , "SELECT A.CODE, A.CODE_NM   FROM TCO_ABCODE A,TCO_ABCODEGRP B WHERE B.ID = 'COAB0140'   AND A.TCO_ABCODEGRP_PK = B.PK AND A.DEL_IF = 0 AND B.DEL_IF = 0 union all select '','' from dual") %>;        
      lstHol.value="";
     if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	{
        datUser_info.Call();     	    
	}
	else
    {    ChangeColorItem(lstOrg.GetControl());
        
    }
	 

}
//----------------------------------------------
function ChangeColorItem(lstctl)
{
    
    var slevel1,slevel2,slevel3;
    for (var i=0;i<lstctl.options.length;i++)
    {
        slevel1=lstctl.options.item(i).text.substr(0,1);
        slevel2=lstctl.options.item(i).text.substr(0,3);
        slevel3=lstctl.options.item(i).text.substr(0,5);
        if (slevel3!=".....")
        {
            if (slevel2=="...")
            {
                lstctl.options.item(i).style.color="0066CC";
            }
            else 
            {
                if (slevel1==".")
                    lstctl.options.item(i).style.color="FF3333";
            }
        }    
    }
}
function set_Interval(x) 
{
 startTime = new Date().valueOf();
 interval_time=setInterval("clock(" + startTime + "," + x  + ")",x);
}
function clock(start,x) 
{
 var d = new Date()
 idInterval.text= Math.round((d.valueOf()-start)/x);

}
function clear_Interval(obj)
{
	clearInterval(interval_time);
	obj.text="";
}


function OnSearch(n)
{   
    if(n==1)
    {
	    set_Interval(100);
	    grdDetail.ClearData();
        datWorkSchedule.Call("SELECT");
    }
    else    
        datWorkSchedule2.Call("SELECT");
}
function OnDelete()
{
	if (confirm("Do you want to delete?\nBạn thực sự muốn xóa?"))
            grdWork.DeleteRow();
}

function OnUndelete()
{
	grdWork.UnDeleteRow();
}

function OnUpdate(n)
{
    if(n==1)
    {
	    if (confirm("Do you want to save?\nBạn muốn save?"))
	    {
		    set_Interval(100);
		    datWorkSchedule.Call();
	    }	
	}
	else
	{
	    if (confirm("Do you want to save?\nBạn muốn save?"))
	        datWorkSchedule2.Call();
	}    
	
}

function OnShowPopup()
{
        var fpath = System.RootURL + "/form/ch/ae/chae00010_dept.aspx?";
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:10;dialogTop:200;edge:sunken;scroll:no;unadorned:yes;help:no');
        if (obj!=null)
        {
             txtUpperDept.text=obj;
             datDeptData.Call();
        }
}


function OnDataReceive(obj)
{
        if (obj.id=="datWorkSchedule")
       {
	   		clear_Interval(idInterval);
            idRecord.text=grdWork.rows-1 +" Records."
       }
       else if (obj.id=="WorkSchedule")
       {
	   		 clear_Interval(idInterval);
             if (txtResult.text=='0')
			 {
			 	alert("Successful.\nThành công");
				if (txtEmpID.text=="")
				    datWorkSchedule.Call("SELECT")
			}	
			 else
			 	alert("Error during process.\nCó lỗi xảy ra");
			
				
       }
        else if (obj.id=="datUser_info")
       {
	        ChangeColorItem(lstOrg.GetControl());
	        datWorkShift_info.Call();
       }else if (obj.id=="datWorkSchedule2")
       {
            idRecord2.text=grdWork2.rows-1+" Records";
	   	    auto_resize_column(grdWork2,0,grdWork2.cols-1,0);
	   	    fill_sunday();	 
       }
       else if (obj.id=="datSunday")
       {
          fill_sunday();
       }
       if(obj.id=="datGet_Period")
		{
	    //alert(idMon_fr2.value);
	    var n;
	    _days=daysInMonth(idMon_fr2.value.substring(4,6),idMon_fr2.value.substring(0,4));	
		tmp1=Number(idMon_fr2.value.substring(6,8));
		tmp2=Number(idMon_to2.value.substring(6,8));
		//alert(tmp2)
		if(tmp2<_days)//chu ky giua thang
		{
		    for(var i=tmp1;i<=31+tmp2;i++)
		    {
		        if(i>31)
		            n=i-31
		         else
		            n=i   
		        grdWork2.SetGridText(0,i-tmp1+col_f,n);
		    }    
		    for(var i=1;i<=31-_days;i++)
		     grdWork2.GetGridControl().ColHidden(i+_days-tmp1+col_f)=true;
		}
		else
		{
		    for(var i=1;i<=31;i++)
		        grdWork2.SetGridText(0,i+col_f-1,i);
		        
		    for(var i=1;i<=31-_days;i++)
		     grdWork2.GetGridControl().ColHidden(i+_days+col_f-1)=true;    
		} 
		
		if(idClose_flag2.text=="Y")
		{
		     idRecord.text="This month is close";
		     ibtnSave2.SetEnable(0);
		}     
		else
		{
		    idRecord.text="";     
		   ibtnSave2.SetEnable(1);
		} 
		datSunday.Call("SELECT");   
	} 
       
}
function fill_sunday()
{
    var tmp;
      
       grdWork2.SetCellBgColor(0, 0,0, grdWork2.cols-1, 0x000000);
      for(var i=1;i<grdWork3.rows;i++)
      {
        
        if(Number(grdWork3.GetGridData(i,0))<Number(idMon_fr2.value.substring(6,8)))
            tmp=31-Number(idMon_fr2.value.substring(6,8))+Number(grdWork3.GetGridData(i,0))+col_f;
        else
            tmp=Number(grdWork3.GetGridData(i,0))-Number(idMon_fr2.value.substring(6,8))+col_f;
            
        //alert(tmp);
        grdWork2.SetCellBgColor(0, tmp,grdWork2.rows-1, tmp, 0x3366FF );  
      }  
} 
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}      
function onProcess_schedule(flag) 
{
	if(confirm("Do you want to make schedule by "+flag+"?"+"\nTiến trình sắp lịch theo kiểu "+flag+"?"))
	{
		alert("It take several seconds, Please wait...\nXin đợi trong giây lát...");
		set_Interval(100);
	
		txtFlag.text=flag;
		WorkSchedule.Call();
	}	
}

function show_detail()
{
	txtMaster_pk.text=grdWork.GetGridData(event.row,4);
	if(imgMaster.status == "expand")
	   datWorkSchedule_detail.Call("SELECT")
}

function OnToggle()
{
        if(imgMaster.status == "expand")
        {
            detail.style.display="none";
            imgMaster.status = "collapse";
			tbl.style.width="100%";
            imgMaster.src = "../../../system/images/iconmaximize.gif";
			imgMaster.alt="Show detail"
          /*  tblMain.style.height="100%";
            tblUpper.style.height="5%";
            tblDetail.style.height="95%";*/
            
        }
        else
        {
            detail.style.display="";
            imgMaster.status = "expand";
            imgMaster.src = "../../../system/images/close_popup.gif";
			imgMaster.alt="Close detail"
			datWorkSchedule_detail.Call("SELECT")
          /*  tblMain.style.height="100%";
            tblUpper.style.height="5%";
            tblDetail.style.height="45%";
            tblMaster.style.height="50%";*/
            
        }
  
}
function onView(n)
{
    if(n==1)
    {
	    var fpath = System.RootURL + "/form/ag/bh/agbh00050_view.aspx";
            var obj  = System.OpenModal(  fpath , 450 , 700 , 'resizable:yes;status:yes');
    }
    else
    {
        if(row>0&&col>0&&grdWork2.GetGridData(row,col)!="")
        {
            var tmp,dt;
            tmp=Number(idMon_fr2.value.substring(6,8))+col-col_f;
            if(tmp>31)
            {
                tmp=tmp-31;
                if(tmp<10)
                    dt=idMon_to2.value.substring(0,6)+""+"0"+tmp;
                else
                    dt=idMon_to2.value.substring(0,6)+""+tmp;
            }
            else
            {
                if(tmp<10)
                    dt=idMon_fr2.value.substring(0,6)+""+"0"+tmp;
                else
                    dt=idMon_fr2.value.substring(0,6)+""+tmp;
            }
            //alert(dt);
            var fpath = System.RootURL + "/form/ag/bh/agbh00050_view2.aspx?group_pk=" + grdWork2.GetGridData(row,32) + "&dt=" +dt;
            var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:50;dialogHeight:30;dialogLeft:50;dialogTop:100;edge:sunken;scroll:yes;unadorned:yes;help:no');
        }    
    }        
}

function OnReport(n)
{
    if(n==1)
        var url=System.RootURL+'/reports/ag/bh/rpt_work_schedule.aspx?p_WG='+lstWG.value+'&p_from='+FromDT.value+'&p_to='+toDT.value;
    else    
        var url=System.RootURL+'/reports/ag/bh/rpt_monthly_schedule.aspx?p_WG='+lstWG2.value+'&p_month='+idWorkMon2.value;
    window.open(url);
}
function OnShowWorkShift()
{
    
    var fpath = System.RootURL + "/form/ag/bh/agbh00050_01.aspx?shift=" + 0; 
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:40;dialogHeight:15;dialogLeft:200;dialogTop:260;edge:sunken;scroll:yes;unadorned:yes;help:no');
       
}
function onSetGrid()
{
    var ctrl = grdWork.GetGridControl();
	for ( var i =  0 ; i < ctrl.SelectedRows ; i++ )
		{
			var row = ctrl.SelectedRow(i);
			if ( row > 0 )
			{		
				grdWork.SetGridText(row,5,lstHol.GetData());
			}		
		}
}
function getDaysInMonth(yyyymm) //xac dinh thang do co bao nhieu ngay
{
   // returns the last day of a given month
    var m,y,tmpDate,checkMonth,lastDay
	
	m = Number(yyyymm.substr(4,2))-1;
		if(m==-1)
			m=Number(yyyymm.substr(5,1))-1;

	y = Number(yyyymm.substr(0,4));
	tmpDate = new Date(y, m, 28);
	checkMonth = tmpDate.getMonth();
	lastDay = 27;

    while(lastDay <= 31){
        temp = tmpDate.setDate(lastDay + 1);
        if(checkMonth != tmpDate.getMonth())
            break;
        lastDay++
    }
    return lastDay;
}
function onHide_column()
{
    //xac dinh thang co bao nhieu ngay 
     grdWork2.ClearData();   
        for(var i=1;i<=31;i++)
            grdWork2.GetGridControl().ColHidden(i)=0
            
        var n=getDaysInMonth(idWorkMon2.value);
        for(var i=n+1;i<=31;i++)
            grdWork2.GetGridControl().ColHidden(i)=1
	
    datSunday.Call("SELECT");    
	OnChangeMon2();		 
}
function onPageActive()
{
    if(tabMain.GetCurrentPageNo()==1)
    {
        if(flag_open==0)
        {
            flag_open=1;
            idMon_fr2.SetEnable(0);
            idMon_to2.SetEnable(0);
            OnChangeMon2();
         }   
    }
}
function on_check()
{
    var r=event.row;
    var c=event.col;
    if(isNaN(grdWork2.GetGridData(event.row,event.col)))
    {
        alert("Incorrect number of shift.\nNhập số thự tự ca làm việc");
        //alert(value_before);
        grdWork2.SetGridText(r,c,value_before);
    }    
}
function on_save_before()
{
    value_before=grdWork2.GetGridData(event.row,event.col);
    //alert(value_before);
}
function on_click()
{
    col=event.col;
    row=event.row;
}
function OnChangeMon2()
{
	for(var i=col_f;i<=col_e;i++)
		    grdWork2.GetGridControl().ColHidden(i)=false;
	datGet_Period.Call();
	
}

function daysInMonth(month, year) {
    return new Date(year, month, 0).getDate();
}

</script>

<body>

<gw:data id="datWorkSchedule" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="1,2,3,4,5" function="HR_sel_80020004_sch_master_v2" procedure="HR_upd_80020004_sch_master_v2"> 
                <input bind="grdWork" >
                    <input bind="lstOrg" />
                    <input bind="FromDT" />
                    <input bind="toDT" />
                </input>
                <output  bind="grdWork" />
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datWorkSchedule_detail" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="1,2,4,5" function="HR_sel_80020004_sch_detail_v2" > 
                <input bind="grdDetail" >
                    <input bind="txtMaster_pk" />
                </input>
                <output  bind="grdDetail" />
            </dso> 
        </xml> 
</gw:data>
<!-------------------data control----------------------->
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="lstOrg" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>
<gw:data id="datWorkShift_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="HR_sp_sel_ws_by_org"  > 
                <input>
                    <input bind="lstOrg" />
                </input> 
                <output>
                    <output bind="lstWS" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="WorkSchedule" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_pro_80020004_sch_v2" > 
                <input>
                    <input bind="lstOrg" />
                    <input bind="lstWS" />
                    <input bind="FromDT" />
                    <input bind="toDT" />
                    <input bind="txtEmpID" />
					<input bind="txtFlag" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datWorkSchedule2" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35" function="HR_sel_800020004_mon_sch_v2" procedure="HR_upd_80020004_mon_sch_v2"> 
                <input bind="grdWork2" >
                    <input bind="lstOrg2" />
                    <input bind="idWorkMon2" />
                    <input bind="idMon_fr2" />
                    <input bind="idMon_to2" />
                </input>
                <output  bind="grdWork2" />
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datSunday" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="1" function="HR_sp_sel_sunday2"> 
                <input bind="grdWork3" >
                    <input bind="idWorkMon2" />
                     <input bind="idMon_fr2" />
                    <input bind="idMon_to2" />
                </input>
                <output  bind="grdWork3" />
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datGet_Period" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_get_sal_period_by_org_v2" > 
                <input >
                    <input bind="lstOrg2" />
                    <input bind="idWorkMon2" /> 
                    <input bind="idLst_period2" />
                </input>
                <output >
                    <output bind="idMon_fr2" /> 
                    <output bind="idMon_to2" /> 
                    <output bind="idnum_day2" />
                    <output bind="idClose_flag2" />  
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:tab id="tabMain"  border=1 style="width:100%;height:100%;" onpageactivate="onPageActive()"  > 
    <table name="Schedule" id="tab1" class="itable" style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
    <tr>
        <td>
	        <table style="width:100%;height:12%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
	            <tr style="height:6%;border:1">	
		            <td colspan=4 align=right style="width:8%;border:1" >Organization</td>
		            <td colspan=10 align=right style="width:20%;border:1">  <gw:list  id="lstOrg" value='ALL' maxlen = "100" styles='width:100%'onchange="datWorkShift_info.Call()" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data>
                        </gw:list></td>
                    <td colspan=2 align=right style="width:4%;border:1">From</td>
		            <td colspan=4 align=left style="width:8%;border:1"><gw:datebox id="FromDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
		            <td align=right style="width:2%;border:1">To</td>
		            <td colspan=4 align=left style="width:8%;border:1"><gw:datebox id="toDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
		            <td colspan=13 align=right style="width:26%;border:1">Emp ID</td>
		            <td colspan=3 align=left style="width:6%;border:1"><gw:textbox id="txtEmpID" maxlen = "9" styles="width:100%" onkeypress="" /></td>
		            <td colspan=3 align=right style="width:6%;border:1" >&nbsp;</td>
		            <td align=right style="width:2%;border:1"><gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="Search" onclick="OnSearch(1)" /></td>
		            <td align=right style="width:2%;border:1"><gw:imgBtn id="ibtnSave" alt="Save" img="save" text="Save" onclick="OnUpdate(1)" /></td>
		            <td align=right style="width:2%;border:1"><gw:imgBtn id="ibtnDelete" alt="Delete" img="delete" text="Delete" onclick="OnDelete()" /></td>
		            <td align=right style="width:2%;border:1"><gw:imgBtn id="ibtnUnDelete" alt="UnDelete" img="udelete" text="UnDelete" onclick="OnUndelete()" /></td>
		            <td align=right style="width:2%;border:1"><gw:imgBtn id="ibtnRpt" alt="Report" img="excel" text="Report" onclick="OnReport(1)" /></td>
		            
                </tr>	
                <tr style="height:6%">	
                    <td colspan=4 align=right style="border:1">Hol Type</td>
                    <td colspan=8 align=right style="border:1"><gw:list  id="lstHol" styles='width:100%' >
                                        <data><%=ESysLib.SetListDataSQL("SELECT A.CODE, A.CODE_NM   FROM TCO_ABCODE A,TCO_ABCODEGRP B WHERE B.ID = 'COAB0140'   AND A.TCO_ABCODEGRP_PK = B.PK AND A.DEL_IF = 0 AND B.DEL_IF = 0 union all select '','' from dual")%></data></gw:list>
                    </td>
                    <td colspan=2 align=right style="border:1"><gw:icon id="idBtnSet"  styles='width:90%' img="in"  text="Set"  onclick="onSetGrid()"/></td>
    	            <td align=right style="border:1">WS</td>	
		            <td colspan=20 align=right style="border:1"><gw:list  id="lstWS"  maxlen = "100" styles='width:100%' >
                                        <data><%=ESysLib.SetListDataSQL("SELECT pk,shift||'-'||remark FROM thr_work_shift a WHERE DEL_IF = 0 and use_yn='Y' and a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk)  order by start_time")%></data></gw:list>
                    </td>
		            <td colspan=2 align=right style="border:1"><gw:icon id="idBtnManual"  styles='width:90%' img="in"  text="Manu"  onclick="onProcess_schedule('MANUAL')"/></td>
		            <td colspan=2 align=right style="border:1"><gw:icon id="idBtnAuto"  styles='width:90%' img="in"  text="Auto"  onclick="onProcess_schedule('AUTO')"/></td>
		            <td colspan=2 align=right style="border:1"><gw:icon id="idBtnCancel"  styles='width:90%' img="in"  text="Del"  onclick="onProcess_schedule('DEL')"/></td>
		            <td colspan=2 align=right style="border:1"><gw:icon id="idBtnView"  styles='width:90%' img="in"  text="View"  onclick="onView(1)"/></td>
		            <td colspan=2 align=center style="border:1"><b style="color=#FF3300"><gw:label id="idInterval" text="" styles="width:100%" ></gw:label></b></td>
		            <td colspan=4 align=center style="border:1" ><b style="color=#FF00CC"><gw:label id="idRecord" text="0 record(s)" styles="width:100%" ></gw:label></b></td>
		            <td  align=right valign="bottom" style="border:1" ><img status="expand" id="imgMaster" alt="Close detail" src="../../../system/images/close_popup.gif" style="cursor:hand" onclick="OnToggle()"  /> </td>
                </tr>		
	        </table>
	        <table id="tbl" style="width:100%;height:88%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
		        <tr style="height:100%">
			        <td id="master" width="65%">
				        <gw:grid   
				        id="grdWork"  
				        header="Organization|Work DT|WS|_Wgrp_pk|_master_pk|Holiday Type|Day Type"   
				        format="0|4|0|1|0|2|0"  
				        aligns="0|0|1|1|0|0|0"  
				        defaults="||||||"  
				        editcol="1|0|1|0|0|1|0"  
				        widths="2000|1300|4500|0|0|1300"  
				        styles="width:100%; height:100%"   
				        sorting="T"   
				         oncellclick     = "show_detail()" />
			        </td>
			        <td id="detail" width="35%">
				        <gw:grid   
				        id="grdDetail"  
				        header="Emp ID|Full Name|Join Dt"   
				        format="0|0|4"  
				        aligns="0|0|0"  
				        defaults="||"  
				        editcol="0|0|0"  
				        widths="1000|2500|1000"  
				        styles="width:100%; height:100%"   
				        sorting="T"   
				        param="0,1,2" 
				        oncelldblclick     = "" />
			        </td>
		        </tr>	
	        </table>
	      </td>
	    </tr>    
    </table>
    <table name="Monthly Schedule" id="Tab2" class="itable" style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
        <tr>
            <td>
	            <table style="width:100%;height:12%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
	                <tr style="height:6%;border:0">	
		                <td colspan=1 align=right style="width:4%;border:0" >Organization </td>
		                <td colspan=2 align=right style="width:15%;border:0"><gw:list  id="lstOrg2" value=" " maxlen = "100" styles='width:100%'onchange="datWorkShift_info.Call()" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data>
                        </gw:list></td>
		                
		                <%--<td colspan=1 align=right style="width:8%;border:0" >Work Group</td>
		                <td colspan=2 align=right style="width:20%;border:0"><gw:list  id="lstWG2" value="ALL"  maxlen = "100" styles='width:100%' onchange="" >
                                <data>
                                    <%=ESysLib.SetListDataSQL("select a.pk,a.workgroup_nm from thr_work_group a where a.del_if=0")%>|ALL|Select All
                                </data>
                            </gw:list></td>--%>
		                <td align=right style="width:8%;border:0" ><b>Month Type</b></td>
	                    <td style="width:8%;border:0"><gw:list  id="idLst_period2" value='01' maxlen = "100" styles='width:100%' onchange="OnChangeMon2()">
                                <data>|01|By Period|02|By Month</data>
                            </gw:list>
                        </td>
                        <td align=right colspan=2 style="width:8%;border:0"><b>Work Mon</b></td>
		                <td align=left colspan=2 style="width:12%;border:0"><gw:datebox id="idWorkMon2"  maxlen = "10" type="month" styles='width:60%'lang="<%=Session("Lang")%>" onchange="onHide_column()" /></td>
		                 <td align=right style="width:8%;border:0"  >From</td>
		                <td align=left colspan=4  style="width:8%;border:0"  >
						    <gw:datebox id="idMon_fr2"  lang="<%=Session("Lang")%>" onchange="" />
					    </td>		
					    <td align=center style="width:2%;border:0" ><b>~</b></td>	
					    <td align=left style="width:8%;border:0" >
						    <gw:datebox id="idMon_to2"  lang="<%=Session("Lang")%>" onchange="" />
					    </td>		
		                
                        <td align=left style="width:2%;border:1">&nbsp;</td>               
		                <td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnSearch2" alt="Search" img="search" text="Search" onclick="OnSearch(2)" /></td>
		                <td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnSave2" alt="Save" img="save" text="Save" onclick="OnUpdate(2)" /></td>
		                <td align=right style="width:2%;border:1"><gw:imgBtn id="ibtnRpt2" alt="Report" img="excel" text="Report" onclick="OnReport(2)" /></td>
		                
                    </tr>	
                    <tr style="height:6%;border:0">	
		                 <td colspan=4 align=right <b style="border:0;color=#FF00CC">&nbsp;</td>            
                        <td colspan=4 align=right style="border:0"><a title="Click here to work shift information" onclick="OnShowWorkShift()" href="#tips" style="text-decoration : none; color=#0000FF">Shift Info</a></td>                
                        <td colspan=4 align=right style="border:0"><a title="Click here to view detail" onclick="onView(2)" href="#tips" style="text-decoration : none; color=#0000FF">View Detail</a></td>
                        <td colspan=11 align=right <b style="border:0;color=#FF00CC"><gw:label id="idRecord2" text="0 record(s)" styles="width:100%" ></gw:label></b></td>
		                
                    </tr>	
	             </table>
	             <table id="Table1" style="width:100%;height:88%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
		            <tr style="height:100%">
			            <td id="Td1" width="100%">
				            <gw:grid   
				            id="grdWork2"  
				            header="Group|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|_grp_pk|_w_mon|_from|_to"   
				            format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
				            aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
				            defaults="|||||||||||||||||||||||||||||||||||"  
				            editcol="0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0|0|0|0"  
				            widths="2500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|500|0|0|0|0"  
				            styles="width:100%; height:100%"   
				            sorting="T"   
				            onafteredit     = "on_check()" 
				            onKeyPressEdit    = "on_save_before()"
				            oncellclick       ="on_click()"    />
			            </td>
		            </tr>	
	            </table>
	          </td>
	     </tr> 
   </table>
</gw:tab>

	<gw:textbox id="txtResult" styles="display:none"/>
	<gw:textbox id="txtFlag" styles="display:none"/>
    <gw:textbox id="txtDeptData" styles="display:none"/>
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtGroupData" styles="display:none"/>
	<gw:textbox id="txtMaster_pk" styles="display:none"/>
	<gw:textbox id="idemp_pk" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
    <gw:textbox id="txtDept" styles="display:none"/>
    <gw:textbox id="txtdept_temp" styles="display:none"/>
    <gw:textbox id="iduser_pk" styles="display:none">
    
</gw:textbox>
    <gw:textbox id="idnum_day2" styles="display:none"/>
    <gw:textbox id="txtForm_ID" styles="display:none">
</gw:textbox>	<gw:textbox id="idClose_flag2" styles="display:none"/>
		<gw:textbox id="idResult2" styles="display:none"/>
    
    <gw:grid   
    id="grdWork3"  
    header="1"   
    format="0"  
    aligns="0"  
    defaults="|"  
    editcol="0"  
    widths="2500"  
    styles="width:100%; height:100%;display:none"   
    sorting="T"   
    />
</body>
</html>

