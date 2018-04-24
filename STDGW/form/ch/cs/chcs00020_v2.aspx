<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var strcodereturn;
var binit=true;
var tab2=false;
var flag2=false;
var startTime,interval_time
var flag_header=true;
var flag_header2=true;
var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);
     iduser_pk.text = "<%=session("USER_PK")%>";
     txtHr_level.text= "<%=session("HR_LEVEL")%>";
   grdSalary.GetGridControl().FrozenCols =5;
   grdSalary2.GetGridControl().FrozenCols =5;
   grdSalary.GetGridControl().ScrollTrack=true;
   grdSalary2.GetGridControl().ScrollTrack=true;
   InitButton(false);
   visible_grdSalary(1,3);
   <%=ESysLib.SetGridColumnComboFormat( "grdSalary" , 6 , "select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm " ) %>; 
   <%=ESysLib.SetGridColumnComboFormat( "grdSalary" , 32 , "select code,CODE_NM from vhr_hr_code where id='HR0040' order by code_nm " ) %>; 
   <%=ESysLib.SetGridColumnComboFormat( "grdSalary2" , 6 , "select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm " ) %>; 
   
   
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

//merge header 
function SetGridHeader(obj)
{
    var stt;
        var fg=obj.GetGridControl(); 
      if(obj==grdSalary)
        {  
            if (flag_header==true)
            {
                fg.rows=fg.rows+1;
                flag_header=false;
            }
        }    
        else if(obj==grdSalary2)
        {
            if (flag_header2==true)
            {
                fg.rows=fg.rows+1;
                flag_header2=false;
            }
        }
        fg.FixedRows = 2;
        fg.FixCols=1;
        fg.MergeCells =5	;// flexMergeFixedOnly	
        stt=1;//num column
        fg.MergeCol(stt) =true	;
        fg.Cell(0, 0, stt, 1, stt)  = "Department";   //fg.Cell(CellPropertySettings,row, from_col, row, to_col)	
        
        stt+=1;
        fg.MergeCol(stt) =true	;
        fg.Cell(0, 0, stt, 1, stt)  = "Team/Section";   
        
        stt+=1;
        fg.MergeCol(stt) =true	;
        fg.Cell(0, 0, stt, 1, stt)  = "Emp ID";   
        
        stt+=1;
        fg.MergeCol(stt) =true	;
        fg.Cell(0, 0, stt, 1, stt)  = "Full Name"; 
        
        stt+=1;
        fg.MergeCol(stt) =true	;
        fg.Cell(0, 0, stt, 1, stt)  = "Join Date";
        
        stt+=1;
        fg.MergeCol(stt) =true	;
        fg.Cell(0, 0, stt, 1, stt)  = "Position";
        
        stt+=1;
        fg.MergeCol(stt) =true	;
        fg.Cell(0, 0, stt, 1, stt)  = "Total L1";
        
        fg.MergeRow(0) =true	;
        stt+=1;
        
        if(obj==grdSalary)
        {
            fg.Cell(0, 0, stt, 0, stt+11)  = "Current Level 1 Salary And Allowance Information";   
            obj.SetCellBgColor(0, stt,0, stt+11, 0x99FF99);
            obj.SetCellBgColor(1, stt,1, stt+11, 0x99FF99);
        }
        else
        {
            fg.Cell(0, 0, stt, 0, stt+11)  = dtMonth2.text+ "- Level 1 Salary And Allowance Information";   
            obj.SetCellBgColor(0, stt,0, stt+11, 0x99FF99);
            obj.SetCellBgColor(1, stt,1, stt+11, 0x99FF99);
        }
            
   
            
        fg.Cell(0, 1, stt, 1, stt) = "Basic";
        
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = "Addition";
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = "Crane";
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = grdAllowance.GetGridData(1,0);
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = grdAllowance.GetGridData(1,1);
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = grdAllowance.GetGridData(1,2);
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = grdAllowance.GetGridData(1,3);
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = grdAllowance.GetGridData(1,4);
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = grdAllowance.GetGridData(1,5);
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = grdAllowance.GetGridData(1,6);
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = grdAllowance.GetGridData(1,7);
        stt+=1;
        fg.MergeCol(stt) =true	;
        fg.Cell(0, 0, stt, 1, stt)  = "Confirm DT";
        stt+=1;
        fg.MergeCol(stt) =true	;
        fg.Cell(0, 0, stt, 1, stt)  = "Total L2";
        stt+=1;
        if(obj==grdSalary)
        {
            fg.Cell(0, 0, stt, 0, stt+11) = " Current Level 2 Salary and allowance information";
            obj.SetCellBgColor(0, stt,0, stt+11, 0xFFCCFF);
            obj.SetCellBgColor(1, stt,1, stt+11, 0xFFCCFF);
        }    
        else
        {
            fg.Cell(0, 0, stt, 0, stt+11) = dtMonth2.text+"- Level 2 Salary And Allowance Information";
            obj.SetCellBgColor(0, stt,0, stt+11, 0xFFCCFF );
            obj.SetCellBgColor(1, stt,1, stt+11, 0xFFCCFF);
        }   
            
        fg.Cell(0, 1, stt, 1, stt) = "Basic";
        
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = "Addition";
        
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = "Crane";
        
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = grdAllowance.GetGridData(1,0);
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = grdAllowance.GetGridData(1,1);
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = grdAllowance.GetGridData(1,2);
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = grdAllowance.GetGridData(1,3);
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = grdAllowance.GetGridData(1,4);
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = grdAllowance.GetGridData(1,5);
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = grdAllowance.GetGridData(1,6);
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = grdAllowance.GetGridData(1,7);
        
        stt+=1;
        fg.MergeCol(stt) =true	;
        fg.Cell(0, 0, stt, 1, stt)  = "Money Kind";
            
        
        obj.SetCellBold(1,0,1,stt,true);
        fg.FontSize=8;
        
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
   if (obj.id=="datAllowance")
   {
        var icol=11; //value of allowance col
        var icol2=24
      
        grdSalary.GetGridControl().ColHidden(icol)=!(Number(grdAllowance.GetGridData(1,8)));
        grdSalary.GetGridControl().ColHidden(icol2)=!(Number(grdAllowance.GetGridData(1,8)));
        
        icol+=1;
        icol2+=1;
        
        grdSalary.GetGridControl().ColHidden(icol)=!(Number(grdAllowance.GetGridData(1,9)));
        grdSalary.GetGridControl().ColHidden(icol2)=!(Number(grdAllowance.GetGridData(1,9)));
        
        icol+=1;
        icol2+=1;
        grdSalary.GetGridControl().ColHidden(icol)=!(Number(grdAllowance.GetGridData(1,10)));
        grdSalary.GetGridControl().ColHidden(icol2)=!(Number(grdAllowance.GetGridData(1,10)));
        
        icol+=1;
        icol2+=1;
        grdSalary.GetGridControl().ColHidden(icol)=!(Number(grdAllowance.GetGridData(1,11)));
        grdSalary.GetGridControl().ColHidden(icol2)=!(Number(grdAllowance.GetGridData(1,11)));
        
        icol+=1;
        icol2+=1;
        grdSalary.GetGridControl().ColHidden(icol)=!(Number(grdAllowance.GetGridData(1,12)));
        grdSalary.GetGridControl().ColHidden(icol2)=!(Number(grdAllowance.GetGridData(1,12)));
        
        icol+=1;
        icol2+=1;
        grdSalary.GetGridControl().ColHidden(icol)=!(Number(grdAllowance.GetGridData(1,13)));
        grdSalary.GetGridControl().ColHidden(icol2)=!(Number(grdAllowance.GetGridData(1,13)));
        
        icol+=1;
        icol2+=1;
        grdSalary.GetGridControl().ColHidden(icol)=!(Number(grdAllowance.GetGridData(1,14)));
        grdSalary.GetGridControl().ColHidden(icol2)=!(Number(grdAllowance.GetGridData(1,14)));
        
        icol+=1;
        icol2+=1;
        grdSalary.GetGridControl().ColHidden(icol)=!(Number(grdAllowance.GetGridData(1,15)));
        grdSalary.GetGridControl().ColHidden(icol2)=!(Number(grdAllowance.GetGridData(1,15)));
        
        SetGridHeader(grdSalary);
        if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
                datUser_info.Call(); 
   }
   else if(obj.id=="datCurrent_Salary")
   {
        lblRecord.text=grdSalary.rows-2 + " record(s)";
        if (grdSalary.rows>1)
        {
            InitButton(true);
            SetGridHeader(grdSalary);
            auto_resize_column(grdSalary,0,grdSalary.GetGridControl().cols-1,0)
        }
        else
        {
            InitButton(false);
        }
        
   }
   else if (obj.id=="datUser_info")
   {
       
            lstOrg.SetDataText(txtdept_temp.text);            
            lstOrg2.SetDataText(txtdept_temp.text);
            txtDept.text=lstOrg.value;
            
       
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
   else if (obj.id=="datMonth_Salary")
   {
        lblRecord2.text=grdSalary2.rows-2 + " rec(s)";
        SetGridHeader(grdSalary2);
        auto_resize_column(grdSalary2,0,grdSalary2.GetGridControl().cols-1,0)
   }
   else if (obj.id=="datSalary_Create_Del")
   {
        if(txtresult.text=='0')
        {
            alert("Finish!\nHoàn thành!")
            clear_Interval(lbldata2);
            datCheck_Month.Call();
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
        	
	        if(rownum == 2)
	            return false;
        	
	        var i;
	        for(i=2; i<rownum; i++)
	        {
	 	        for(j=8; j <= 18; j++)
		        {
		            
			            var ij_num 	= grdSalary.GetGridData(i, j);
			            if (isNaN(ij_num))
			            {
				            alert("Please enter is number at col " + i + " and " + (j-1) );
				            return false;
			            }
			            if (Number(ij_num) < 0)
			            {
				            alert("Please enter is number >= -1 at col " + i + " and " + (j-1) );
				            return false;
			            }
			       
		        }	
	        }
	        for(i=2; i<rownum; i++)
	        {
	 	        for(j=21; j <= 31; j++)
		        {
		            
			            var ij_num 	= grdSalary.GetGridData(i, j);
			            if (isNaN(ij_num))
			            {
				            alert("Please enter is number at col " + i + " and " + (j-1) );
				            return false;
			            }
			            if (Number(ij_num) < 0)
			            {
				            alert("Please enter is number >= -1 at col " + i + " and " + (j-1) );
				            return false;
			            }
			       
		        }	
	        }
	        return true;
	 }   
    else if(n==2)
    {
	        var ctrl 	= grdSalary2.GetGridControl();
	        var rownum 	= ctrl.Rows;
        	
	        if(rownum == 2)
	            return false;
        	
	        var i;
	        for(i=2; i<rownum; i++)
	        {
	 	        for(j=8; j <= 18; j++)
		        {
		            
			            var ij_num 	= grdSalary2.GetGridData(i, j);
			            if (isNaN(ij_num))
			            {
				            alert("Please enter is number at col " + i + " and " + (j-1) );
				            return false;
			            }
			            if (Number(ij_num) < 0)
			            {
				            alert("Please enter is number >= -1 at col " + i + " and " + (j-1) );
				            return false;
			            }
			       
		        }	
	        }
	        for(i=2; i<rownum; i++)
	        {
	 	        for(j=21; j <= 31; j++)
		        {
		            
			            var ij_num 	= grdSalary2.GetGridData(i, j);
			            if (isNaN(ij_num))
			            {
				            alert("Please enter is number at col " + i + " and " + (j-1) );
				            return false;
			            }
			            if (Number(ij_num) < 0)
			            {
				            alert("Please enter is number >= -1 at col " + i + " and " + (j-1) );
				            return false;
			            }
			       
		        }	
	        }
	        return true;
	 }  
}


//----------------------------------------------------
function OnSearch(n)
{
    if(n==1)
        datCurrent_Salary.Call("SELECT");
    else if(n==2)
        datMonth_Salary.Call("SELECT");    
}

//-----------------------------------------------
function OnSave(n)
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
				    grdSalary.SetGridText(row,19,dtConfirmDate.value);
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
				    grdSalary2.SetGridText(row,19,dtConfirmDate2.value);
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
		                case "0":
		                    col=8;
		                    old_tmp=grdSalary.GetGridData(row,col);
		                    break;
		                case "1":
		                    col=9;
		                    old_tmp=grdSalary.GetGridData(row,col);  
		                    break;
		                case "2":
		                    col=10;
		                    old_tmp=grdSalary.GetGridData(row,col);  
		                    break;    
		                case "A1":
		                    col=11; 
		                    old_tmp=grdSalary.GetGridData(row,col);  
		                    break;
		                case "A2":  
		                    col=12;
		                    old_tmp=grdSalary.GetGridData(row,col);  
		                    break;        
		                case "A3":
		                    col=13;
		                    old_tmp=grdSalary.GetGridData(row,col); 
		                    break;  
		                case "A4":
		                    col=14;
		                    old_tmp=grdSalary.GetGridData(row,col); 
		                    break;  
		                case "A5":
		                    col=15;
		                    old_tmp=grdSalary.GetGridData(row,col); 
		                    break;  
		                case "A6":
		                    col=16;
		                    old_tmp=grdSalary.GetGridData(row,col);  
		                    break;  
		                case "A7":
		                    col=17;
		                    old_tmp=grdSalary.GetGridData(row,col);  
		                    break;  
		                case "A8":
		                    col=18;
		                    old_tmp=grdSalary.GetGridData(row,col); 
		                    break;                          
		                }
		           
		            if (old_tmp=="")
		                old_tmp=0;
		            if (lstOperator.value=="+")
		            {
		                new_tmp=Number(old_tmp) + Number(txtNewSalary.text);
		            }
		            else if (lstOperator.value=="=")// operator is "=" 
		                new_tmp=txtNewSalary.text;
		            else //%
		                new_tmp=Number(txtNewSalary.text)*Number(old_tmp)/100 + Number(old_tmp);
		                
		            grdSalary.SetGridText(row,col,new_tmp);
		           
		        }		
	        }
	 }   
	else if(n==2)
    {
            if (isNaN(txtNewSalary_L2.text))
            {
                alert("Please input number!");
                return;   
            }   
            if (Number(txtNewSalary_L2.text)<0)
            {
                alert("Please input number larger than 0!");
                return;   
            }  
            if ((Number(txtNewSalary_L2.text)<=0 || Number(txtNewSalary_L2.text)>100) && lstOperator_L2.value =="%")
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
		            switch(lstTmp_L2.value)
		            {
		                case "0":
		                    col=21;
		                    old_tmp=grdSalary.GetGridData(row,col);
		                    break;
		                case "1":
		                    col=22;
		                    old_tmp=grdSalary.GetGridData(row,col);  
		                    break;
		                case "2":
		                    col=23;
		                    old_tmp=grdSalary.GetGridData(row,col);  
		                    break;    
		                case "A1":
		                    col=24; 
		                    old_tmp=grdSalary.GetGridData(row,col);  
		                    break;
		                case "A2":  
		                    col=25;
		                    old_tmp=grdSalary.GetGridData(row,col);  
		                    break;        
		                case "A3":
		                    col=26;
		                    old_tmp=grdSalary.GetGridData(row,col); 
		                    break;  
		                case "A4":
		                    col=27;
		                    old_tmp=grdSalary.GetGridData(row,col); 
		                    break;  
		                case "A5":
		                    col=28;
		                    old_tmp=grdSalary.GetGridData(row,col); 
		                    break;  
		                case "A6":
		                    col=29;
		                    old_tmp=grdSalary.GetGridData(row,col);  
		                    break;  
		                case "A7":
		                    col=30;
		                    old_tmp=grdSalary.GetGridData(row,col);  
		                    break;  
		                case "A8":
		                    col=31;
		                    old_tmp=grdSalary.GetGridData(row,col); 
		                    break;                          
		                }
		           
		            if (old_tmp=="")
		                old_tmp=0;
		            if (lstOperator.value=="+")
		            {
		                new_tmp=Number(old_tmp) + Number(txtNewSalary_L2.text);
		            }
		            else if (lstOperator.value=="=")// operator is "=" 
		                new_tmp=txtNewSalary_L2.text;
		            else //%
		                new_tmp=Number(txtNewSalary_L2.text)*Number(old_tmp)/100 + Number(old_tmp);
		                
		            grdSalary.SetGridText(row,col,new_tmp);
		           
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
                var pos_code=grdSalary.GetGridData(event.row,event.col);
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
           var icol=11; //value of allowance col
            var icol2=24
          
            grdSalary2.GetGridControl().ColHidden(icol)=!(Number(grdAllowance.GetGridData(1,8)));
            grdSalary2.GetGridControl().ColHidden(icol2)=!(Number(grdAllowance.GetGridData(1,8)));
            
            icol+=1;
            icol2+=1;
            
            grdSalary2.GetGridControl().ColHidden(icol)=!(Number(grdAllowance.GetGridData(1,9)));
            grdSalary2.GetGridControl().ColHidden(icol2)=!(Number(grdAllowance.GetGridData(1,9)));
            
            icol+=1;
            icol2+=1;
            grdSalary2.GetGridControl().ColHidden(icol)=!(Number(grdAllowance.GetGridData(1,10)));
            grdSalary2.GetGridControl().ColHidden(icol2)=!(Number(grdAllowance.GetGridData(1,10)));
            
            icol+=1;
            icol2+=1;
            grdSalary2.GetGridControl().ColHidden(icol)=!(Number(grdAllowance.GetGridData(1,11)));
            grdSalary2.GetGridControl().ColHidden(icol2)=!(Number(grdAllowance.GetGridData(1,11)));
            
            icol+=1;
            icol2+=1;
            grdSalary2.GetGridControl().ColHidden(icol)=!(Number(grdAllowance.GetGridData(1,12)));
            grdSalary2.GetGridControl().ColHidden(icol2)=!(Number(grdAllowance.GetGridData(1,12)));
            
            icol+=1;
            icol2+=1;
            grdSalary2.GetGridControl().ColHidden(icol)=!(Number(grdAllowance.GetGridData(1,13)));
            grdSalary2.GetGridControl().ColHidden(icol2)=!(Number(grdAllowance.GetGridData(1,13)));
            
            icol+=1;
            icol2+=1;
            grdSalary2.GetGridControl().ColHidden(icol)=!(Number(grdAllowance.GetGridData(1,14)));
            grdSalary2.GetGridControl().ColHidden(icol2)=!(Number(grdAllowance.GetGridData(1,14)));
            
            icol+=1;
            icol2+=1;
            grdSalary2.GetGridControl().ColHidden(icol)=!(Number(grdAllowance.GetGridData(1,15)));
            grdSalary2.GetGridControl().ColHidden(icol2)=!(Number(grdAllowance.GetGridData(1,15)));
            
            SetGridHeader(grdSalary2);
            
            
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
               // grdSalary.GetGridControl().ColHidden(7)=0;
                break;
            case 2://large
                //alert(2)
                grdSalary.GetGridControl().ColHidden(2)=0;
                grdSalary.GetGridControl().ColHidden(5)=0;
             //   grdSalary.GetGridControl().ColHidden(7)=0;
                break;
            case 3://hide all
                //alert(3)
                grdSalary.GetGridControl().ColHidden(1)=1;
                grdSalary.GetGridControl().ColHidden(2)=1;
                grdSalary.GetGridControl().ColHidden(5)=1;
                grdSalary.GetGridControl().ColHidden(6)=1;
               // grdSalary.GetGridControl().ColHidden(7)=1;
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
     datCheck_Month.Call();
    var txt;
    if(flag=="DEL")
        txt="Do you want to delete?\nBạn muốn xóa?";
    else txt="Do you want to create?\n Bạn muốn tạo mới";
    if(confirm(txt))
    {
        if(txtMonth_flag.text=="Y")//thang nay da hoac dang tinh luong
        {
            if(Trim(idEmp_id_M.text)=="")
            {
                alert("This month existed, you only can do if you choose emp id.\nTháng này đã tồn tại dữ liệu, bạn chỉ có thể thực hiện cho từng emp id.")
                return;
            }    
        }
        else
        {      
            if(confirm("Are you sure?\nBạn đã chắc chắn?"))
                {
                    set_Interval(100);
                    txtFlag.text=flag
                    datSalary_Create_Del.Call();
                } 
        }
    }
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
function OnReport(obj)
{
   if(obj==1) //tab thu nhat
        var url =System.RootURL + '/reports/ch/cs/rpt_salary_v2.aspx?org='+lstOrg.value+'&org_type='+lstOrg_type.value
        +'&pos='+lstPosition.value+'&lsttmp='+lstTemp.value+'&txttmp='+txtTemp.text+'&contract='+lstContract_Type.value
        +'&status='+lstStatus.value+'&fromjoin='+dtFrom_JoinDate.value+'&tojoin='+dtTo_JoinDate.value
        +'&lstmoney='+lstMoney.value+'&lstmon_year='+lstMon_Year.value+'&from_mon_year='+txtFrom_Mon_Year.text
        +'&to_mon_year='+txtTo_Mon_Year.text+'&lstSal_L1='+lstTmp.value+'&fromsal_L1='+txtFromSalary.text+'&tosal_L1='+txtToSalary.text
        +'&lstSal_L2='+lstTmp_L2.value+'&fromsal_L2='+txtFromSalary_L2.text+'&tosal_L2='+txtToSalary_L2.text;
   window.open(url);
}
</script>
<body >
<!-------------------data control----------------------->
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

<!------------------------------------------------------>
<gw:data id="datAllowance" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="hr_sel_10030002_allow_sal" > 
                <input bind="grdAllowance" >
                </input>
                <output  bind="grdAllowance" />
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------>
<gw:data id="datCheck_Month" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10030002_check_mon_v2" > 
                <input >
                    <input bind="dtMonth_close" /> 
                </input>
                <output >
                    <output bind="lbldata2" /> 
                    <output bind="lblstatus2" /> 
                    <output bind="txtMonth_flag" /> 
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>
<gw:data id="datCurrent_Salary" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,6,8,9,10,11,12,13,14,15,16,17,18,19,21,22,23,24,25,26,27,28,29,30,31,32" function="hr_sel_10030002_current_sal_v2" procedure="hr_upd_10030002_current_sal_v2"> 
                <input bind="grdSalary" >
                   <input bind="lstOrg" /> 
                   <input bind="lstOrg_type" /> 
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
                   <input bind="txtFromSalary" /> 
                   <input bind="txtToSalary" /> 
                   <input bind="dtConfirmDate" />
                   <input bind="lstMoney" />
                   <input bind="lstTmp" />
                   <input bind="txtFromSalary_L2" /> 
                   <input bind="txtToSalary_L2" />
                   <input bind="lstTmp_L2" /> 
                </input>
                <output  bind="grdSalary" />
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>
<gw:data id="datMonth_Salary" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,6,8,9,10,11,12,13,14,15,16,17,18,19,21,22,23,24,25,26,27,28,29,30,31,32" function="hr_sel_10030002_mon_sal_v2" procedure="hr_upd_10030002_mon_sal_v2"> 
                <input bind="grdSalary2" >
                   <input bind="lstOrg2" /> 
                   <input bind="lstOrg_type2" /> 
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
                   <input bind="txtFromSalary2" /> 
                   <input bind="txtToSalary2" /> 
                   <input bind="dtConfirmDate2" />
                   <input bind="dtMonth2" />
                   <input bind="lstTmp2" />
                   <input bind="lstMoney2" />
                </input>
                <output  bind="grdSalary2" />
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------>
<gw:data id="datSalary_Create_Del" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10030002_cre_del_sal_V2" > 
                <input >
                    <input bind="txtFlag" /> 
                    <input bind="dtMonth_close" />
                    <input bind="idEmp_id_M" />  
                </input>
                <output >
                    <output bind="txtresult" /> 
                </output>
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
                        <td colspan=5 width="10%" align="right" style="border:0;"><a title="Click here to show organization" onclick="OnShowPopup(1)" href="#tips" >Organization</a>                  
                        </td>
                        <td colspan=10 width="20%"  align="left" style="border:0;">
                         <gw:list  id="lstOrg" value='ALL' styles='width:100%' onchange="" >
                            <data>
                                <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td colspan=5 width="10%" align="right" style="border:0;" >Org Type</td>
                        <td colspan=6 width="12%"  align="left" style="border:0;" >
                            <gw:list  id="lstOrg_type" value='ALL' maxlen = "100" styles="width:100%" >
                                <data><%= ESysLib.SetListDataFUNC("SELECT F_COMMONCODE('COEO0030','','') FROM DUAL")%>|ALL|Select All</data></gw:list>
                        </td>
                         <td colspan=3 width="6%" align="right" style="border:0;" >Position</td>
                        <td colspan=5 width="10%"  align="left" style="border:0;">
                             <gw:list  id="lstPosition" value='ALL' styles='width:100%' >
                               <data>
                                    <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code")%>|ALL|Select All
                                </data></gw:list>
                        </td>
                       
                        <td colspan=5 width="10%"  align="right" valign="middle" style="border:0;">Search by</td>
					    <td  colspan=4 width="8%" style="border:0;">
					        <gw:list  id="lstTemp" value="2" styles='width:100%' onchange=""> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID</data> 
					        </gw:list>
				        </td>
                        <td colspan=4 width="8%" align=center style="border:0"> 
					        <gw:textbox id="txtTemp" onenterkey   ="OnSearch(1)" styles='width:100%'/>
				        </td>
                        <td width="2%" style="border:0;" align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch(1)"/>
                        </td>
                        <td width="2%" style="border:0" align="right">
                            <gw:imgBtn img="save" id="ibtnSave"    alt="Save"  onclick="OnSave(1)"/>
                        </td>
                        <td width="2%" style="border:0" align="right">
                         <gw:imgBtn img="excel" id="ibtnReport"    alt="Report"  onclick="OnReport(1)"/>
                        </td>
                     </tr>
                     <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td colspan=5 style="border:0;" align="left" > <gw:list  id="lstMon_Year" value='MON' maxlen = "100" styles='width:95%'>
                            <data>|MON|Months|YEAR|Years</data>     </gw:list>
                        </td>
                        <td  colspan=2 style="border:0;" align="left" ><gw:textbox id="txtFrom_Mon_Year"  styles='width:100%'/>
                        </td>
                         <td width="2%" style="border:0;" align="center" ><b>~</b></td>
                         <td colspan=2 style="border:0;" align="left" ><gw:textbox id="txtTo_Mon_Year"  styles='width:100%'/>
                        </td>
                        <td colspan=5 style="border:0;" align="right" >Contract Type</td>
                        <td colspan=5 style="border:0;" align="left">
                            <gw:list  id="lstContract_Type" value='ALL' maxlen = "100" styles='width:100%' >
                                <data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0001' order by code")%>|ALL|Select All</data></gw:list>
                        </td>
                        <td  colspan=2 style="border:0" align="right">Status</td>
                        <td colspan=4 style="border:0"> 
					        <gw:list  id="lstStatus" value='A' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0022' order by code" )%>|ALL|Select All</data></gw:list>
                        </td>
                        <td colspan=3 style="border:0;" align="right" >Join Date</td>
                        <td colspan=5 style="border:0;" align="left" >
                            <gw:datebox id="dtFrom_JoinDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" />
                        </td>
                        <td width="2%" style="border:0;" align="center" ><b>~</b></td>
                        <td colspan=5 align="left" style="border:0;">
                            <gw:datebox id="dtTo_JoinDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" />
                        </td>
                        <td colspan=5 align="right" style="border:0;" >Money Kind</td>
                        <td colspan=6 align="right" style="border:0;"><gw:list  id="lstMoney" value='01' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0040' order by code" )%>|ALL|Select All</data></gw:list></td>
                     </tr>
                     <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td  colspan=5 style="border:0;" align="center" >Set Salary L1</td>
                        <td colspan=8 style="border:0;" align="right" ><gw:list  id="lstTmp" value='A0' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("SELECT '0','Basic' from dual union SELECT '1','Addition' from dual union SELECT '2','Crane' from dual union SELECT A.CODE,A.CODE_NM FROM VHR_HR_CODE A WHERE A.ID='HR0019' AND A.NUM_2=1" )%></data></gw:list>
                        </td>
                        <td colspan=4 style="border:0;"  align="left"><gw:textbox text=""  id="txtFromSalary"  styles='width:100%'/></td>
                        <td  width="2%" style="border:0;" align="center" > <b>~</b></td>
                        <td colspan=4 style="border:0;" align="left"> <gw:textbox text="" id="txtToSalary"  styles='width:95%'/>
                        </td>
                        <td colspan=2 style="border:0;" align="left">
                            <gw:list  id="lstOperator" value='=' maxlen = "100" styles='width:100%' >
                                <data>|+|+|=|=|%|%</data></gw:list>
                        </td>
                        <td  colspan=4 style="border:0" align="right"><gw:textbox text="" onkeypress="return Numbers(event)" type="number" format="#,###,###,###.##R" id="txtNewSalary"  styles='width:95%' />
					    </td>
					    <td colspan=2 style="border:0" align="right">
                            <gw:imgBtn img="set" id="ibtnSetSalary"    alt="Set Salary L1"  onclick="OnSetSalary(1)"/>
                        </td>
                         <td  colspan=4 style="border:0" align="right">Confirm Dt</td>
                        <td colspan=5 style="border:0"><gw:datebox id="dtConfirmDate"  styles="width:100%" lang="<%=Session("Lang")%>" nullaccept/></td>
                        <td width="2%" style="border:0;" align="left" ><gw:imgBtn img="set" id="ibtnSetConfirmDate"    alt="Set Confirm Date"  onclick="OnSetConfirmDate(1)"/></td>
                        <td colspan=8 style="border:0;" align="center" ></td>
                        <td width="2%" align="right" style="border:0" valign="bottom"></td>
                    </tr>
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td  colspan=5 style="border:0;" align="center" >Set Salary L2</td>
                        <td colspan=8 style="border:0;" align="right" ><gw:list  id="lstTmp_L2" value='A0' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("SELECT '0','Basic' from dual union SELECT '1','Addition' from dual union SELECT '2','Crane' from dual union SELECT A.CODE,A.CODE_NM FROM VHR_HR_CODE A WHERE A.ID='HR0019' AND A.NUM_2=1" )%></data></gw:list>
                        </td>
                        <td colspan=4 style="border:0;"  align="left"><gw:textbox text=""  id="txtFromSalary_L2"  styles='width:100%'/></td>
                        <td  width="2%" style="border:0;" align="center" > <b>~</b></td>
                        <td colspan=4 style="border:0;" align="left"> <gw:textbox text="" id="txtToSalary_L2"  styles='width:95%'/>
                        </td>
                        <td colspan=2 style="border:0;" align="left">
                            <gw:list  id="lstOperator_L2" value='=' maxlen = "100" styles='width:100%' >
                                <data>|+|+|=|=|%|%</data></gw:list>
                        </td>
                        <td  colspan=4 style="border:0" align="right"><gw:textbox text=""  onkeypress="return Numbers(event)" type="number" format="#,###,###,###.##R" id="txtNewSalary_L2"  styles='width:95%' />
					    </td>
					    <td colspan=2 style="border:0" align="right">
                            <gw:imgBtn img="set" id="ibtnSetSalary_L2"    alt="Set Salary L2"  onclick="OnSetSalary(2)"/>
                        </td>
                         <td  colspan=4 style="border:0" align="right"></td>
                        <td colspan=5 style="border:0"></td>
                        <td width="2%" style="border:0;" align="left" ></td>
                        <td colspan=9 style="border:0;" align="center" ><gw:label id="lblRecord"  text="0 record(s)" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" /></td>
                        <td width="2%" align="right" style="border:0" valign="bottom"><img status="middle" id="img1" alt="Show more columns" src="../../../system/images/menu.gif" style="cursor:hand" onclick="OnToggle(1)"  /></td>
                    </tr>
                    
                    <tr style="border:1;width:100%;height:80%" valign="top">
                        <td colspan=50  style="width:100%;height:100%;"> 
                             <gw:grid   
                                id="grdSalary"  
                                header="_EMP_PK|Department|Team/Section|Emp ID|Full Name|Join Date|Postion|_Total L1|Basic|_Addition|_Crane|Allow1|Allow2|Allow3|Allow4|allow5|Allow6|Allow7|Allow8|Confirm DT|_Total L2|Basic|_Addition|_Crane|Allow1|Allow2|Allow3|Allow4|allow5|Allow6|Allow7|Allow8|Money Kind"
                                format="0|0|0|0|0|4|0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|4|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|0"  
                                aligns="0|2|2|1|0|1|1|3|3|3|3|1|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
                                defaults="||||||||||||||||||||||||||||||"  
                                editcol="0|0|0|0|0|0|1|0|1|1|1|1|1|1|1|1|1|1|1|1|0|1|1|1|1|1|1|1|1|1|1"  
                                widths="0|1500|1600|1000|2500|1200|1700|1200|1200|1200|1200|1200|1500|1700|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500"  
                                styles="width:100%; height:100%" 
                                sorting="T" acceptNullDate   
                                oncelldblclick="OnClickGrid(1)"
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
                        <td width="1%" style="border:0;" align="right" ></td>
                        <td width="9%" style="border:0;" align="right" >Month</td>
                        <td width="12%" colspan=4 style="border:0;" align="left" ><gw:datebox id="dtMonth_close"  onchange="OnChangeMonth(1)" tyles="width:100%" type="month" lang="<%=Session("Lang")%>" /></td>
                        <td width="10%" style="border:0;" align="right" >Data</td>
                        <td width="13%" style="border:0;" align="center" colspan=2 ><gw:label id="lbldata2"  text="status 1" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" /></td>
                         <td width="10%" colspan=2 style="border:0;" align="right" >Status</td>
                        <td width="10%" style="border:0;" align="center" ><gw:label id="lblstatus2"  text="status 2" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" /></td>
                        <td  style="border:0"  width="9%"  align="right" valign="middle"></td>
					    <td align=right style="border:0" width="10%" ><a title="Click here to choose" onclick="OnShowPopup(2)" href="#tips" >Emp ID</a></td>
                        <td width="7%" align=center style="border:0" colspan=2><gw:textbox id="idEmp_id_M" styles="width:95%" /></td>
                        <td width="3%" style="border:0;" align="right" ></td>
                        <td width="3%" style="border:0" align="right"><gw:imgBtn img="process" id="ibtnProcess2" alt="Create Salary" onclick="OnSalary_New_Del('NEW')"/></td>
                        <td width="3%" style="border:0" align="right"><gw:imgBtn img="delete" id="ibtnCancel2"    alt="Delete Month Salary"  onclick="OnSalary_New_Del('DEL')"/></td>
                    </tr>
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td width="1%" style="border:0;" align="right" ><img status="show" id="img2" alt="Show month salary information" src="../../../system/images/iconmaximize.gif" style="cursor:hand" onclick="OnToggle(2)"  /></td>
                        <td width="9%" style="border:0;" align="right" ><a title="Click here to show organization" onclick="OnShowPopup(3)" href="#tips" >Organization</a>                  
                        </td>
                        <td width="12%" colspan=4 style="border:0;" align="left" >
                         <gw:list  id="lstOrg2" value='ALL' maxlen = "100" styles='width:100%'onchange="" >
                            <data>
                                <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td width="10%" style="border:0;" align="right" >Org Type</td>
                        <td width="13%" style="border:0;" align="left" colspan=2 >
                         <gw:list  id="lstOrg_type2" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%= ESysLib.SetListDataFUNC("SELECT F_COMMONCODE('COEO0030','','') FROM DUAL")%>|ALL|Select All</data></gw:list>
                        </td>
                         <td width="10%" colspan=2 style="border:0;" align="right" >Position</td>
                        <td width="10%" style="border:0;" align="left" >
                         <gw:list  id="lstPosition2" value='ALL' maxlen = "100" styles='width:100%' >
                           <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code")%>|ALL|Select All
                            </data></gw:list>
                        </td>
                        
                        <td  style="border:0"  width="9%"  align="right" valign="middle">Search by</td>
					    <td  style="border:0" width="10%" >
					        <gw:list  id="lstTemp2" value="2" styles='width:100%' onchange=""> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID</data> 
					        </gw:list>
				        </td>
                        <td width="7%" align=center style="border:0" colspan=2> 
					        <gw:textbox id="txtTemp2" onenterkey   ="OnSearch(2)" styles='width:95%'/>
				        </td>
				         
                        <td width="3%" style="border:0;" align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch2"   alt="Search"  onclick="OnSearch(2)"/>
                        </td>
                        <td width="3%" style="border:0" align="right">
                         <gw:imgBtn img="save" id="ibtnSave2"    alt="Save"  onclick="OnSave(2)"/>
                        </td>
                        <td width="3%" style="border:0" align="right"></td>
                        
                    </tr>
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td width="1%" style="border:0;" align="right" ></td>
                        <td style="border:0;" align="right" > <gw:list  id="lstMon_Year2" value='MON' maxlen = "100" styles='width:100%'>
                            <data>|MON|Months|YEAR|Years</data>     </gw:list>
                        </td>
                        <td  style="border:0;" width="5%" align="left" ><gw:textbox id="txtFrom_Mon_Year2"  styles='width:100%'/>
                        </td>
                         <td style="border:0;" width="1%" align="center" ><b>~</b>
                        </td>
                         <td style="border:0;" width="5%" colspan=2 align="left" ><gw:textbox id="txtTo_Mon_Year2"  styles='width:100%'/>
                        </td>
                        <td style="border:0;" align="right" >Contract Type</td>
                        <td style="border:0;" align="left" colspan=2>
                         <gw:list  id="lstContract_Type2" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0001' order by code")%>|ALL|Select All</data></gw:list>
                        </td>
                        <td  style="border:0" colspan=2  align="right">Status</td>
                        <td style="border:0"> 
					        <gw:list  id="lstStatus2" value='A' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0022' order by code")%>|ALL|Select All</data></gw:list>
                        </td>
                         <td style="border:0;" align="right" >Join Date</td>
                        <td style="border:0;" align="left" >
                         <gw:datebox id="dtFrom_JoinDate2" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" />
                        </td>
                        <td style="border:0;" width="2%" align="center" ><b>~</b></td>
                        <td colspan=4 style="border:0;"  align="left" >
                         <gw:datebox id="dtTo_JoinDate2" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" />
                        </td>
                       
                    </tr>
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td width="1%" style="border:0;" align="right" >L2</td>
                         
                        <td width="10%" style="border:0;" align="right" ><gw:list  id="lstTmp2" value='0' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("SELECT '0','Total Basic' from dual union SELECT '1','Basic' from dual union SELECT '2','Addition' from dual union SELECT '3','Crane' from dual union SELECT A.CODE,A.CODE_NM FROM VHR_HR_CODE A WHERE A.ID='HR0019' AND A.NUM_2=1")%></data></gw:list></td>
                        <td colspan=3 style="border:0;" width="9%" align="left"><gw:textbox text=""  id="txtFromSalary2"  styles='width:100%'/></td>
                        <td style="border:0;" align="center" width="2%" > <b>~</b>       
                        </td>
                        <td width="5%" style="border:0;" align="left"> <gw:textbox text="" id="txtToSalary2"  styles='width:95%'/>
                        </td>
                       
					    <td  width="7%" style="border:0" align="right">Month</td>
					    <td style="border:0"> 
					         <gw:datebox id="dtMonth2"  onchange="OnChangeMonth(2)" tyles="width:100%" type="month" lang="<%=Session("Lang")%>" /></td>
                        <td colspan=2 style="border:0;" align="right" >Confirm Date</td>
                        <td style="border:0;" align="left" >
                         <gw:datebox id="dtConfirmDate2" styles="width:100%" lang="<%=Session("Lang")%>" nullaccept/>
                        </td>
                         <td style="border:0" align="left">
                         <gw:imgBtn img="set" id="ibtnSetConfirmDate2"    alt="Set Confirm Date"  onclick="OnSetConfirmDate(2)"/>
                        </td>
                        <td align="right" style="border:0;"><gw:list  id="lstMoney2" value='01' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0040' order by code" )%>|ALL|Select All</data></gw:list></td>
                        <td style="border:0;" colspan=3 align="right" ><gw:label id="lblRecord2"  text="0 rec(s)" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" /></td>
                        <td align="right" style="border:0" valign="bottom"><img status="middle" id="img3" alt="Show more columns" src="../../../system/images/menu.gif" style="cursor:hand" onclick="OnToggle(3)"  /></td>
                        
                    </tr>
                    <tr style="border:1;width:100%;height:80%" valign="top">
                        <td colspan=20  style="width:100%;height:100%;"> 
                            <gw:grid   
                                id="grdSalary2"  
                                header="_EMP_PK|Organization|Group|Emp ID|Full Name|Join Date|Postion|_Total L1|Basic|_Addition|_Crane|Allow1|Allow2|Allow3|Allow4|allow5|Allow6|Allow7|Allow8|Confirm DT|_Total L2|Basic|_Addition|_Crane|Allow1|Allow2|Allow3|Allow4|allow5|Allow6|Allow7|Allow8|_w_mon"
                                format="0|0|0|0|0|4|0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|4|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|0"  
                                aligns="0|2|2|1|0|1|1|3|3|3|3|1|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
                                defaults="||||||||||||||||||||||||||||||"  
                                editcol="0|0|0|0|0|0|1|0|1|1|1|1|1|1|1|1|1|1|1|1|0|1|1|1|1|1|1|1|1|1|1"  
                                widths="0|1500|1600|1000|2500|1200|1700|1200|1200|1200|1200|1200|1500|1700|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500"  
                                styles="width:100%; height:100%" 
                                sorting="T" acceptNullDate   
                                oncelldblclick="OnClickGrid(2)"
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
</html>
