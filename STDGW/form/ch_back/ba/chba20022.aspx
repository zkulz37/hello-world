<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser(Session("APP_DBUSER"))%>

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
var check_init=0;

var c_confirm=0;
 c_org = 1
 c_wg = 2
 c_emp_id=3,
 c_fullname =4,
 c_ws=5,
 c_date_in=6,
 c_n1=7,
 c_in_time=8,
 c_date_out=9,
 c_n2=10,
 c_out_time=11,
 c_wt=12,
 c_ot=13,
 c_nt=14,
 c_nt2=15,
 c_ht=16,
 c_abs_code=17,
 c_abs_hour=18,
 c_work_dt=19,
 c_hol_type=20,
 c_no_scan=21,
 c_status=22,
  c_ot_plus=23,
 c_close=24,
 c_emp_pk=25
 
function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);	
     iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
	txtCompany_pk.text="<%=Session("COMPANY_PK")%>";
    user= "<%=session("USER_NAME")%>";
    menu_id.text=System.Menu.GetMenuID();
     var tmp;
     tmp="<%=ESysLib.SetGridColumnDataSQL("select a.CODE,a.CODE_NM from vhr_hr_code a where a.id='HR0003' and a.code<>'04' union SELECT NULL,'' FROM DUAL ") %>";
     grd_att.SetComboFormat(c_abs_code,tmp);
     
      lstOrg.value="ALL";
	  lstWG.value="ALL";
	  FromDT.SetEnable(0);
	  ToDT.SetEnable(0);
	  Month.SetEnable(0);
	  grd_att.GetGridControl().ColEditMask(c_in_time)="99:99";
	  grd_att.GetGridControl().ColEditMask(c_out_time)="99:99";	
	  grd_att.GetGridControl().FrozenCols =5;
	  grd_att.GetGridControl().ScrollTrack=true;
	  onSetEnable(0);
	  
	  
	grd_att.GetGridControl().ColHidden(c_date_in)=1;
	grd_att.GetGridControl().ColHidden(c_n1)=1;
	grd_att.GetGridControl().ColHidden(c_date_out)=1;
	grd_att.GetGridControl().ColHidden(c_n2)=1;

    auto_resize_column(grd_att,0,grd_att.cols-1,0);  

    ChangeColorItem(lstOrg.GetControl());
			
    datCheck_View.Call();
	

}

//-----------------------------------------------
 function ChangeColorItem(lstctl) 
 {
        var slevel1, slevel2, slevel3,slevel4;
        for (var i = 0; i < lstctl.options.length; i++)
        {
            slevel1 = lstctl.options.item(i).text.substr(0, 1);
            slevel2 = lstctl.options.item(i).text.substr(0, 3);
            slevel3 = lstctl.options.item(i).text.substr(0, 5);
            slevel4 = lstctl.options.item(i).text.substr(0, 7);
            if (slevel4 != ".......")
            {
                if(slevel3==".....")
                {
                    lstctl.options.item(i).style.color = "0066CC";
                }
                else  
                {
                    if (slevel2 == "...")
                    {
                        lstctl.options.item(i).style.color = "FF4500";
                    }
                    else
                    {
                        if (slevel1 == ".")
                            lstctl.options.item(i).style.color = "FF00FF";  //FF3333
                    }
                }                
            }
        }
    }

//---------------------------------------------------------------------------
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
//------------------------------------------------------------------------------------

function clear_Interval(obj)
{
	clearInterval(interval_time);
	obj.text="";
}
//------------------------------------------------------------------------------------

/*function OnShowPopup()
{
        var fpath = System.RootURL + "/form/ch/ae/chae00010_dept.aspx?";
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:60;dialogTop:200;edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {
             txtUpperDept.text=obj;
             datDeptData.Call();
        }
}
*/
function OnShowPopup()
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:25;dialogHeight:25;dialogLeft:10;dialogTop:240;edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {
        lstOrg.value=obj
        txtUpperDept.text=obj;
        onChange_org();
    }
    
}
//------------------------------------------------------------------------------------

//------------------------------------------------------------------------------------
function onSetEnable(n)
{
      chkSelectAll.SetEnable(n);
      chkConfirm.SetEnable(n);
      ibtnSave.SetEnable(n);
      ibtnDelete.SetEnable(n);
      ibtnUnDelete.SetEnable(n);
      chkSelectAll.value='F';
      chkConfirm.value='F';
}

