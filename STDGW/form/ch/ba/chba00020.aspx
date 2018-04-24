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
var g_col=new Array();
var g_emp_pk        =0,
    g_org           =1,
    g_grp           =2,
    g_emp_id         =3,
    g_full_nm        =4,
    g_ws             =5,
    g_date_in        =6,
    g_n1             =7,
    g_in_time        =8,
    g_date_out       =9,
    
    g_n2             =10,
    g_out_time       =11,
    g_wt             =12,
    g_ot             =13,
    g_nt             =14,
    
    g_ht             =15,
    g_abs_code       =16,
    g_h              =17,
    g_ale_remain     =18,
    g_wkd_pk         =19,
    
    g_ot_pk          =20,              
    g_abs_pk         =21,
    g_work_dt        =22,
    g_nt_pk          =23,
    g_ht_pk          =24,
    
    g_dt_now         =25,
    g_dt_next        =26,
    g_hol_type       =27,
    g_mod_by_hand    =28,
    g_no_scan        =29,
    
    g_s              =30,
    g_temp_in        =31,
    g_temp_out       =32,
    g_temp_hour      =33,
    g_close      =34
      
function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);	
     iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    txtCompany_pk.text="<%=Session("COMPANY_PK")%>";
    user= "<%=session("USER_ID")%>";
    
    
    var t1 = "<%=ESysLib.SetGridColumnDataSQL("select a.CODE,a.CODE_NM from vhr_hr_code a where a.id='HR0003' and a.code<>'04' union SELECT NULL,'' FROM DUAL ")%>";
    grd_att.SetComboFormat(g_abs_code,t1);
    
    t1 = "<%=ESysLib.SetGridColumnDataSQL( "select A.PK,A.SHIFT from THR_WORK_SHIFT A where a.del_if=0 AND A.USE_YN='Y' ORDER BY A.SHIFT") %>" ; 
    grd_att.SetComboFormat(g_ws,t1);
    
    
      lstOrg.value="ALL";
	  lstWG.value="ALL";
	  FromDT.SetEnable(0);
	  ToDT.SetEnable(0);
	  Month.SetEnable(0);
	  grd_att.GetGridControl().ColEditMask(g_in_time)="99:99";
	  grd_att.GetGridControl().ColEditMask(g_out_time)="99:99";	
	  grd_att.GetGridControl().ColEditMask(g_temp_in)="99:99";
	  grd_att.GetGridControl().ColEditMask(g_temp_out)="99:99";
	  grd_att.GetGridControl().FrozenCols =g_ws;
	  grd_att.GetGridControl().ScrollTrack=true;
	  onSetEnable(0);
	  onSetEnable2(0);
	  
	grd_att.GetGridControl().ColHidden(g_date_in )=1;
	grd_att.GetGridControl().ColHidden(g_n1)=1;
	grd_att.GetGridControl().ColHidden(g_date_out)=1;
	grd_att.GetGridControl().ColHidden(g_n2)=1;
	idlbN1.style.display   = 'none';
	D_IN.style.display   = 'none';
	idlbN2.style.display   = 'none';
	D_OUT.style.display   = 'none';

	ChangeColorItem(lstOrg.GetControl());
    		
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
//------------------------------------------------------------------------------------
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
/*
function OnShowPopup()
{
        var fpath = System.RootURL + "/form/ch/ae/chae00010_dept.aspx?";
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:60;dialogTop:200;edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {
             txtUpperDept.text=obj;
             datDeptData.Call();
        }
}

/**/
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

function OnChangeDept()
{
    //txtDept.text=lstOrg.value;
    //datGroupData.Call();
}
//------------------------------------------------------------------------------------

