<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var check_init =0;
var flag;
var strcodereturn;
var binit=true;
var tab2=false;
var flag2=false;
var startTime,interval_time

var g_emp_pk =0;
    g_app_name =23;
    g_app_type =24;

var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);
     iduser_pk.text = "<%=session("USER_PK")%>";
     txtHr_level.text= "<%=session("HR_LEVEL")%>";
     //menu_id.text=System.Menu.GetMenuID();
   grdSalary.GetGridControl().FrozenCols =5;
   grdSalary2.GetGridControl().FrozenCols =5;
   grdSalary.GetGridControl().ScrollTrack=true;
   grdSalary2.GetGridControl().ScrollTrack=true;
   InitButton(false);
   visible_grdSalary(1,3);
   ibtnSave2.style.display = "none";

   <%=ESysLib.SetGridColumnComboFormat( "grdSalary" , 11 , "select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm " ) %>; 
   <%=ESysLib.SetGridColumnComboFormat( "grdSalary" , 12 , "select s.pk,POS_GRP_NAME||'-'||RATE  from thr_table_salary s,thr_position_grp g  where s.del_if=0 and thr_position_grp_pk=g.pk and g.del_if=0 order by POS_GRP_NAME||'-'||RATE " ) %>; 
   <%=ESysLib.SetGridColumnComboFormat( "grdSalary" , 21 , "select code,CODE_NM from vhr_hr_code where id='HR0040' order by code_nm " ) %>; 
   <%=ESysLib.SetGridColumnComboFormat( "grdSalary2" , 10 , "select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm " ) %>; 
   <%=ESysLib.SetGridColumnComboFormat( "grdSalary2" , 11 , "select s.pk,POS_GRP_NAME||'-'||RATE  from thr_table_salary s,thr_position_grp g  where s.del_if=0 and thr_position_grp_pk=g.pk and g.del_if=0 order by POS_GRP_NAME||'-'||RATE " ) %>; 
   <%=ESysLib.SetGridColumnComboFormat( "grdSalary2" , 22 , "select code,CODE_NM from vhr_hr_code where id='HR0056' order by code_nm " ) %>; 
   lstTimesPeriod.value="";
   var bins_sal="<%=ESysLib.SetDataSQL("select 1 from vhr_hr_code where id='HR0006' and code='14' and nvl(num_3,0)=1")%>";
    if (bins_sal==1)//su dung insurance salary
    {
        grdSalary.GetGridControl().ColHidden(22)=false;
        grdSalary2.GetGridControl().ColHidden(23)=false;
        lstTmp.SetDataText("<%=Esyslib.SetListDataSQL("SELECT 'A0','Level2 Salary' from dual union SELECT 'A9','Ins Salary' from dual union SELECT A.CODE,A.CODE_NM FROM VHR_HR_CODE A WHERE A.ID='HR0019' AND A.NUM_2=1" )%>")
        lstTmp2.SetDataText("<%=Esyslib.SetListDataSQL("SELECT 'A0','Level2 Salary' from dual union SELECT 'A9','Ins Salary' from dual union SELECT A.CODE,A.CODE_NM FROM VHR_HR_CODE A WHERE A.ID='HR0019' AND A.NUM_2=1" )%>")
    }        
    else
    {
        grdSalary.GetGridControl().ColHidden(22)=true;
        grdSalary2.GetGridControl().ColHidden(23)=true;
        
    }
    
    //datCheck_View.Call();
   datAllowance.Call("SELECT");
    
}
function set_Interval(x) 
{
 startTime = new Date().valueOf();
 interval_time=setInterval("clock(" + startTime + "," + x  + ")",x);
}
function clock(start,x) 
{
 var d = new Date()
 lbldata2.text= Math.round((d.valueOf()-start)/x);

}