//------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
    if(obj.id == "datCheck_View")
    {
        if(txtFlag_View.text == 'Y')
        {
            ibtnSave.style.display = "none";
            ibtnDelete.style.display = "none";
            ibtnUnDelete.style.display = "none";
        }
        
        if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	    {
            datUser_info.Call();     	    
	    }
        check_init =1;
    }
    else if (obj.id=="datAttendence_confirm")
       {
            clear_Interval(idInterval);
            idRecord.text=grd_att.rows-1 + " Record(s)."
            if(grd_att.rows>1)
            {
                var wt,ot,nt,ht,abs;
                wt=ot=nt=ht=abs=0;
                onSetEnable(1);
                for(var i=1;i<grd_att.rows;i++)
                {  if(grd_att.GetGridData(i,c_close)=="M")
                         grd_att.SetCellBgColor(i, c_confirm,i, c_close, 0x99FFFF );
                   if(grd_att.GetGridData(i,c_close)=="Y")      
                         grd_att.SetCellBgColor(i, c_confirm,i, c_close, 0xFFEEFF );
                   
                    
                    if(Trim(grd_att.GetGridData(i,c_hol_type))!="")
                    {
                        if(Trim(grd_att.GetGridData(i,c_hol_type))=="HOL")
                        {
                            grd_att.SetCellBgColor(i, c_ht,i, c_ht, 0x3366FF );
                            grd_att.SetCellBold(i,c_ht,i,c_ht,true);
                        }
                        else    
                        {
                            grd_att.SetCellBgColor(i, c_ht,i, c_ht, 0xCC9900 );
                            grd_att.SetCellBold(i,c_ht,i,c_ht,true);
                        }
                    }
                        
                } 
            }    
            else    
            {
                onSetEnable(0);
                idlbWtOtNtHt.text="";
            } 
            auto_resize_column(grd_att,0,grd_att.cols-1,0);   
                        
       }
       else if (obj.id=="datFind_Report")
       {                
            var url =System.RootURL + '/reports/ch/ba/'+txtReport_tmp.text+'?p_user=' + user + '&p_wg=' + lstWG.value + '&p_search_by=' + idSearch.value + '&p_search_temp=' + idtxtTmp.text + '&p_tco_org_pk=' + lstOrg.value  + '&p_from_date=' +  txtFrom.text +'&p_to_date=' + txtTo.text + '&p_work_shift=' + lstWS.value + '&p_date_type=' + opt_value + '&p_nation=' + lstNation.value + '&p_reg=' + lstReg.value + '&p_confirm=' + idConfirm.value+'&p_com='+txtCompany_pk.text;
            window.open(url);
       }    
       else if (obj.id=="datWorkGroup_info")
       {               
                lstWG.SetDataText(txtwg_tmp.text+'|ALL|Select All');
                lstWG.value='ALL';
            
                datWorkShift_info.Call();
       }
        else if (obj.id=="datWorkShift_info")
        {
            
            lstWS.SetDataText(txt_WS_temp.text+'|ALL|All Shift');
            lstWS.value='ALL';
			check_init=1;
           
        }
          else if (obj.id=="datUser_info")
          { 
             ChangeColorItem(lstOrg.GetControl());
			onChange_org();
          }
        
       
	   
}     
//---------------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
//------------------------------------------------------------------------------------

function onClickOption(n)
{   
    opt_value=n;
    switch(n)
    {
        case 1:
            DailyDT.SetEnable(1);
            FromDT.SetEnable(0);
	        ToDT.SetEnable(0);
	        Month.SetEnable(0);
	        break;
	    case 2:
	        DailyDT.SetEnable(0);
            FromDT.SetEnable(1);
	        ToDT.SetEnable(1);
	        Month.SetEnable(0);
	        break;   
	    case 3:
	        DailyDT.SetEnable(0);
            FromDT.SetEnable(0);
	        ToDT.SetEnable(0);
	        Month.SetEnable(1);
	        break;        
    }
}
//------------------------------------------------------------------------------------


//------------------------------------------------------------------------------------

function On_AfterEdit()
{
	var tmpIN,tmpOUT,tmpDT,ws,temp;
	cIdx=event.col;
	

    if(grd_att.GetGridData(event.row,c_status)=="1" && (grd_att.GetGridData(event.row,c_close)=="M"||grd_att.GetGridData(event.row,c_close)=="Y") )
	  {
        alert("You can't modify and save this record because salary period was closed! \nBạn không thể điều chỉnh và lưu thông tin của dòng dữ liệu này vì tháng lương đã đóng! ") ;
	      grd_att.SetGridText(event.row,c_status,"");
	      return;
	  }

     if(cIdx==c_confirm)
	{
	    grd_att.SetGridText(event.row,c_status,"1");
	}    



}
//------------------------------------------------------------------------------------