function onSetEnable(n)
{
      chkSelectAll.SetEnable(n);
      D_OUT.SetEnable(n);
      D_IN.SetEnable(n);
      ibtnSave.SetEnable(n);
      ibtnDelete.SetEnable(n);
      ibtnUnDelete.SetEnable(n);
}
function onSetEnable2(n)
{
      idHH.SetEnable(n);
      idMM1.SetEnable(n);
      idMM2.SetEnable(n);
      idBtnSet.SetEnable(n);
      idBtnClear.SetEnable(n);
}
//------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
       if (obj.id=="datDeptData")
       {    
            if(txtHr_level.text=="6")
                txtDeptData.text=txtDeptData.text+"|ALL|Select All";
            lstOrg.SetDataText(txtDeptData.text)    ;
            
              obj=lstOrg.GetControl()
		    if (obj.options.length ==2)
			    obj.options.selectedIndex=0;
		    else
			    obj.options.selectedIndex=0;
           
            //datGroupData.Call();
       }
       else if (obj.id=="datGroupData")
       {
            lstWG.SetDataText(txtGroupData.text);
            var obj=lstWG.GetControl()
		    if (obj.options.length ==2)
			    obj.options.selectedIndex=0;
		    else
			    obj.options.selectedIndex=obj.options.length-1;
       }
       else if (obj.id=="datWorkGroup_info")
        {                          
                lstWG.SetDataText(txtwg_tmp.text+'|ALL|Select All');
                lstWG.value='ALL';            
        }       
       else if (obj.id=="datAttendence_absence")
       {
            clear_Interval(idInterval);
            idRecord.text=grd_att.rows-1 + " Record(s)."
            if(grd_att.rows>1)
            {
                var wt,ot,nt,ht,abs;
                wt=ot=nt=ht=abs=0;
                onSetEnable(1);
                if(idLstInOut.value!="0")
                    onSetEnable2(1);
                for(var i=1;i<grd_att.rows;i++)
                { if(grd_att.GetGridData(i,g_close)=="M")
                         grd_att.SetCellBgColor(i, g_emp_pk,i, g_close, 0x99FFFF );
                   if(grd_att.GetGridData(i,g_close)=="Y")      
                         grd_att.SetCellBgColor(i, g_emp_pk,i, g_close, 0xFFEEFF );
                  
                    if(Trim(grd_att.GetGridData(i,g_hol_type))!="")
                    {
                        if(Trim(grd_att.GetGridData(i,g_hol_type))=="HOL")
                        {
                            grd_att.SetCellBgColor(i, g_ht,i, g_ht, 0x3366FF );
                            grd_att.SetCellBold(i,g_ht,i,g_ht,true);
                        }
                        else    
                        {
                            grd_att.SetCellBgColor(i, g_ht,i, g_ht, 0xCC9900 );
                            grd_att.SetCellBold(i,g_ht,i,g_ht,true);
                        }
                    }
                    if(grd_att.GetGridData(i,g_date_in)!=grd_att.GetGridData(i,g_dt_now))
                        grd_att.SetGridText(i,g_n1,'-1');
                    if(grd_att.GetGridData(i,g_date_out)!=grd_att.GetGridData(i,g_dt_now))
                        grd_att.SetGridText(i,g_n2,'-1'); 
                    if(Trim(grd_att.GetGridData(i,g_wt))==""?wt+=0:wt+=Number(grd_att.GetGridData(i,g_wt)));       
                    if(Trim(grd_att.GetGridData(i,g_ot))==""?ot+=0:ot+=Number(grd_att.GetGridData(i,g_ot)));
                    if(Trim(grd_att.GetGridData(i,g_nt))==""?nt+=0:nt+=Number(grd_att.GetGridData(i,g_nt)));
                    if(Trim(grd_att.GetGridData(i,g_ht))==""?ht+=0:ht+=Number(grd_att.GetGridData(i,g_ht)));
                    if(Trim(grd_att.GetGridData(i,g_h))==""?abs+=0:abs+=Number(grd_att.GetGridData(i,g_h)));
                        
                } 
                idlbWtOtNtHt.text="WT: "+wt+"(H)."+"OT:"+ot+"(H). "+" NT: "+nt+"(H). "+" Absence: "+abs+"(H).";   
            }    
            else    
            {
                onSetEnable(0);
                onSetEnable2(0);
                idlbWtOtNtHt.text="";
            } 
            auto_resize_column(grd_att,0,grd_att.cols-1,0);   
                        
       }
       else if (obj.id=="datUser_info")
       {
            ChangeColorItem(lstOrg.GetControl());
            onChange_org();
       }
       else if (obj.id=="datFind_Report")
       {    
            if (idPrint_type.value ==1)
                    var url =System.RootURL + '/reports/ch/ba/'+txtReport_tmp.text+'?p_user=' + user + '&p_wg=' + lstWG.value + '&p_search_by=' + idSearch.value + '&p_search_temp=' + idtxtTmp.text + '&p_tco_org_pk=' + lstOrg.value  + '&p_from_date=' +  txtFrom.text +'&p_to_date=' + txtTo.text + '&p_work_shift=' + lstWS.value + '&p_date_type=' + opt_value + '&p_nation=' + lstNation.value + '&p_reg=' + lstReg.value +'&p_com='+txtCompany_pk.text;
            else if (idPrint_type.value ==2)
                 var url =System.RootURL + '/reports/ch/ba/'+txtReport_tmp.text+'?p_user=' + user + '&p_wg=' + lstWG.value + '&p_search_by=' + idSearch.value + '&p_search_temp=' + idtxtTmp.text + '&p_tco_org_pk=' + lstOrg.value  + '&p_from_date=' +  txtFrom.text +'&p_to_date=' + txtTo.text + '&p_work_shift=' + lstWS.value + '&p_date_type=' + opt_value + '&p_nation=' + lstNation.value + '&p_reg=' + lstReg.value+'&p_com='+txtCompany_pk.text;
            else if (idPrint_type.value ==3)
                var url =System.RootURL + '/reports/ch/ba/'+txtReport_tmp.text+'?p_user=' + user + '&p_wg=' + lstWG.value + '&p_search_by=' + idSearch.value + '&p_search_temp=' + idtxtTmp.text + '&p_tco_org_pk=' + lstOrg.value  + '&p_from_date=' +  txtFrom.text +'&p_to_date=' + txtTo.text + '&p_work_shift=' + lstWS.value + '&p_date_type=' + opt_value + '&p_nation=' + lstNation.value + '&p_reg=' + lstReg.value+'&p_com='+txtCompany_pk.text;
            else
                var url =System.RootURL + '/reports/ch/ba/'+txtReport_tmp.text+'?p_user=' + user + '&p_wg=' + lstWG.value + '&p_search_by=' + idSearch.value + '&p_search_temp=' + idtxtTmp.text + '&p_tco_org_pk=' + lstOrg.value  + '&p_from_date=' +  txtFrom.text +'&p_to_date=' + txtTo.text + '&p_work_shift=' + lstWS.value + '&p_date_type=' + opt_value + '&p_nation=' + lstNation.value + '&p_reg=' + lstReg.value+'&p_com='+txtCompany_pk.text;
            window.open(url);
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

function change_list()
{
    if(idLstInOut.value=="0")
    {
        onSetEnable2(0);   
        return;
    }
	if((idLstInOut.value=="1")||(idLstInOut.value=="2"))
	{
   		idMM1.style.display   = '';
		idMM2.style.display   = '';
		idlbHH.text="HH"
		idlbMM1.text="MM1"
		idlbMM2.text="MM2"
		

	}
	else
	{
		idMM1.style.display   = 'none';
		idMM2.style.display   = 'none';
		idlbHH.text="H"
		idlbMM1.text=""
		idlbMM2.text=""
		
	}
	if(grd_att.rows>1)
	{
	    onSetEnable2(1);
	    idHH.GetControl().focus();
	}    
	    
	
}
//------------------------------------------------------------------------------------

function On_AfterEdit()
{
	var tmpIN,tmpOUT,tmpDT,ws,temp;
	cIdx=event.col;
	//Lay data WS
	ws=grd_att.GetGridData(event.row,g_ws)
	lstWS_temp.value=ws;
	idlbWS.text=lstWS_temp.GetText();
	
	if (cIdx==g_in_time||cIdx==g_temp_in)
	{
		tmpIN=grd_att.GetGridData(event.row,cIdx)
		if(tmpIN.length==0)
		{
			grd_att.SetGridText(event.row,cIdx,"")
		}
		if((tmpIN.length!=4)&&(tmpIN.length!=0))
		{
			alert("Input time is not correct type.(type: hh:mm)\nKiểu giờ nhập không đúng")
			grd_att.SetGridText(event.row,cIdx,'')
			return;
		}
		if((Number(tmpIN.substr(0,2))>=24)||(Number(tmpIN.substr(0,2))<0))
		{
			alert("Input time(Hour) is not correct type.(00<= hh <= 23)\nKiểu giờ phải >=00 và <=23")
			grd_att.SetGridText(event.row,cIdx,'')
			return;
		}
		if((Number(tmpIN.substr(2,2))>=60)||(Number(tmpIN.substr(2,2))<0))
		{
			alert("Input time(Minute) is not correct type.(00<= hh < 59)\nKiểu phút phải >=00 và <=59")
			grd_att.SetGridText(event.row,cIdx,'')
			return;
		}
		if(tmpIN.length>0)
		{
		    tmpIN=tmpIN.substr(0,2)+":"+tmpIN.substr(2,2)
		    grd_att.SetGridText(event.row,cIdx,tmpIN)
		}
		// Set Columm WT khi edit
		if(tmpIN!=dt_tmp)
		{
		    grd_att.SetGridText(event.row,g_wt,"")
		    grd_att.SetGridText(event.row,cIdx,tmpIN)
		}
		
	}
	if (cIdx==g_out_time||cIdx==g_temp_in)
	{
		tmpOUT=grd_att.GetGridData(event.row,cIdx)
		if(tmpOUT.length==0)
		{
			grd_att.SetGridText(event.row,cIdx,"")
		}
		if((tmpOUT.length!=4)&&(tmpOUT.length!=0))
		{
			alert("Input time is not correct type.(type: hh:mm)\nKiểu giờ không đúng(hh:mm)")
			grd_att.SetGridText(event.row,cIdx,'')
			return;
		}
		if((Number(tmpOUT.substr(0,2))>=24)||(Number(tmpOUT.substr(0,2))<0))
		{
			alert("Input time(Hour) is not correct type.(00<= hh <= 23)\nKiểu giờ phải >=00 và <=23")
			grd_att.SetGridText(event.row,cIdx,'')
			return;
		}
		if((Number(tmpOUT.substr(2,2))>=60)||(Number(tmpOUT.substr(2,2))<0))
		{
			alert("Input time(Minute) is not correct type.(00<= hh < 60)\nKiểu phút phải >=00 và <=59")
			grd_att.SetGridText(event.row,cIdx,'')
			return;
		}
		if(tmpOUT.length>0)
		{
		    tmpOUT=tmpOUT.substr(0,2)+":"+tmpOUT.substr(2,2)
		    grd_att.SetGridText(event.row,cIdx,tmpOUT)
		} 
		// Set Columm WT khi edit
		if(tmpOUT!=dt_tmp)
		{
		    grd_att.SetGridText(event.row,g_wt,"")
		    grd_att.SetGridText(event.row,cIdx,tmpOUT)
		}   
	}		
	if ((cIdx==g_date_in)||(cIdx==g_date_out)) //date in out
	{
		tmpDT=grd_att.GetGridData(event.row,cIdx)
		if(Number(tmpDT)<Number(grd_att.GetGridData(event.row,g_dt_now))-1||Number(tmpDT)>Number(grd_att.GetGridData(event.row,g_dt_now))+1)
		{
		    if(!confirm("You choose date maybe not correct, Do you want to keep?\nBạn đã chọn ngày không hợp lệ, Bạn chắc chắn?"))
		        grd_att.SetGridText(event.row,cIdx,dt_tmp);
		}   
	}		
	if (cIdx==g_abs_code||cIdx==g_ws) //ABS
	{
	    if(grd_att.GetGridData(event.row,cIdx)=="")
	    {
	        grd_att.SetCellBgColor(event.row, cIdx,event.row, cIdx, 0x000000);
            grd_att.SetCellBold(event.row,cIdx,event.row,cIdx,false);
	    }
	    else if(dt_tmp!=grd_att.GetGridData(event.row,cIdx))
	    {
         grd_att.SetCellBgColor(event.row, cIdx,event.row, cIdx, 0x3366FF );
         grd_att.SetCellBold(event.row,cIdx,event.row,cIdx,true);
        }
    }     
    if (cIdx==g_wt) //WT      
    {
        if(Number(grd_att.GetGridData(event.row,cIdx))>0&&grd_att.GetGridData(event.row,g_hol_type)!="")
        {
            alert("This day is holiday, haven't WT.\nNgày này là ngày nghỉ không thể có giờ làm việc chính thức.")
            grd_att.SetGridText(event.row,cIdx,'0');
        }
    }
    //chkSelectAll.value='F';
	if(cIdx==g_n1)
	{
	    if(grd_att.GetGridData(event.row,g_n1)==0)
	    {   
	        temp=grd_att.GetGridData(event.row,g_dt_now)
	        grd_att.SetGridText(event.row,g_date_in,temp)
	    }
	    else    
	    {
	        temp=grd_att.GetGridData(event.row,g_dt_next)
	        grd_att.SetGridText(event.row,g_date_in,temp)
	    }
	}
	else if(cIdx==g_n2)
	{
	    if(grd_att.GetGridData(event.row,g_n2)==0)
	    {   
	        temp=grd_att.GetGridData(event.row,g_dt_now)
	        grd_att.SetGridText(event.row,g_date_out,temp)
	    }
	    else    
	    {
	        temp=grd_att.GetGridData(event.row,g_dt_next)
	        grd_att.SetGridText(event.row,g_date_out,temp)
	    }
	}
	if(dt_tmp!=grd_att.GetGridData(event.row,cIdx))
	{
	    grd_att.SetGridText(event.row,g_s,"1");
	} 
	
	 if(grd_att.GetGridData(event.row,g_s)=="1" && (grd_att.GetGridData(event.row,g_close)=="M"||grd_att.GetGridData(event.row,g_close)=="Y") )
	  {alert("You can't modify and save this record because salary period was closed! \nBạn không thể điều chỉnh và lưu thông tin của dòng dữ liệu này vì tháng lương đã đóng! ") ;
	      grd_att.SetGridText(event.row,g_s,"");
	      return;
	  }

	
}
//------------------------------------------------------------------------------------

function OnSearch()
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
            datAttendence_absence.Call("SELECT");
        }    
    }   
    else 
    {
        set_Interval(100);
        datAttendence_absence.Call("SELECT");
    }   
    
}
//------------------------------------------------------------------------------------
function OnUpdate()
{
    if(confirm("Do you want to save?\nBạn muốn save?"))
        datAttendence_absence.Call();
}
//------------------------------------------------
function OnToggle()
{
        if(imgMaster.status == "expand")
        {
            imgMaster.status = "collapse";
			grd_att.GetGridControl().ColHidden(g_date_in)=1;
			grd_att.GetGridControl().ColHidden(g_n1)=1;
			grd_att.GetGridControl().ColHidden(g_date_out)=1;
			grd_att.GetGridControl().ColHidden(g_n2)=1;
			idlbN1.style.display   = 'none';
			D_IN.style.display   = 'none';
			idlbN2.style.display   = 'none';
			D_OUT.style.display   = 'none';
			
			
            imgMaster.src = "../../../system/images/iconmaximize.gif";
			imgMaster.alt="Show Column";
        }
        else
        {
			grd_att.GetGridControl().ColHidden(g_date_in)=0;
			grd_att.GetGridControl().ColHidden(g_n1)=0;
			grd_att.GetGridControl().ColHidden(g_date_out)=0;
			grd_att.GetGridControl().ColHidden(g_n2)=0;
		    idlbN1.style.display   = '';
			D_IN.style.display   = '';
			idlbN2.style.display   = '';
			D_OUT.style.display   = '';	
            imgMaster.status = "expand";
            imgMaster.src = "../../../system/images/close_popup.gif";
			imgMaster.alt="Hide Column";
        }
  
}
//-----------------------------------------------------------------------------------
function OnDelete()
{
    var ctrl=grd_att.GetGridControl();
    grd_att.DeleteRow();
    for(var i=1;i<=ctrl.SelectedRows;i++)
       grd_att.SetGridText(ctrl.SelectedRow(i-1),g_s,"1");
    
    
}
//------------------------------------------------------------------------------------

