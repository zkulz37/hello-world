<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var emp_pk_list;
var startTime,interval_time;
var dt_tmp;
var opt_value=1;
var user;
var v_language = "<%=Session("SESSION_LANG")%>";
var check_init=0;
//_EMP_PK|Approval YN|ORGANIZATION|WGROUP|EMP_ID|FULL_NM|W_S|Work Date|IN TIME|OUT TIME|OT_R|NT_R|NT2_R|HT_R|OT|NT|NT2|HT|OT_A|NT_A|NT2_A|HT_A|Note|_S
var emp_pk = 0;
var approval_yn = 1;
var org = 2;
var wg = 3;
var empid = 4;
var fullname = 5;
var ws = 6;
var workdate = 7;
var intime = 8;
var outtime = 9;
var ot_r = 10;
var nt_r = 11;
var nt2_r = 12;
var ht_r = 13;
var ot = 14;
var nt = 15;
var nt2 = 16;
var ht = 17;
var ot_a = 18;
var nt_a = 19;
var nt2_a = 20;
var ht_a = 21;
var note = 22;
var p_status = 23;
var p_hol_type = 24;
var p_att_confirm = 25;

 
function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);	
        iduser_pk.text = "<%=session("USER_PK")%>";
        txtHr_level.text= "<%=session("HR_LEVEL")%>";
        txtCompany_pk.text = "<%=Session("COMPANY_PK")%>";
        idDBUSR.text = "<%=session("APP_DBUSER")%>";
        user= "<%=session("USER_ID")%>";
        menu_id.text=System.Menu.GetMenuID();
       
     
        lstOrg.value="ALL";
        lstWG.value="ALL";
        FromDT.SetEnable(0);
        ToDT.SetEnable(0);
        Month.SetEnable(0);
        onSetEnable(0);
        grd_att.GetGridControl().FrozenCols =5;
        grd_att.GetGridControl().ScrollTrack=true;
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
function onSetEnable(n)
{
      chkSelectAll.SetEnable(n);
      ibtnSave.SetEnable(n);
      ibtnDelete.SetEnable(n);
      ibtnUnDelete.SetEnable(n);
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
    else if (obj.id=="datOT_Confirm")
       {
            clear_Interval(idInterval);
            idRecord.text=grd_att.rows-1 + " Record(s)."
            if (grd_att.rows > 1) {
                SetColColor();
                onSetEnable(1);//true
                auto_resize_column(grd_att, 0, grd_att.cols - 1, 0);
            }                        
       }
       else if (obj.id=="datFind_Report")
       {                
            var url =System.RootURL + '/reports/ch/ba/'+txtReport_tmp.text+'?p_user=' + user + '&p_wg=' + lstWG.value + '&p_search_by=' + idSearch.value + '&p_search_temp=' + idtxtTmp.text + '&p_tco_org_pk=' + lstOrg.value  + '&p_from_date=' +  txtFrom.text +'&p_to_date=' + txtTo.text + '&p_work_shift=' + lstWS.value + '&p_date_type=' + opt_value + '&p_nation=' + lstNation.value + '&p_com='+txtCompany_pk.text;           
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
        
          else if (obj.id == "datGetData")
          {
              if (txtResult.text == '1') {
                  alert("Get data success !");
                  SetColColor();
                  datOT_Confirm.Call("SELECT");
              }
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
function On_click()
{
    var workshift;
    dt_tmp=grd_att.GetGridData(event.row,event.col)//luu tru gia tri vua click
    workshift = grd_att.GetGridData(event.row, ws)
    lstWS_temp.value = workshift;
    idlbWS.text=lstWS_temp.GetText();
	
}

    //---------------------------------------------------------------------------------------
function Confirm_Cell() {
    
    Calculate_OT();
}

    //----------------------function set column color-------------------------------
function SetColColor() {
    grd_att.SetCellBgColor(1, ot_r, grd_att.rows - 1, ot_r, 0xFFEEFF);
    grd_att.SetCellBgColor(1, nt_r, grd_att.rows - 1, nt_r, 0xFFEEFF);
    grd_att.SetCellBgColor(1, nt2_r, grd_att.rows - 1, nt2_r, 0xFFEEFF);
    grd_att.SetCellBgColor(1, ht_r, grd_att.rows - 1, ht_r, 0xFFEEFF);

    grd_att.SetCellBgColor(1, ot_a, grd_att.rows - 1, ot_a, 0xCC9900);
    grd_att.SetCellBgColor(1, nt_a, grd_att.rows - 1, nt_a, 0xCC9900);
    grd_att.SetCellBgColor(1, nt2_a, grd_att.rows - 1, nt2_a, 0xCC9900);
    grd_att.SetCellBgColor(1, ht_a, grd_att.rows - 1, ht_a, 0xCC9900);

    
    grd_att.SetCellBgColor(1, approval_yn, grd_att.rows - 1, approval_yn, 0xFFEEFF);
    grd_att.SetCellBgColor(1, note, grd_att.rows - 1, note, 0xFFEEFF);
}
//------------------------------------------------------------------------------------

function On_AfterEdit()
{
    var cTdx, work_shift;
    
    cIdx = event.col;
	if(dt_tmp!=grd_att.GetGridData(event.row,cIdx))
	{
		/*if(grd_att.GetGridData(event.row,p_att_confirm)=="Y")
		{
			//grd_att.SetGridText(event.row, cIdx, dt_tmp);	
			alert("Attendance already confirmed, you can not modify");
		}
		else*/
		grd_att.SetGridText(event.row, p_status, "1");
	   
	}  
}
function OnSearch()
{
	if(check_init==1)
	{
		clear_Interval(idInterval);
		 var arr = txt_WS_temp.text.replace("DATA|",'').split("|");
		   var s="";
		   var t=0;
			   for(var i=0;i< (arr.length+1)/2-1;i++)
				{
					s = s +"#" + arr[t] + ";" + arr[t+1].split('-')[0]+"|";
					t=t+2;
				}
				grd_att.SetComboFormat(ws,s  );
		
		
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
				datOT_Confirm.Call("SELECT");
			}    
		}   
		else 
		{			
			datOT_Confirm.Call("SELECT");
		}   
	}	
    
}
//------------------------------------------------------------------------------------
function OnUpdate()
{
    if(confirm("Do you want to save?\nBạn muốn save?"))
        datOT_Confirm.Call();
}

//-----------------------------------------------------------------------------------
function OnDelete()
{
    var ctrl=grd_att.GetGridControl();
    grd_att.DeleteRow();
    for(var i=1;i<=ctrl.SelectedRows;i++)
       grd_att.SetGridText(ctrl.SelectedRow(i-1),p_status,"1");
    
    
}
//------------------------------------------------------------------------------------

function OnUndelete()
{
    var ctrl=grd_att.GetGridControl();
    grd_att.UnDeleteRow();
    for(var i=1;i<=ctrl.SelectedRows;i++)
       grd_att.SetGridText(ctrl.SelectedRow(i-1),p_status,"0");
}

//---------------------------------------------------------------


//show sample file
function OnSampleFile()
{
    var url = System.RootURL + '/reports/ch/ba/rpt_ot_confirm_template.aspx';
    window.open(url);
}

function OnChangeShift()
{
    var ctrl,i
	ctrl=grd_att.GetGridControl();
	if(ctrl.SelectedRows>1 && lstWS.value!="ALL")
		for(i=0;i<ctrl.SelectedRows;i++)
    		grd_att.SetGridText(ctrl.SelectedRow(i),ws,lstWS.value)
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
    //alert(opt_value);
    txtReport_tmp.text="rpt_ot_confirm_yujin.aspx";                    
    datFind_Report.Call();                  
}

//------------------------------------------------------------------------------------
function OnSelectAll(obj_checkbox, obj_grd) {
    var ctrl = obj_grd.GetGridControl();
    if (obj_checkbox.GetData() == 'T') {
        for (var i = 1; i < ctrl.rows; i++)
            ctrl.IsSelected(i) = "True";
    }
    else {
        for (var i = 1; i < ctrl.rows; i++)
            ctrl.IsSelected(i) = "False";
    }

}
//-------------------------------------------------------------------------
function OnConfirm() {    
    var ctrl = grd_att.GetGridControl();
    var tmp = chkConfirm.GetData();
    if (tmp == 'T')
        tmp = '-1'
    else
        tmp = '0'

    for (var i = 1; i <= ctrl.SelectedRows; i++) {
            grd_att.SetGridText(ctrl.SelectedRow(i - 1), approval_yn, tmp);
            grd_att.SetGridText(ctrl.SelectedRow(i - 1), p_status, "1");                  
    }
    Calculate_OT();
}
    //---------------------------------
function Calculate_OT()
{
    var ctrl = grd_att.GetGridControl();
    for (var i = 1; i <= ctrl.SelectedRows; i++)
    {
        if (grd_att.GetGridData(ctrl.SelectedRow(i - 1), approval_yn) == '-1')
        {
            //OT
            if (grd_att.GetGridData(ctrl.SelectedRow(i - 1), ot_r) >= grd_att.GetGridData(ctrl.SelectedRow(i - 1), ot)) {
                grd_att.SetGridText(ctrl.SelectedRow(i - 1), ot_a, grd_att.GetGridData(ctrl.SelectedRow(i - 1), ot));
            }
            else {
                grd_att.SetGridText(ctrl.SelectedRow(i - 1), ot_a, grd_att.GetGridData(ctrl.SelectedRow(i - 1), ot_r));
            }

            //NT
            if (grd_att.GetGridData(ctrl.SelectedRow(i - 1), nt_r) >= grd_att.GetGridData(ctrl.SelectedRow(i - 1), nt)) {
                grd_att.SetGridText(ctrl.SelectedRow(i - 1), nt_a, grd_att.GetGridData(ctrl.SelectedRow(i - 1), nt));
            }
            else {
                grd_att.SetGridText(ctrl.SelectedRow(i - 1), nt_a, grd_att.GetGridData(ctrl.SelectedRow(i - 1), nt_r));
            }

            //NT2
            if (grd_att.GetGridData(ctrl.SelectedRow(i - 1), nt2_r) >= grd_att.GetGridData(ctrl.SelectedRow(i - 1), nt2)) {
                grd_att.SetGridText(ctrl.SelectedRow(i - 1), nt2_a, grd_att.GetGridData(ctrl.SelectedRow(i - 1), nt2));
            }
            else {
                grd_att.SetGridText(ctrl.SelectedRow(i - 1), nt2_a, grd_att.GetGridData(ctrl.SelectedRow(i - 1), nt2_r));
            }

            //HT
            if (grd_att.GetGridData(ctrl.SelectedRow(i - 1), ht_r) >= grd_att.GetGridData(ctrl.SelectedRow(i - 1), ht)) {
                grd_att.SetGridText(ctrl.SelectedRow(i - 1), ht_a, grd_att.GetGridData(ctrl.SelectedRow(i - 1), ht));
            }
            else {
                grd_att.SetGridText(ctrl.SelectedRow(i - 1), ht_a, grd_att.GetGridData(ctrl.SelectedRow(i - 1), ht_r));
            }
        }
        else
        {
            grd_att.SetGridText(ctrl.SelectedRow(i - 1), ot_a, '');
            grd_att.SetGridText(ctrl.SelectedRow(i - 1), nt_a, '');
            grd_att.SetGridText(ctrl.SelectedRow(i - 1), nt2_a, '');
            grd_att.SetGridText(ctrl.SelectedRow(i - 1), ht_a, '');     
        }
    }
}
function onChange_org()
{
    //if(lstOrg.value!='ALL')
        datWorkGroup_info.Call();
}
    //-----------------------------------function to get data real ot, nt nt2, ht-----------------------------
function OnGetData()
{
    confirm("Do you want to get data ?")
    {
        datGetData.Call();
    }

}
    //-----------------------------------function to import data from excel .xls------------------------------
function OnImport()
{
    var currentTime = new Date();
    txtSequence.text = currentTime.getTime();

    //argument fixed table_name, procedure, procedure_file, p_type ko dung nhung van phai truyen vao
    var url = System.RootURL + '/system/binary/ReadExcel.aspx?import_seq=' + txtSequence.text +'&p_type=1'+ '&table_name=TES_FILEOBJECT' + '&procedure=GASP.SP_INSERT_IMAGE' + '&procedure_file=' + idDBUSR.text + '.SP_UPD_OT_CONFIRM_EXCELL' + '&p_err_cont=Y';
    //alert(url);
    txtRecord.text = System.OpenModal(url, 415, 100, "unadorned:on ; center:yes; edge:sunken ; resizable:yes;status:yes;");

    if (txtRecord.text != 'undefined') {
        alert("Imported : " + txtRecord.text + " record(s)");
    }

    datOT_Confirm.Call("SELECT");
}


</script>

<body>
<!------------------------------------------>
<gw:data id="datGetData" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="process" procedure="HR_SP_UPD_GET_EXTRA_TIME"> 
                <input>
                    <input bind="txtFrom" />
                    <input bind="txtTo" />  
                </input>
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datCheck_View" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="process" procedure="HR_SP_PRO_CHECK_VIEW"  > 
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
<!--_EMP_PK(0)|Approval YN(1)|ORGANIZATION(2)|WGROUP(3)|EMP_ID(4)|FULL_NM(5)|W_S(6)|Work Date(7)|IN TIME(8)|OUT TIME(9)|OT_R(10)|NT_R(11)|NT2_R(12)|HT_R(13)|OT(14)|NT(15)|NT2(16)|HT(17)|
    OT_A(18)|NT_A(19)|NT2_A(20)|HT_A(21)|Note(22)|_S(23)-->
<gw:data id="datOT_Confirm" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,1,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25" function="HR_SEL_10020021_OT_CONFIRM" procedure="HR_UPD_10020021_OT_CONFIRM"> 
                <input bind="grd_att" >
                    <input bind="lstOrg" />
                    <input bind="lstWG" />
                    <input bind="lstWS" />
                    <input bind="txtFrom" />
                    <input bind="txtTo" />
                    <input bind="idSearch" />
                    <input bind="idtxtTmp" />
                    <input bind="lstNation" />  
                    <input bind="txtSequence" /> 
                    <input bind="lstApprove" />                 
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
		<td colspan=2 align=right style="width:10%;border:1;color=Black" ><input type="radio" name="option_P" value="1" checked onclick="onClickOption(1)" ><font>Daily</font></td>
		<td colspan=2 align=left style="width:10%;border:1"><gw:datebox id="DailyDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
		<td align=right style="width:5%;border:1"></td>
		<td colspan=1 align=right style="width:8%;border:0"><input type="radio" name="option_P" value="2" onclick="onClickOption(2)" ><font size=3>From</font></td>
		<td colspan=1 align=left style="width:5%;border:0"><gw:datebox id="FromDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
		<td align=right style="width:5%;border:0"><font>To</font> </td>
		<td colspan=2 align=left style="width:10%;border:0"><gw:datebox id="ToDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
		<td align=right style="width:5%;border:0"></td>
        <td align=right colspan=2 style="width:10%;border:0"><input type="radio" name="option_P" value="3" onclick="onClickOption(3)" ><font>Month</font> </td>
		<td align=left colspan=1 style="width:10%;border:0"><gw:datebox id="Month"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" type=month /></td>
		<td  align=center valign="bottom" style="width:3%;border:0" >
            <gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="Search" onclick="OnSearch()" />
		</td>
		<td align=center style="width:3%;border:0"><gw:imgBtn id="ibtnSave" alt="Save" img="save" text="Save" onclick="OnUpdate()" /></td>
		<td align=center style="width:3%;border:0"><gw:imgBtn id="ibtnDelete" alt="Delete" img="delete" text="Delete" onclick="OnDelete()" /></td>
		<td align=center style="width:3%;border:0"><gw:imgBtn id="ibtnUnDelete" alt="UnDelete" img="udelete" text="UnDelete" onclick="OnUndelete()" /></td>
		<td align=right style="width:3%;border:0"></td>
        
    </tr>	
    <tr style="height:7%;border:1">	
		<td align=right style="width:5%;border:0" ><a title="Click here to show department" onclick="OnShowPopup()" href="#tips" style="text-decoration : none; color=#0000FF">Organization</a></td>
		<td colspan=3 align=right style="width:15%;border:0"><gw:list  id="lstOrg"  maxlen = "100" styles='width:100%' onchange="onChange_org()" >
                <data>
                    <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                </data>
            </gw:list>
        </td>
		<td align=right style="width:5%;border:0">Group</td>
		<td colspan=3 align=right style="width:15%;border:0"><gw:list  id="lstWG"  maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("select pk, workgroup_nm from thr_work_group where del_if=0")%>|ALL|Select All</data></gw:list>
        </td>
        <td colspan=4 align=right style="width:20%;border:0"><gw:list  id="lstWS" value="ALL"  maxlen = "100" styles='width:100%' onchange="OnChangeShift()">
                            <data><%=ESysLib.SetListDataSQL("SELECT pk,shift||'-'||remark FROM thr_work_shift WHERE DEL_IF = 0 and use_yn='Y'  order by shift")%>|ALL|All Shift</data></gw:list>
        </td>
        <td  colspan=1 align=right style="width:5%;border:0">
            
        </td>
        <td colspan=1 align=right style="width:10%;border:0">
            
        </td>
        <td align=right colspan=2 style="width:6%;border:0">
            <gw:imgBtn id="ibtnRpt" alt="Report" img="excel" text="Report" onclick="OnReport()" />
        </td>
    </tr>	
    <tr style="height:7%">	
        <td colspan=1 align=right style="width:5%;border:0">Nation</td>	
        <td colspan=1 align=right style="width:10%;border:0">
            <gw:list id='lstNation' value='01'>
                <data>
                    <%=ESysLib.SetListDataSQL("select code, code_nm from vhr_hr_code v where v.ID='HR0009'")%>|ALL|Select All
                </data>
            </gw:list>
        </td>
    	<%--<td colspan=1 style="width:10%;border:0"></td>--%>	
        <%--<td colspan=1 style="width:15%;border:0"></td>--%>
		<td style="width:5%;border:0" align="right">
            <gw:icon id="idBtnImport"  styles='width:90%' img="in"  text="Import data"  onclick="OnImport()"/>
		</td>
		<td align="center" colspan="2" style="font-weight:bold;width:100%;color:black;white-space:nowrap; border:0">            
            <gw:imgBtn id="ibtnSampleRpt" alt="Sample file" img="excel" text="Report" onclick="OnSampleFile()" />
		</td>
		<td align="left" style="width:5%;border:0">
            <gw:icon id="idBtnGet"  styles='width:90%' img="in"  text="Get data"  onclick="OnGetData()"/>
		</td>		
        <td style="border:0;">
            <gw:list  id="lstApprove" value="ALL" styles="width:100%" onChange="">
            <data>|Y|Yes|N|No|ALL|Approve YN - Select All</data></gw:list>
        </td>
		<td colspan="1" align=right style="border:0">           
            Search
        </td>
		<td colspan="2" align=left style="width:5%;border:0">
            <gw:list  id="idSearch" value="1" styles="width:95%" onChange="">
            <data>|1|Emp ID|2|Card ID|3|Name</data></gw:list>
		</td>
		<td colspan=3 align=right style="width:10%;border:0"><gw:textbox id="idtxtTmp" maxlen = "20" styles="width:100%" onenterkey="OnSearch()" /></td>
		<%--<td colspan=1 align=right style="width:6%;border:0"></td>--%>
		<td align=center style="width:1%;border:0"><gw:label id="idInterval" text="" styles="width:100%" ></gw:label></td>
		<td colspan=5 align=center style="width:15%;border:0;">
            <gw:label id="idRecord" text="0 record(s)" styles="width:100%;color:green;font-weight:bold;" ></gw:label>
		</td>
		
    </tr>	
    <tr style="height:2%;border:inherit">	
        <td align=right style="width:5%;border:1" ><gw:checkbox id="chkSelectAll" value="F" onclick="OnSelectAll(chkSelectAll,grd_att)" ></gw:checkbox ></td>
        <td colspan=2 align=left style="width:10%;border:1" >Select All</td>
        <td colspan=3 align=left style="width:10%;border:1">
            <gw:checkbox id="chkConfirm" value="F" onclick="OnConfirm()"></gw:checkbox>
            <label>Confirm</label>
        </td>
        <%--<td align=left style="width:5%;border:0"></td>--%>
        <td align=left style="width:15%;border:0;white-space:nowrap"></td>
        <td align=center valign=middle style="width:5%;border:inherit" ></td>
		<td align=right style="width:5%;border:0" >
            
		</td>
		<td align=left style="width:5%;border:0" ></gw:checkbox ></td>
		<td colspan=9 align=center style="width:40%;border:0" ><gw:label id="idlbWS" styles="width:100%;color:red"></gw:label></b></td>
    </tr>	
	</table>
	<table id="tbl" style="width:100%;height:77%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
		<tr style="height:100%">
            <!--EMP_PK(0)|Approval YN(1)|ORGANIZATION(2)|WGROUP(3)|EMP_ID(4)|FULL_NM(5)|W_S(6)|Work Date(7)|IN TIME(8)|OUT TIME(9)
                |OT_R(10)|NT_R(11)|NT2_R(12)|HT_R(13)|OT(14)|NT(15)|NT2(16)|HT(17)
                |OT_A(18)|NT_A(19)|NT2_A(20)|HT_A(21)|Note(22)|_S(23)-->
			<td id="master" width="100%">
				<gw:grid
					id="grd_att"
					header="_EMP_PK|Confirm YN|ORGANIZATION|WGROUP|EMP_ID|FULL_NM|W_S|Work Date|IN TIME|OUT TIME|OT_R|NT_R|NT2_R|HT_R|OT|NT|NT2|HT|OT_A|NT_A|NT2_A|HT_A|Note|Status|HOL_TYPE|Att Confirm "
					format="0|3|0|0|0|0|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
					aligns="0|0|0|0|0|0|0|1|1|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
					defaults="||||||||||||||||||||||||||"
					editcol="0|0|0|0|0|0|0|0|0|0|1|1|1|1|0|0|0|0|0|0|0|0|1|0|0|0"
					widths="0|1200|2000|1000|1000|2500|1200|1200|1000|1200|800|800|800|800|800|800|800|800|800|800|800|1500|2000|0|0|1500"
					styles="width:100%;height:100%"
					sorting="T"
					onafteredit="On_AfterEdit();"
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
         <data><%=ESysLib.SetListDataSQL("SELECT shift,shift||'-'||remark FROM thr_work_shift WHERE DEL_IF = 0 and use_yn='Y' order by shift")%>|ALL|WS-Select All</data></gw:list>
    <gw:textbox id="txtReport_tmp" styles="display:none"/>             
    <gw:textbox id="txt_WS_temp" styles="display:none"/>             
    <gw:textbox id="menu_id" text="" styles="display:none"  />
    <gw:textbox id="txtFlag_View" text="" styles="display:none"  />               
	<gw:textbox id="txtSequence" text="" styles="display:none"  />
    <gw:textbox id="txtRecord" text="" styles="display:none"  />
    <gw:textbox id="idDBUSR" text="" styles="display:none"  />
</body>
</html>

