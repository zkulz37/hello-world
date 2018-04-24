<!-- #include file="../../../system/lib/form.inc"  -->
<%ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var sun_day=new Array();
var mon_day=new Array();
var sun_col=new Array();
var dem_sun,dem_mon,dem_sun_col;
var user;
var v_language = "<%=Session("SESSION_LANG")%>";
var rpt_no=0;
function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);	
    lstWeek.SetEnable(0);
    txtM1.style.display="none";
    txtM2.style.display="none";
    label1.style.display="none";
    label2.style.display="none";
     iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    txtCompany_pk.text="<%=Session("COMPANY_PK")%>";
    user= "<%=session("USER_ID")%>";
    idPrint2.SetEnable(0);
    idGrid1.GetGridControl().ScrollTrack=true;
    idGrid2.GetGridControl().ScrollTrack=true;
    idGrid3.GetGridControl().ScrollTrack=true;
    ChangeColorItem(lstOrg.GetControl());
    ChangeColorItem(lstOrg2.GetControl());
    ChangeColorItem(lstOrg3.GetControl());
	if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	{
        datUser_info.Call();     	    
	}
	else
        onChange_org();  

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
/**************** xu ly ngay ********************************/
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

/**************************************/
function addZero(num)//9=09
{
    if(num<10)
    {
	   return '0' + num;
	}
	else
	{
	   return  '' + num;
	}
 } 

function clear_data() //tra du lieu ve trang thai ban dau
{
	var i,j;
	//alert(mon_day.length)
	if(mon_day.length>0)
		for(i=0;i<dem_mon-1;i++)
			mon_day[i]=0
	if(sun_day.length>0)
		for(i=0;i<dem_sun-1;i++)
			sun_day[i]=0
		if(sun_day.length>0)
	for(i=0;i<dem_sun_col-1;i++)
			sun_col[i]=0
}