function clear_Interval(obj)
{
	clearInterval(interval_time);
	obj.text="";
}
//----------------------------------
function InitButton(flag)
{
    ibtnSave.SetEnable(flag);
   
}
//----------------------------------
function OnShowPopup(n)
{
     var strcom;
    if(n==1||n==3)
    {
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:20;dialogHeight:30;dialogLeft:10;dialogTop:240;edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {
            if(n==1)
                lstOrg.value=obj;
            else    
                lstOrg2.value=obj;
        }    
     }
     else
     {   
        var fpath = System.RootURL + "/form/ch/ae/chae00010_search_emp.aspx" ;
        var obj  = System.OpenModal(  fpath , 900 ,600, 'resizable:yes;status:yes;');
	    if (obj!=null)
	        idEmp_id_M.text=obj[1];
	  }      
     
        
    
}
//------------------------------------
function OnChangeMonth(n)
{
    if(n==1)
        datCheck_Month.Call();
    else if(n==2)
    {
        grdSalary2.ClearData();
        dtMonth_close.value=dtMonth2.value;
        OnChangeMonth(1);
        
    }    
}
//----------------------------------------------------
function ChoseList_box(obj_list,value)
{
    obj_list.SetDataText(value)    ;
    obj=obj_list.GetControl();
	if (obj.options.length ==2)
		obj.options.selectedIndex=0;
	else
		obj.options.selectedIndex=obj.options.length-1;
}
//----------------------------------------------
function OnDataReceive(obj)
{  
   if (obj.id=="dat_salary_level")
   {      switch (tabMain.GetCurrentPageNo())
            {   
                case 0:
                {if(grdSalary_level.rows==2)  
                    {//alert("event " + event.row + " row " + grdSalary.row )
                       grdSalary.SetGridText(rowselect,9,grdSalary_level.GetGridData(1,4));
                        grdSalary.SetGridText(rowselect,13,grdSalary_level.GetGridData(1,5));
                        grdSalary.SetGridText(rowselect,14,grdSalary_level.GetGridData(1,6));
                        grdSalary.SetGridText(rowselect,15,grdSalary_level.GetGridData(1,7));
                        grdSalary.SetGridText(rowselect,16,grdSalary_level.GetGridData(1,8));
                        grdSalary.SetGridText(rowselect,17,grdSalary_level.GetGridData(1,9));
                        grdSalary.SetGridText(rowselect,18,grdSalary_level.GetGridData(1,10));
                        grdSalary.SetGridText(rowselect,19,grdSalary_level.GetGridData(1,11));
                        grdSalary.SetGridText(rowselect,20,grdSalary_level.GetGridData(1,12));
                   }
                    break;
                }
                case 1:
                {   if(grdSalary_level.rows==2)  
                      { grdSalary2.SetGridText(rowselect,8,grdSalary_level.GetGridData(1,4));
                        grdSalary2.SetGridText(rowselect,12,grdSalary_level.GetGridData(1,5));
                        grdSalary2.SetGridText(rowselect,13,grdSalary_level.GetGridData(1,6));
                        grdSalary2.SetGridText(rowselect,14,grdSalary_level.GetGridData(1,7));
                        grdSalary2.SetGridText(rowselect,15,grdSalary_level.GetGridData(1,8));
                        grdSalary2.SetGridText(rowselect,16,grdSalary_level.GetGridData(1,9));
                        grdSalary2.SetGridText(rowselect,17,grdSalary_level.GetGridData(1,10));
                        grdSalary2.SetGridText(rowselect,18,grdSalary_level.GetGridData(1,11));
                        grdSalary2.SetGridText(rowselect,19,grdSalary_level.GetGridData(1,12));
                      }
                    break;
                }
            }  
      
   }
   else if (obj.id=="datAllowance")
   {
        var icol=13; //value of allowance col
        grdSalary.SetGridText(0,icol,grdAllowance.GetGridData(1,0));
        grdSalary.SetGridText(0,icol+1,grdAllowance.GetGridData(1,1));
        grdSalary.SetGridText(0,icol+2,grdAllowance.GetGridData(1,2));
        grdSalary.SetGridText(0,icol+3,grdAllowance.GetGridData(1,3));
        grdSalary.SetGridText(0,icol+4,grdAllowance.GetGridData(1,4));
        grdSalary.SetGridText(0,icol+5,grdAllowance.GetGridData(1,5));
        grdSalary.SetGridText(0,icol+6,grdAllowance.GetGridData(1,6));
        grdSalary.SetGridText(0,icol+7,grdAllowance.GetGridData(1,7));
        grdSalary.GetGridControl().ColHidden(icol)=!(Number(grdAllowance.GetGridData(1,8)));
        grdSalary.GetGridControl().ColHidden(icol+1)=!(Number(grdAllowance.GetGridData(1,9)));
        grdSalary.GetGridControl().ColHidden(icol+2)=!(Number(grdAllowance.GetGridData(1,10)));
        grdSalary.GetGridControl().ColHidden(icol+3)=!(Number(grdAllowance.GetGridData(1,11)));
        grdSalary.GetGridControl().ColHidden(icol+4)=!(Number(grdAllowance.GetGridData(1,12)));
        grdSalary.GetGridControl().ColHidden(icol+5)=!(Number(grdAllowance.GetGridData(1,13)));
        grdSalary.GetGridControl().ColHidden(icol+6)=!(Number(grdAllowance.GetGridData(1,14)));
        grdSalary.GetGridControl().ColHidden(icol+7)=!(Number(grdAllowance.GetGridData(1,15)));
        if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
        {
            datGet_Location_dept.Call(); 
               
        }
        
        check_init =1;
   }
   else if(obj.id=="datCurrent_Salary")
   {
        lblRecord.text=grdSalary.rows-1 + " record(s)";
        if (grdSalary.rows>1)
        {
            InitButton(true);
            auto_resize_column(grdSalary,0,grdSalary.GetGridControl().cols-1,0)
        }
        else
        {
            InitButton(false);
        }
        for(var i=1; i<grdSalary.rows; i++)
        {
            if(grdSalary.GetGridData(i, g_app_type) =="01")// status waiting
                grdSalary.SetCellBgColor(i, g_emp_pk ,i, g_app_type, 0xFFCCFF);
        }
   }
   else if (obj.id=="datUser_info")
   {
       
            lstOrg.SetDataText(txtdept_temp.text);            
            lstOrg2.SetDataText(txtdept_temp.text);
            txtDept.text=lstOrg.value;
            
            check_init =1;
   }
   else if (obj.id=="datGet_Location_dept")
   {
        if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
            datUser_info.Call(); 
   }
   else if (obj.id=="datCheck_Month")
   {
        if(flag2==false)
        {
            flag2=true;
        }
        if(lblstatus2.text=="Closed")
        {
            ibtnProcess2.SetEnable(0);
            ibtnCancel2.SetEnable(0);
        }    
        else
        {
            ibtnProcess2.SetEnable(1);
            ibtnCancel2.SetEnable(1);
        }     
   }
   else if(obj.id=="datCheck_Crt_Pro")
   {
        if(txtMonth_flag.text=="Y" && txtFlag.text=="DEL")//thang nay da hoac dang tinh luong
        {
            if(Trim(idEmp_id_M.text)=="")
            {
                alert("This month existed, you only can do if you choose emp id.\nTháng này đã tồn tại dữ liệu, bạn chỉ có thể thực hiện cho từng emp id.")
                return;
            }    
        }
        else
        {      
            if(txtCheck_App.text == "Y")
            {
                alert("Salary data  haven't approved!\nDữ liệu lương thay đổi chưa được duyệt!");
                return ;
            }
            if(confirm("Are you sure?\nBạn đã chắc chắn?"))
            {
                set_Interval(100);           
                datSalary_Create_Del.Call();
            } 
        }
   }
   else if (obj.id=="datMonth_Salary")
   {
        lblRecord2.text=grdSalary2.rows-1 + " record(s)";
        auto_resize_column(grdSalary2,0,grdSalary2.GetGridControl().cols-1,0)
       for(var i=1;i<grdSalary2.rows;i++)
     {
     if(grdSalary2.GetGridData(i,21)=="M")
              grdSalary2.SetCellBgColor(i, 0,i, 21, 0x99FFFF );
     if(grdSalary2.GetGridData(i,21)=="Y")      
             grdSalary2.SetCellBgColor(i, 0,i, 21, 0xFFEEFF );
     }              
        
   }
   else if (obj.id=="datSalary_Create_Del")
   {
        if(txtresult.text=='0')
        {
            alert("Finish!\nHoàn thành!")
            clear_Interval(lbldata2);
            datCheck_Month.Call();
        }        
        else if (txtresult.text=='1')
        {
            alert("Salary period have been undefined !\n Chu kỳ lương tháng này chưa đuợc định nghĩa!")
            clear_Interval(lbldata2);
            lbldata2.text="Fail";
        }
        else
        {
            alert("There is error occur.\nĐã có lỗi xảy ra.")
            clear_Interval(lbldata2);
            lbldata2.text="Fail";
         }   
       
   }
   
   
}
//-------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}

//------------------------------------------------------
function checkNumber(n)
{
    if(n==1)
    {
	        var ctrl 	= grdSalary.GetGridControl();
	        var rownum 	= ctrl.Rows;
        	
	        if(rownum == 1)
	            return false;
        	
	        var i;
	        for(i=1; i<rownum; i++)
	        {
	 	        for(j=7; j <= 19; j++)
		        {
		            if (j<9 || j>11)
			        {
			            var ij_num 	= grdSalary.GetGridData(i, j);
			            if (isNaN(ij_num))
			            {
				            alert("Please enter is number at col " + i + " and " + (j-1) );
				            return false;
			            }
			            if (Number(ij_num) < -1)
			            {
				            alert("Please enter is number >= -1 at col " + i + " and " + (j-1) );
				            return false;
			            }
			        }
		        }	
	        }
	        return true;
	 }   
    else if(n==2)
    {
	        var ctrl 	= grdSalary2.GetGridControl();
	        var rownum 	= ctrl.Rows;
        	
	        if(rownum == 1)
	            return false;
        	
	        var i;
	        for(i=1; i<rownum; i++)
	        {
	 	        for(j=7; j <= 18; j++)
		        {
		            if (j<9 || j>10)
			        {
			            var ij_num 	= grdSalary2.GetGridData(i, j);
			            if (isNaN(ij_num))
			            {
				            alert("Please enter is number at col " + i + " and " + (j-1) );
				            return false;
			            }
			            if (Number(ij_num) < -1)
			            {
				            alert("Please enter is number >= -1 at col " + i + " and " + (j-1) );
				            return false;
			            }
			        }
		        }	
	        }
	        return true;
	 }  
}


//----------------------------------------------------
function OnSearch(n)
{
    if(check_init ==1)
    {
        if(n==1)
            datCurrent_Salary.Call("SELECT");
        else if(n==2)
            datMonth_Salary.Call("SELECT");    
    }
}

//-----------------------------------------------
function OnSave(n)
{
    if(check_init ==1)
    {
        if (confirm("Do you want to save? \n Bạn có muốn lưu không?"))
        {
            if(n==1)
            {
                if (checkNumber(1))
                     datCurrent_Salary.Call();
            }
            else if(n==2)
            {
                if (checkNumber(2))
                     datMonth_Salary.Call();
            }        
        }
     }  
}