function OnSearch()
{
	if(check_init==1)
	{
		clear_Interval(idInterval);
		
		 switch(opt_value)
		{
			case 1:
			   txtFrom.text=DailyDT.value
			   txtTo.text=DailyDT.value
				break;
			case 2:
				txtFrom.text=FromDT.value
				txtTo.text=ToDT.value
				break;   
			case 3:
				txtFrom.text=Month.value+"01"
				txtTo.text=Month.value+"31"
				break;        
		}
		if((opt_value!=1)&&(lstOrg.value=="ALL")&&(lstWG.value=="ALL")&&(idtxtTmp.text==""))
		{
			if(confirm("It will take long time because you get overload data, do you want to continous?\nHệ thống dự báo dữ liệu quá nhiều bạn sẽ phải đợi trong 1 thời gian dài, bạn có muốn tiếp tục?"))
			{
				set_Interval(100);
				datAttendence_confirm.Call("SELECT");
			}    
		}   
		else 
		{
			set_Interval(100);
			datAttendence_confirm.Call("SELECT");
		}   
	}	
    
}
//------------------------------------------------------------------------------------
function OnUpdate()
{
    if(confirm("Do you want to save?\nBạn muốn save?"))
        datAttendence_confirm.Call();
}

//-----------------------------------------------------------------------------------
function OnDelete()
{
    var ctrl=grd_att.GetGridControl();
    grd_att.DeleteRow();
    for(var i=1;i<=ctrl.SelectedRows;i++)
       grd_att.SetGridText(ctrl.SelectedRow(i-1),c_status,"1");
    
    
}
//------------------------------------------------------------------------------------

function OnUndelete()
{
    var ctrl=grd_att.GetGridControl();
    grd_att.UnDeleteRow();
    for(var i=1;i<=ctrl.SelectedRows;i++)
       grd_att.SetGridText(ctrl.SelectedRow(i-1),c_status,"0");
}
//------------------------------------------------------------------------------------
function OnSelectAll(obj_checkbox,obj_grd)
{	
    var ctrl=obj_grd.GetGridControl();
    if( obj_checkbox.GetData()=='T')
    {
        for(var i=1;i<ctrl.rows;i++)
            ctrl.IsSelected(i)="True";
    }
	else
	{
        for(var i=1;i<ctrl.rows;i++)
            ctrl.IsSelected(i)="False";
    }        

}

function OnConfirm()
{	
    var ctrl=grd_att.GetGridControl();
    var tmp=chkConfirm.GetData();
    if(tmp=='T')
        tmp='-1'
    else
        tmp='0' 
    
    for(var i=1;i<=ctrl.SelectedRows;i++)
    {
       grd_att.SetGridText(ctrl.SelectedRow(i-1),c_confirm,tmp);     
       grd_att.SetGridText(ctrl.SelectedRow(i-1),c_status,"1");
    }

}

function On_click()
{
    var ws;
	dt_tmp=grd_att.GetGridData(event.row,event.col)//luu tru gia tri vua click
	ws=grd_att.GetGridData(event.row,c_ws)
	lstWS_temp.value=ws;
	idlbWS.text=lstWS_temp.GetText();
	
}

//---------------------------------------------------------------------------

//---------------------------------------------------------------------------
function get_random(num)
{
    var ranNum= Math.floor(Math.random()*num);//tra ra so nguyen
    return ranNum;
}
//---------------------------------------------------------------

//---------------------------------------------------
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
//---------------------------------
function OnReport()
{
    switch(opt_value)
    {
        case 1:
           txtFrom.text=DailyDT.value
           txtTo.text=DailyDT.value
	        break;
	    case 2:
	        txtFrom.text=FromDT.value
            txtTo.text=ToDT.value
	        break;   
	    case 3:
	        txtFrom.text=Month.value+"01"
            txtTo.text=Month.value+"31"
	        break;        
    }
    
    txtReport_tmp.text="rpt_attendence_absence_n2.aspx";        
    datFind_Report.Call();                  
}
function onChange_org()
{
    //if(lstOrg.value!='ALL')
        datWorkGroup_info.Call();
}
</script>

<body>
<!------------------------------------------>
<gw:data id="datCheck_View" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="process" procedure="HR_sp_pro_check_view"  > 
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
<gw:data id="datWorkShift_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="HR_sp_sel_ws_role"  > 
                <input>
                    <input bind="lstOrg" />
                </input> 
                <output>
                    <output bind="txt_WS_temp" />
                </output>
            </dso> 
        </xml> 