function define_dt()
{
    
	var dt,dt1,dt2,i,numday,yyyy,mm;
	clear_data();
	dem_sun=0;
	dem_mon=0;
	dem_sun_col=0;
	if(lstMonthOnly.value=="0")
	{
	    lstWeek.value="ALL";
	    lstWeek.SetEnable(0);
	    idPrint2.value="1";
	    return;
	}
	else
	{
	    lstWeek.SetEnable(1);
	}
	
	
	yyyy=Number(idYear2.value);
	mm=Number(lstMonthOnly.value)-1
	dt=idYear2.value+""+lstMonthOnly.GetText()+"01";
	numday=getDaysInMonth(dt); //so ngay co trong thang duoc chon
	var yy=yyyy
	//alert(mm);
	var m=0;
	if(mm == 0)
	{
		m = 12;
		yy = yy -1
	}	
	else
		m=mm
	var day=getDaysInMonth(yy+""+addZero(m));
	var tmp_lastdt=new Date(yy,m-1,day);
	//alert(tmp_lastdt);
	if(tmp_lastdt.getDay() == 0)//ngay cuoi thang la chu nhat
	{
		var temp_day = day - 6;
		for(i=temp_day;i<=day;i++)
		{
			var dt_c=new Date(yy,m,i);
			if(dt_c.getDay()==0)//ngay chu nhat
			{
				sun_day[dem_sun]=yy+""+addZero(m)+""+addZero(i);
				//alert("dem "+ dem_sun + " " +sun_day[dem_sun]);
				dem_sun+=1;
			}	
		}
	}
	for(i=1;i<=numday;i++)
	{
		var dt_c=new Date(yyyy,mm,i);
		if(dt_c.getDay()==0)//ngay chu nhat
		{
			sun_day[dem_sun]=yyyy+""+addZero(mm+1)+""+addZero(i);
			dem_sun+=1;
		}	
		if(dt_c.getDay()==1)//ngay thu 2
		{
			mon_day[dem_mon]=yyyy+""+addZero(mm+1)+""+addZero(i);
			dem_mon+=1;
		}	
	}
	//alert(mm)
	var tmp_dt=new Date(yyyy,mm,numday);
	//alert(tmp_dt)
	if(tmp_dt.getDay()!=0)//ngay cuoi thang ko phai la chu nhat
	{
		mm+=1;
		
		if(mm==12){
			mm=0;
			yyyy+=1;
		}	
		for(i=1;i<=7;i++) //chay them 1 tuan nua cua thang ke tiep
		{
			var dt_c=new Date(yyyy,mm,i);
			if(dt_c.getDay()==0)//ngay chu nhat
			{
				sun_day[dem_sun]=yyyy+""+addZero(mm+1)+""+addZero(i);
				dem_sun+=1;
			}	
			if(dt_c.getDay()==1)//ngay thu 2
			{
				mon_day[dem_mon]=yyyy+""+addZero(mm+1)+""+addZero(i);
				dem_mon+=1;
			}	
			//alert(dt_c)
		}
		
	}
	FromDT2.value=mon_day[0];
	var f_dt;
	f_dt=Number(mon_day[0].substr(6,2));
	if(dem_sun==6){
		ToDT2.value=sun_day[5];
		lstWeek.SetDataText("|1|01|2|02|3|03|4|04|5|05|ALL|Select All");
	}
	else
	{
		lstWeek.SetDataText("|1|01|2|02|3|03|4|04|ALL|Select All");
		ToDT2.value=sun_day[4];
	}
    lstWeek.value='1'
	
	define_week();
}
function define_week()
{
	var min_dt,week
	min_dt=Number(mon_day[0].substr(6,2))//ngay nho nhat trong thang
	week=lstWeek.value //tuan thu may
 switch (week)
  {   
	case '1': //tuan thu nhat
	{
		FromDT2.value=mon_day[0];
		ToDT2.value=sun_day[1]
		//alert("from: " + mon_day[0] + " To: "+ sun_day[0]);
	}	 
	break;
	case '2' : 
	{
		FromDT2.value=mon_day[0].substr(0,6)+""+addZero(min_dt+7)
		ToDT2.value=sun_day[2]
    }		 
	break;   
	case '3' : 
	{
		FromDT2.value=mon_day[0].substr(0,6)+""+addZero(min_dt+14)
		ToDT2.value=sun_day[3]
    }		 
	break;   
	case '4' : 
	{
		FromDT2.value=mon_day[0].substr(0,6)+""+addZero(min_dt+21)
		ToDT2.value=sun_day[4]
    }		 
	break;   
	case '5' : 
	{
			FromDT2.value=mon_day[0].substr(0,6)+""+addZero(min_dt+28)
			ToDT2.value=sun_day[5]
    }		 
	break;   
	case 'ALL' : 
	{
			FromDT2.value=mon_day[0]; //ngay dau thang
			if(dem_sun==6)
			    ToDT2.value=sun_day[5];
			else    
			    ToDT2.value=sun_day[4];
    }		 
	break;   
  }
    //alert(lstMonthOnly.value);
    if (lstMonthOnly.value=="0")//report by Detail Date
        idPrint2.value="1";
    else
    {
        if (lstWeek.value=="ALL")
            idPrint2.value="3"; //report by Detail Week of Month
        else
            idPrint2.value="2"; //report by Detail Date of Week
    }
    idPrint2.SetEnable(0);
  
}
//------------------------------------------------------------------------------------
function onPage_active()
{
    if(tabMain.GetCurrentPageNo()==1)
    {
        txtDept.text=lstOrg2.value;
        //datGroupData.Call();
    }
    else if(tabMain.GetCurrentPageNo()==2)
    {
        txtDept.text=lstOrg3.value;
        //datGroupData.Call();
     }   
        
}
//-------------------------------------------------
function OnChangeDept(depObj)
{
    txtDept.text=depObj.value;
    //datGroupData.Call();
}
//-------------------------------------------------
function OnDataReceive(obj)
{
    var obj_lst;
       if (obj.id=="datDeptData")
       {
         if(txtHr_level.text=="6")
                txtDeptData.text=txtDeptData.text+"|ALL|Select All";   
            switch (tabMain.GetCurrentPageNo())
            {
                case 0:
                {
                    lstOrg.SetDataText(txtDeptData.text);
                    txtDept.text=lstOrg.value;
                    break;
                }
                case 1:
                {
                    lstOrg2.SetDataText(txtDeptData.text);
                    txtDept.text=lstOrg2.value;
                    break;
                }
                case 2:
                {
                    lstOrg3.SetDataText(txtDeptData.text);
                    txtDept.text=lstOrg3.value;
                    break;
                }
            }  
            //datGroupData.Call();
       }
       else if (obj.id=="datWorkGroup_info")
       {
            if(tabMain.GetCurrentPageNo()==0)
            {
                //if(lstOrg.value=='ALL')
                //{                
                    lstWG.SetDataText(txtwg_tmp.text+'|ALL|Select All');
                    lstWG.value='ALL';
                //}
                //else
                  //  lstWG.SetDataText(txtwg_tmp.text);
            }
            if(tabMain.GetCurrentPageNo()==1)
            {
                //if(lstOrg2.value=='ALL')
                //{                
                    lstWG2.SetDataText(txtwg_tmp.text+'|ALL|Select All');
                    lstWG2.value='ALL';
                //}
                //else
                  //  lstWG2.SetDataText(txtwg_tmp.text);
            }
            if(tabMain.GetCurrentPageNo()==2)
            {
                //if(lstOrg3.value=='ALL')
                //{                
                    lstWG3.SetDataText(txtwg_tmp.text+'|ALL|Select All');
                    lstWG3.value='ALL';
                //}
                //else
                  //  lstWG3.SetDataText(txtwg_tmp.text);
            }
       }
       else if (obj.id=="datUser_info")
       {
            lstOrg.SetDataText(txtdept_temp.text);            
            lstOrg2.SetDataText(txtdept_temp.text);
            lstOrg3.SetDataText(txtdept_temp.text);
            
            txtDept.text=lstOrg.value;

            ChangeColorItem(lstOrg.GetControl());
            ChangeColorItem(lstOrg2.GetControl());
            ChangeColorItem(lstOrg3.GetControl());

            //datWorkGroup_info.Call();
            onChange_org();
       }
       else if (obj.id=="datTime_summary1")
       {
           idRecord.text=idGrid1.rows-1+" Records."; 
           for(var i=1;i<idGrid1.rows;i++)
           {
                if(Number(idGrid1.GetGridData(i,12))<0||Number(idGrid1.GetGridData(i,13))<0)
                {
                    idGrid1.SetCellBgColor(i, 12,i, 13, 0x3366FF );
                    idGrid1.SetCellBold(i,12,i,13,true);
                }
           }
           auto_resize_column(idGrid1,0,idGrid1.cols-1,0)
       }
       else if (obj.id=="datTime_summary2")
       {
           idRecord2.text=idGrid2.rows-1+" Records."; 
       }
       else if (obj.id=="datTime_summary3")
       {
           idRecord3.text=idGrid3.rows-1+" Records."; 
       }
       else if (obj.id=="datFind_Report")
       {
           var url;
    
            if (rpt_no==1)
                url =System.RootURL + '/reports/ch/ba/'+txtReport_tmp.text+'?p_user=' + user + '&p_wg=' + lstWG.value + '&p_search=' + idSearch.value + '&p_input=' + idtxtTmp.text + '&p_tco_org_pk=' + lstOrg.value  + '&p_from=' +  FromDT.value +'&p_to=' + ToDT.value + '&p_thr_ws_pk=' + lstWS.value + '&p_opt=' + idOpt.value+ '&p_opt_text=' + idOpt.GetText() + "&p_m1=" + txtM1.text +  "&p_m2=" + txtM2.text + "&p_nation=" + lstNation.value  ;
            else if (rpt_no==2)
            {
                if (idPrint2.value==1)
                    url =System.RootURL + '/reports/ch/ba/'+txtReport_tmp.text+'?p_user=' + user + '&p_wg=' + lstWG2.value + '&p_search=' + idSearch2.value + '&p_input=' + idtxtTmp2.text + '&p_tco_org_pk=' + lstOrg2.value   + '&p_from=' +  FromDT2.value + '&p_to=' + ToDT2.value + '&p_opt=' + idLstWT2.value + '&p_wt_ot=' + idtxtWT2.text + "&p_nation=" + lstNation2.value  + "&p_status=" + lstStatus2.value + "&p_val=" + idLstVal2.value ;
                else if (idPrint2.value==2)
                    url =System.RootURL + '/reports/ch/ba/'+txtReport_tmp.text+'?p_user=' + user + '&p_wg=' + lstWG2.value + '&p_search=' + idSearch2.value + '&p_input=' + idtxtTmp2.text + '&p_tco_org_pk=' + lstOrg2.value   + '&p_from=' +  FromDT2.value + '&p_to=' + ToDT2.value + '&p_opt=' + idLstWT2.value + '&p_wt_ot=' + idtxtWT2.text + '&p_month=' + (lstMonthOnly.GetText()  + '/' + idYear2.value ) + '&p_week=' + lstWeek.value + "&p_nation=" + lstNation2.value   + "&p_status=" + lstStatus2.value + "&p_val=" + idLstVal2.value ;
                else
                    url =System.RootURL + '/reports/ch/ba/'+txtReport_tmp.text+'?p_user=' + user + '&p_wg=' + lstWG2.value + '&p_search=' + idSearch2.value + '&p_input=' + idtxtTmp2.text + '&p_tco_org_pk=' + lstOrg2.value   + '&p_from=' +  FromDT2.value + '&p_to=' + ToDT2.value + '&p_opt=' + idLstWT2.value + '&p_wt_ot=' + idtxtWT2.text + '&p_month=' + (lstMonthOnly.GetText()  + '/' + idYear2.value ) + "&p_nation=" + lstNation2.value  + "&p_status=" + lstStatus2.value + "&p_val=" + idLstVal2.value ;
            }
            else if (rpt_no==3)
                url =System.RootURL + '/reports/ch/ba/'+txtReport_tmp.text+'?p_user=' + user + '&p_wg=' + lstWG3.value + '&p_search_by=' + idSearch3.value + '&p_search_temp=' + idtxtTmp3.text + '&p_tco_org_pk=' + lstOrg3.value  + '&p_year=' +  idYear3.value + '&p_search_ot=' + idLstOT3.value + '&p_ot=' + idtxtOT3.text + "&p_nation=" + lstNation3.value;
            else if (rpt_no==4)
                url =System.RootURL + '/reports/ch/ba/'+txtReport_tmp.text+'?p_user=' + user + '&p_wg=' + lstWG2.value + '&p_search_by=' + idSearch2.value + '&p_search_temp=' + idtxtTmp2.text + '&p_tco_org_pk=' + lstOrg2.value  + '&p_from=' +  FromDT2.value + '&p_to=' + ToDT2.value + '&p_opt=' + idLstWT2.value + '&p_wt_ot=' + idtxtWT2.text + '&p_month=' + (lstMonthOnly.GetText()  + '/' + idYear2.value ) + "&p_nation=" + lstNation2.value  + "&p_status=" + lstStatus2.value + "&p_val=" + idLstVal2.value ;
            
            window.open(url);
       }
}   
//-------------------------------------------------
function OnShowPopup(num)
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:25;dialogHeight:25;dialogLeft:10;dialogTop:240;edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {
        if(num==1)
        {
            lstOrg.value=obj
        }
        if(num==2)
        {
            lstOrg2.value=obj
        }    
        if(num==3)
        {
            lstOrg3.value=obj
        }
        //txtUpperDept.text=obj;
        onChange_org();
    }
    
}
//------------------------------------------------------------  
function OnSearch(obj)
{
    obj.Call("SELECT");
}
//-------------------------------------------------------------
function Popup(n)
{
    var col=event.col;
    if(n==1)
    {
        if(col<=4)//show time temp
        {
            //alert(idGrid1.GetGridData(event.row,17));
            var fpath = System.RootURL + "/form/ch/ba/chba00020_01.aspx?emp_pk=" + idGrid1.GetGridData(event.row,17) + "&dt1=" +idGrid1.GetGridData(event.row,18)
            + "&dt2=" +idGrid1.GetGridData(event.row,19)+ "&emp_id=" +idGrid1.GetGridData(event.row,3);
            var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:30;dialogHeight:35;dialogLeft:50;dialogTop:100;edge:sunken;scroll:yes;unadorned:yes;help:no');
        }
     }
     else if(n==2)
     {
        if((col==1)||(col==3))//show time summary
        {
            var fpath = System.RootURL + "/form/ch/ba/chba00030_01.aspx?emp_id=" + idGrid2.GetGridData(event.row,1) + "&dt1=" + FromDT2.value
            + "&dt2=" +ToDT2.value;
            var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:50;dialogHeight:35;dialogLeft:50;dialogTop:100;edge:sunken;scroll:yes;unadorned:yes;help:no');
        }
     }
     else if(n==3)   //progressive ot
     {
        if(col>=1 && col<15)
        {   
            var ym;
            if(col==2||col==1)
                ym=idYear3.value;
            else if(col>2 && col<15)    
                ym=idYear3.value+""+addZero(col-2);
                
            var fpath = System.RootURL + "/form/ch/ba/chba00030_02.aspx?emp_pk=" + idGrid3.GetGridData(event.row,16) + "&dt=" + ym;
             var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:50;dialogHeight:35;dialogLeft:50;dialogTop:100;edge:sunken;scroll:yes;unadorned:yes;help:no');
        }
     }
}    
//--------------------------------------------
function OnReport(obj)
{
    rpt_no=obj;
    var url;
    
    if (obj==1)
        txtReport_tmp.text="rpt_time_summary_new.aspx";
    else if (obj==2)
    {
        if(lstMonthOnly.value=="0")
        {
          alert("Please select month to query data");
          return;  
        }    
        
        if (idPrint2.value==1)
            txtReport_tmp.text="rpt_working_time_total_new.aspx";
        else if (idPrint2.value==2)
            txtReport_tmp.text="rpt_weekly_wt_ot_v2.aspx";
        else
            txtReport_tmp.text="rpt_working_time_total_month_v2.aspx";
    }
    else if (obj==3)
        txtReport_tmp.text="rpt_time_summary_year_new.aspx";
    else if (obj==4)
    {    
        if(lstMonthOnly.value=="0")
        {
          alert("Please select month to query data");
          return;  
        }        
        txtReport_tmp.text="rpt_time_group_new.aspx";
        
    }   
    datFind_Report.Call();
}
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
//-----------------------------------------------------
function OnChangeOption()
{
    switch (Number(idOpt.value))
    {
        case 1:
        {
            txtM1.style.display="none";
            txtM2.style.display="none";
            label1.style.display="none";
            label2.style.display="none";
            break;
        }
        case 2:
        {
            txtM1.style.display="";
            txtM2.style.display="";
            label1.style.display="";
            label2.style.display="";
            label1.text="Minute"
            break;
        }
        case 3:
        {
            txtM1.style.display="";
            txtM2.style.display="";
            label1.style.display="";
            label2.style.display="";
            label1.text="Minute"
            break;
        }
        case 4:
        {
            txtM1.style.display="none";
            txtM2.style.display="none";
            label1.style.display="none";
            label2.style.display="none";
            break;
        }
        case 5:
        {
            txtM1.style.display="none";
            txtM2.style.display="none";
            label1.style.display="none";
            label2.style.display="none";
            break;
        }
        case 6:
        {
            txtM1.style.display="";
            txtM2.style.display="";
            label1.style.display="";
            label2.style.display="";
            label1.text="Minute"
            break;
        }
        case 7:
        {
            txtM1.style.display="";
            txtM2.style.display="";
            label1.style.display="";
            label2.style.display="";
            label1.text="HH:MM"
            break;
        }
        case 8:
        {
            txtM1.style.display="";
            txtM2.style.display="";
            label1.style.display="";
            label2.style.display="";
            label1.text="HH:MM"
            break;
        }
            
    }
    
}
function onChange_org()
{
    if(tabMain.GetCurrentPageNo()==0)
        txtOrg_tmp.text=lstOrg.value;
    if(tabMain.GetCurrentPageNo()==1)
        txtOrg_tmp.text=lstOrg2.value;
    if(tabMain.GetCurrentPageNo()==2)
        txtOrg_tmp.text=lstOrg3.value;
    datWorkGroup_info.Call();
}