//----------------------------------------------------
function OnSetConfirmDate(n)
{
    if(n==1)//tab 1 current
    {
        var ctrl = grdSalary.GetGridControl();
	    for ( var i =  0 ; i < ctrl.SelectedRows ; i++ )
		    {
			    var row = ctrl.SelectedRow(i);
			    if ( row > 0 )
			    {		
				    grdSalary.SetGridText(row,10,dtConfirmDate.value);
			    }	
		    }
	}	    
	else if(n==2)//tab 2 month
    {
        var ctrl = grdSalary2.GetGridControl();
	    for ( var i =  0 ; i < ctrl.SelectedRows ; i++ )
		    {
			    var row = ctrl.SelectedRow(i);
			    if ( row > 0 )
			    {		
				    grdSalary2.SetGridText(row,9,dtConfirmDate2.value);
			    }	
		    }
	}	    
}
//----------------------------------------------------
function OnSetSalary(n)
{
    if(n==1)
    {
            if (isNaN(txtNewSalary.text))
            {
                alert("Please input number!");
                return;   
            }   
            if (Number(txtNewSalary.text)<0)
            {
                alert("Please input number larger than 0!");
                return;   
            }  
            if ((Number(txtNewSalary.text)<=0 || Number(txtNewSalary.text)>100) && lstOperator.value =="%")
            {
                alert("Please input number from 1 to 100!");
                return;   
            }  
            var ctrl = grdSalary.GetGridControl();
	        for ( var i =  0 ; i < ctrl.SelectedRows ; i++ )
	        {
		        var row = ctrl.SelectedRow(i);
		        if ( row > 0 )
		        {	
		            var old_tmp,new_tmp,col;	
		            switch(lstTmp.value)
		            {
		                case "A0":
		                    old_tmp=grdSalary.GetGridData(row,9);
		                    col=9;
		                    break;
		                case "A1":
		                    old_tmp=grdSalary.GetGridData(row,13);  
		                    col=13; 
		                    break;
		                case "A2":
		                    old_tmp=grdSalary.GetGridData(row,14);  
		                    col=14; 
		                    break;    
		                case "A3":
		                    old_tmp=grdSalary.GetGridData(row,15); 
		                    col=15;  
		                    break;  
		                case "A4":
		                    old_tmp=grdSalary.GetGridData(row,16); 
		                    col=16;  
		                    break;  
		                case "A5":
		                    old_tmp=grdSalary.GetGridData(row,17); 
		                    col=17;  
		                    break;  
		                case "A6":
		                    old_tmp=grdSalary.GetGridData(row,18);  
		                    col=18; 
		                    break;  
		                case "A7":
		                    old_tmp=grdSalary.GetGridData(row,19);  
		                    col=19; 
		                    break;  
		                case "A8":
		                    old_tmp=grdSalary.GetGridData(row,20); 
		                    col=20;  
		                    break;  
		                case "A9":
		                    old_tmp=grdSalary.GetGridData(row,20); 
		                    col=22;  
		                    break;                         
		                }
		           
		            if (old_tmp=="")
		                old_tmp=0;
		            if(old_tmp>=Number(txtFromSalary.text) && old_tmp<=Number(txtToSalary.text))
		            {    
		                if (lstOperator.value=="+")
		                {
		                    new_tmp=Number(old_tmp) + Number(txtNewSalary.text);
		                }
		                else if (lstOperator.value=="=")// operator is "=" 
		                    new_tmp=txtNewSalary.text;
		                else //%
		                    new_tmp=Number(txtNewSalary.text)*Number(old_tmp)/100 + Number(old_tmp);
    		                
    		            new_tmp = Math.round(new_tmp)
		                grdSalary.SetGridText(row,col,new_tmp);
		            }
		        }		
	        }
	 }   
	else if(n==2)
    {
            if (isNaN(txtNewSalary2.text))
            {
                alert("Please input number!");
                return;   
            }   
            if (Number(txtNewSalary2.text)<0)
            {
                alert("Please input number larger than 0!");
                return;   
            }  
            if ((Number(txtNewSalary2.text)<=0 || Number(txtNewSalary2.text)>100) && lstOperator2.value =="%")
            {
                alert("Please input number from 1 to 100!");
                return;   
            }  
            var ctrl = grdSalary2.GetGridControl();
	        for ( var i =  0 ; i < ctrl.SelectedRows ; i++ )
	        {
		        var row = ctrl.SelectedRow(i);
		        if ( row > 0 )
		        {	
		            var old_tmp,new_tmp,col;	
		            switch(lstTmp2.value)
		            {
		                case "A0":
		                    old_tmp=grdSalary2.GetGridData(row,8);
		                    col=8;
		                    break;
		                case "A1":
		                    old_tmp=grdSalary2.GetGridData(row,12);  
		                    col=12; 
		                    break;
		                case "A2":
		                    old_tmp=grdSalary2.GetGridData(row,13);  
		                    col=13; 
		                    break;    
		                case "A3":
		                    old_tmp=grdSalary2.GetGridData(row,14); 
		                    col=14;  
		                    break;  
		                case "A4":
		                    old_tmp=grdSalary2.GetGridData(row,15); 
		                    col=15;  
		                    break;  
		                case "A5":
		                    old_tmp=grdSalary2.GetGridData(row,16); 
		                    col=16;  
		                    break;  
		                case "A6":
		                    old_tmp=grdSalary2.GetGridData(row,17);  
		                    col=17; 
		                    break;  
		                case "A7":
		                    old_tmp=grdSalary2.GetGridData(row,18);  
		                    col=18; 
		                    break;  
		                case "A8":
		                    old_tmp=grdSalary2.GetGridData(row,19); 
		                    col=19;  
		                    break;   
		                case "A9":
		                    old_tmp=grdSalary2.GetGridData(row,19); 
		                    col=23;  
		                    break;                          
		                }
		            if (old_tmp=="")
		                old_tmp=0;
		            if(old_tmp>=Number(txtFromSalary2.text) && old_tmp<=Number(txtToSalary2.text))
		            {    
		                if (lstOperator2.value=="+")
		                {
		                    new_tmp=Number(old_tmp) + Number(txtNewSalary2.text);
		                }
		                else if (lstOperator2.value=="=")// operator is "=" 
		                    new_tmp=txtNewSalary2.text;
		                else //%
		                    new_tmp=Number(txtNewSalary2.text)*Number(old_tmp)/100 + Number(old_tmp);
		                new_tmp = Math.round(new_tmp)
		                grdSalary2.SetGridText(row,col,new_tmp);
		            }
		        }		
	        }
	 }   
}
//--------------------------------------------------------------
function  OnClickGrid(n)
{
    switch(n)
    {
        case 1:
            if (event.col==11) // double on position column
            {
                var pos_code=grdSalary.GetGridData(event.row,event.col);
                var id="HR0008";
                var fpath = System.RootURL + "/form/ch/cs/chcs0020_code.aspx?code=" + pos_code + "&id=" + id;
                var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:30;dialogHeight:25;dialogLeft:300;dialogTop:230;edge:sunken;scroll:yes;unadorned:yes;help:no');
                if (obj!=null)
                {
                    
                    if(obj[0]!=pos_code)
                    {
                        grdSalary.SetGridText(event.row,event.col,obj[0]);
                        grdSalary.SetCellBgColor(event.row, event.col,event.row, event.col, 0xcc99ff );
                        grdSalary.SetCellBold(event.row,event.col,event.row,event.col,true);
                    }
                }
            }
             if (event.col==12) // double on position column
            {
                var pos_code=grdSalary.GetGridData(event.row,event.col);
               // var id="HR0008";
                var fpath = System.RootURL + "/form/ch/cs/chcs0020_slary_level.aspx?pk=" + pos_code +"&option=1";
                var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:50;dialogHeight:50;dialogLeft:300;dialogTop:230;edge:sunken;scroll:yes;unadorned:yes;help:no');
                if (obj!=null)
                {
                    
                    if(obj[0]!=pos_code)
                    {
                        grdSalary.SetGridText(event.row,event.col,obj[0]);
                        grdSalary.SetGridText(event.row,9,obj[1]);
                        grdSalary.SetGridText(event.row,13,obj[2]);
                        grdSalary.SetGridText(event.row,14,obj[3]);
                        grdSalary.SetGridText(event.row,15,obj[4]);
                        grdSalary.SetGridText(event.row,16,obj[5]);
                        grdSalary.SetGridText(event.row,17,obj[6]);
                        grdSalary.SetGridText(event.row,18,obj[7]);
                        grdSalary.SetGridText(event.row,19,obj[8]);
                        grdSalary.SetGridText(event.row,20,obj[9]);
                        
                        
                        
                        grdSalary.SetCellBgColor(event.row, event.col,event.row, event.col, 0xcc99ff );
                        grdSalary.SetCellBold(event.row,event.col,event.row,event.col,true);
                    }
                }
            }
            else if (event.col<=6) // 
            {
                var emp_id=grdSalary.GetGridData(event.row,3);
                var fpath = System.RootURL + "/form/ch/cs/chcs0020_salary_his.aspx?emp_id=" + emp_id;
                window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:60;dialogHeight:25;dialogLeft:100;dialogTop:230;edge:sunken;scroll:yes;unadorned:yes;help:no');
            }
            break;
        case 2:
            if (event.col==10) // double on position column
            {
                var pos_code=grdSalary2.GetGridData(event.row,event.col);
                var id="HR0008";
                var fpath = System.RootURL + "/form/ch/cs/chcs0020_code.aspx?code=" + pos_code + "&id=" + id;
                var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:30;dialogHeight:25;dialogLeft:300;dialogTop:230;edge:sunken;scroll:yes;unadorned:yes;help:no');
                
                 if (obj!=null)
                {
                    
                    if(obj[0]!=pos_code)
                    {
                        grdSalary2.SetGridText(event.row,event.col,obj[0]);
                        grdSalary2.SetCellBgColor(event.row, event.col,event.row, event.col, 0xcc99ff );
                        grdSalary2.SetCellBold(event.row,event.col,event.row,event.col,true);
                    }
                }
            }
              if (event.col==11) // double on position column
            {
                var pos_code=grdSalary2.GetGridData(event.row,event.col);
               // var id="HR0008";
                var fpath = System.RootURL + "/form/ch/cs/chcs0020_slary_level.aspx?pk=" + pos_code +"&option=1";
                var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:50;dialogHeight:50;dialogLeft:300;dialogTop:230;edge:sunken;scroll:yes;unadorned:yes;help:no');
                if (obj!=null)
                {
                    
                    if(obj[0]!=pos_code)
                    {
                        grdSalary2.SetGridText(event.row,event.col,obj[0]);
                        grdSalary2.SetGridText(event.row,8,obj[1]);
                        grdSalary2.SetGridText(event.row,12,obj[2]);
                        grdSalary2.SetGridText(event.row,13,obj[3]);
                        grdSalary2.SetGridText(event.row,14,obj[4]);
                        grdSalary2.SetGridText(event.row,15,obj[5]);
                        grdSalary2.SetGridText(event.row,16,obj[6]);
                        grdSalary2.SetGridText(event.row,17,obj[7]);
                        grdSalary2.SetGridText(event.row,18,obj[8]);
                        grdSalary2.SetGridText(event.row,19,obj[9]);
                        
                        
                        
                        grdSalary.SetCellBgColor(event.row, event.col,event.row, event.col, 0xcc99ff );
                        grdSalary.SetCellBold(event.row,event.col,event.row,event.col,true);
                    }
                }
            }
            else if (event.col<=6) // 
            {
                var emp_id=grdSalary2.GetGridData(event.row,3);
                var fpath = System.RootURL + "/form/ch/cs/chcs0020_salary.aspx?emp_id=" + emp_id;
                window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:60;dialogHeight:25;dialogLeft:100;dialogTop:230;edge:sunken;scroll:yes;unadorned:yes;help:no');
            }
            break;    
    }    
}

