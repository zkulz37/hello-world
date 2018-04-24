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
var opt_value2=1;

var user;
var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);	
     idemp_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    user= "<%=session("USER_ID")%>";
    <%=ESysLib.SetGridColumnComboFormat( "grd_att" , 15 , "select a.CODE,a.CODE_NM from vhr_hr_code a where a.id='HR0003' and a.code<>'MLE' union SELECT NULL,'' FROM DUAL ")%>;        
    <%=ESysLib.SetGridColumnComboFormat( "grd_att" , 4 , "select A.PK,A.SHIFT from THR_WORK_SHIFT A where a.del_if=0 AND A.USE_YN='Y' ORDER BY A.SHIFT") %>; 
      lstOrg.value="ALL";
	  lstGrp_Code.value="ALL";
	  FromDT.SetEnable(0);
	  ToDT.SetEnable(0);
	  Month.SetEnable(0);
	  grd_att.GetGridControl().ColEditMask(7)="99:99";
	  grd_att.GetGridControl().ColEditMask(10)="99:99";	
	  grd_att.GetGridControl().FrozenCols =4;
	  grd_att.GetGridControl().ScrollTrack=true;
	  onSetEnable(0);
	  onSetEnable2(0);
	  
	grd_att.GetGridControl().ColHidden(5)=1;
	grd_att.GetGridControl().ColHidden(6)=1;
	grd_att.GetGridControl().ColHidden(8)=1;
	grd_att.GetGridControl().ColHidden(9)=1;
	idlbN1.style.display   = 'none';
	D_IN.style.display   = 'none';
	idlbN2.style.display   = 'none';
	D_OUT.style.display   = 'none';
	tb1.style.display='none';
			
	if((Trim(idemp_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	{
        datUser_info.Call();     	    
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
///----------------------
function set_Interval2(x) 
{
 startTime = new Date().valueOf();
 interval_time=setInterval("clock2(" + startTime + "," + x  + ")",x);
}

function clock2(start,x) 
{
 var d = new Date()
 idInterval2.text= Math.round((d.valueOf()-start)/x);

}

//------------------------------------------------------------------------------------

function clear_Interval(obj)
{
	clearInterval(interval_time);
	obj.text="";
}
//------------------------------------------------------------------------------------

function OnShowPopup()
{
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:'+window.event.screenX+';dialogTop:'+window.event.screenY+';edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {
             txtUpperDept.text=obj;
			 lstOrg.value=obj;
             //datDeptData.Call();
        }
}


//------------------------------------------------------------------------------------

function OnChangeDept()
{
    //txtDept.text=lstOrg.value;

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
           
       }
       
       else if (obj.id=="datAttendence_absence")
       {
            clear_Interval(idInterval);
            idRecord.text=grd_att.rows-1 + " Rec(s)."
            if(grd_att.rows>1)
            {
                var wt,ot,nt,ht,abs;
                wt=ot=nt=ht=abs=0;
                onSetEnable(1);
                if(idLstInOut.value!="0")
                    onSetEnable2(1);
                for(var i=1;i<grd_att.rows;i++)
                {
                    if(Trim(grd_att.GetGridData(i,25))!="")
                    {
                        if(Trim(grd_att.GetGridData(i,25))=="HOL")
                        {
                            grd_att.SetCellBgColor(i, 14,i, 14, 0x3366FF );
                            grd_att.SetCellBold(i,14,i,14,true);
                        }
                        else    
                        {
                            grd_att.SetCellBgColor(i, 14,i, 14, 0xCC9900 );
                            grd_att.SetCellBold(i,14,i,14,true);
                        }
                    }
                    if(grd_att.GetGridData(i,5)!=grd_att.GetGridData(i,23))
                        grd_att.SetGridText(i,6,'-1');
                    if(grd_att.GetGridData(i,8)!=grd_att.GetGridData(i,23))
                        grd_att.SetGridText(i,9,'-1'); 
                    if(Trim(grd_att.GetGridData(i,11))==""?wt+=0:wt+=Number(grd_att.GetGridData(i,11)));       
                    if(Trim(grd_att.GetGridData(i,12))==""?ot+=0:ot+=Number(grd_att.GetGridData(i,12)));
                    if(Trim(grd_att.GetGridData(i,13))==""?nt+=0:nt+=Number(grd_att.GetGridData(i,13)));
                    if(Trim(grd_att.GetGridData(i,14))==""?ht+=0:ht+=Number(grd_att.GetGridData(i,14)));
                    if(Trim(grd_att.GetGridData(i,16))==""?abs+=0:abs+=Number(grd_att.GetGridData(i,16)));
                        
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
       else if (obj.id=="datFind_Report")
       {    
            if (idPrint_type.value ==1)
                    var url =System.RootURL + '/reports/ch/om/'+txtReport_tmp.text+'?p_user=' + user + '&p_thr_wg_pk=' + lstGrp_Code.value + '&p_search_by=' + idSearch.value + '&p_search_temp=' + idtxtTmp.text + '&p_tco_org_pk=' + lstOrg.value  + '&p_from_date=' +  txtFrom.text +'&p_to_date=' + txtTo.text + '&p_work_shift=' + lstWS.value + '&p_date_type=' + opt_value + '&p_nation=' + lstForeigner.value;
            else if (idPrint_type.value ==2)
                 var url =System.RootURL + '/reports/ch/om/'+txtReport_tmp.text+'?p_user=' + user + '&p_thr_wg_pk=' + lstGrp_Code.value + '&p_search_by=' + idSearch.value + '&p_search_temp=' + idtxtTmp.text + '&p_tco_org_pk=' + lstOrg.value  + '&p_from_date=' +  txtFrom.text +'&p_to_date=' + txtTo.text + '&p_work_shift=' + lstWS.value + '&p_date_type=' + opt_value + '&p_nation=' + lstForeigner.value;
            else if (idPrint_type.value ==3)
                var url =System.RootURL + '/reports/ch/om/'+txtReport_tmp.text+'?p_user=' + user + '&p_thr_wg_pk=' + lstGrp_Code.value + '&p_search_by=' + idSearch.value + '&p_search_temp=' + idtxtTmp.text + '&p_tco_org_pk=' + lstOrg.value  + '&p_from_date=' +  txtFrom.text +'&p_to_date=' + txtTo.text + '&p_work_shift=' + lstWS.value + '&p_date_type=' + opt_value + '&p_nation=' + lstForeigner.value;
            else
                var url =System.RootURL + '/reports/ch/om/'+txtReport_tmp.text+'?p_user=' + user + '&p_thr_wg_pk=' + lstGrp_Code.value + '&p_search_by=' + idSearch.value + '&p_search_temp=' + idtxtTmp.text + '&p_tco_org_pk=' + lstOrg.value  + '&p_from_date=' +  txtFrom.text +'&p_to_date=' + txtTo.text + '&p_work_shift=' + lstWS.value + '&p_date_type=' + opt_value + '&p_nation=' + lstForeigner.value;
            window.open(url);
       }  
       else if (obj.id=="datProcess_magic")  
       {
            clear_Interval(idInterval2);
            if(txtResult.text=='0')
            {
                alert("Successful.\nTiến trình thực hiện thành công.");
                idInterval2.text="Sucessful!";
            }
            else
            {
                alert("There is error when system processing.\nĐã có lỗi xảy ra.");
                idInterval2.text="Unsucessful!";
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

function onClickOption(m,n)
{   
    opt_value=n;
    if(m==1)
    {
        switch(n)
        {
            case 1:
                DailyDT_T.SetEnable(1);
                FromDT_T.SetEnable(0);
	            ToDT_T.SetEnable(0);
	            Month_T.SetEnable(0);
	            break;
	        case 2:
	            DailyDT_T.SetEnable(0);
                FromDT_T.SetEnable(1);
	            ToDT_T.SetEnable(1);
	            Month_T.SetEnable(0);
	            break;   
	        case 3:
	            DailyDT_T.SetEnable(0);
                FromDT_T.SetEnable(0);
	            ToDT_T.SetEnable(0);
	            Month_T.SetEnable(1);
	            break;        
        }
    }
    else
    {
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
	ws=grd_att.GetGridData(event.row,4)
	lstWS_temp.value=ws;
	idlbWS.text=lstWS_temp.GetText();
	if (cIdx==7)
	{
		tmpIN=grd_att.GetGridData(event.row,cIdx)
		if(tmpIN.length==0)
		{
			grd_att.SetGridText(event.row,cIdx,"")
			
		}
		if((tmpIN.length!=4)&&(tmpIN.length!=0))
		{
			alert("Input In time is not correct type.(type: hh:mm)\nKiểu giờ in nhập không đúng")
			grd_att.SetGridText(event.row,cIdx,'')
			return;
		}
		if((Number(tmpIN.substr(0,2))>=24)||(Number(tmpIN.substr(0,2))<0))
		{
			alert("Input In time(Hour) is not correct type.(00<= hh <= 23)\nKiểu giờ in phải >=00 và <=23")
			grd_att.SetGridText(event.row,cIdx,'')
			return;
		}
		if((Number(tmpIN.substr(2,2))>=60)||(Number(tmpIN.substr(2,2))<0))
		{
			alert("Input In time(Minute) is not correct type.(00<= hh < 59)\nKiểu phút phải >=00 và <=59")
			grd_att.SetGridText(event.row,cIdx,'')
			return;
		}
		if(tmpIN.length>0)
		{
		    tmpIN=tmpIN.substr(0,2)+":"+tmpIN.substr(2,2)
		    grd_att.SetGridText(event.row,cIdx,tmpIN)
		}    
	}
	if (cIdx==10)
	{
		tmpOUT=grd_att.GetGridData(event.row,cIdx)
		if(tmpOUT.length==0)
		{
			grd_att.SetGridText(event.row,cIdx,"")
		}
		if((tmpOUT.length!=4)&&(tmpOUT.length!=0))
		{
			alert("Input Out time is not correct type.(type: hh:mm)\nKiểu giờ out không đúng(hh:mm)")
			grd_att.SetGridText(event.row,cIdx,'')
			return;
		}
		if((Number(tmpOUT.substr(0,2))>=24)||(Number(tmpOUT.substr(0,2))<0))
		{
			alert("Input Out time(Hour) is not correct type.(00<= hh <= 23)\nKiểu giờ out phải >=00 và <=23")
			grd_att.SetGridText(event.row,cIdx,'')
			return;
		}
		if((Number(tmpOUT.substr(2,2))>=60)||(Number(tmpOUT.substr(2,2))<0))
		{
			alert("Input Out time(Minute) is not correct type.(00<= hh < 60)\nKiểu phút phải >=00 và <=59")
			grd_att.SetGridText(event.row,cIdx,'')
			return;
		}
		if(tmpOUT.length>0)
		{
		    tmpOUT=tmpOUT.substr(0,2)+":"+tmpOUT.substr(2,2)
		    grd_att.SetGridText(event.row,cIdx,tmpOUT)
		}    
	}		
	if ((cIdx==5)||(cIdx==8)) //date in out
	{
		tmpDT=grd_att.GetGridData(event.row,cIdx)
		if(Number(tmpDT)<Number(grd_att.GetGridData(event.row,23))-1||Number(tmpDT)>Number(grd_att.GetGridData(event.row,23))+1)
		{
		    if(!confirm("You choose date maybe not correct, Do you want to keep?\nBạn đã chọn ngày không hợp lệ, Bạn chắc chắn?"))
		        grd_att.SetGridText(event.row,cIdx,dt_tmp);
		}   
	}		
	if (cIdx==15||cIdx==4) //ABS
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
    if (cIdx==11) //WT      
    {
        if(Number(grd_att.GetGridData(event.row,cIdx))>0&&grd_att.GetGridData(event.row,25)!="")
        {
            alert("This day is holiday, haven't WT.\nNgày này là ngày nghỉ không thể có giờ làm việc chính thức.")
            grd_att.SetGridText(event.row,cIdx,'0');
        }
    }
    //chkSelectAll.value='F';
	if(cIdx==6)
	{
	    if(grd_att.GetGridData(event.row,6)==0)
	    {   
	        temp=grd_att.GetGridData(event.row,23)
	        grd_att.SetGridText(event.row,5,temp)
	    }
	    else    
	    {
	        temp=grd_att.GetGridData(event.row,24)
	        grd_att.SetGridText(event.row,5,temp)
	    }
	}
	else if(cIdx==9)
	{
	    if(grd_att.GetGridData(event.row,9)==0)
	    {   
	        temp=grd_att.GetGridData(event.row,23)
	        grd_att.SetGridText(event.row,8,temp)
	    }
	    else    
	    {
	        temp=grd_att.GetGridData(event.row,24)
	        grd_att.SetGridText(event.row,8,temp)
	    }
	}
	if(dt_tmp!=grd_att.GetGridData(event.row,cIdx))
	{
	    grd_att.SetGridText(event.row,28,"1");
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
    if((opt_value!=1)&&(lstOrg.value=="ALL")&&(lstGrp_Code.value=="ALL")&&(idtxtTmp.text==""))
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
			grd_att.GetGridControl().ColHidden(5)=1;
			grd_att.GetGridControl().ColHidden(6)=1;
			grd_att.GetGridControl().ColHidden(8)=1;
			grd_att.GetGridControl().ColHidden(9)=1;
			idlbN1.style.display   = 'none';
			D_IN.style.display   = 'none';
			idlbN2.style.display   = 'none';
			D_OUT.style.display   = 'none';
			
			
            imgMaster.src = "../../../system/images/iconmaximize.gif";
			imgMaster.alt="Show Column";
        }
        else
        {
			grd_att.GetGridControl().ColHidden(5)=0;
			grd_att.GetGridControl().ColHidden(6)=0;
			grd_att.GetGridControl().ColHidden(8)=0;
			grd_att.GetGridControl().ColHidden(9)=0;
		    idlbN1.style.display   = '';
			D_IN.style.display   = '';
			idlbN2.style.display   = '';
			D_OUT.style.display   = '';	
            imgMaster.status = "expand";
            imgMaster.src = "../../../system/images/close_popup.gif";
			imgMaster.alt="Hide Column";
        }
        
  
}
//------------------------------------------------
function OnToggle_T(n)
{
    if(n==1)
    {
        if(img_T1.status == "expand")
        {
            tb1.style.display='none';
            tb2.style.display='';
            tb3.style.display='';
            //img_T1.status = "collapse";
           // img_T1.src = "../../../system/images/iconmaximize.gif";
			//img_T1.alt="Show expand";
        }
        
    }
    else
    {
        if(img_T2.status == "collapse")
        {
			
			tb1.style.display='';
			tb2.style.display='none';
            tb3.style.display='none';
            //img_T2.status = "expand";
           // img_T2.src = "../../../system/images/close_popup.gif";
			//img_T2.alt="Hide expand";
        }
     }   
  
}
//-----------------------------------------------------------------------------------
function OnDelete()
{
    var ctrl=grd_att.GetGridControl();
    grd_att.DeleteRow();
    for(var i=1;i<=ctrl.SelectedRows;i++)
       grd_att.SetGridText(ctrl.SelectedRow(i-1),28,"1");
    
    
}
//------------------------------------------------------------------------------------

function OnUndelete()
{
    var ctrl=grd_att.GetGridControl();
    grd_att.UnDeleteRow();
    for(var i=1;i<=ctrl.SelectedRows;i++)
       grd_att.SetGridText(ctrl.SelectedRow(i-1),28,"0");
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
	ws=grd_att.GetGridData(event.row,4)
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
                        temp=grd_att.GetGridData(i,24);
                        grd_att.SetGridText(ctrl.SelectedRow(i-1),5,temp);
                        grd_att.SetGridText(ctrl.SelectedRow(i-1),6,'-1');
                    }
              }
              else
              {
                    for(var i=1;i<=ctrl.SelectedRows;i++)
                    {
                        temp=grd_att.GetGridData(i,23);
                        grd_att.SetGridText(ctrl.SelectedRow(i-1),5,temp);
                        grd_att.SetGridText(ctrl.SelectedRow(i-1),6,'0');
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
                        temp=grd_att.GetGridData(i,24);
                        grd_att.SetGridText(ctrl.SelectedRow(i-1),8,temp);
                        grd_att.SetGridText(ctrl.SelectedRow(i-1),9,'-1');
                    }
              }
              else
              {
                    for(var i=1;i<=ctrl.SelectedRows;i++)
                    {
                            temp=grd_att.GetGridData(ctrl.SelectedRow(i-1),23);
                            grd_att.SetGridText(ctrl.SelectedRow(i-1),8,temp);
                            grd_att.SetGridText(ctrl.SelectedRow(i-1),9,'0');
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
    if((col==2)||(col==3))
    {
        var fpath = System.RootURL + "/form/ch/ba/chba00020_01.aspx?emp_pk=" + grd_att.GetGridData(event.row,0) + "&dt1=" +grd_att.GetGridData(event.row,23)
        + "&dt2=" +grd_att.GetGridData(event.row,24)+ "&emp_id=" +grd_att.GetGridData(event.row,2);
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:35;dialogHeight:20;dialogLeft:50;dialogTop:100;edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {
            if(obj[0]!="")
            {
                if(obj[0]!=grd_att.GetGridData(event.row,5))
                {
                    grd_att.SetGridText(event.row,5,obj[0]);
                    grd_att.SetCellBgColor(event.row, 5,event.row, 5, 0x3366FF );
                    grd_att.SetCellBold(event.row,5,event.row,5,true);
                    flag=1;
                }    
                if(obj[1]!=grd_att.GetGridData(event.row,7))
                {
                    grd_att.SetGridText(event.row,7,obj[1]);
                    grd_att.SetCellBgColor(event.row, 7,event.row, 7, 0x3366FF );
                    grd_att.SetCellBold(event.row,7,event.row,7,true);
	                flag=1;
	            }   
	            
            }
            if(obj[2]!="")
            {
                if(obj[2]!=grd_att.GetGridData(event.row,8))
                {
                    grd_att.SetGridText(event.row,8,obj[2]);
                    grd_att.SetCellBgColor(event.row, 8,event.row, 8, 0x3366FF );
                    grd_att.SetCellBold(event.row,8,event.row,8,true);
                    flag=1;
                }    
                if(obj[3]!=grd_att.GetGridData(event.row,10))
                {
                    grd_att.SetGridText(event.row,10,obj[3]);
                    grd_att.SetCellBgColor(event.row, 10,event.row, 10, 0x3366FF );
                    grd_att.SetCellBold(event.row,10,event.row,10,true);
                    flag=1;
	                
	            }    
	            
            }
            if(flag==1)
            {
                grd_att.SetGridText(event.row,11,"");
                grd_att.SetGridText(event.row,28,"1");
            }    
        }
    }
    else if(col==4)
    {
        var fpath = System.RootURL + "/form/ch/ba/chba00020_02.aspx?shift=" + grd_att.GetGridData(event.row,4);
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:40;dialogHeight:15;dialogLeft:100;dialogTop:260;edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {
            if(obj[0]!=grd_att.GetGridData(event.row,4))
            {
                grd_att.SetGridText(event.row,col,obj[0]);
                grd_att.SetCellBgColor(event.row, 4,event.row, 4, 0x3366FF );
                grd_att.SetCellBold(event.row,4,event.row,4,true);
                lstWS_temp.value=obj[0];
	            idlbWS.text=lstWS_temp.GetText();
	            grd_att.SetGridText(event.row,28,"1");
	            
            }
        }
            //alert(obj[0]);
    }
    else if(col==15)
    {
        var fpath = System.RootURL + "/form/ch/ba/chba00020_03.aspx?abs_code=" + grd_att.GetGridData(event.row,15);
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:50;dialogHeight:25;dialogLeft:200;dialogTop:230;edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {
            if(obj[0]!=grd_att.GetGridData(event.row,15))
            {
                grd_att.SetGridText(event.row,col,obj[0]);
                grd_att.SetCellBgColor(event.row, 15,event.row, 15, 0x3366FF );
                grd_att.SetCellBold(event.row,15,event.row,15,true);
                grd_att.SetGridText(event.row,28,"1");
            }
        }
           
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
								if (grd_att.GetGridData(i,7)=="")
								{
									var day_type;
									day_type=grd_att.GetGridData(i,25); //day type
									if(day_type==0)
									{
									   grd_att.SetGridText(i,7,result);
									   grd_att.SetGridText(i,28,"1");
									}   
								}
							}
							if (idLstInOut.value=="2") //out
							{
								
								if (grd_att.GetGridData(i,10)=="")
								{
									var day_type;
									day_type=grd_att.GetGridData(i,25); //day type
									if(day_type==0)
									{
									   grd_att.SetGridText(i,10,result);
									   grd_att.SetGridText(i,28,"1");
									}   
									
								}
							}
						}							
						else if (idLstInOut.value=="3")
						  {      
								grd_att.SetGridText(i,11,Trim(idHH.text));
								grd_att.SetGridText(i,28,"1");
						  }	    
						else if (idLstInOut.value=="4")
						{
								grd_att.SetGridText(i,12,Trim(idHH.text));
								grd_att.SetGridText(i,28,"1");
						}		
						else if (idLstInOut.value=="5")
						{
								grd_att.SetGridText(i,13,Trim(idHH.text));
								grd_att.SetGridText(i,28,"1");
						}		
						else if (idLstInOut.value=="6")
						{
								grd_att.SetGridText(i,14,Trim(idHH.text));
								grd_att.SetGridText(i,28,"1");
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
						grd_att.SetGridText(tmp,7,result);
						grd_att.SetGridText(tmp,28,"1");
					}	
					if (idLstInOut.value=="2")
					{
						grd_att.SetGridText(tmp,10,result);
						grd_att.SetGridText(tmp,28,"1");
					}	
					
				}
				else if (idLstInOut.value=="3")
				{
					grd_att.SetGridText(tmp,11,Trim(idHH.text));
					grd_att.SetGridText(tmp,28,"1");
				}	
				else if (idLstInOut.value=="4")
				{
					grd_att.SetGridText(tmp,12,Trim(idHH.text));
					grd_att.SetGridText(tmp,28,"1");
				}	
				else if (idLstInOut.value=="5")
				{
					grd_att.SetGridText(tmp,13,Trim(idHH.text));
					grd_att.SetGridText(tmp,28,"1");
				}	
				else if (idLstInOut.value=="6")
				{
					grd_att.SetGridText(tmp,14,Trim(idHH.text));
					grd_att.SetGridText(tmp,28,"1");
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
						grd_att.SetGridText(i,7,"")
						grd_att.SetGridText(i,28,"1");
					}	
				break;
				case "2": //out
					for(i=1;i<ctrl.rows;i++)
					{
						grd_att.SetGridText(i,10,"")
						grd_att.SetGridText(i,28,"1");
					}	
				break;
				case "3": //wt
					for(i=1;i<ctrl.rows;i++)
					{
						grd_att.SetGridText(i,11,"")
						grd_att.SetGridText(i,28,"1");
					}	
				break;
				case "4": //ot
					for(i=1;i<ctrl.rows;i++)
					{
						grd_att.SetGridText(i,12,"")
						grd_att.SetGridText(i,28,"1");
					}	
				break;
				case "5": //nt
					for(i=1;i<ctrl.rows;i++)
					{
						grd_att.SetGridText(i,13,"")
						grd_att.SetGridText(i,28,"1");
					}	
				break;
				case "6": //ht
					for(i=1;i<ctrl.rows;i++)
					{
						grd_att.SetGridText(i,14,"")
						grd_att.SetGridText(i,28,"1");
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
					grd_att.SetGridText(tmp,7,"")
					grd_att.SetGridText(tmp,28,"1");
				break;
				case "2":
					grd_att.SetGridText(tmp,10,"")
					grd_att.SetGridText(tmp,28,"1");
				break;
				case "3":
					grd_att.SetGridText(tmp,11,"")
					grd_att.SetGridText(tmp,28,"1");
				break;
				case "4":
					grd_att.SetGridText(tmp,12,"")
					grd_att.SetGridText(tmp,28,"1");
				break;
				case "5":
					grd_att.SetGridText(tmp,13,"")
					grd_att.SetGridText(tmp,28,"1");
				break;
				case "6":
					grd_att.SetGridText(tmp,14,"")
					grd_att.SetGridText(tmp,28,"1");
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
    		grd_att.SetGridText(ctrl.SelectedRow(i),4,lstWS.value)
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
        txtReport_tmp.text="rpt_absence_ur.aspx";
        
    else if (idPrint_type.value ==2)
        txtReport_tmp.text="rpt_att_working_time_ur.aspx";
        
    else if (idPrint_type.value ==3)
        txtReport_tmp.text="rpt_att_incorrect_time_ur.aspx";
        
    else
        txtReport_tmp.text="rpt_attendence_absence_ur.aspx";
        
    datFind_Report.Call();    
 
}
function onOption(n)
{
    opt_value2=n;
}
function Process(flag)
{
   txt_flag.text=flag;
   if(flag=='DEL')
   {
        if(!confirm("Do you want to delete?\nBạn thực sự muốn xóa?"))
            return;
   }
   else
        if(!confirm("Magic process data will take several seconds?\nTiến trình dữ liệu ảo bắt đầu, vui lòng đợi trong giây lát"))
            return;
            
   switch(opt_value2)
    {
        case 1:
           txtFrom.text=DailyDT_T.value
           txtTo.text=DailyDT_T.value
	        break;
	    case 2:
	        txtFrom.text=FromDT_T.value
            txtTo.text=ToDT_T.value
	        break;   
	    case 3:
	        txtFrom.text=Month_T.value+"01"
            txtTo.text=Month_T.value+"31"
	        break;        
    }
   set_Interval2(1000);         
   datProcess_magic.Call();
    
}
</script>
<style>
.top { border-top:1px solid #034D72; }
.topright { border-top :1px solid #034D72;
			border-right: 1px solid #034D72;;padding-right:10px
			}
.topleft {border-left:1px solid #034D72; 
			border-top :1px solid #034D72;
			}
.left { border-left:1px solid #034D72; }
.right { border-right:1px solid #034D72;padding-right:10px }
.bottomright { border-bottom:1px solid #034D72; 
				border-right:1px solid #034D72; padding-right:10px
				}
.bottomleft { border-bottom:1px solid #034D72; 
				border-left:1px solid #034D72;;
			}
.bottom { border-bottom:1px solid #034D72; }

.topleftbottom { border-left:1px solid #034D72; 
			border-top :1px solid #034D72;
			border-bottom:1px solid #034D72; }

.topbottom {border-top :1px solid #034D72;
			border-bottom:1px solid #034D72; }
			
.toprightbottom { border-right:1px solid #034D72; 
			border-top :1px solid #034D72;
			border-bottom:1px solid #034D72;
			}		
			
.toprightleft { border-right:1px solid #034D72; 
			border-top :1px solid #034D72;
			border-left:1px solid #034D72;
			}						
			

.toprightbottomleft { border-right:1px solid #034D72; 
			border-top :1px solid #034D72;
			border-bottom:1px solid #034D72;
			border-left:1px solid #034D72;  }
	
#up { background-color:#DFF2FF; }
#down { background-color:#EAEAEA; }

</style>
<body>
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr.sp_sel_user_role2"  > 
                <input>
                    <input bind="idemp_pk" />
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

<gw:data id="datAttendence_absence" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,4,5,7,8,10,11,12,13,14,15,16,17,18,19,21,22,23,25,27,28,29" function="HR.SP_SEL_ATT_ABS_UR_SSA" procedure="HR.SP_UPD_ATT_ABS_UR_SSA"> 
                <input bind="grd_att" >
                    <input bind="lstOrg" />
                    <input bind="lstGrp_Code" />
                    <input bind="lstWS" />
                    <input bind="txtFrom" />
                    <input bind="txtTo" />
                    <input bind="idSearch" />
                    <input bind="idtxtTmp" />
                    <input bind="lstForeigner" />
                </input>
                <output  bind="grd_att" />
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

<gw:data id="datProcess_magic" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.SP_PROCESS_MAGIC_DATA" > 
                <input>
                     <input bind="txtFrom" />
                    <input bind="txtTo" />
                    <input bind="txt_flag" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

	<table id="tb1" style="width:100%;height:7%" cellpadding="0" cellspacing="0" valign="top" border="1" class="toprightbottomleft" >
	<tr  style="height:10%;border:1; width:100%" >	
	    <td align=left valign=top style="width:3%;border:inherit" ><img status="expand" id="img_T1" alt="Show Column" src="../../../system/images/close_popup.gif" style="cursor:hand;position:absolute;" onclick="OnToggle_T(1)"  /></td>
		<td colspan=2 align=right style="width:10%;border:1;color=Black"  ><input type="radio" name="option_T" value="1" checked onclick="onOption(1)" ><font>Daily</font></td>
		<td colspan=2 align=right style="width:10%;border:1"><gw:datebox id="DailyDT_T"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
		<td align=right style="width:3%;border:1">&nbsp;</td>
		<td colspan=2 align=right style="width:10%;border:0"><input type="radio" name="option_T" value="2" onclick="onOption(2)" ><font size=3>From</font></td>
		<td colspan=2 align=right style="width:10%;border:0"><gw:datebox id="FromDT_T"  maxlen = "10" text="" styles='width:70%'lang="<%=Session("Lang")%>" /></td>
		<td align=right style="width:3%;border:0"><font>To</font> </td>
		<td colspan=2 align=right style="width:10%;border:0"><gw:datebox id="ToDT_T"  maxlen = "10" text="" styles='width:70%'lang="<%=Session("Lang")%>" /></td>
		<td align=right style="width:5%;border:0"></td>
        <td align=right colspan=2 style="width:10%;border:0"><input type="radio" name="option_T" value="3" onclick="onOption(3)" ><font>Month</font> </td>
		<td align=left colspan=3 style="width:15%;border:0"><gw:datebox id="Month_T"  text="" styles='width:50%'lang="<%=Session("Lang")%>" type=month /></td>
		<td  align=right valign="bottom" style="width:3%;border:0" >&nbsp;</td>
		<td align=right style="width:5%;border:0"><gw:icon id="idBtnProcess" img="in" text="Process" onclick="Process('PRO')" /></td>
		<td style="width:8%;border:0"><b style="color=#FF3300"><gw:label id="idInterval2" text="" styles="width:100%" ></gw:label></b></td>
		<td align=right style="width:5%;border:0"><gw:icon id="idBtnDel" img="in" text="Delete" onclick="Process('DEL')" /></td>
		
		
    </tr>
    </table>
    <table id="tb2" style="width:100%;height:26%" cellpadding="0" cellspacing="0" valign="top" border="1" class="toprightleft" >		
	<tr style="height:7%;border:1; width:100%">	
	    <td align=left valign=top style="width:3%;border:inherit" ><img status="collapse" id="img_T2" alt="Show Column" src="../../../system/images/iconmaximize.gif" style="cursor:hand;position:absolute;" onclick="OnToggle_T(2)"  /></td>
		<td colspan=2 align=right style="width:10%;border:1;color=Black" ><input type="radio" name="option_P" value="1" checked onclick="onClickOption(2,1)" ><font>Daily</font></td>
		<td colspan=2 align=right style="width:10%;border:1"><gw:datebox id="DailyDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
		<td align=right style="width:5%;border:1"></td>
		<td colspan=2 align=right style="width:10%;border:0"><input type="radio" name="option_P" value="2" onclick="onClickOption(2,2)" ><font size=3>From</font></td>
		<td colspan=2 align=right style="width:10%;border:0"><gw:datebox id="FromDT"  maxlen = "10" text="" styles='width:70%'lang="<%=Session("Lang")%>" /></td>
		<td align=right style="width:5%;border:0"><font>To</font> </td>
		<td colspan=2 align=right style="width:10%;border:0"><gw:datebox id="ToDT"  maxlen = "10" text="" styles='width:70%'lang="<%=Session("Lang")%>" /></td>
		<td align=right style="width:5%;border:0"></td>
        <td align=right colspan=2 style="width:10%;border:0"><input type="radio" name="option_P" value="3" onclick="onClickOption(2,3)" ><font>Month</font> </td>
		<td align=left colspan=3 style="width:15%;border:0"><gw:datebox id="Month"  text="" styles='width:50%'lang="<%=Session("Lang")%>" type=month /></td>
		
		<td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="Search" onclick="OnSearch()" /></td>
		<td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnSave" alt="Save" img="save" text="Save" onclick="OnUpdate()" /></td>
		<td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnDelete" alt="Delete" img="delete" text="Delete" onclick="OnDelete()" /></td>
		<td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnUnDelete" alt="UnDelete" img="udelete" text="UnDelete" onclick="OnUndelete()" /></td>
    </tr>	
    <tr style="height:7%;border:1; width:100%">	
		<td align=right style="width:5%;border:0" ><a title="Click here to show Organization" onclick="OnShowPopup()" href="#tips" style="text-decoration : none; color=#0000FF">Organization</a></td>
		<td colspan=4 align=right style="width:20%;border:0"><gw:list  id="lstOrg"  maxlen = "100" styles='width:100%' onchange="OnChangeDept()" >
                <data>
                    <%=ESysLib.SetListDataSQL("select pk,org_nm from comm.tco_org a where del_if=0 order by nvl(a.seq,99999)")%>|ALL|Select All
                </data>
            </gw:list>
        </td>
		<td align=right style="width:5%;border:0">WGroup</td>
		<td colspan=3 align=right style="width:20%;border:0"><gw:list  id="lstGrp_Code"  maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("SELECT pk,WorkGroup_NM FROM Thr_Work_Group WHERE DEL_IF = 0 order by WorkGroup_id")%>|ALL|Select All</data></gw:list>
        </td>
        <td colspan=6 align=right style="border:0"><gw:list  id="lstWS" value="ALL"  maxlen = "100" styles='width:100%' onchange="OnChangeShift()">
                            <data><%=ESysLib.SetListDataSQL("SELECT pk,shift||'-'||remark FROM thr_work_shift WHERE DEL_IF = 0 and use_yn='Y'  order by shift")%>|ALL|WS-Select All</data></gw:list>
        </td>
        <td align=right style="width:10% ;border:0" >Foreigner</td>
        <td align=right style="width:20% ;border:0" ><gw:list  id="lstForeigner" value="ALL" styles='width:100%' >
        <data>|01|Vietnamese|02|Foreiger|ALL|Select All</data></gw:list></td>

        <td align=right colspan=2 style="width:6%;border:0">Print</td>
         <td align=right colspan=3 style="width:9%;border:0"><gw:list  id="idPrint_type" value="4" styles='width:100%' onChange="">
                <data>|1|Absence|2|Working time|3|Incorrect time|4|Select All</data></gw:list>
         </td>
         <td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnRpt" alt="Report" img="excel" text="Report" onclick="OnReport()" /></td>
    </tr>	
    <tr style="height:7%; width:100%">	
    	<td colspan=2 align=right style="width:10%;border:0">Set Time</td>	
		<td colspan=3 align=right style="width:15%;border:0"><gw:list id="idLstInOut"  styles="width:100%" value="0" onchange="change_list()"><data>|0|Choose...|1|Random In time|2|Random Out time|3|WT|4|OT|5|NT|6|HT</data></gw:list ></td>
		<td align=right style="width:5%;border:0"><gw:label id="idlbHH" styles="width:100%">HH&nbsp;</gw:label></td>
		<td align=right style="width:5%;border:0"><gw:textbox id="idHH" maxlen = "5" styles="width:100%" onkeypress="" /></td>
		<td align=right style="width:5%;border:0"><gw:label id="idlbMM1" styles="width:100%">MM1&nbsp;</gw:label></td>
		<td align=right style="width:5%;border:0"><gw:textbox id="idMM1" maxlen = "2" styles="width:100%"  onkeypress="return Numbers(event)"/></td>
		<td align=right style="width:5%;border:0"><gw:label id="idlbMM2" styles="width:100%">MM2&nbsp;</gw:label></td>
		<td align=right style="width:5%;border:0"><gw:textbox id="idMM2"	maxlen = "2" styles="width:100%" onkeypress="return Numbers(event)" /></td>
		<td align=right style="width:5%;border:0"><gw:icon id="idBtnSet"  styles='width:90%' img="in"  text="Set"  onclick="OnSetToGrid()"/></td>
		<td align=right style="width:5%;border:0"><gw:icon id="idBtnClear"  styles='width:90%' img="in"  text="Clear"  onclick="onClearGrid()"/></td>
		<td align=right style="width:5%;border:0">Search</td>
		<td colspan=2 align=right style="width:10%;border:0"><gw:list  id="idSearch" value="1" styles="width:95%" onChange="">
                <data>|1|Emp ID|2|Card ID|3|Name</data></gw:list></td>
		<td colspan=2 align=right style="width:8%;border:0"><gw:textbox id="idtxtTmp" maxlen = "20" styles="width:97%" onenterkey="OnSearch()" /></td>
		<td align=center style="width:3%;border:0"><gw:label id="idInterval" text="" styles="width:100%" ></gw:label></td>
		<td colspan=3 align=center style="width:9%;border:0"><gw:label id="idRecord" text="0 record(s)" styles="width:100%" ></gw:label></td>
		
    </tr>	
    <tr style="height:2%;border:inherit; width:100%">	
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
	<table id="tb3" style="width:100%;height:74%" cellpadding="0" cellspacing="0" valign="top" border="1" class="toprightbottomleft" >	
		<tr style="height:100%">
			<td id="master" width="100%">
				<gw:grid
					id="grd_att"
					header="_EMP_PK|GROUP|EMP_ID|FULL_NM|W_S|DATE_IN|N|IN TIME|DATE_OUT|N|OUT TIME|WT|OT|NT|HT|ABSENCE CODE|H|_WKD_PK|_OT_PK|_ABS_PK|WorkDT|_NT_PK|_HT_PK|_Date_Now|_date_next|_Hol_type|Mod by hand|No Scan|_S|OT Plus"
					format="0|0|0|0|0|4|3|0|4|3|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|3|0|0"
					aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|0|0|0"
					defaults="||||||||||||||||||||||||||||||"
					editcol="0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|0|0|0|0|0|0|0|0|0|0|1|0|1"
					widths="0|1500|1000|2500|500|1200|300|1000|1200|300|1000|500|500|500|500|1500|300|0|0|0|1500|0|0|0|0|0|1500|500|0|1500"
					styles="width:100%;height:100%"
					sorting="T"
					onafteredit="On_AfterEdit()"
					acceptNullDate="T"
					oncelldblclick = "Popup()"
					onentercell = "On_click()"/>
			</td>
		</tr>	
	</table>
	<gw:textbox id="txtResult" styles="display:none"/>
    <gw:textbox id="txtDeptData" styles="display:none"/>
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtGroupData" styles="display:none"/>
    <gw:textbox id="txtFrom" styles="display:none"/>
    <gw:textbox id="txtTo" styles="display:none"/>
    <gw:textbox id="idemp_pk" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
    <gw:list  id="lstWS_temp" value="ALL"  maxlen = "100" styles='display:none' >
                            <data><%=ESysLib.SetListDataSQL("SELECT PK,shift||'-'||remark FROM thr_work_shift WHERE DEL_IF = 0 and use_yn='Y'  order by shift")%>|ALL|WS-Select All</data></gw:list>
    <gw:textbox id="txtReport_tmp" styles="display:none"/>  
     <gw:textbox id="txt_flag" styles="display:none"/>  
     
                              
	
</body>
</html>

