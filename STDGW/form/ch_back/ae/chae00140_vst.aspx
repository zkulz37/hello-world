﻿<!-- #include file="../../../system/lib/form.inc"  -->

 <%ESysLib.SetUser("hr")%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var strcodereturn;
var binit_date=true;
var binit_month=true;
var user;
var v_language = "<%=Session("SESSION_LANG")%>";
var p_opt2=1;
function BodyInit()
{
    
    grdEmpDate.GetGridControl().ScrollTrack=true;
    grdEmpMonth.GetGridControl().ScrollTrack=true;
    if (v_language!="ENG")
        System.Translate(document);
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    user="<%=session("USER_ID")%>";
    grdEmpMonth.style.display="none";
    grdEmpDate.GetGridControl().FrozenCols =2;
    grdEmpDate.GetGridControl().ColHidden(1)=true;
    grdEmpMonth.GetGridControl().ColHidden(1)=true;
    SetGridHeader(grdEmpDate);
    SetGridHeader(grdEmpMonth);
    if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	{
        datUser_info.Call();     	    
	}
	else
	    datFindConfirm.Call();
}
//---------------------------------------------------
function OnShowPopup()
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:'+window.event.screenX+';dialogTop:'+window.event.screenY+';edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {
        lstwg.value=obj;
        txtUpperOrg.text=obj;
        datOrgData.Call();
            
        
    }
    
}
//----------------------------------------------
function OnDataReceive(obj)
{
   if (obj.id=="datUser_info")
   {
        datFindConfirm.Call();
   }
   else if (obj.id=="datFindConfirm" || obj.id=="datFindConfirmMonth")
   {
        
        if (txtConfirm.text==1)
        {   
            lblStatus.text="Already Confirmed";
            txtResult.text=1;
        }
        else
            lblStatus.text="Not Confirmed";
        
        
   }
   else if (obj.id=="datDailyEmp")
   {
        clear_Interval(lstInterval);
        if (txtResult.text=="1")
        {
            alert("Confirm successfull!");
            lblStatus.text="Already Confirmed";
            txtResult.text=1;
            for (var i=2;i<grdEmpDate.rows;i++)
            {
                if (grdEmpDate.GetGridData(i,22)!="") 
                    grdEmpDate.SetRowStatus(i,16);
                else
                    grdEmpDate.SetRowStatus(i,0);
            }
           // datDailyEmpSearch.Call();
        }
        else
            alert("Confirm fail, pls call admin!");
        
   }
   else if (obj.id=="datMonthlyEmp")
   {
        clear_Interval(lstInterval);
        if (txtResult.text=="1")
        {
            alert("Confirm successfull!");
            lblStatus.text="Already Confirmed";
            txtResult.text=1;
            
        }
        else
            alert("Confirm fail, pls call admin!");
   }
   else if (obj.id=="datDailyEmpSearch")
   {
        SetGridHeader(grdEmpDate);
        var ctr=grdEmpDate.GetGridControl(); 
        ctr.OutlineBar =2 ;
        //ctr.SubtotalPosition=0;
        var color;
        var caption;
        var operator;
        for (var igroup=0;igroup<=0;igroup++)
        {
            switch (igroup)
            {
                case 0:
                {
                    color=0x99FF99;
                    caption='Grand Total';
                    break;
                }
                case 1:
                {
                    color=0x99FFFF;
                    caption='Dept:%s';
                    break;
                }
                
            }
                
            for (var itotal=3;itotal<=24;itotal++)
            {
                if (igroup==0)
                {
                    if (itotal==20)
                        ctr.ColFormat(itotal) = "(#,###.##)";
                    else
                        ctr.ColFormat(itotal) = "(#,###)";
                }
                if (itotal>=24)
                    operator=6;
                else
                    operator=2;
                ctr.SubTotal(operator,igroup, itotal,'',color,0x000000,'1',caption,'',true);
            }
        }
        
        auto_resize_column(grdEmpDate,0,grdEmpDate.cols-1,10);    
	    
   }
   else if (obj.id=="datMonthlyEmpSearch")
   {
        SetGridHeader(grdEmpMonth);
        var ctr=grdEmpMonth.GetGridControl(); 
        ctr.OutlineBar =2 ;
        //ctr.SubtotalPosition=0;
        var color;
        var caption;
        var operator;
        for (var igroup=0;igroup<=0;igroup++)
        {
            switch (igroup)
            {
                case 0:
                {
                    color=0x99FF99;
                    caption='Grand Total';
                    break;
                }
                case 1:
                {
                    color=0x99FFFF;
                    caption='Dept:%s';
                    break;
                }
                
            }
                
            for (var itotal=3;itotal<=14;itotal++)
            {
                if (igroup==0)
                {
                    ctr.ColFormat(itotal) = "(#,###)";
                }
                if (itotal>=13 )
                    operator=6;
                else
                    operator=2;
                ctr.SubTotal(operator,igroup, itotal,'',color,0x000000,'1',caption,'',true);
            }
        }
        auto_resize_column(grdEmpMonth,0,grdEmpMonth.cols-1,10);    
   }
   else if (obj.id=="datOrgData")
   {    txtOrgData.text=txtOrgData.text+"|ALL|Select All";
        lstwg.SetDataText(txtOrgData.text);
        lstwg.value = txtUpperOrg.text;
            
   }
   else if (obj.id=="datFind_Report")
   {
        var url;
        
      if(p_opt2==0)
      {
            if (txtOption.text==1)
            {
                //txtReport_tmp.text="rpt_daily_employee_status.aspx";
                url =System.RootURL + '/reports/ch/ae/'+txtReport_tmp.text+'?p_user=' + user + '&p_date='  + dtDate.value + '&p_date_text='  + dtDate.text + '&p_dept=' +  lstwg.value;
            }
           else
            {
                //if (txtOption.text==1)
                //txtReport_tmp.text="rpt_daily_employee_status.aspx";
                //txtReport_tmp.text="rpt_monthly_employee_status.aspx";
                url =System.RootURL + '/reports/ch/ae/'+txtReport_tmp.text+'?p_user=' + user + '&p_month='  + dtMonth.value + '&p_month_text='  + dtMonth.text + '&p_dept=' +  lstwg.value ;
            }
      }
      else
      {
        url =System.RootURL + '/reports/ch/ae/'+txtReport_tmp.text+'?p_opt=' + p_opt2 + '&p_dt1='  + id_tmp1.text + '&p_dt2='  + id_tmp2.text;
      }
        
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

//----------------------------------------------------
function OnSearch()
{
   if (txtOption.text==1)
    {
        datDailyEmpSearch.Call("SELECT");
    }
   else
    {
        datMonthlyEmpSearch.Call("SELECT");
    }    
}
//-----------------------------------------------
function OnConfirm()
{
    var obj;
    var bconfirm;
    bconfirm=true;
    
    if (txtOption.text==1)
        obj=datDailyEmp;
    else
        obj=datMonthlyEmp;
    
    if (txtConfirm.text==1)
    {
        if (!confirm("This Date have already confirmed! Do you want to confirm again?\n Ngày này đã được xác nhận! Bạn có muốn xác nhận lại không?"))
        {
            bconfirm=false;
        }
    }
    if (bconfirm)
    {
        set_Interval(1000); 
        obj.Call();
    }
    
    
}
//-----------------------------------------------
function set_Interval(x) 
{
 startTime = new Date().valueOf();
 interval_time=setInterval("clock(" + startTime + "," + x  + ")",x);
}
//-----------------------------------------------
function clock(start,x) 
{
 var d = new Date()
 lstInterval.text= Math.round((d.valueOf()-start)/x);

}
//-----------------------------------------------
function clear_Interval(obj)
{
	clearInterval(interval_time);
	obj.text="";
}
//-----------------------------------------------
function OnReport(n)
{
    if(n==1)
    {
        p_opt2=0;
        if (txtResult.text!="1")
        {
            alert("Please confirm before reporting!");
            return;
        }
        if (txtOption.text==1)
                txtReport_tmp.text="rpt_daily_employee_status_vst.aspx";
        else  
                txtReport_tmp.text="rpt_monthly_employee_status_vst.aspx";
    }   
    else
    {
        if(p_opt2==1)
        {
            id_tmp1.text=dt.value
            id_tmp2.text=dt.value
        }    
        else if(p_opt2==2)    
        {
            id_tmp1.text=dt1.value
            id_tmp2.text=dt2.value
        }
        else if(p_opt2==3)    
        {
            id_tmp1.text=dtM.value+""+"01"
            id_tmp2.text=dtM.value+""+getDaysInMonth(dtM.value);
        }
        else if(p_opt2==4)    
        {
            
            id_tmp1.text=dtY.value+""+"0101"
            id_tmp2.text=dtY.value+""+"1231";
        }
        txtReport_tmp.text="rpt_manpower_vst.aspx";

    }     
    datFind_Report.Call();
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
//-------------------------------------------------
function SetGridHeader(obj)
{
    var stt;
    
    if (obj==grdEmpDate)
    {
        var fg=obj.GetGridControl(); 	  
        if (binit_date==true)
        {
            fg.rows=fg.rows+1;
            binit_date=false;
        }
        fg.FixedRows = 2;
        fg.FixCols=1;
        fg.MergeCells =5	;
        stt=0;//num column
        fg.MergeCol(stt) =true	;
        fg.Cell(0, 0, stt, 1, stt)  = " ";   //fg.Cell(0,row, from_col, row, to_col)	
        
        fg.MergeCol(stt+1) =true	;
        fg.Cell(0, 0, stt+1, 1, stt+1)  = "Department";   //fg.Cell(0,row, from_col, row, to_col)	
        fg.MergeCol(stt+2) =true	;
        fg.Cell(0, 0, stt+2, 1, stt+2)  = "Work Group";   //fg.Cell(0,row, from_col, row, to_col)	
        fg.MergeRow(0) =true	;
        fg.Cell(0, 0, stt+3, 0, stt+4)  = "Yesterday";   //fg.Cell(0,row, from_col, row, to_col)	
        fg.Cell(0, 1, stt+3, 1, stt+3) = "Male";
        fg.Cell(0, 1, stt+4, 1, stt+4) = "Female";
        
        fg.Cell(0, 0, stt+5, 0, stt+6)  = "Today";   //fg.Cell(0,row, from_col, row, to_col)	
        fg.Cell(0, 1, stt+5, 1, stt+5) = "Male";
        fg.Cell(0, 1, stt+6, 1, stt+6) = "Female";
        
        fg.Cell(0, 0, stt+7, 0, stt+8)  = "Newcomer";   //fg.Cell(0,row, from_col, row, to_col)	
        fg.Cell(0, 1, stt+7, 1, stt+7) = "Male";
        fg.Cell(0, 1, stt+8, 1, stt+8) = "Female";
        
        fg.Cell(0, 0, stt+9, 0, stt+10)  = "Resigned Employees";   //fg.Cell(0,row, from_col, row, to_col)	
        fg.Cell(0, 1, stt+9, 1, stt+9) = "Male";
        fg.Cell(0, 1, stt+10, 1, stt+10) = "Female";
        
        fg.Cell(0, 0, stt+11, 0, stt+17)  = "Absence";   //fg.Cell(0,row, from_col, row, to_col)	
        fg.Cell(0, 1, stt+11, 1, stt+11) = "NON";
       // fg.Cell(0, 1, stt+12, 1, stt+12) = "Training ";
        //fg.Cell(0, 1, stt+13, 1, stt+13) = "Business Trip";
        fg.Cell(0, 1, stt+12, 1, stt+12) = "NOP";
        fg.Cell(0, 1, stt+13, 1, stt+13) = "PER"
        fg.Cell(0, 1, stt+14, 1, stt+14) = "REG";
        fg.Cell(0, 1, stt+15, 1, stt+15) = "MLE";
        
        fg.MergeCol(stt+16) =true	;
        fg.Cell(0, 0, stt+16, 1, stt+16)  = "Late in";   //fg.Cell(0,row, from_col, row, to_col)	
        fg.MergeCol(stt+17) =true	;
        fg.Cell(0, 0, stt+17, 1, stt+17)  = "Early out";   //fg.Cell(0,row, from_col, row, to_col)	
        
        
        fg.MergeCol(stt+18) =true	;
        fg.Cell(0, 0, stt+18, 1, stt+18)  = "Not Schedule";   //fg.Cell(0,row, from_col, row, to_col)	
        
        fg.MergeCol(stt+19) =true	;
        fg.Cell(0, 0, stt+19, 1, stt+19)  = "OT Emps";   //fg.Cell(0,row, from_col, row, to_col)	
        
        fg.MergeCol(stt+20) =true	;
        fg.Cell(0, 0, stt+20, 1, stt+20)  = "OT Hours";   //fg.Cell(0,row, from_col, row, to_col)	
        
        fg.Cell(0, 0, stt+21, 0, stt+22)  = "Attendence";   //fg.Cell(0,row, from_col, row, to_col)	
        fg.Cell(0, 1, stt+21, 1, stt+21) = "Male";
        fg.Cell(0, 1, stt+22, 1, stt+22) = "Female";
        fg.MergeCol(stt+23) =true	;
        fg.Cell(0, 0, stt+23, 1, stt+23)  = "Night Shift";   //fg.Cell(0,row, from_col, row, to_col)
        fg.MergeCol(stt+26) =true	;
        fg.Cell(0, 0, stt+26, 1, stt+26)  = "Remark";   //fg.Cell(0,row, from_col, row, to_col)
        
        obj.SetCellBold(1,1,1,stt+24,true);
        //fg.Cell(0, 0, 1, 0) = "Department"
    }
    else
    {
         var fg=obj.GetGridControl(); 	  
        if (binit_month==true)
        {
            fg.rows=fg.rows+1;
            binit_month=false;
        }
        fg.FixedRows = 2;
        fg.FixCols= 1;
        fg.MergeCells =5	;
        stt=0;
        fg.MergeCol(stt) =true	;
        fg.Cell(0, 0, stt, 1, stt)  = " ";   //fg.Cell(0,row, from_col, row, to_col)	
        
        fg.MergeCol(stt+1) =true	;
        fg.Cell(0, 0, stt+1, 1, stt+1)  = "Department";   //fg.Cell(0,row, from_col, row, to_col)	
        
        fg.MergeCol(stt+2) =true	;
        fg.Cell(0, 0, stt+2, 1, stt+2)  = "Work Group";   //fg.Cell(0,row, from_col, row, to_col)	
        
        fg.MergeRow(0) =true	;
        fg.Cell(0, 0, stt+3, 0, stt+4)  = "The Beginning";   //fg.Cell(0,row, from_col, row, to_col)	
        fg.Cell(0, 1, stt+3, 1, stt+3) = "Male";
        fg.Cell(0, 1, stt+4, 1, stt+4) = "Female";
        
        fg.MergeCol(stt+5) =true	;
        fg.Cell(0, 0, stt+5, 1, stt+5)  = "Beginning Total";   //fg.Cell(0,row, from_col, row, to_col)	
        
        fg.Cell(0, 0, stt+6, 0, stt+7)  = "Newcomer";   //fg.Cell(0,row, from_col, row, to_col)	
        fg.Cell(0, 1, stt+6, 1, stt+6) = "Male";
        fg.Cell(0, 1, stt+7, 1, stt+7) = "Female";
        
        fg.Cell(0, 0, stt+8, 0, stt+9)  = "Resigned";   //fg.Cell(0,row, from_col, row, to_col)	
        fg.Cell(0, 1, stt+8, 1, stt+8) = "Male ";
        fg.Cell(0, 1, stt+9, 1, stt+9) = "Female";
       
        fg.Cell(0, 0, stt+10, 0, stt+11)  = "The Ending";   //fg.Cell(0,row, from_col, row, to_col)	
        fg.Cell(0, 1, stt+10, 1, stt+10) = "Male ";
        fg.Cell(0, 1, stt+11, 1, stt+11) = "Female";
       
        fg.MergeCol(stt+12) =true	;
        fg.Cell(0, 0, stt+12, 1, stt+12)  = "Ending Total";   //fg.Cell(0,row, from_col, row, to_col)	
        
        obj.SetCellBold(1,stt,1,stt+12,true);
        //fg.Cell(0, 0, 1, 0) = "Department"
    }
}
//--------------------------------------------------
function OnSelect(obj)
{
    txtOption.text=obj;
    
    if (obj==1)
    {
        grdEmpDate.style.display="";
        grdEmpMonth.style.display="none";
        datFindConfirm.Call();
    }
    else
    {
        grdEmpDate.style.display="none";
        grdEmpMonth.style.display="";
        datFindConfirmMonth.Call();
    }
      
}
function sel_tab2(n)
{
    p_opt2=n;
}
//----------------------------------------------
function ShowDailyDetail()
{
    var dept_pk,grp_pk,sdate,sex,stime,stype
    var temp;
    var irow,icol;
    irow=event.row;
    icol=event.col;
    if(icol<=2)
        return;
    var iyes_male,iyes_female,ito_male,ito_female,inew_male,inew_female,iout_male,iout_female,iabs_non,iabs_train,ilate,iearly,iabs_reg,iabs_mle,inot_schedule,iot_people,iot_hours,iatt_male,iatt_female,inight_shift,iabs_nop;
    iyes_male=3;
    iyes_female=4;
    ito_male=5;
    ito_female=6;
    inew_male=7;
    inew_female=8;
    iout_male=9;
    iout_female=10;
    iabs_non=11;
   // iabs_train=12;
    //iabs_btrip=13;
    iabs_nop=12;
    iabs_per=13;
    iabs_reg=14;
    iabs_mle=15;
	ilate=16;
	iearly=17;
    inot_schedule=18;
    iot_people=19;
    iot_hours=20;
    iatt_male=21;
    iatt_female=22;
    inight_shift=23;
    idept_pk=24;
    igrp_pk=25;
    var vTotal;
    vTotal=grdEmpDate.GetGridData(irow,0);
    if (vTotal.substr(0,5)=="Grand")
    {
        dept_pk="ALL";
        grp_pk="ALL";
    }
    else if (vTotal.substr(0,5)=="Dept:")
    {
        dept_pk=grdEmpDate.GetGridData(irow,idept_pk);  //dept pk
        grp_pk="ALL";
    }
    else
    {
        dept_pk=grdEmpDate.GetGridData(irow,idept_pk);  //dept pk
        grp_pk=grdEmpDate.GetGridData(irow,igrp_pk); //group pk
    }
    sdate=dtDate.value;
    if ((icol == iyes_male) || (icol == ito_male) || (icol == iatt_male) || (icol == inew_male) || (icol == iout_male))
        sex="Male";
    else if ((icol == iyes_female) || (icol == ito_female) || (icol == iatt_female) || (icol == inew_female) || (icol == iout_female))    
        sex="Female";
    else
        sex="ALL";
    if ((icol == iyes_male) || (icol == ito_male) || (icol == iyes_female) || (icol == ito_female) || (icol == inew_female) || (icol == iout_female) || (icol == inew_male) || (icol == iout_male) )     
    {
        if ((icol==iyes_male) || (icol==iyes_female))
            stime="Yes";
        else
            stime="Tod";
        if ((icol==inew_male) || (icol==inew_female))
            stype="New"; //newcommer or resigned employee
        else if ((icol==iout_male) || (icol==iout_female))
            stype="Out";//newcommer or resigned employee
        else
            stype="ALL";//newcommer or resigned employee
       //alert(dept_pk);
        var fpath = System.RootURL + "/form/ch/ae/chae00140_Show_emp_vst.aspx?dept_pk=" + dept_pk + "&grp_pk=" + grp_pk + "&sdate=" + sdate + "&sex=" + sex + "&stime=" + stime + "&upper_dept_pk=" + lstwg.value + "&stype=" + stype+"&nation="+lstNation.value; 
        var obj=System.OpenModal(  fpath , 600 , 450 , 'resizable:yes;status:yes');
    }
    else if (icol >=iabs_non && icol <=iabs_mle)     
    {
        var abs_type;
        switch (icol)
        {
            case iabs_non:
            {
                abs_type='1';
                break;
            }
            case iabs_nop:
            {
                abs_type='2';
                break;
            }
            
            case iabs_per:
            {
                abs_type='3';
                break;
            }    
            case iabs_reg:
            {
                abs_type='4';
                break;
            }
            case iabs_mle:
            {
                abs_type='5';
                break;
            }
            
        }
        var fpath = System.RootURL + "/form/ch/ae/chae00140_Show_abs_vst.aspx?dept_pk=" + dept_pk + "&grp_pk=" + grp_pk + "&sdate=" + sdate + "&upper_dept_pk=" + lstwg.value + "&abs_type=" + abs_type+"&nation="+lstNation.value;
        var obj=System.OpenModal(  fpath , 800 , 450 , 'resizable:yes;status:yes');
    }
    else if (icol ==inot_schedule )  
    {
        var fpath = System.RootURL + "/form/ch/ae/chae00140_Not_Schedule_vst.aspx?dept_pk=" + dept_pk + "&grp_pk=" + grp_pk + "&sdate=" + sdate + "&upper_dept_pk=" + lstwg.value+"&nation="+lstNation.value;
        var obj=System.OpenModal(  fpath , 800 , 450 , 'resizable:yes;status:yes');
    }
    else if (icol ==inight_shift )  
    {
        var fpath = System.RootURL + "/form/ch/ae/chae00140_Nt_vst.aspx?dept_pk=" + dept_pk + "&grp_pk=" + grp_pk + "&sdate=" + sdate + "&upper_dept_pk=" + lstwg.value+"&nation="+lstNation.value;
        var obj=System.OpenModal(  fpath , 800 , 450 , 'resizable:yes;status:yes');
    }
	 else if (icol ==iearly)  
    {
        var fpath = System.RootURL + "/form/ch/ae/chae00140_early_late_vst.aspx?late=02&dept_pk=" + dept_pk + "&grp_pk=" + grp_pk + "&sdate=" + sdate + "&upper_dept_pk=" + lstwg.value+"&nation="+lstNation.value;
        var obj=System.OpenModal(  fpath , 800 , 450 , 'resizable:yes;status:yes');
    }
	 else if (icol ==ilate)  
    {
        var fpath = System.RootURL + "/form/ch/ae/chae00140_early_late_vst.aspx?late=01&dept_pk=" + dept_pk + "&grp_pk=" + grp_pk + "&sdate=" + sdate + "&upper_dept_pk=" + lstwg.value+"&nation="+lstNation.value;
        var obj=System.OpenModal(  fpath , 800 , 450 , 'resizable:yes;status:yes');
    }
    else
    {
        var ot;
        if ((icol==iot_people) || (icol==iot_hours) )
            ot="OT";
        else
            ot="ALL";
        var fpath = System.RootURL + "/form/ch/ae/chae00140_attendence_vst.aspx?dept_pk=" + dept_pk + "&grp_pk=" + grp_pk + "&sdate=" + sdate + "&upper_dept_pk=" + lstwg.value + "&OT=" + ot + "&sex=" + sex+"&nation="+lstNation.value;
        var obj=System.OpenModal(  fpath , 800 , 450 , 'resizable:yes;status:yes');
    }
}
//----------------------------------------------
function ShowMonthlyDetail()
{
    var dept_pk,grp_pk,smonth,sex,stype
    var irow,icol;
    irow=event.row;
    icol=event.col;
    if(icol<=2)
        return;
    var ibegin_male,ibegin_female,ibegin_total,inew_male,inew_female,iout_male,iout_female,iend_male,iend_female,iend_total
    ibegin_male=3;
    ibegin_female=4;
    ibegin_total=5;
    inew_male=6;
    inew_female=7;
    iout_male=8;
    iout_female=9;
    iend_male=10;
    iend_female=11;
    iend_total=12;
    idept_pk=13;
    igrp_pk=14;
    var vTotal;
    vTotal=grdEmpMonth.GetGridData(irow,0);
    if (vTotal.substr(0,5)=="Grand")
    {
        dept_pk="ALL";
        grp_pk="ALL";
    }
    else if (vTotal.substr(0,5)=="Dept:")
    {
        dept_pk=grdEmpMonth.GetGridData(irow,idept_pk);  //dept pk
        grp_pk="ALL";
    }
    else
    {
        dept_pk=grdEmpMonth.GetGridData(irow,idept_pk);  //dept pk
        grp_pk=grdEmpMonth.GetGridData(irow,igrp_pk); //group pk
    }
    smonth=dtMonth.value;
    if ((icol == ibegin_male) || (icol == inew_male) || (icol == iout_male) || (icol == iend_male))
        sex="Male";
    else if ((icol == ibegin_female) || (icol == inew_female) || (icol == iout_female) || (icol == iend_female))    
        sex="Female";
    else
        sex="ALL";
    if ((icol>=ibegin_male) && (icol <=ibegin_total))
        stype="Begin"; // beginning of the month
    else if ((icol>=inew_male) && (icol <=inew_female))
        stype="New"; // in the month
    else if ((icol>=iout_male) && (icol <=iout_female))
        stype="Out"; // in the month
    else 
        stype="End"; // in the month
   var fpath = System.RootURL + "/form/ch/ae/chae00140_Show_monthly_emp.aspx?dept_pk=" + dept_pk + "&grp_pk=" + grp_pk + "&smonth=" + smonth + "&sex=" + sex + "&upper_dept_pk=" + lstwg.value + "&stype=" + stype; 
   var obj=System.OpenModal(  fpath , 600 , 450 , 'resizable:yes;status:yes');
   
} 
function OnCheckConfirm(n)
{
    if(n==1)
        datFindConfirm.Call();
    else
        datFindConfirmMonth.Call();
}

</script>
<body>
<!-------------------data control----------------------->


<gw:data id="datDailyEmp" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_daily_emp_vst" > 
                <input>
                    <input bind="lstwg" /> 
                    <input bind="dtDate" /> 
                    <input bind="lstNation" /> 
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------>
<gw:data id="datOrgData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="comm.sp_pro_dept_data_all" > 
                <input>
                    <input bind="txtUpperOrg" /> 
                </input> 
                <output>
                    <output bind="txtOrgData" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------>
<gw:data id="datDailyEmpSearch" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"   function="HR.sp_sel_daily_emp_vst" parameter="23,24,25" procedure="hr.sp_upd_daily_emp_vst" > 
                <input bind="grdEmpDate" >
                    <input bind="lstwg" /> 
                    <input bind="dtDate" /> 
                    <input bind="lstNation" /> 
                </input>
                <output  bind="grdEmpDate" />
            </dso> 
        </xml> 
</gw:data>

<!-------------------data control----------------------->
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr.sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="lstwg" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------>
<gw:data id="datFindConfirm" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_find_confirm" > 
                <input>
                    <input bind="lstwg" /> 
                    <input bind="dtDate" /> 
                </input> 
                <output>
                    <output bind="txtConfirm" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------>
<gw:data id="datFindConfirmMonth" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_find_confirm_month" > 
                <input>
                    <input bind="lstwg" /> 
                    <input bind="dtMonth" /> 
                </input> 
                <output>
                    <output bind="txtConfirm" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------>
<gw:data id="datMonthlyEmpSearch" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"   function="HR.sp_sel_monthly_emp_vst" > 
                <input bind="grdEmpMonth" >
                    <input bind="lstwg" /> 
                    <input bind="dtMonth" /> 
                    <input bind="lstNation" />
                </input>
                <output  bind="grdEmpMonth" />
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------>
<gw:data id="datMonthlyEmp" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_monthly_emp_vst" > 
                <input>
                    <input bind="lstwg" /> 
                    <input bind="dtMonth" /> 
                    <input bind="lstNation" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------>
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
<!---------------------------table---------------------------->
<gw:tab id="tabMain"  border=1 style="width:100%;height:100%;" onpageactivate=""  >   
    <table name="Detail" align = top cellspacing=0 cellpadding=0 border=1 style="width:100%;height:100%;" >
	<tr>
	    <td  align = top >
		    <table align=top  cellspacing=0 cellpadding=0 style="width:100%;height:10%;" border=0>
			    <tr style="height:5%;">      
				    <td width="7%" align="right">Work Group</td>
				    <td width="18%"><gw:list  id="lstwg" value='ALL' maxlen = "100" styles='width:100%' onchange="">
                                <data>
                                    <%=ESysLib.SetListDataSQL("select a.pk,a.workgroup_nm from thr_work_group a where a.del_if=0  order by NVL(a.seq,99999)")%>|ALL|Select All
                                </data>
                            </gw:list></td>
                    <td width="8%" align=right><input type="radio"  name="option_P" id="option_P1" value="0" checked onclick="OnSelect(1)"><b><font color=Black>Date</font></b></td>
				    <td width="10%"><gw:datebox id="dtDate" styles="width:70%" lang="<%=Session("Lang")%>" onchange="OnCheckConfirm(1)"/></td>				
				    <td width="8%" align=right><input type="radio"  name="option_P" id="option_P2" value="1" onclick="OnSelect(2)"><b><font color=Black>Month</font></b></td>
            	    <td width="10%" nowrap align="left"><gw:datebox id="dtMonth" type="month" lang="<%=Session("Lang")%>" styles="width:50%" onchange="OnCheckConfirm(2)"></gw:datebox></td>
			        <td width="8%" align="right">Status</td>
			        <td width="14%" align="left"><gw:label id="lblStatus" text="Not Confirmed" maxlen = "100" styles="color:#0099cc;width:90%;font-weight: bold;font-size:12"></gw:label></td>
				    <td width="3%"><gw:imgBtn id="ibtnConfirm" alt="Confirm" img="confirm" text="" onclick="OnConfirm()"/></td> 
				    <td width="3%" ><gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="" onclick="OnSearch()"/></td> 
				    <td width="3%" > <gw:imgBtn id="ibtnReport" alt="Report" img="excel" text="" onclick="OnReport(1)"/></td>
				    <td width="5%" align="center"><gw:label id="lstInterval" text="" maxlen = "100" styles="color:#black;width:90%;font-weight: bold;font-size:12"></gw:label></td>
				    
		        </tr>
		        <tr  style="height:5%;">
		            <td style="border:0;" align="right" >Nation</td>
                    <td style="border:0;" align="left" >
                        <gw:list  id="lstNation" value='01' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by code_nm" )%>|ALL|Select All</data></gw:list>
                    </td>
		            <td colspan=8 align=center style="color:#ff3399;width:100%;font-size:13">Double click onto cell to see detail</td>
		        </tr>
		        
		    </table>
		    <table align=top  cellspacing=0 cellpadding=0 style="width:100%;height:90%;" border=1>
			    <tr  style="width:100%;height:100%;">
		            <td style="width:100%;height:100%;">
		            <gw:grid   
			            id="grdEmpDate"  
			            header="_Num|_Department|Work Group|Yes_Male|Yes_Female|Today_Male
			            |Today_Female|New_Male|New_Female|Out_Male|Out_Female|Abs_Non|Abs_Train|Abs_BTrip|Abs_Sick|Abs_Per|Abs_ALE|Abs_Mat|Not Schedule|OT_Emps|OT_Hours|Attendence_Male|Attendence_FeMale|NT|_Dept_pk|_team_Pk|Remark|_Date"   
			            format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|)"  
			            aligns="0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0|0"  
			            defaults="||||||||||||||||||||||||||"  
			            editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|01|0"  
			            widths="1000|1500|1500|800|800|800|800|800|800|800|800|800|800|1200|1000|1000|800|800|1000|1000|1000|1000|1000|1000|1000|0|0|0"  
			            styles="width:100%; height:100%;"   
			            sorting="F"   
			            oncelldblclick     = "ShowDailyDetail()"/>
			         <gw:grid   
			            id="grdEmpMonth"  
			            header="_Num|_Department|Work Group|Begin_Male|Begin_Female|Begin_Total|Newcommer_Male|Newcommer_Female|Resigned_Male|Resigned_Female|End_Male|End_Female|End_Total|_Dept_PK|_GROUP_PK"   
			            format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
			            aligns="0|0|0|1|1|1|1|1|1|1|1|1|1|1|1"  
			            defaults="||||||||||||||"  
			            editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
			            widths="1000|2000|1500|1500|1500|1500|1200|1200|1200|1200|1200|1200|1200|1200|1200"  
			            styles="width:100%; height:100%"   
			            sorting="F"   
			            oncelldblclick     = "ShowMonthlyDetail()"/>   
			            
			        </td>
		        </tr>
		        
		    </table>
		    
		</td>
	</tr>
</table>
<table name="Summary" align = top cellspacing=0 cellpadding=0 border=1 style="width:100%;height:10%;" >
	<tr>
	    <td  align = top >
		    <table align=top  cellspacing=0 cellpadding=0 style="width:100%;height:100%;" border=0>
			    <tr style="height:5%;">      
                    <td width="10%" align=right><input type="radio"  name="option_P" id="Radio1" value="0" checked onclick="sel_tab2(1)"><b><font color=Black>Daily</font></b></td>
				    <td width="10%"><gw:datebox id="dt" styles="width:70%" lang="<%=Session("Lang")%>" onchange=""/></td>	
				    <td width="10%" align=right><input type="radio"  name="option_P" id="Radio3" value="1"  onclick="sel_tab2(2)"><b><font color=Black>Weekly</font></b></td>
				    <td width="10%"><gw:datebox id="dt1" styles="width:70%" lang="<%=Session("Lang")%>" onchange=""/></td>			
				    <td width="2%"><b>~</b></td>			
				    <td width="10%"><gw:datebox id="dt2" styles="width:70%" lang="<%=Session("Lang")%>" onchange=""/></td>			
				    <td width="10%" align=right><input type="radio"  name="option_P" id="Radio2" value="2" onclick="sel_tab2(3)"><b><font color=Black>Monthly</font></b></td>
            	    <td width="10%" nowrap align="left"><gw:datebox id="dtM" type="month" lang="<%=Session("Lang")%>" styles="width:50%" onchange=""></gw:datebox></td>
                    <td width="10%" align=right><input type="radio"  name="option_P" id="Radio4" value="3" onclick="sel_tab2(4)"><b><font color=Black>Yearly</font></b></td>
            	    <td width="10%" nowrap align="left"><gw:datebox id="dtY" type="year" lang="<%=Session("Lang")%>" styles="width:50%" onchange=""></gw:datebox></td>
				    <td width="8%" > <gw:imgBtn id="ibtnReport2" alt="Report" img="excel" text="" onclick="OnReport(2)"/></td>
		        </tr>
		    </table>
		</td>
	</tr>
</table>
</gw:tab>   
</body>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
<gw:textbox id="txtDeptData" styles="display:none"/>
<gw:textbox id="txtUpperDept" styles="display:none"/>
<gw:textbox id="txtOption" text="1" styles="display:none"/>
<gw:textbox id="txtResult" text="0"  styles="display:none"/>
<gw:textbox id="txtConfirm" styles="display:none"/>
<gw:textbox id="txtReport_tmp" styles="display:none"/>
<gw:textbox id="txtOrgData" styles="display:none"/>
 <gw:textbox id="txtUpperOrg" styles="display:none"/>
 <gw:textbox id="id_tmp1" styles="display:none"/>
 <gw:textbox id="id_tmp2" styles="display:none"/>
</html>