function onPage_active()
{
    if(tabMain.GetCurrentPageNo()==1)
    {
        if(tab2==false)
        {
            var icol=12; //value of allowance col
            grdSalary2.SetGridText(0,icol,grdAllowance.GetGridData(1,0));
            grdSalary2.SetGridText(0,icol+1,grdAllowance.GetGridData(1,1));
            grdSalary2.SetGridText(0,icol+2,grdAllowance.GetGridData(1,2));
            grdSalary2.SetGridText(0,icol+3,grdAllowance.GetGridData(1,3));
            grdSalary2.SetGridText(0,icol+4,grdAllowance.GetGridData(1,4));
            grdSalary2.SetGridText(0,icol+5,grdAllowance.GetGridData(1,5));
            grdSalary2.SetGridText(0,icol+6,grdAllowance.GetGridData(1,6));
            grdSalary2.SetGridText(0,icol+7,grdAllowance.GetGridData(1,7));
            grdSalary2.GetGridControl().ColHidden(icol)=!(Number(grdAllowance.GetGridData(1,8)));
            grdSalary2.GetGridControl().ColHidden(icol+1)=!(Number(grdAllowance.GetGridData(1,9)));
            grdSalary2.GetGridControl().ColHidden(icol+2)=!(Number(grdAllowance.GetGridData(1,10)));
            grdSalary2.GetGridControl().ColHidden(icol+3)=!(Number(grdAllowance.GetGridData(1,11)));
            grdSalary2.GetGridControl().ColHidden(icol+4)=!(Number(grdAllowance.GetGridData(1,12)));
            grdSalary2.GetGridControl().ColHidden(icol+5)=!(Number(grdAllowance.GetGridData(1,13)));
            grdSalary2.GetGridControl().ColHidden(icol+6)=!(Number(grdAllowance.GetGridData(1,14)));
            grdSalary2.GetGridControl().ColHidden(icol+7)=!(Number(grdAllowance.GetGridData(1,15)));
            tab2=true;
            tr_month.style.display="none";
            visible_grdSalary(2,3);
            txtDept.text=lstOrg2.value;
            datCheck_Month.Call();
            
            
         }   
        
    }
}
//------------------------------------------