function OnSearch_Tab2()
{
    if(lstMonthOnly.value=="0")
    {
        alert("Please select month to query data");
        return;
    }
    datTime_summary2.Call("SELECT");
            
}

//-------------------------------------------------------------------------------------------
</script>
<body>
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="txtdept_temp" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------------>
<gw:data id="datWorkGroup_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_sel_wg_role"  > 
                <input>
                    <input bind="txtOrg_tmp" />
                </input> 
                <output>
                    <output bind="txtwg_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datTime_summary1" onreceive="OnDataReceive(this)"  > 
        <xml> 
           <dso  type="grid"  function="hr_SEL_10020003_TIME_SUM_v2" procedure="" parameter="1"> 
                <input bind="idGrid1"> 
                    <input bind="lstOrg" /> 
                    <input bind="lstWG" /> 
                    <input bind="FromDT" /> 
                    <input bind="ToDT" /> 
                    <input bind="idOpt" /> 
                    <input bind="lstWS" /> 
                    <input bind="idSearch" />
                    <input bind="idtxtTmp" />
                    <input bind="txtM1" />
                    <input bind="txtM2" />
                    <input bind="lstNation" />
                    <input bind="lstStatus" />
                </input> 
                <output bind="idGrid1"/>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datTime_summary2" onreceive="OnDataReceive(this)"  > 
        <xml> 
           <dso  type="grid"  function="hr_SEL_10020003_TIME_SUM2_v2" procedure="" parameter="1"> 
                <input bind="idGrid2"> 
                    <input bind="lstOrg2" /> 
                    <input bind="lstWG2" /> 
                    <input bind="FromDT2" /> 
                    <input bind="ToDT2" /> 
                    <input bind="idLstWT2" /> 
                    <input bind="idLstVal2" /> 
                    <input bind="idtxtWT2" />
                    <input bind="idSearch2" />
                    <input bind="idtxtTmp2" />
                    <input bind="lstNation2" />
                    <input bind="lstStatus2" />
                </input> 
                <output bind="idGrid2"/>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datTime_summary3" onreceive="OnDataReceive(this)"  > 
        <xml> 
           <dso  type="grid"  function="HR_SEL_10020003_PROGRESSIVE_OT" procedure="" parameter="1"> 
                <input bind="idGrid3"> 
                    <input bind="lstOrg3" /> 
                    <input bind="lstWG3" /> 
                    <input bind="idYear3" /> 
                    <input bind="idSearch3" /> 
                    <input bind="idtxtTmp3" /> 
                    <input bind="idLstOT3" />
                    <input bind="idtxtOT3" />
                    <input bind="lstNation3" />
                    <input bind="lstStatus3" />
                </input> 
                <output bind="idGrid3"/>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------>
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

   <!--------------------main table----------------------------------->