</gw:data>

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
<gw:data id="datAttendence_confirm" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,19,22,25" function="HR_SEL_10020022_CONFIRM" procedure="HR_UPD_10020022_CONFIRM"> 
                <input bind="grd_att" >
                    <input bind="lstOrg" />
                    <input bind="lstWG" />
                    <input bind="lstWS" />
                    <input bind="txtFrom" />
                    <input bind="txtTo" />
                    <input bind="idSearch" />
                    <input bind="idtxtTmp" />
                    <input bind="lstNation" />
                    <input bind="lstReg" />
                    <input bind="idConfirm" />
                </input>
                <output  bind="grd_att" />
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>
<gw:data id="datFind_Report" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sp_pro_find_report_2" > 
                <input>
                    <input bind="txtReport_tmp" /> 
					<input bind="txtCompany_pk" /> 
                </input> 
                <output>
                    <output bind="txtReport_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------------>
<gw:data id="datWorkGroup_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_sel_wg_role"  > 
                <input>
                    <input bind="lstOrg" />
                </input> 
                <output>
                    <output bind="txtwg_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>


<table style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
	<table style="width:100%;height:23%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
  	
	<tr style="height:7%;border:1">	
		<td colspan=3 align=right style="width:6%;border:1;color=Black" ><input type="radio" name="option_P" value="1" checked onclick="onClickOption(1)" ><font>Daily</font></td>
		<td colspan=5 align=left style="width:10%;border:1"><gw:datebox id="DailyDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
		<td colspan=2 align=right style="width:4%;border:1"></td>
		<td colspan=5 align=right style="width:10%;border:0"><input type="radio" name="option_P" value="2" onclick="onClickOption(2)" ><font size=3>From</font></td>
		<td colspan=5 align=right style="width:10%;border:0"><gw:datebox id="FromDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
		<td colspan=3 align=right style="width:6%;border:0"><font>To</font> </td>
		<td colspan=5 align=right style="width:10%;border:0"><gw:datebox id="ToDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
		<td colspan=2 align=right style="width:4%;border:0"></td>
        <td align=right colspan=5 style="width:10%;border:0"><input type="radio" name="option_P" value="3" onclick="onClickOption(3)" ><font>Month</font> </td>
		<td align=left colspan=5 style="width:10%;border:0"><gw:datebox id="Month"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" type=month /></td>
		<td colspan=3 align=right valign="bottom" style="width:6%;border:0" ></td>
		<td align=right style="width:2%;border:0"><gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="Search" onclick="OnSearch()" /></td>
        <td  align=right valign="bottom" style="width:2%;border:0" ></td>
		<td align=right style="width:2%;border:0"><gw:imgBtn id="ibtnSave" alt="Save" img="save" text="Save" onclick="OnUpdate()" /></td>
        <td  align=right valign="bottom" style="width:2%;border:0" ></td>
		<td align=right style="width:2%;border:0"><gw:imgBtn id="ibtnDelete" alt="Delete" img="delete" text="Delete" onclick="OnDelete()" /></td>
        <td  align=right valign="bottom" style="width:2%;border:0" ></td>
		<td align=right style="width:2%;border:0"><gw:imgBtn id="ibtnUnDelete" alt="UnDelete" img="udelete" text="UnDelete" onclick="OnUndelete()" /></td>
    </tr>	
    <tr style="height:7%;border:1">	
		<td colspan=3 align=right style="width:6%;border:0" ><a title="Click here to show department" onclick="OnShowPopup()" href="#tips" style="text-decoration : none; color=#0000FF">Organization</a></td>
		<td colspan=9 align=right style="width:18%;border:0"><gw:list  id="lstOrg"  maxlen = "100" styles='width:100%' onchange="onChange_org()" >
                <data>
                    <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                </data>
            </gw:list>
        </td>
		<td colspan=10 align=right style="width:20%;border:0"><gw:list  id="lstWG"  maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("select pk, workgroup_nm from thr_work_group where del_if=0")%>|ALL|W.Group-Select All</data></gw:list>
        </td>
        <td colspan=10 align=right style="width:20%;border:0"><gw:list  id="lstWS" value="ALL"  maxlen = "100" styles='width:100%' onchange="">
                            <data><%=ESysLib.SetListDataSQL("SELECT pk,shift||'-'||remark FROM thr_work_shift WHERE DEL_IF = 0 and use_yn='Y'  order by shift")%>|ALL|All W-Shift</data></gw:list>
        </td>
        
        <td colspan=8 align=right style="width:16%;border:0"><gw:list  id="lstReg"  maxlen = "100" styles='width:100%' >
                            <data>|ALL|Reg - Select All|1|Reg Allowance</data></gw:list>
        </td>
         <td align=right colspan=7 style="width:14%;border:0"><gw:list  id="idConfirm" value="ALL" styles='width:100%' onChange="">
                <data>|Y|Y|N|N|ALL|Confirm - All</data></gw:list>
         </td>
         <td colspan=3 align=right style="width:6%;border:0"><gw:imgBtn id="ibtnRpt" alt="Report" img="excel" text="Report" onclick="OnReport()" /></td>
    </tr>	
    <tr style="height:7%">	
        <td colspan=3 align=right style="width:6%;border:0">Nation</td>	
        <td colspan=4 align=right style="width:8%;border:0">
            <gw:list id='lstNation' value='01'>
                <data>
                    <%=ESysLib.SetListDataSQL("select code, code_nm from vhr_hr_code v where v.ID='HR0009'")%>|ALL|Select All
                </data>
            </gw:list>
        </td>
		<td colspan=5 align=right style="width:10%;border:0"><gw:list  id="idSearch" value="1" styles="width:95%" onChange="">
                <data>|1|Emp ID|2|Card ID|3|Name</data></gw:list></td>
		<td colspan=5 align=right style="width:10%;border:0"><gw:textbox id="idtxtTmp" maxlen = "20" styles="width:97%" onenterkey="OnSearch()" /></td>
		<td align=center style="width:2%;border:0"><gw:label id="idInterval" text="" styles="width:100%" ></gw:label></td>
        <td colspan=23 align=right style="width:46%;border:0">&nbsp;</td>
		<td colspan=7 align=center style="width:14%;border:0"><gw:label id="idRecord" text="0 record(s)" styles="width:100%" ></gw:label></td>
		
    </tr>	
    <tr style="height:2%;border:inherit">	
        <td colspan=3 align=right style="width:6%;border:1" ><gw:checkbox id="chkSelectAll" value="F" onclick="OnSelectAll(chkSelectAll,grd_att)" ></gw:checkbox ></td>
        <td colspan=5 align=left style="width:10%;border:1" >Select All</td>
        <td colspan=3 align=right style="width:6%;border:1" ><gw:checkbox id="chkConfirm" value="F" onclick="OnConfirm()" ></gw:checkbox ></td>
        <td colspan=5 align=left style="width:10%;border:1" >Confirm</td>
        <td colspan=7 align=center style="width:14%;border:1" style="color=#FF00CC"><gw:label id="idlbWtOtNtHt" styles="width:100%;"></gw:label></td>
		<td colspan=27 align=center style="width:54%;border:0" ><gw:label id="idlbWS" styles="width:100%;color:red"></gw:label></b></td>
    </tr>	
	</table>
	<table id="tbl" style="width:100%;height:77%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
		<tr style="height:100%">
			<td id="master" width="100%">
				<gw:grid
					id="grd_att"
					header="Confirm|ORGANIZATION|WGROUP|EMP_ID|FULL_NM|W_S|DATE_IN|N|IN TIME|DATE_OUT|N|OUT TIME|WT|OT|NT|NT2|HT|ABSENCE CODE|H|WorkDT|_Hol_type|_No Scan|_S|_OT Plus|_close|_emp_pk|Note"
					format="3|0|0|0|0|0|4|3|0|4|3|0|0|0|0|0|0|0|0|4|0|0|0|0|0|0|0"
					aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
					defaults="|||||||||||||||||||||||||||"
					editcol="1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
					widths="0|1500|1500|1000|2500|500|1200|300|1000|1200|300|1000|500|500|500|500|500|1500|300|600|1500|0|0|500|0|0|1000"
					styles="width:100%;height:100%"
					sorting="T"
					onafteredit="On_AfterEdit()"
                    oncellclick="On_AfterEdit()"
					acceptNullDate="T"
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
	<gw:textbox id="txtCompany_pk" styles="display:none"/>
    <gw:textbox id="txtwg_tmp" styles="display:none"/>
    <gw:list  id="lstWS_temp" value="ALL"  maxlen = "100" styles='display:none' >
                            <data><%=ESysLib.SetListDataSQL("SELECT shift,shift||'-'||remark FROM thr_work_shift WHERE DEL_IF = 0 and use_yn='Y'  order by shift")%>|ALL|WS-Select All</data></gw:list>
    <gw:textbox id="txtReport_tmp" styles="display:none"/>             
    <gw:textbox id="txt_WS_temp" styles="display:none"/>             
    <gw:textbox id="menu_id" text="" styles="display:none"  />
    <gw:textbox id="txtFlag_View" text="" styles="display:none"  />               
	
</body>
</html>