function OnToggle(n)
{
    switch(n)
    {
        case 1:
            if(img1.status == "middle")
            {
                img1.status = "large";
                img1.src = "../../../system/images/iconmaximize.gif";
			    img1.alt="Show all columns";
			    visible_grdSalary(1,2);
    			
            }
            else if(img1.status == "large")
            {
                img1.status = "min";
                img1.src = "../../../system/images/iconminimize.gif";
			    img1.alt="Hide column";
			    visible_grdSalary(1,1);
            }
            else if(img1.status == "min")
            {
                img1.status = "middle";
                img1.src = "../../../system/images/menu.gif";
			    img1.alt="Show more columns";
			    visible_grdSalary(1,3);
            }
            break;
       case 2:
            if(img2.status == "show")
            {
                img2.status = "hide";
                img2.src = "../../../system/images/close_popup.gif";
			    img2.alt="Hide month salary information";
			    tr_month.style.display='';
            }
            else 
            {
                img2.status = "show";
                img2.src = "../../../system/images/iconmaximize.gif";
			    img2.alt="Show month salary information";
			    tr_month.style.display="none";
            }
           
            break;   
       case 3:
            if(img3.status == "middle")
            {
                img3.status = "large";
                img3.src = "../../../system/images/iconmaximize.gif";
			    img3.alt="Show all columns";
			    visible_grdSalary(2,2);
    			
            }
            else if(img3.status == "large")
            {
                img3.status = "min";
                img3.src = "../../../system/images/iconminimize.gif";
			    img3.alt="Hide column";
			    visible_grdSalary(2,1);
            }
            else if(img3.status == "min")
            {
                img3.status = "middle";
                img3.src = "../../../system/images/menu.gif";
			    img3.alt="Show more columns";
			    visible_grdSalary(2,3);
            }
            break;       
    }    
    
  
}
function visible_grdSalary(grid_no,n)
{
    if(grid_no==1)
    {
        switch(n)
        {
            case 1://middle
               
                grdSalary.GetGridControl().ColHidden(1)=0;
                grdSalary.GetGridControl().ColHidden(2)=0;
                grdSalary.GetGridControl().ColHidden(5)=0;
                grdSalary.GetGridControl().ColHidden(6)=0;
                grdSalary.GetGridControl().ColHidden(7)=0;
                break;
            case 2://large
                //alert(2)
                grdSalary.GetGridControl().ColHidden(2)=0;
                grdSalary.GetGridControl().ColHidden(5)=0;
                grdSalary.GetGridControl().ColHidden(7)=0;
                break;
            case 3://hide all
                //alert(3)
                grdSalary.GetGridControl().ColHidden(1)=1;
                grdSalary.GetGridControl().ColHidden(2)=1;
                grdSalary.GetGridControl().ColHidden(5)=1;
                grdSalary.GetGridControl().ColHidden(6)=1;
                grdSalary.GetGridControl().ColHidden(7)=1;
                break;    
        }
    }
    else if(grid_no==2)
    {
        switch(n)
        {
            case 1://middle
               
                grdSalary2.GetGridControl().ColHidden(1)=0;
                grdSalary2.GetGridControl().ColHidden(2)=0;
                grdSalary2.GetGridControl().ColHidden(5)=0;
                grdSalary2.GetGridControl().ColHidden(6)=0;
                
                break;
            case 2://large
                //alert(2)
                grdSalary2.GetGridControl().ColHidden(2)=0;
                grdSalary2.GetGridControl().ColHidden(5)=0;
                
                break;
            case 3://hide all
                //alert(3)
                grdSalary2.GetGridControl().ColHidden(1)=1;
                grdSalary2.GetGridControl().ColHidden(2)=1;
                grdSalary2.GetGridControl().ColHidden(5)=1;
                grdSalary2.GetGridControl().ColHidden(6)=1;
                
                break;    
        }
    }    
}
function OnSalary_New_Del(flag)
{   
    txtFlag.text=flag;
    datCheck_Crt_Pro.Call();
    
}
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
function ChangSalary()
{   if(idSAL_KIND.value=='01')
        {
        lstTimesPeriod.SetEnable(false);
        lstTimesPeriod.value ="";
        idSAL_KIND.text="";       
        
        }
        else
        {lstTimesPeriod.SetEnable(true);
          idSAL_KIND.text="Resign Salary";
          lstTimesPeriod.value ="01";
          
        }
}
var rowselect=0;
function OnSelChange_salary(obj)
{   if(obj=='1' && grdSalary.row>0 && grdSalary.col==12 )
        {txt_PK.text=grdSalary.GetGridData(grdSalary.row,12);
         rowselect=grdSalary.row;
         dat_salary_level.Call('SELECT');
        }
    if(obj=='2' && grdSalary2.row>0 && grdSalary2.col==11 )
        {txt_PK.text=grdSalary2.GetGridData(grdSalary2.row,11);
               dat_salary_level.Call('SELECT');
               rowselect=grdSalary2.row;
        }

}
</script>
<body >
<!-------------------data control----------------------->
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
                    <output bind="txtdept_temp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------>
<gw:data id="datAllowance" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="HR_SP_SEL_ALLOWANCE_SALARY" > 
                <input bind="grdAllowance" >
                </input>
                <output  bind="grdAllowance" />
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------>
<gw:data id="datCheck_Month" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_check_month_sal_v1" > 
                <input >
                    <input bind="dtMonth_close" /> 
                    <input bind="lstLocation_dept" /> 
                    <input bind="idSAL_KIND" /> 
                    <input bind="lstTimesPeriod" /> 
                </input>
                <output >
                    <output bind="lbldata2" /> 
                    <output bind="lblstatus2" /> 
                    <output bind="txtMonth_flag" /> 
                    <output bind="txtCheck_App" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------>
<gw:data id="datCheck_Crt_Pro" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_check_month_sal_v1" > 
                <input >
                    <input bind="dtMonth_close" /> 
                    <input bind="lstLocation_dept" /> 
                    <input bind="idSAL_KIND" /> 
                    <input bind="lstTimesPeriod" /> 
                </input>
                <output >
                    <output bind="lbldata2" /> 
                    <output bind="lblstatus2" /> 
                    <output bind="txtMonth_flag" /> 
                    <output bind="txtCheck_App" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>
<gw:data id="datCurrent_Salary" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22" function="hr.sp_sel_current_salary_v1" procedure="hr.SP_upd_current_salary_v1"> 
                <input bind="grdSalary" >
                   <input bind="lstOrg" /> 
                   <input bind="lstWGroup" /> 
                   <input bind="lstPosition" /> 
                   <input bind="lstTemp" /> 
                   <input bind="txtTemp" /> 
                   <input bind="lstMon_Year" /> 
                   <input bind="txtFrom_Mon_Year" /> 
                   <input bind="txtTo_Mon_Year" /> 
                   <input bind="lstContract_Type" /> 
                   <input bind="lstStatus" /> 
                   <input bind="dtFrom_JoinDate" /> 
                   <input bind="dtTo_JoinDate" /> 
                   <input bind="dtFrom_LeftDate" /> 
                   <input bind="dtTo_LeftDate" /> 
                   <input bind="txtFromSalary" /> 
                   <input bind="txtToSalary" /> 
                   <input bind="dtConfirmDate" />
                   <input bind="lstMoney" />
                   <input bind="lstTmp" />
                   <input bind="lstEmp_Type" />
                </input>
                <output  bind="grdSalary" />
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------------>
<gw:data id="datMonth_Salary" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,7,8,9,10,11,12,13,14,15,16,17,18,19,20,22,23" function="hr.sp_sel_month_salary_v1" procedure="hr.SP_upd_month_salary_v1"> 
                <input bind="grdSalary2" >
                   <input bind="lstOrg2" /> 
                   <input bind="lstWGroup2" /> 
                   <input bind="lstPosition2" /> 
                   <input bind="lstTemp2" /> 
                   <input bind="txtTemp2" /> 
                   <input bind="lstMon_Year2" /> 
                   <input bind="txtFrom_Mon_Year2" /> 
                   <input bind="txtTo_Mon_Year2" /> 
                   <input bind="lstContract_Type2" /> 
                   <input bind="lstStatus2" /> 
                   <input bind="dtFrom_JoinDate2" /> 
                   <input bind="dtTo_JoinDate2" /> 
                   <input bind="dtFrom_LeftDate2" /> 
                   <input bind="dtTo_LeftDate2" /> 
                   <input bind="txtFromSalary2" /> 
                   <input bind="txtToSalary2" /> 
                   <input bind="dtConfirmDate2" />
                   <input bind="dtMonth2" />
                   <input bind="lstTmp2" />
                   <input bind="lstEmp_Type2" />
                </input>
                <output  bind="grdSalary2" />
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------>
<gw:data id="datSalary_Create_Del" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_create_del_sal" > 
                <input >
                    <input bind="txtFlag" /> 
                    <input bind="dtMonth_close" />
                    <input bind="idEmp_id_M" />  
                    <input bind="lstLocation_dept" />  
                    <input bind="idSAL_KIND" />
                    <input bind="lstTimesPeriod" />
                </input>
                <output >
                    <output bind="txtresult" /> 
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------>
<gw:data id="datGet_Location_dept" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="HR.SP_PRO_GET_DEPT_PARENT" > 
                <input>
                    <input bind="iduser_pk" /> 
                </input> 
                <output>
                    <output bind="lstLocation_dept" />
                </output>
            </dso> 
        </xml> 