<gw:tab id="tabMain"  border=1 style="width:100%;height:100%;" onpageactivate="onPage_active()"  > 
    <table name="Time Summary" id="timesummary" class="itable" width="100%" cellpadding="0"  cellspacing="0" border=1 style="height:100%;">
     <tr style="width:100%;height:100%" valign="top">
        <td>
            <table width="100%;height:12%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                    <td colspan=5 align=right style="width:6%;border:0" ><a title="Click here to show department" onclick="OnShowPopup(1)" href="#tips" >Organization</a></td>
		            <td colspan=8 align=right style="width:20%;border:0"><gw:list  id="lstOrg" value="ALL"  maxlen = "100" styles='width:100%' onchange="onChange_org()" >
                        <data>
                            <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                        </data>
                        </gw:list>
                    </td>
                    <td colspan=3 align=right style="width:6%;border:0">WGroup</td>
		            <td colspan=8 align=right style="width:16%;border:0"><gw:list  id="lstWG" value="ALL"  maxlen = "100" styles='width:100%' >
                                <data><%=ESysLib.SetListDataSQL("select pk, workgroup_nm from thr_work_group where del_if=0") %>|ALL|Select All</data></gw:list>
                    </td>
                    <td colspan=4 style="width:8%" align="right">Work DT</td>
                    <td colspan=5 align=right style="width:10%;border:0"><gw:datebox id="FromDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
		            <td align=right style="width:2%;border:0"><b>~</b></td>
		            <td colspan=5 align=right style="width:10%;border:0"><gw:datebox id="ToDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
		            <td align=right colspan=3 style="width:6%;border:0">Nation</td>
                    <td align=left colspan=4 style="width:8%;border:0">
                    <gw:list id="lstNation" value='01' styles="width:100%">
				        <data>
				        <%=ESysLib.SetListDataSQL("select code, code_nm from vhr_hr_code v where v.ID='HR0009'")%>|ALL|Select All
				        </data>
				        </gw:list>
                    </td>
                    <td align=right colspan=1 style="width:2%;border:0"></td>
                    <td align=right style="width:2%;border:0"><gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="Search" onclick="OnSearch(datTime_summary1)" /></td>
                    <td align=right style="width:2%;border:0"></td>
                    <td align=right style="width:2%;border:0"><gw:imgBtn id="ibtnRpt" alt="Report" img="excel" text="Report" onclick="OnReport(1)" /></td>
                    
              </tr>
              <tr>
                    <td colspan=5 align=right style="width=10%">Work Shift</td>
                    <td colspan=19 align=right style="width=38%"><gw:list  id="lstWS" value="ALL"  maxlen = "100" styles='width:100%' onchange="OnChangeShift()">
                            <data><%=ESysLib.SetListDataSQL("SELECT pk,shift||'-'||remark FROM thr_work_shift WHERE DEL_IF = 0 and use_yn='Y'  order by shift")%>|ALL|WS-Select All</data></gw:list>
                    </td>
                    <td colspan=4 align=right style="width:8%">Search by</td>
		            <td colspan=5 align=right style="width:10%"><gw:list  id="idSearch" value="1" styles="width:96%" onChange="">
                            <data>|1|Emp ID|2|Card ID|3|Name</data></gw:list></td>
                    <td align=right style="width:2%;border:0"></td>
		            <td colspan=5 align=right style="width:10%"><gw:textbox id="idtxtTmp" maxlen = "20" styles="width:96%" onenterkey="OnSearch(datTime_summary1)" /></td>
		            <td colspan=3 align=right style="width:5%" >Status</td>
                    <td colspan=4 align=right style="width:10%;border:1" ><gw:list  id="lstStatus" value='A' styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("SELECT B.CODE,B.CODE_NM FROM VHR_HR_CODE B WHERE B.ID='HR0022' ORDER BY B.CODE")%>|ALL|Select All</data></gw:list>
                    </td>
		            <td colspan=4 align=right style="width:22%"style="color=#FF00CC"><gw:label id="idRecord" text="0 record(s)" styles="width:100%;color:red" ></gw:label></td>
              </tr>
              <tr>
                 <td width="100%" colspan=50>
                    <table cellspacing=0 cellpadding=0 style="height:5%" width=100% border=0>
                        <tr>
                            <td align=right width="20%">Option</td>
                            <td align=right width="10%"><gw:list  id="idOpt" value="5" styles='width:100%' onChange="OnChangeOption()">
                                <data>|1|Incorrect time|2|Lately|3|Early|4|Mod By hand|6|Lately or Early|7|InTime|8|OutTime|5|Select All</data></gw:list></td>
                            <td align=right width="10%"><gw:label id="label1" text="Minute" styles="width:100%" ></gw:label></td>
                            <td align=left width="5%" ><gw:textbox id="txtM1" maxlen = "20" styles="width:96%" onenterkey="OnSearch(datTime_summary1)" /></td>
                            <td align=center width="3%"><gw:label id="label2" text="~" styles="width:100%" ></gw:label></td>
		                    <td align=left width="5%"><gw:textbox id="txtM2" maxlen = "20" styles="width:96%" onenterkey="OnSearch(datTime_summary1)" /></td>
		                   <td align=center width="47%"></td>
                        </tr>
                    </table>
                 </td>
              </tr>
            </table>
            <table cellspacing=0 cellpadding=0 style="height:88%" width=100% border=1>
                    <tr style="border:1;height:100%" valign="top">
                        <td  style="width:100%"> 
                            <gw:grid   
	                            id="idGrid1"  
	                            header="Organization|WGroup|Date|Emp ID|Name|Work Shift|IN|OUT|WT|OT|NT|NT2|HT|Lately|Early|By Hand|Mod By|_EMP_PK|_DT IN|_DT OUT|NO SCAN"   
	                            format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|3"  
	                            aligns="0|0|0|1|0|0|1|1|1|1|1|1|0|0|0|0|0|0|0|0|0"  
	                            defaults="||||||||||||||||||||"  
	                            editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
	                            widths="1500|1200|1200|1000|2250|2000|800|800|500|500|500|500|500|800|800|1200|1000|1000|0|1200"  
	                            styles="width:100%; height:100%"   
	                            sorting="T" oncelldblclick = "Popup(1)"  
	                            /> 
                        </td>
                        
                    </tr>
               </table> 
        </td>
     </tr>
    </table>
    
    <table name="WT & OT" id="wt_ot" class="itable" width="100%" cellpadding="0"  cellspacing="0" border=1 style="height:100%;">
        <tr style="width:100%;height:100%" valign="top">
        <td>
            <table width="100%;height:12%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                    <td colspan=5 align=right style="width:6%;border:0" ><a title="Click here to show department" onclick="OnShowPopup(2)" href="#tips" >Organization</a></td>
		            <td colspan=8 align=right style="width:20%;border:0"><gw:list  id="lstOrg2" value="ALL"  maxlen = "100" styles='width:100%' onchange="onChange_org()" >
                        <data>
                            <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                        </data>
                        </gw:list>
                    </td>
                    <td colspan=3 align=right style="width:6%;border:0">WGroup</td>
		            <td colspan=8 align=left style="width:16%;border:0"><gw:list  id="lstWG2" value="ALL"  maxlen = "100" styles='width:100%' >
                                <data><%=ESysLib.SetListDataSQL("select pk, workgroup_nm from thr_work_group where del_if=0") %>|ALL|Select All</data></gw:list>
                    </td>
                    <td colspan=3 align=right style="width=6%">Option</td>
                    <td colspan=4 align=right style="width:8%"><gw:list  id="idLstWT2" value="1" styles="width:100%" onChange="">
                            <data> LIST|1|WT|2|OT|3|HT|4|WT+OT|5|OT+HT</data></gw:list>
                    </td>
                    <td colspan=2 align=right style="width:6%"><gw:list  id="idLstVal2" value="1" styles="width:100%" onChange="">
                            <data> LIST|=|=|>|>|<|<|>=|>=|<=|<=</data></gw:list>
                    </td>
                    <td colspan=1 align=right style="width:10%"><gw:textbox id="idtxtWT2" maxlen = "20" styles="width:95%" onenterkey="OnSearch_Tab2()" /></td>
                    <td colspan=3 align=right style="width:6%">Search</td>
		            <td colspan=4 align=left style="width:8%"><gw:list  id="idSearch2" value="1" styles="width:100%" onChange="">
                            <data>|1|Emp ID|2|Card ID|3|Name</data></gw:list>
                    </td>
		            <td colspan=5 align=center style="width:10%"><gw:textbox id="idtxtTmp2" maxlen = "20" styles="width:90%" onenterkey="OnSearch_Tab2()" /></td>
		            <td align=right style="width:2%;border:0"></td>
                    <td align=right style="width:2%;border:0"><gw:imgBtn id="ibtnSearch2" alt="Search" img="search" text="Search" onclick="OnSearch_Tab2()" /></td>
              </tr>
              <tr>
                    <td colspan=5 align=right style="width=3%">Nation</td>
                    <td colspan=3 align=right style="width=8%">
                        <gw:list id="lstNation2" value='01' styles="width:100%">
				        <data>
				        <%=ESysLib.SetListDataSQL("select code, code_nm from vhr_hr_code v where v.ID='HR0009'")%>|ALL|Select All
				        </data>
				        </gw:list>
                    </td>
                    </td>
                    <td colspan=2 align=right style="width=3%">Year</td>
                    <td colspan=3 style="width=8%"><gw:datebox id="idYear2" styles="width:100%" onchange="define_dt()" lang="<%=Session("Lang")%>" type="year"/></td>
                    
                    <td colspan=3 align=right style="width=4%">Month</td>
                    <td colspan=1 style="width=4%"><gw:list id="lstMonthOnly" styles="width:100%" value="" onchange="define_dt()" >		  
					        <data>|0||1|01|2|02|3|03|4|04|5|05|6|06|7|07|8|08|9|09|10|10|11|11|12|12</data></gw:list>
					</td>				  
				    <td colspan=3 style="width=6%" align="right">Week</td>
				    <td colspan=4 style="width=8%"><gw:list id="lstWeek" styles="width:100%" value="ALL" onchange="define_week()" >		  
					    <data>|1|01|2|02|3|03|4|04|5|05|ALL|Select All</data></gw:list>
					</td>
				    <td colspan=3 style="width=6%" align = "right">From</td>
				    <td colspan=4 style="width=8%"><gw:datebox id="FromDT2" styles="width:100%" lang="<%=Session("Lang")%>"/></td>	
				    <td style="width=2%" align="center"><b>~</b></td>
				    <td colspan=4 style="width=8%"><gw:datebox id="ToDT2" styles="width:100%" lang="<%=Session("Lang")%>"/></td>
		            <td colspan=7 align=right style="width:16%"><gw:list  id="idPrint2" value="1" styles="width:100%" onChange="">
                            <data>|1|By Detail Date|2|By Date of Week|3|By Week of Month</data></gw:list>
                     </td>                  
                    <td align=right style="width:2%"><gw:imgBtn id="ibtnRpt2" alt="Report" img="excel" text="Report" onclick="OnReport(2)" /></td>
                    <td align=right style="width:2%"><gw:imgBtn id="ibtnRpt4" alt="Report by workgroup" img="excel" text="Report" onclick="OnReport(4)" /></td>
              </tr>
              <tr>
                    <td colspan=5 align=right style="width=3%">Status</td>
                    <td colspan=3 align=right style="width=8%">
                        <gw:list  id="lstStatus2" value='A' maxlen = "100" styles='width:100%'>
                                    <data>
                                        <%=ESysLib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0022' order by code_nm")%>|ALL|Select All
                                    </data>
                        </gw:list>
                                        
                    </td>
                    <td colspan=2 align=right style="width=3%"></td>
                    <td colspan=3 style="width=8%"></td>
                    <td colspan=3 align=right style="width=4%"></td>
                    <td colspan=1 style="width=4%">
					</td>				  
				    <td colspan=3 style="width=6%" align="right"></td>
				    <td colspan=4 style="width=8%">
					</td>
				    <td colspan=3 style="width=6%" align = "right"></td>
				    <td colspan=4 style="width=8%"></td>	
				    <td style="width=2%" align="center"></td>
				    <td colspan=4 style="width=8%"></td>
		            <td colspan=12 align=right style="width:10%"><b style="color=#FF00CC"><gw:label id="idRecord2" text="0 rec(s)" styles="color:red;width:100%;font-weight: bold;font-size:13" ></gw:label></b></td>
              </tr>
            </table>
            <table cellspacing=0 cellpadding=0 style="height:88%" width=100% border=1>
                    <tr style="border:1;height:100%" valign="top">
                        <td  style="width:100%"> 
                            <gw:grid   
	                            id="idGrid2"  
	                            header="Organization|WGroup|Emp ID|Join date|Name|WT|OT|NT|NT2|HT|Total WT+OT|Total OT+HT|Total Night OT"   
	                            format="0|0|0|0|0|0|0|0|0|0|0|0|0"  
	                            aligns="0|0|0|0|0|3|3|3|3|3|3|3|3"  
	                            defaults="||||||||||||||"  
	                            editcol="0|0|0|0|0|0|0|0|0|0|0|0|0"  
	                            widths="3000|1200|1200|1500|3000|800|800|800|800|800|1200|1200|1500"  
	                            styles="width:100%; height:100%"   
	                            sorting="T" oncelldblclick = "Popup(2)" /> 
                        </td>
                        
                    </tr>
               </table> 
        </td>
     </tr>
    </table>
    <table name="MONTHLY OT" id="Table1" class="itable" width="100%" cellpadding="0"  cellspacing="0" border=1 style="height:100%;">
        <tr style="width:100%;height:100%" valign="top">
        <td>
            <table width="100%;height:12%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                    <td colspan=5 align=right style="width:6%;border:0" ><a title="Click here to show department" onclick="OnShowPopup(3)" href="#tips" >Organization</a></td>
		            <td colspan=8 align=right style="width:20%;border:0"><gw:list  id="lstOrg3" value="ALL"  maxlen = "100" styles='width:100%' onchange="onChange_org()" >
                        <data>
                            <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                        </data>
                        </gw:list>
                    </td>
                    <td colspan=3 align=right style="width:6%;border:0">WGroup</td>
		            <td colspan=8 align=left style="width:16%;border:0"><gw:list  id="lstWG3" value="ALL"  maxlen = "100" styles='width:100%' >
                                <data><%=ESysLib.SetListDataSQL("select pk, workgroup_nm from thr_work_group where del_if=0") %>|ALL|Select All</data></gw:list>
                    </td>
                    <td colspan=3 align=right style="width=6%">Search</td>
                    <td colspan=4 align=right style="width:8%"><gw:list  id="idSearch3" value="1" styles="width:100%" onChange="">
                            <data>|1|Emp ID|2|Card ID|3|Name</data></gw:list></td>
                    <td colspan=4 align=center style="width:8%">
                    <gw:textbox id="idtxtTmp3" maxlen = "20" styles="width:90%" onenterkey="OnSearch(datTime_summary3)" /></td>
                    <td colspan=3 align=right style="width:6%">
                    Nation
                    </td>
		            <td colspan=4 align=left style="width:8%">
		            <gw:list id="lstNation3" value='01' styles="width:100%">
				        <data>
				        <%=ESysLib.SetListDataSQL("select code, code_nm from vhr_hr_code v where v.ID='HR0009'")%>|ALL|Select All
				        </data>
				        </gw:list>
		            </td>
		            <td colspan=1 align=center style="width:3%">
		            <gw:imgBtn id="ibtnSearch3" alt="Search" img="search" text="Search" onclick="OnSearch(datTime_summary3)" />
		            </td>
		            <td colspan=1 align=center style="width:3%">
		            <gw:imgBtn id="ibtnRpt3" alt="Report" img="excel" text="Report" onclick="OnReport(3)" />
		            </td>
		            <td colspan=6 align=center style="width:10%">
		            </td>
              </tr>
              <tr>
                    <td colspan=13 align=left style="width=26%"><i style="color=red">Double click cell to view detail</i></td>
                    <td align=right colspan=3 style="width=6%">Option</td>				  
				    <td colspan=8 style="width=16%"><gw:list  id="idLstOT3" value="1" styles="width:100%" onChange="">
                            <data> LIST|1|TOTAL OT >=|2|TOTAL OT <</data></gw:list>
                            </td>
				    <td colspan=3 style="width=6%" align = "center"><gw:textbox id="idtxtOT3" maxlen = "20" styles="width:90%" onenterkey="OnSearch(datTime_summary3)" /></td>
				    <td colspan=4 style="width=8%" align="right">Year</td>
				    <td colspan=4 style="width=8%"><gw:datebox id="idYear3" styles="width:100%" onchange="define_dt()" lang="<%=Session("Lang")%>" type="year"/></td>                  
                    <td colspan=3 align=right style="width:5%" >Status</td>
		            <td colspan=4 align=right style="width:10%;border:1" ><gw:list  id="lstStatus3" value='A' styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("SELECT B.CODE,B.CODE_NM FROM VHR_HR_CODE B WHERE B.ID='HR0022' ORDER BY B.CODE")%>|ALL|Select All</data></gw:list>
                    </td>
		            <td colspan=8 align=right style="width:28%"><b style="color=#FF00CC"><gw:label id="idRecord3" text="0 record(s)" styles="width:100%;color:red" ></gw:label></b></td>
              </tr>
            </table>
            <table cellspacing=0 cellpadding=0 style="height:88%" width=100% border=1>
                    <tr style="border:1;height:100%" valign="top">
                        <td  style="width:100%"> 
                            <gw:grid   
	                            id="idGrid3"  
			                    header="ORGANIZATION|EMP ID|NAME|JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC|TOTAL|_EMP_PK"   
			                    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
			                    aligns="0|0|2|1|1|1|1|1|1|1|1|1|1|1|1|2|1"  
			                    defaults="||||||||||||||||"  
			                    editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
			                    widths="2000|1200|2600|600|600|600|600|600|600|600|600|600|600|600|600|1000|1000"  
			                    styles="width:100%; height:100%"   
			                    sorting="T"
			                    oncelldblclick = "Popup(3)" /> 
                        </td>
                        
                    </tr>
               </table> 
        </td>
     </tr>
    </table>
    </gw:tab>
    <gw:textbox id="iduser_pk" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
    <gw:textbox id="txtDept" styles="display:none"/>	
    <gw:textbox id="txtDeptData" styles="display:none"/>
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtGroupData" styles="display:none"/>
    <gw:textbox id="txtdept_temp" styles="display:none"/>  
    <gw:textbox id="txtReport_tmp" styles="display:none"/>  
    <gw:textbox id="txtCompany_pk" styles="display:none"/>
    <gw:textbox id="txtwg_tmp" styles="display:none"/>    
    <gw:textbox id="txtOrg_tmp" styles="display:none"/> 
</body>

   
</html>