function OnUndelete()
{
    var ctrl=grd_att.GetGridControl();
    grd_att.UnDeleteRow();
    for(var i=1;i<=ctrl.SelectedRows;i++)
       grd_att.SetGridText(ctrl.SelectedRow(i-1),g_s,"0");
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
function On_click()
{
    var ws;
	dt_tmp=grd_att.GetGridData(event.row,event.col)//luu tru gia tri vua click
	ws=grd_att.GetGridData(event.row,g_ws)
	lstWS_temp.value=ws;
	idlbWS.text=lstWS_temp.GetText();
	
}
function On_check_next(n)
{
    var flag,temp, ctrl=grd_att.GetGridControl();
    flag=0;
    if(n==1)//date in 
    {
        if (ctrl.SelectedRows>1)
        {
            if(D_IN.GetData()=='T')
             {
                    for(var i=1;i<=ctrl.SelectedRows;i++)
                    {
                        temp=grd_att.GetGridData(i,g_dt_next);
                        grd_att.SetGridText(ctrl.SelectedRow(i-1),g_date_in,temp);
                        grd_att.SetGridText(ctrl.SelectedRow(i-1),g_n1,'-1');
                    }
              }
              else
              {
                    for(var i=1;i<=ctrl.SelectedRows;i++)
                    {
                        temp=grd_att.GetGridData(i,g_dt_now);
                        grd_att.SetGridText(ctrl.SelectedRow(i-1),g_date_in,temp);
                        grd_att.SetGridText(ctrl.SelectedRow(i-1),g_n1,'0');
                    }
              } 
        }  
        else
        {
                      alert("Select more than 1 row please, 1 row, you can do in grid.\nViệc này chỉ cho phép khi bạn chọn nhiều hơn 1 dòng, 1 dòng thì chỉnh dưới lưới.")
                D_IN.value='F';

        }  
    }
    else if(n==2)
    {
        if (ctrl.SelectedRows>1)
        {
            if(D_OUT.GetData()=='T')
             {
                    for(var i=1;i<=ctrl.SelectedRows;i++)
                    {
                        temp=grd_att.GetGridData(i,g_dt_next);
                        grd_att.SetGridText(ctrl.SelectedRow(i-1),g_date_out,temp);
                        grd_att.SetGridText(ctrl.SelectedRow(i-1),g_n2,'-1');
                    }
              }
              else
              {
                    for(var i=1;i<=ctrl.SelectedRows;i++)
                    {
                            temp=grd_att.GetGridData(ctrl.SelectedRow(i-1),g_dt_now);
                            grd_att.SetGridText(ctrl.SelectedRow(i-1),g_date_out,temp);
                            grd_att.SetGridText(ctrl.SelectedRow(i-1),g_n2,'0');
                    }
              } 
        } 
        else
        {
           alert("Select more than 1 row please, 1 row, you can do in grid.\nViệc này chỉ cho phép khi bạn chọn nhiều hơn 1 dòng, 1 dòng thì chỉnh dưới lưới.")
                D_OUT.value='F';
        }     
    }    
}
//---------------------------------------------------------------------------
function Popup()
{
    var col=event.col;
    var flag=0;
    if((col==g_emp_id)||(col==g_full_nm))
    {
        var fpath = System.RootURL + "/form/ch/ba/chba00020_01.aspx?emp_pk=" + grd_att.GetGridData(event.row,g_emp_pk) + "&dt1=" +grd_att.GetGridData(event.row,g_dt_now)
        + "&dt2=" +grd_att.GetGridData(event.row,g_dt_next)+ "&emp_id=" +grd_att.GetGridData(event.row,g_emp_id);
        //
        //alert(g_emp_pk+"+"+g_emp_id+"+"+event.row,g_emp_id);
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:yes;dialogWidth:35;dialogHeight:20;dialogLeft:50;dialogTop:100;edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {
            if(obj[0]!="")
            {
                if(obj[0]!=grd_att.GetGridData(event.row,g_date_in))
                {
                    grd_att.SetGridText(event.row,g_date_in,obj[0]);
                    grd_att.SetCellBgColor(event.row, g_date_in,event.row, g_date_in, 0x3366FF );
                    grd_att.SetCellBold(event.row,g_date_in,event.row,g_date_in,true);
                    flag=1;
                }    
                if(obj[1]!=grd_att.GetGridData(event.row,g_in_time))
                {
                    grd_att.SetGridText(event.row,g_in_time,obj[1]);
                    grd_att.SetCellBgColor(event.row, g_in_time,event.row, g_in_time, 0x3366FF );
                    grd_att.SetCellBold(event.row,g_in_time,event.row,g_in_time,true);
	                flag=1;
	            }   
	            
            }
            if(obj[2]!="")
            {
                if(obj[2]!=grd_att.GetGridData(event.row,g_date_out))
                {
                    grd_att.SetGridText(event.row,g_date_out,obj[2]);
                    grd_att.SetCellBgColor(event.row, g_date_out,event.row, g_date_out, 0x3366FF );
                    grd_att.SetCellBold(event.row,g_date_out,event.row,g_date_out,true);
                    flag=1;
                }    
                if(obj[3]!=grd_att.GetGridData(event.row,g_out_time))
                {
                    grd_att.SetGridText(event.row,g_out_time,obj[3]);
                    grd_att.SetCellBgColor(event.row, g_out_time,event.row, g_out_time, 0x3366FF );
                    grd_att.SetCellBold(event.row,g_out_time,event.row,g_out_time,true);
                    flag=1;
	                
	            }    
	            
            }
            if(flag==1)
            {
                grd_att.SetGridText(event.row,g_wt,"");
                grd_att.SetGridText(event.row,g_s,"1");
            }    
            
        }
    }
    else if(col==g_ws)
    {
        var fpath = System.RootURL + "/form/ch/ba/chba00020_02.aspx?shift=" + grd_att.GetGridData(event.row,g_ws);
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:40;dialogHeight:15;dialogLeft:100;dialogTop:260;edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {
            if(obj[0]!=grd_att.GetGridData(event.row,g_ws))
            {
                grd_att.SetGridText(event.row,col,obj[0]);
                grd_att.SetCellBgColor(event.row, g_ws,event.row, g_ws, 0x3366FF );
                grd_att.SetCellBold(event.row,g_ws,event.row,g_ws,true);
                lstWS_temp.value=obj[0];
	            idlbWS.text=lstWS_temp.GetText();
	            grd_att.SetGridText(event.row,g_s,"1");
	            
            }
        }
            //alert(obj[0]);
    }
    else if(col==g_abs_code)
    {
        var fpath = System.RootURL + "/form/ch/ba/chba00020_03.aspx?abs_code=" + grd_att.GetGridData(event.row,g_abs_code);
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:50;dialogHeight:25;dialogLeft:200;dialogTop:230;edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {
            if(obj[0]!=grd_att.GetGridData(event.row,g_abs_code))
            {
                grd_att.SetGridText(event.row,col,obj[0]);
                grd_att.SetCellBgColor(event.row, g_abs_code,event.row, g_abs_code, 0x3366FF );
                grd_att.SetCellBold(event.row,g_abs_code,event.row,g_abs_code,true);
                grd_att.SetGridText(event.row,g_s,"1");
            }
        }
           
    }
    
  if(grd_att.GetGridData(event.row,g_s)=="1" && (grd_att.GetGridData(event.row,g_close)=="M"||grd_att.GetGridData(event.row,g_close)=="Y") )
	  {alert("You can't modify and save this record because salary period was closed! \nBạn không thể điều chỉnh và lưu thông tin của dòng dữ liệu này vì tháng lương đã đóng! ") ;
	      grd_att.SetGridText(event.row,g_s,"");
	      return;
	  }  
}
//---------------------------------------------------------------------------
function get_random(num)
{
    var ranNum= Math.floor(Math.random()*num);//tra ra so nguyen
    return ranNum;
}
//---------------------------------------------------------------
function OnSetToGrid()
{
	var gCtrl,i;
	var input_time,hh,mm1,mm2
	var mm_tmp, ran_var,result
	gCtrl=grd_att.GetGridControl();		
	mm1=Trim(idMM1.text);
	mm2=Trim(idMM2.text);
	hh=Trim(idHH.text);

	if(gCtrl.rows>1)
	{
		if(gCtrl.SelectedRows<=1)
		{
			if(confirm("Set to all blank records (not include holiday)?\nĐiền vào tất cả những dòng còn trống (không kể ngày nghỉ)?"))
			{
					for(i=1;i<gCtrl.rows;i++)
					{		
						if((Number(mm1)>=0)&&(Number(mm1)<60)&&(Number(mm2)>=0)&&(Number(mm2)<60)&&(Number(hh)>=0)&&(Number(hh)<=23)&&(Number(mm1)<Number(mm2))
							&&(mm1.length==2)&&(mm2.length==2)&&(hh.length==2))
						{
							mm_tmp=Number(mm2)-Number(mm1);
							ran_var=get_random(mm_tmp)+Number(mm1);
							if(Number(ran_var)<10)
								ran_var="0"+ran_var;
							result=hh+":"+ran_var;
							if (idLstInOut.value=="1") //in
							{
								if (grd_att.GetGridData(i,g_in_time)=="")
								{
									var day_type;
									day_type=grd_att.GetGridData(i,g_hol_type); //day type
									if(day_type==0)
									{
									   grd_att.SetGridText(i,g_in_time,result);
									   grd_att.SetGridText(i,g_s,"1");
									}   
								}
							}
							if (idLstInOut.value=="2") //out
							{
								
								if (grd_att.GetGridData(i,g_out_time)=="")
								{
									var day_type;
									day_type=grd_att.GetGridData(i,g_hol_type); //day type
									if(day_type==0)
									{
									   grd_att.SetGridText(i,g_out_time,result);
									   grd_att.SetGridText(i,g_s,"1");
									}   
									
								}
							}
						}							
						else if (idLstInOut.value=="3")
						  {      
								grd_att.SetGridText(i,g_wt,Trim(idHH.text));
								grd_att.SetGridText(i,g_s,"1");
						  }	    
						else if (idLstInOut.value=="4")
						{
								grd_att.SetGridText(i,g_ht_pk,Trim(idHH.text));
								grd_att.SetGridText(i,g_s,"1");
						}		
						else if (idLstInOut.value=="5")
						{
								grd_att.SetGridText(i,g_nt,Trim(idHH.text));
								grd_att.SetGridText(i,g_s,"1");
						}		
						else if (idLstInOut.value=="6")
						{
								grd_att.SetGridText(i,g_ht,Trim(idHH.text));
								grd_att.SetGridText(i,g_s,"1");
						}		
						else
						{
							alert("Incorrect type of time.(HH:00->24),(mm1,mm2: 00->60), pld try again\nKiểu giờ bạn nhập không đúng, hãy nhập lại?")
							return;
						}
					}
				}
			}
		else
		{			
			for(i=0;i<gCtrl.SelectedRows;i++)
			{
				var tmp=gCtrl.SelectedRow(i);	
				
				if((Number(mm1)>=0)&&(Number(mm1)<60)&&(Number(mm2)>=0)&&(Number(mm2)<60)&&(Number(hh)>=0)&&(Number(hh)<=23)&&(Number(mm1)<Number(mm2))
					&&(mm1.length==2)&&(mm2.length==2)&&(hh.length==2))
				{
					mm_tmp=Number(mm2)-Number(mm1)
					ran_var=get_random(mm_tmp)+Number(mm1)
					if(Number(ran_var)<10)
						ran_var="0"+ran_var
					result=hh+":"+ran_var
					
					if (idLstInOut.value=="1")
					{
						grd_att.SetGridText(tmp,g_in_time,result);
						grd_att.SetGridText(tmp,g_s,"1");
					}	
					if (idLstInOut.value=="2")
					{
						grd_att.SetGridText(tmp,g_out_time,result);
						grd_att.SetGridText(tmp,g_s,"1");
					}	
					
				}
				else if (idLstInOut.value=="3")
				{
					grd_att.SetGridText(tmp,g_wt,Trim(idHH.text));
					grd_att.SetGridText(tmp,g_s,"1");
				}	
				else if (idLstInOut.value=="4")
				{
					grd_att.SetGridText(tmp,g_ot,Trim(idHH.text));
					grd_att.SetGridText(tmp,g_s,"1");
				}	
				else if (idLstInOut.value=="5")
				{
					grd_att.SetGridText(tmp,g_nt,Trim(idHH.text));
					grd_att.SetGridText(tmp,g_s,"1");
				}	
				else if (idLstInOut.value=="6")
				{
					grd_att.SetGridText(tmp,g_ht,Trim(idHH.text));
					grd_att.SetGridText(tmp,g_s,"1");
				}	
				else
				{
					alert("Incorrect type of time.(HH:00->24),(mm1,mm2: 00->60), pld try again\nKiểu giờ bạn nhập không đúng, hãy nhập lại?");
					return;
				}
				
			}
		}
	}
}
//-------------------------------------------------------------
function onClearGrid()
{
	var ctrl,i
	ctrl=grd_att.GetGridControl();
	if(ctrl.SelectedRows<=1)
	{
		if(confirm("Set to all blank records"))
		{
			switch(idLstInOut.value)
			{
				case "1": //in
					for(i=1;i<ctrl.rows;i++)
					{
						grd_att.SetGridText(i,g_in_time,"")
						grd_att.SetGridText(i,g_s,"1");
					}	
				break;
				case "2": //out
					for(i=1;i<ctrl.rows;i++)
					{
						grd_att.SetGridText(i,g_out_time,"")
						grd_att.SetGridText(i,g_s,"1");
					}	
				break;
				case "3": //wt
					for(i=1;i<ctrl.rows;i++)
					{
						grd_att.SetGridText(i,g_wt,"")
						grd_att.SetGridText(i,g_s,"1");
					}	
				break;
				case "4": //ot
					for(i=1;i<ctrl.rows;i++)
					{
						grd_att.SetGridText(i,g_ot,"")
						grd_att.SetGridText(i,g_s,"1");
					}	
				break;
				case "5": //nt
					for(i=1;i<ctrl.rows;i++)
					{
						grd_att.SetGridText(i,g_nt,"")
						grd_att.SetGridText(i,g_s,"1");
					}	
				break;
				case "6": //ht
					for(i=1;i<ctrl.rows;i++)
					{
						grd_att.SetGridText(i,g_ht,"")
						grd_att.SetGridText(i,g_s,"1");
					}	
				break;
			}
		}
	}
	else
	{
		for(i=0;i<ctrl.SelectedRows;i++)
		{
			var tmp=ctrl.SelectedRow(i);	
			switch(idLstInOut.value)
			{
				case "1":
					grd_att.SetGridText(tmp,g_in_time,"")
					grd_att.SetGridText(tmp,g_s,"1");
				break;
				case "2":
					grd_att.SetGridText(tmp,g_out_time,"")
					grd_att.SetGridText(tmp,g_s,"1");
				break;
				case "3":
					grd_att.SetGridText(tmp,g_wt,"")
					grd_att.SetGridText(tmp,g_s,"1");
				break;
				case "4":
					grd_att.SetGridText(tmp,g_ot,"")
					grd_att.SetGridText(tmp,g_s,"1");
				break;
				case "5":
					grd_att.SetGridText(tmp,g_nt,"")
					grd_att.SetGridText(tmp,g_s,"1");
				break;
				case "6":
					grd_att.SetGridText(tmp,g_ht,"")
					grd_att.SetGridText(tmp,g_s,"1");
				break;
			}
		}
	}
}
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
function OnChangeShift()
{
    var ctrl,i
	ctrl=grd_att.GetGridControl();
	if(ctrl.SelectedRows>1 && lstWS.value!="ALL")
		for(i=0;i<ctrl.SelectedRows;i++)
    		grd_att.SetGridText(ctrl.SelectedRow(i),g_ws,lstWS.value)
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
    if (idPrint_type.value ==1)
        txtReport_tmp.text="rpt_absence.aspx";
        //var url =System.RootURL + '/reports/ch/ba/rpt_absence.aspx?p_user=' + user + '&p_wg=' + lstWG.value + '&p_search_by=' + idSearch.value + '&p_search_temp=' + idtxtTmp.text + '&p_tco_org_pk=' + lstOrg.value  + '&p_from_date=' +  txtFrom.text +'&p_to_date=' + txtTo.text + '&p_work_shift=' + lstWS.value + '&p_date_type=' + opt_value ;
    else if (idPrint_type.value ==2)
        txtReport_tmp.text="rpt_att_working_time.aspx";
        //var url =System.RootURL + '/reports/ch/ba/rpt_att_working_time.aspx?p_user=' + user + '&p_wg=' + lstWG.value + '&p_search_by=' + idSearch.value + '&p_search_temp=' + idtxtTmp.text + '&p_tco_org_pk=' + lstOrg.value  + '&p_from_date=' +  txtFrom.text +'&p_to_date=' + txtTo.text + '&p_work_shift=' + lstWS.value + '&p_date_type=' + opt_value ;
    else if (idPrint_type.value ==3)
        txtReport_tmp.text="rpt_att_incorrect_time.aspx";
        //var url =System.RootURL + '/reports/ch/ba/rpt_att_incorrect_time.aspx?p_user=' + user + '&p_wg=' + lstWG.value + '&p_search_by=' + idSearch.value + '&p_search_temp=' + idtxtTmp.text + '&p_tco_org_pk=' + lstOrg.value  + '&p_from_date=' +  txtFrom.text +'&p_to_date=' + txtTo.text + '&p_work_shift=' + lstWS.value + '&p_date_type=' + opt_value ;
    else if   (idPrint_type.value ==4)
        txtReport_tmp.text="rpt_attendence_absence.aspx";    
        //var url =System.RootURL + '/reports/ch/ba/rpt_attendence_absence.aspx?p_user=' + user + '&p_wg=' + lstWG.value + '&p_search_by=' + idSearch.value + '&p_search_temp=' + idtxtTmp.text + '&p_tco_org_pk=' + lstOrg.value  + '&p_from_date=' +  txtFrom.text +'&p_to_date=' + txtTo.text + '&p_work_shift=' + lstWS.value + '&p_date_type=' + opt_value ;
    datFind_Report.Call();    
    //window.open(url);
     
     
}

function onChange_org()
{
    //if(lstOrg.value!='ALL')
        datWorkGroup_info.Call();
}
</script>

<body>

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

<gw:data id="datAttendence_absence" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,5,6,8,9,11,12,13,14,15,16,17,19,20,21,23,24,25,27,29,30,31,32,33" function="hr_sel_10020002_ATT_ABS" procedure="hr_upd_10020002_ATT_ABS"> 
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

<table style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
	<table style="width:100%;height:17%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
	<tr style="height:5%;border:1">	
		<td colspan=2 align=right style="width:10%;border:1;color=Black" ><input type="radio" name="option_P" value="1" checked onclick="onClickOption(1)" ><font>Daily</font></td>
		<td colspan=2 align=right style="width:10%;border:1"><gw:datebox id="DailyDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
		<td align=right style="width:5%;border:1"></td>
		<td colspan=2 align=right style="width:10%;border:0"><input type="radio" name="option_P" value="2" onclick="onClickOption(2)" ><font size=3>From</font></td>
		<td colspan=2 align=right style="width:10%;border:0"><gw:datebox id="FromDT"  maxlen = "10" text="" styles='width:70%'lang="<%=Session("Lang")%>" /></td>
		<td align=right style="width:5%;border:0"><font>To</font> </td>
		<td colspan=2 align=right style="width:10%;border:0"><gw:datebox id="ToDT"  maxlen = "10" text="" styles='width:70%'lang="<%=Session("Lang")%>" /></td>
		<td align=right style="width:5%;border:0"></td>
        <td align=right colspan=2 style="width:10%;border:0"><input type="radio" name="option_P" value="3" onclick="onClickOption(3)" ><font>Month</font> </td>
		<td align=left colspan=3 style="width:15%;border:0"><gw:datebox id="Month"  text="" styles='width:50%'lang="<%=Session("Lang")%>" type=month /></td>
		<td  align=right valign="bottom" style="width:3%;border:0" ></td>
		<td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="Search" onclick="OnSearch()" /></td>
		<td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnSave" alt="Save" img="save" text="Save" onclick="OnUpdate()" /></td>
		<td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnDelete" alt="Delete" img="delete" text="Delete" onclick="OnDelete()" /></td>
		<td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnUnDelete" alt="UnDelete" img="udelete" text="UnDelete" onclick="OnUndelete()" /></td>
    </tr>	
    <tr style="height:5%;border:1">	
		<td align=right style="width:5%;border:0" ><a title="Click here to show Organization" onclick="OnShowPopup()" href="#tips" style="text-decoration : none; color=#0000FF">Organization</a></td>
		<td colspan=4 align=right style="width:20%;border:0"><gw:list  id="lstOrg"  maxlen = "100" styles='width:100%' onchange="onChange_org()" >
                <data>
                    <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                </data>
            </gw:list>
        </td>
		<td align=right style="width:5%;border:0">WGroup</td>
		<td colspan=3 align=right style="width:20%;border:0"><gw:list  id="lstWG"  maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("select pk, workgroup_nm from thr_work_group where del_if=0")%>|ALL|Select All</data></gw:list>
        </td>
        <td colspan=4 align=right style="border:0"><gw:list  id="lstWS" value="ALL"  maxlen = "100" styles='width:100%' onchange="OnChangeShift()">
                            <data><%=ESysLib.SetListDataSQL("SELECT pk,shift||'-'||remark FROM thr_work_shift WHERE DEL_IF = 0 and use_yn='Y'  order by shift")%>|ALL|WS-Select All</data></gw:list>
        </td>
        <td  colspan=2 align=right style="width:5%;border:0">Reg Allowance</td>
        <td colspan=3 align=right style="width:20%;border:0"><gw:list  id="lstReg"  maxlen = "100" styles='width:100%' >
                            <data>|ALL|Select All|1|Reg Allowance</data></gw:list>
        </td>
        <td align=right colspan=2 style="width:6%;border:0">Print</td>
         <td align=right colspan=3 style="width:9%;border:0"><gw:list  id="idPrint_type" value="4" styles='width:100%' onChange="">
                <data>|1|Absence|2|Working time|3|Incorrect time|4|Select All</data></gw:list>
         </td>
         <td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnRpt" alt="Report" img="excel" text="Report" onclick="OnReport()" /></td>
    </tr>	
    <tr style="height:5%">	
        <td colspan=1 align=right style="width:5%;border:0">Nation</td>	
        <td colspan=1 align=right style="width:8%;border:0">
            <gw:list id='lstNation' value='01'>
                <data>
                    <%=ESysLib.SetListDataSQL("select code, code_nm from vhr_hr_code v where v.ID='HR0009'")%>|ALL|Select All
                </data>
            </gw:list>
        </td>	
    	<td colspan=1 align=right style="width:6%;border:0"><font color="FF3399">Set Time</font></td>	
		<td colspan=2 align=right style="width:5%;border:0"><gw:list id="idLstInOut"  styles="width:100%" value="0" onchange="change_list()"><data>|0|Choose...|1|Random IN|2|Random OUT|3|WT|4|OT|5|NT|6|HT</data></gw:list ></td>
		<td align=right style="width:5%;border:0"><gw:label id="idlbHH" styles="width:100%">HH</gw:label></td>
		<td align=right style="width:5%;border:0"><gw:textbox id="idHH" maxlen = "5" styles="width:100%" onkeypress="" /></td>
		<td align=right style="width:5%;border:0"><gw:label id="idlbMM1" styles="width:100%">MM1</gw:label></td>
		<td align=right style="width:5%;border:0"><gw:textbox id="idMM1" maxlen = "2" styles="width:100%"  onkeypress="return Numbers(event)"/></td>
		<td align=right style="width:5%;border:0"><gw:label id="idlbMM2" styles="width:100%">MM2</gw:label></td>
		<td align=right style="width:5%;border:0"><gw:textbox id="idMM2"	maxlen = "2" styles="width:100%" onkeypress="return Numbers(event)" /></td>
		<td align=right style="width:5%;border:0"><gw:icon id="idBtnSet"  styles='width:90%' img="in"  text="Set"  onclick="OnSetToGrid()"/></td>
		<td align=right style="width:5%;border:0"><gw:icon id="idBtnClear"  styles='width:90%' img="in"  text="Clear"  onclick="onClearGrid()"/></td>
		<td align=right style="width:5%;border:0">Search</td>
		<td colspan=1 align=right style="width:8%;border:0"><gw:list  id="idSearch" value="1" styles="width:95%" onChange="">
                <data>|1|Emp ID|2|Card ID|3|Name</data></gw:list></td>
		<td colspan=2 align=right style="width:8%;border:0"><gw:textbox id="idtxtTmp" maxlen = "20" styles="width:97%" onenterkey="OnSearch()" /></td>
		<td align=center style="width:3%;border:0"><gw:label id="idInterval" text="" styles="width:100%" ></gw:label></td>
		<td colspan=5 align=center style="width:19%;border:0"><gw:label id="idRecord" text="0 record(s)" styles="width:100%" ></gw:label></td>
		
    </tr>	
    <tr style="height:2%;border:inherit">	
        <td align=right style="width:5%;border:1" ><gw:checkbox id="chkSelectAll" value="F" onclick="OnSelectAll(chkSelectAll,grd_att)" ></gw:checkbox ></td>
        <td colspan=2 align=left style="width:10%;border:1" >Select All</td>
        <td colspan=5 align=center style="width:25%;border:1" style="color=#FF00CC"><gw:label id="idlbWtOtNtHt" styles="width:100%;"></gw:label></td>
        <td align=right style="width:5%;border:0" ><gw:label id="idlbN1" styles="width:100%">N</gw:label></td>
        <td align=left style="width:5%;border:0" ><gw:checkbox id="D_IN" value="F" onclick="On_check_next(1)" ></gw:checkbox ></td>
        <td align=center valign=middle style="width:5%;border:inherit" ><img status="collapse" id="imgMaster" alt="Show Column" src="../../../system/images/iconmaximize.gif" style="cursor:hand;position:absolute;" onclick="OnToggle()"  /></td>
		<td align=right style="width:5%;border:0" ><gw:label id="idlbN2" styles="width:100%">N</gw:label></td>
		<td align=left style="width:5%;border:0" ><gw:checkbox id="D_OUT" value="F" onclick="On_check_next(2)" ></gw:checkbox ></td>
		<td colspan=9 align=center style="width:40%;border:0" ><gw:label id="idlbWS" styles="width:100%;color:red"></gw:label></b></td>
    </tr>	
	</table>
	<table id="tbl" style="width:100%;height:78%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
		<tr style="height:100%">
			<td id="master" width="100%">
				<gw:grid
					id="grd_att"
					header="_EMP_PK|ORGANIZATION|W-GROUP|EMP_ID|FULL_NM|W_S|DATE_IN|N|IN TIME|DATE_OUT|N|OUT TIME|WT|OT|NT|HT|ABSENCE CODE|H|Remain ALE|_WKD_PK|_OT_PK|_ABS_PK|WorkDT|_NT_PK|_HT_PK|_Date_Now|_date_next|_Hol_type|Mod by hand|_No Scan|_S|Temp In|Temp Out|Temp Hour|_close"
					format="0|0|0|0|0|0|4|3|0|4|3|0|0|0|0|0|0|0|1|0|0|0|0|0|0|0|0|0|0|3|0|0|0|0|0"
					aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|0|0|0|0|0|0"
					defaults="|||||||||||||||||||||||||||||||||||"
					editcol="0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|0|0|0|0|0|0|0|0|0|0|0|1|0|1|1|1|0"
					widths="0|1500|1000|1000|2500|500|1200|300|1000|1200|300|1000|500|500|500|500|1500|300|0|0|0|0|1500|0|0|0|0|0|1500|500|0|1000|1000|1000|0"
					styles="width:100%;height:100%"
					sorting="T"
					onafteredit="On_AfterEdit()"
					acceptNullDate="T"
					oncelldblclick = "Popup()"
					onentercell = "On_click()"/>
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
                            <data><%=ESysLib.SetListDataSQL("SELECT PK,shift||'-'||remark FROM thr_work_shift WHERE DEL_IF = 0 and use_yn='Y'  order by shift")%>|ALL|WS-Select All</data></gw:list>
    <gw:textbox id="txtReport_tmp" styles="display:none"/>                            
	
</body>
</html>