</gw:data>


<gw:data id="dat_salary_level" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="" function="HR.sp_group_salary"> 
                <input bind="grdSalary_level" >
                 <input bind="txt_PK" />
                 <input bind="txt_option" />                 
                    </input>
                <output  bind="grdSalary_level" />
            </dso> 
        </xml> 
</gw:data>
<!-------------------data control----------------------->
<gw:tab id="tabMain" border=1 style="width:100%;height:100%;" onpageactivate="onPage_active()"  >
   <table name="Current Sal" id="management" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="tblexp" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                    <tr style="border:1;width:100%;height:5%" valign="center" >
                        <td colspan=5 width="10%" align="right" style="border:0;"><a title="Click here to show Organization" onclick="OnShowPopup(1)" href="#tips" >Organization</a>                  
                        </td>
                        <td colspan=10 width="20%"  align="left" style="border:0;">
                         <gw:list  id="lstOrg" value='ALL' styles='width:100%' onchange="" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td colspan=4 width="8%" align="right" style="border:0;" >W-Group</td>
                        <td colspan=8 width="16%"  align="left" style="border:0;" >
                            <gw:list  id="lstWGroup" value='ALL' maxlen = "100" styles="width:100%" >
                                <data><%=Esyslib.SetListDataSQL("SELECT pk,workgroup_NM FROM Thr_work_Group WHERE DEL_IF = 0 order by workgroup_id" )%>|ALL|Select All</data></gw:list>
                        </td>
                         <td colspan=4 width="8%" align="right" style="border:0;" >Position</td>
                        <td colspan=5 width="10%"  align="left" style="border:0;">
                             <gw:list  id="lstPosition" value='ALL' styles='width:100%' >
                               <data>
                                    <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code")%>|ALL|Select All
                                </data></gw:list>
                        </td>
                       
                        <td colspan=4 width="8%"  align="right" valign="middle" style="border:0;">Search by</td>
					    <td  colspan=2 width="8%" style="border:0;">
					        <gw:list  id="lstTemp" value="2" styles='width:100%' onchange=""> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID</data> 
					        </gw:list>
				        </td>
                        <td colspan=6 width="12%" align=center style="border:0"> 
					        <gw:textbox id="txtTemp" onenterkey   ="OnSearch(1)" styles='width:100%'/>
				        </td>
                        <td width="2%" style="border:0;" align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch(1)"/>
                        </td>
                        <td width="2%" style="border:0" align="right">
                            <gw:imgBtn img="save" id="ibtnSave"    alt="Save"  onclick="OnSave(1)"/>
                        </td>
                     </tr>
                     <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td colspan=3 style="border:0;" align="left" > <gw:list  id="lstMon_Year" value='MON' maxlen = "100" styles='width:95%'>
                            <data>|MON|Months|YEAR|Years</data>     </gw:list>
                        </td>
                        <td  colspan=2 style="border:0;" align="left" ><gw:textbox id="txtFrom_Mon_Year"  styles='width:100%'/>
                        </td>
                         <td width="2%" style="border:0;" align="center" ><b>~</b></td>
                         <td colspan=2 style="border:0;" align="left" ><gw:textbox id="txtTo_Mon_Year"  styles='width:100%'/>
                        </td>
                        <td colspan=7 style="border:0;" align="center" > <gw:list  id="lstEmp_Type" value='ALL' maxlen = "100" styles='width:94%' >
                           <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0017' order by code")%>|ALL|Emp Type-Select All
                            </data></gw:list></td>
                        <td colspan=6 style="border:0;  " align="center">
                            <gw:list  id="lstContract_Type" value='ALL' maxlen = "100" styles='width:94% ' >
                                <data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0001' order by code")%>|ALL|Contract-Select All</data></gw:list>
                        </td>
                        <td  colspan=2 style="border:0" align="right">Status</td>
                        <td colspan=4 style="border:0"> 
					        <gw:list  id="lstStatus" value='A' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0022' order by code" )%>|ALL|Select All</data></gw:list>
                        </td>
                        <td colspan=4 style="border:0;" align="right" >Join Date</td>
                        <td colspan=4 style="border:0;" align="left" >
                            <gw:datebox id="dtFrom_JoinDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" />
                        </td>
                        <td width="2%" style="border:0;" align="center" ><b>~</b></td>
                        <td colspan=4 align="left" style="border:0;">
                            <gw:datebox id="dtTo_JoinDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" />
                        </td>
                       <td colspan=2 style="border:0;" align="right" >Left Date</td>
                        <td colspan=4 style="border:0;" align="left" >
                            <gw:datebox id="dtFrom_LeftDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" />
                        </td>
                        <td width="2%" style="border:0;" align="center" ><b>~</b></td>
                        <td colspan=5 align="left" style="border:0;">
                            <gw:datebox id="dtTo_LeftDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" />
                        </td>
                     </tr>
                     <tr style="border:0;width:100%;height:5%" valign="center" >
                        
                        <td colspan=8 style="border:0;" align="right" ><gw:list  id="lstTmp" value='A0' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("SELECT 'A0','Level2 Salary' from dual union SELECT A.CODE,A.CODE_NM FROM VHR_HR_CODE A WHERE A.ID='HR0019' AND A.NUM_2=1" )%></data></gw:list>
                        </td>
                        <td colspan=4 style="border:0;"  align="left"><gw:textbox text=""  id="txtFromSalary"  styles='width:100%'/></td>
                        <td  width="2%" style="border:0;" align="center" > <b>~</b></td>
                        <td colspan=4 style="border:0;" align="left"> <gw:textbox text="" id="txtToSalary"  styles='width:95%'/>
                        </td>
                        <td colspan=2 style="border:0;" align="left">
                            <gw:list  id="lstOperator" value='=' maxlen = "100" styles='width:100%' >
                                <data>|+|+|=|=|%|%</data></gw:list>
                        </td>
                        <td  colspan=4 style="border:0" align="right"><gw:textbox text=""  onkeypress="return Numbers(event)" type="number" format="#,###,###,###.##R" id="txtNewSalary"  styles='width:95%' />
					    </td>
					    <td colspan=2 style="border:0" align="right">
                            <gw:imgBtn img="set" id="ibtnSetSalary"    alt="Set Salary"  onclick="OnSetSalary(1)"/>
                        </td>
                         <td  colspan=5 style="border:0" align="right">Confirm Dt</td>
                        <td colspan=5 style="border:0"><gw:datebox id="dtConfirmDate"  styles="width:100%" lang="<%=Session("Lang")%>" nullaccept/></td>
                        <td width="2%" style="border:0;" align="left" ><gw:imgBtn img="set" id="ibtnSetConfirmDate"    alt="Set Confirm Date"  onclick="OnSetConfirmDate(1)"/></td>
                         <td colspan=4 align="right" style="border:0;" >Money Kind</td>
                        <td colspan=4 align="right" style="border:0;"><gw:list  id="lstMoney" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0040' order by code" )%>|ALL|Select All</data></gw:list></td>
                        <td colspan=4 style="border:0;" align="center" ><gw:label id="lblRecord"  text="0 record(s)" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" /></td>
                        <td  align="right" style="border:0" valign="bottom"><img status="middle" id="img1" alt="Show more columns" src="../../../system/images/menu.gif" style="cursor:hand" onclick="OnToggle(1)"  /></td>
                    </tr>
                    
                    <tr style="border:1;width:100%;height:85%" valign="top">
                        <td colspan=50  style="width:100%;height:100%;"> 
                             <gw:grid   
                                id="grdSalary"  
                                header="_EMP_PK|Organization|W-Group|Emp ID|Full Name|Join Date|Contract Type|Pro Salary|Level 1|Level 2|Confirm DT|Postion|_Salary Level|Allow1|Allow2|Allow3|Allow4|allow5|Allow6|Allow7|Allow8|Money Kind|Ins Salary|Approve Status|_APPROVE_TYPE"
                                format="0|0|0|0|0|4|0|-0|-0|-0|4|0|0|-0|-0|-0|-0|-0|-0|-0|-0|0|-0|2|0"  
                                aligns="0|2|2|1|0|1|1|3|3|3|3|1|1|1|0|0|0|0|0|0|0|0|0|1|0"  
                                defaults="||||||||||||||||||||||||"  
                                editcol="0|0|0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0|0"  
                                widths="0|1500|1600|1000|2500|1200|1700|1200|1200|1200|1200|1200|1500|1700|1700|1500|1500|1500|1500|1500|1500|1500|1500|1500|0"  
                                styles="width:100%; height:100%" 
                                sorting="T" acceptNullDate   
                                oncelldblclick="OnClickGrid(1)"
                                onafteredit="OnSelChange_salary(1)"
                                /> 
                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table>
    <table name="Month Sal" id="MonthSal" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="Table2" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                     <tr id="tr_month" style="border:0;width:100%;height:5%" valign="center" >
                        <td colspan="20">
                            <table style="width:100%;height:100%;">
                                <tr style="width:100%;height:50%"  >
                                    <td width="5%" style="border:0;" align="right" >Location</td>
                                    <td width="10%"  style="border:0;" align="left" ><gw:list  id="lstLocation_dept" value='ALL'  styles='width:100%' >
                                        <data>|ALL|Select All</data></gw:list></td>
                                    <td width="5%" style="border:0;" align="right" >Month</td>
                                    <td width="13%" style="border:0;" align="center"  ><gw:datebox id="dtMonth_close"  onchange="OnChangeMonth(1)" tyles="width:100%" type="month" lang="<%=Session("Lang")%>" /></td>
                                     <td width="12%"  style="border:0;" align="left" >
                                    <gw:list  id="idSAL_KIND" value='01' maxlen = "100" styles='width:100%' onchange="ChangSalary();OnChangeMonth(1)" >
                                                <data>|01|Month salary |02|Resign Salary</data></gw:list></td>
                                     <td width="13%" style="border:0;" align="center"  ><gw:list  id="lstTimesPeriod" value='' maxlen = "100" styles='width:100%' onchange="OnChangeMonth(1)">
                                            <data><%=ESysLib.SetListDataSQL("select a.Code,a.CODE_NM from thr_code_master b,thr_code_detail a  where b.pk=a.THR_CODE_MASTER_PK and a.del_if=0 and b.del_if=0 and b.ID='HR0117' and nvl(b.use_yn,'N')='Y' and  nvl(a.use_yn,'N')='Y' ")%></data></gw:list>
                                     </td>
                                    <td width="4%"  style="border:0;" align="right" >Data</td>
                                    <td width="10%" style="border:0;" align="center" ><gw:label id="lbldata2"  text="status 1" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" /></td>
                                    <td  style="border:0" colspan=2 width="4%"  align="right" valign="middle">Status</td>
					                <td align=center style="border:0" width="10%" ><gw:label id="lblstatus2"  text="status 2" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" /></td>
					               
                                    <td width="6%" align=center style="border:0" ><a title="Click here to choose" onclick="OnShowPopup(2)" href="#tips" >Emp ID</a></td>
                                    <td width="10%" align=center style="border:0" ><gw:textbox id="idEmp_id_M" styles="width:100%" /></td>
                                    <td width="1%" style="border:0" align="right"><gw:imgBtn img="process" id="ibtnProcess2" alt="Create Salary" onclick="OnSalary_New_Del('NEW')"/></td>
                                    <td width="1%" style="border:0" align="right"><gw:imgBtn img="delete" id="ibtnCancel2"    alt="Delete Month Salary"  onclick="OnSalary_New_Del('DEL')"/></td>
                                </tr>
                             </table>
                        </td>
                  </tr>
                    
                  
                  
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td width="1%" style="border:0;" align="right" ><img status="show" id="img2" alt="Show month salary information" src="../../../system/images/iconmaximize.gif" style="cursor:hand" onclick="OnToggle(2)"  /></td>
                        <td width="9%" style="border:0;" align="right" ><a title="Click here to show Organization" onclick="OnShowPopup(3)" href="#tips" >Organization</a>                  
                        </td>
                        <td width="14%" colspan=4 style="border:0;" align="left" >
                         <gw:list  id="lstOrg2" value='ALL' maxlen = "100" styles='width:100%' onchange="" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td width="10%" style="border:0;" align="right"  >W-Group</td>
                        <td width="13%" style="border:0;" align="left" colspan=2>
                         <gw:list  id="lstWGroup2" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("SELECT pk,workGroup_NM FROM Thr_work_Group WHERE DEL_IF = 0 order by workgroup_id" )%>|ALL|Select All</data></gw:list>
                        </td>
                         <td width="8%" colspan=2 style="border:0;" align="right" >Position</td>
                        <td width="10%" style="border:0;" align="left" >
                         <gw:list  id="lstPosition2" value='ALL' maxlen = "100" styles='width:100%' >
                           <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code")%>|ALL|Select All
                            </data></gw:list>
                        </td>
                        
                        <td  style="border:0" colspan=2  width="9%"  align="right" valign="middle"> <gw:list  id="lstEmp_Type2" value='ALL' maxlen = "100" styles='width:100%' >
                           <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0017' order by code")%>|ALL|Emp Type-Select All
                            </data></gw:list></td>
					    <td align=right style="border:0" width="6%" >Search by</td>
                        <td width="7%" align=center style="border:0" colspan=2 > 
					       <gw:list  id="lstTemp2" value="2" styles='width:100%' onchange=""> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID</data> 
					        </gw:list>
				        </td>
				          <td width="7%" style="border:0" align="right">
                            <gw:textbox id="txtTemp2" onenterkey   ="OnSearch(2)" styles='width:100%'/>
                        </td>
                        <td width="3%" style="border:0;" align="right"  >
                         <gw:imgBtn img="search" id="ibtnSearch2"   alt="Search"  onclick="OnSearch(2)"/>
                        </td>
                        <td width="3%" style="border:0" align="right">
                         <gw:imgBtn img="save" id="ibtnSave2"    alt="Save"  onclick="OnSave(2)"/>
                        </td>
                       
                        
                    </tr>
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td width="1%" style="border:0;" align="right" ></td>
                        <td style="border:0;" align="right" > <gw:list  id="lstMon_Year2" value='MON' maxlen = "100" styles='width:90%'>
                            <data>|MON|Months|YEAR|Years</data>     </gw:list>
                        </td>
                        <td  style="border:0;" width="5%" align="left" ><gw:textbox id="txtFrom_Mon_Year2"  styles='width:100%'/>
                        </td>
                         <td style="border:0;" width="1%" align="center" ><b>~</b>
                        </td>
                         <td style="border:0;" width="5%" colspan=2 align="left" ><gw:textbox id="txtTo_Mon_Year2"  styles='width:100%'/>
                        </td>
                        <td style="border:0;" align="right" > <gw:list  id="lstContract_Type2" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0001' order by code")%>|ALL|Contract-Select All</data></gw:list>
                       </td>
                        
                        <td  style="border:0" colspan=1 align="right">Status</td>
                        <td style="border:0"> 
					        <gw:list  id="lstStatus2" value='A' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0022' order by code")%>|ALL|Select All</data></gw:list>
                        </td>
                        <td style="border:0;" align="right" colspan=2 >Join Date</td>
                        <td style="border:0;" align="left" >
                         <gw:datebox id="dtFrom_JoinDate2" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" />
                        </td>
                        <td style="border:0;" width="2%" align="left" ><b>~</b></td>
                        <td colspan=1 style="border:0;"  align="left" >
                         <gw:datebox id="dtTo_JoinDate2" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" />
                        </td>
                         <td style="border:0;" align="right" >Left Date</td>
                        <td style="border:0;" align="left" >
                         <gw:datebox id="dtFrom_LeftDate2" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" />
                        </td>
                        <td style="border:0;"  align="center" width="2%" ><b>~</b></td>
                        <td colspan=3 style="border:0;"  align="left" >
                         <gw:datebox id="dtTo_LeftDate2" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" />
                        </td>
                       
                    </tr>
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td width="1%" style="border:0;" align="right" ></td>
                        <td style="border:0;" align="right" ><gw:list  id="lstTmp2" value='A0' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("SELECT 'A0','Level2 Salary' from dual union SELECT A.CODE,A.CODE_NM FROM VHR_HR_CODE A WHERE A.ID='HR0019' AND A.NUM_2=1" )%></data></gw:list></td>
                        <td colspan=3 style="border:0;" width="9%" align="left"><gw:textbox text=""  id="txtFromSalary2"  styles='width:100%'/></td>
                        <td style="border:0;" align="center" width="2%" > <b>~</b>       
                        </td>
                        <td style="border:0;" align="left"> <gw:textbox text="" id="txtToSalary2"  styles='width:95%'/>
                        </td>
                        <td style="border:0;" align="left" width="5%">
                         <gw:list  id="lstOperator2" value='=' maxlen = "100" styles='width:100%' >
                            <data>|+|+|=|=|%|%</data></gw:list>
                        </td>
                        <td  width="8%" style="border:0" align="center"><gw:textbox text=""  onenterkey="OnSetSalary(2)" type="number" format="#,###,###,###.##R" id="txtNewSalary2"  styles='width:95%' />
					    </td>
					     <td width="3%" style="border:0" align="right">
                         <gw:imgBtn img="set" id="ibtnSetSalary2"    alt="Set Salary"  onclick="OnSetSalary(2)"/>
                        </td>
					    <td  width="5%" style="border:0" align="right">Month</td>
					  
                        <td style="border:0"> 
					         <gw:datebox id="dtMonth2"  onchange="OnChangeMonth(2)" tyles="width:100%" type="month" lang="<%=Session("Lang")%>" /></td>
                        <td style="border:0;"  colspan=2 align="right" >Confirm Date</td>
                        <td style="border:0;" align="left" >
                         <gw:datebox id="dtConfirmDate2" styles="width:100%" lang="<%=Session("Lang")%>" nullaccept/>
                        </td>
                         <td style="border:0" align="center">
                         <gw:imgBtn img="set" id="ibtnSetConfirmDate2"    alt="Set Confirm Date"  onclick="OnSetConfirmDate(2)"/>
                        </td>
                        <td style="border:0;" colspan=3 align="right" ><gw:label id="lblRecord2"  text="0 rec(s)" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" /></td>
                        <td align="right" style="border:0" valign="bottom"><img status="middle" id="img3" alt="Show more columns" src="../../../system/images/menu.gif" style="cursor:hand" onclick="OnToggle(3)"  /></td>
                        
                    </tr>
                    <tr style="border:1;width:100%;height:80%" valign="top">
                        <td colspan=21  style="width:100%;height:100%;"> 
                             <gw:grid   
                                id="grdSalary2"  
                                header="_EMP_PK|Organization|W-Group|Emp ID|Full Name|Join Date|Contract Type|Level 1|Level 2|Confirm DT|Postion|_Salary Level|Allow1|Allow2|Allow3|Allow4|allow5|Allow6|Allow7|Allow8|_WMON|_close|Salary Type|INS Salary"
                                format="0|0|0|0|0|4|0|-0|-0|4|0|0|-0|-0|-0|-0|-0|-0|-0|-0|0|0|2|-0"  
                                aligns="0|2|2|1|0|1|1|3|3|3|1|1|0|0|0|0|0|0|0|0|0|0|0|0"  
                                defaults="|||||||||||||||||||||||"  
                                editcol="0|0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|0|0|1|1"  
                                widths="0|1500|1600|1000|2500|1200|1700|1200|1200|1200|1200|1500|1500|1700|1700|1500|1500|1500|1500|1500|1500|0|0|1500|1500"  
                                styles="width:100%; height:100%" 
                                sorting="T" acceptNullDate   
                                oncelldblclick="OnClickGrid(2)"
                                onafteredit="OnSelChange_salary(2)"
                                /> 
                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table>
    </gw:tab>
</body>
<gw:textbox id="txtDeptData" styles="display:none"/>
<gw:textbox id="txtUpperDept" styles="display:none"/>
<gw:textbox id="txtGroupData" styles="display:none"/>
<gw:textbox id="dtEndDate" styles="display:none" />
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
<gw:textbox id="txtDept" styles="display:none"/>
<gw:textbox id="txtdept_temp" styles="display:none"/>
<gw:textbox id="txtFlag" styles="display:none"/>
<gw:textbox id="txtresult" styles="display:none"/>
<gw:textbox id="txtMonth_flag" styles="display:none"/>
<gw:textbox id="txtCheck_App" styles="display:none"/>
 <!------------------------------------------------->
<gw:textbox id="idSAL_ALL" styles="display:none"/>  
                      
 <gw:grid   
    id="grdAllowance"  
    header="Code Name 1|Code Name 2|Code Name 3|Code Name 4|Code Name 5|Code Name 6|Code Name 7|Code Name 8|Display 1|Display 2|Display 3|Display 4|Display 5|Display 6|Display 7|Display 7"
    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
    aligns="0|2|2|1|0|0|1|1|2|1|0|0|0|0|0|0"  
    defaults="||||||||||||||"  
    editcol="0|0|0|0|0|1|1|1|1|1|0|0|0|0|0|0"  
    widths="0|1500|1600|1000|2500|1500|1700|1500|1700|1500|1500|1200|1200|1200|1200|1200"  
    styles="display:none" 
    sorting="T"    
/> 
	<gw:grid   
                        id="grdSalary_level"  
                        header="_PK|Group Salary Name|ID|Level|Basic salary|Allow1|Allow2|Allow3|Allow4|allow5|Allow6|Allow7|Allow8|Remark"
                        format="0|0|0|0|1|1|1|1|1|1|1|1|1|0"
                        aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                        defaults="|||||||||||||"
                        editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                        widths="0|2000|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500"
                        styles="display:none" 
                        sorting="T"  
                          
                        />
                         
 <gw:textbox id="txt_PK"  styles="display:none"/>
 <gw:textbox id="menu_id" text="" styles="display:none"  />
<gw:textbox id="txtFlag_View" text="" styles="display:none"  /> 
<gw:textbox id="txt_option"  text='2' styles="display:none"/>                       
                        
</html>
