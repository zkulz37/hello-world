<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var flag;
var strcodereturn;
var binit=true;
var tab2=false;
var flag2=false;
var startTime,interval_time
var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);
     iduser_pk.text = "<%=session("USER_PK")%>";
     txtHr_level.text= "<%=session("HR_LEVEL")%>";
  
   grdSalary.GetGridControl().FrozenCols =5;
 
   grdSalary.GetGridControl().ScrollTrack=true;
   
   visible_grdSalary(3);
    
   
   OnClick(1);
   //<!--EMP_PK 0|Organization 1|W-Group 2|Emp ID 3|Full Name 4|Join Date 5|Postion 6|Level 1 7|Level 2 8|Confirm DT 9|Allow1 10|Allow2 11|Allow3 12|Allow4 13|allow5 14|Allow6 15|Allow7 16|Allow8 17|_WMON 18|E 19|E2 20|E3 21|E4 22|E5 23|E6 24|E7 25|E8 26|E9 27|E10 28|Total Increase 29|New Salary 30|Allow1 31|Allow2 32|Allow3 33|Allow4 34|allow5 35|Allow6 36|Allow7 37|Allow8 38|Conform DT 39|Salary Type 40|Employee Type 41|Change Date 42|Remark 43|Action 44|_check 45" function="HR.sp_sel_increase_salary" procedure="hr.SP_upd_month_salary-->
   var data = "<%=ESysLib.SetGridColumnDataSQL(" select code,code_nm from vhr_hr_code where id='HR0056' order by code_nm " ) %> ";       
    grdSalary.SetComboFormat(40,data);   
    data = "<%=ESysLib.SetGridColumnDataSQL(" select code,code_nm from vhr_hr_code where id='HR0017' order by code_nm " ) %> ";       
    grdSalary.SetComboFormat(41,data);   
    data = "<%=ESysLib.SetGridColumnDataSQL(" select '01','Update' from dual union select '02','Increase' from dual union select '03','No Action' from dual " ) %> ";       
    grdSalary.SetComboFormat(44,data);  
    
     if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
              datUser_info.Call();  
     else
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
   
        
    
}
//------------------------------------
function OnChangeMonth(n)
{
    if(n==1)
        datCheck_Month.Call();
    else if(n==2)
    {
        grdSalary.ClearData();
        dtMonthTo_close.value=dtMonthTo.value;
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
                    var icol=10; //value of old salary
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
       
       
       //-----
        var icol=31; //value new allow
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
       
        
        datInc.Call()
        }
      else if (obj.id=="datInc")
   {
      
       
           var icol=19; // element increase
        grdSalary.SetGridText(0,icol,grdIncrease.GetGridData(1,0));
        grdSalary.SetGridText(0,icol+1,grdIncrease.GetGridData(1,1));
        grdSalary.SetGridText(0,icol+2,grdIncrease.GetGridData(1,2));
        grdSalary.SetGridText(0,icol+3,grdIncrease.GetGridData(1,3));
        grdSalary.SetGridText(0,icol+4,grdIncrease.GetGridData(1,4));
        grdSalary.SetGridText(0,icol+5,grdIncrease.GetGridData(1,5));
        grdSalary.SetGridText(0,icol+6,grdIncrease.GetGridData(1,6));
        grdSalary.SetGridText(0,icol+7,grdIncrease.GetGridData(1,7));
        grdSalary.SetGridText(0,icol+8,grdIncrease.GetGridData(1,8));
        grdSalary.SetGridText(0,icol+9,grdIncrease.GetGridData(1,9));
        
        grdSalary.GetGridControl().ColHidden(icol)=!(Number(grdIncrease.GetGridData(1,10)));
        grdSalary.GetGridControl().ColHidden(icol+1)=!(Number(grdIncrease.GetGridData(1,11)));
        grdSalary.GetGridControl().ColHidden(icol+2)=!(Number(grdIncrease.GetGridData(1,12)));
        grdSalary.GetGridControl().ColHidden(icol+3)=!(Number(grdIncrease.GetGridData(1,13)));
        grdSalary.GetGridControl().ColHidden(icol+4)=!(Number(grdIncrease.GetGridData(1,14)));
        grdSalary.GetGridControl().ColHidden(icol+5)=!(Number(grdIncrease.GetGridData(1,15)));
        grdSalary.GetGridControl().ColHidden(icol+6)=!(Number(grdIncrease.GetGridData(1,16)));
        grdSalary.GetGridControl().ColHidden(icol+7)=!(Number(grdIncrease.GetGridData(1,17)));
        grdSalary.GetGridControl().ColHidden(icol+8)=!(Number(grdIncrease.GetGridData(1,18)));
        grdSalary.GetGridControl().ColHidden(icol+9)=!(Number(grdIncrease.GetGridData(1,19)));
              
       
         icol=2; //value of allowance col
        grdSalary2.SetGridText(0,icol,grdIncrease.GetGridData(1,0));
        grdSalary2.SetGridText(0,icol+1,grdIncrease.GetGridData(1,1));
        grdSalary2.SetGridText(0,icol+2,grdIncrease.GetGridData(1,2));
        grdSalary2.SetGridText(0,icol+3,grdIncrease.GetGridData(1,3));
        grdSalary2.SetGridText(0,icol+4,grdIncrease.GetGridData(1,4));
        grdSalary2.SetGridText(0,icol+5,grdIncrease.GetGridData(1,5));
        grdSalary2.SetGridText(0,icol+6,grdIncrease.GetGridData(1,6));
        grdSalary2.SetGridText(0,icol+7,grdIncrease.GetGridData(1,7));
        grdSalary2.SetGridText(0,icol+8,grdIncrease.GetGridData(1,8));
        grdSalary2.SetGridText(0,icol+9,grdIncrease.GetGridData(1,9));
        
        grdSalary2.GetGridControl().ColHidden(icol)=!(Number(grdIncrease.GetGridData(1,10)));
        grdSalary2.GetGridControl().ColHidden(icol+1)=!(Number(grdIncrease.GetGridData(1,11)));
        grdSalary2.GetGridControl().ColHidden(icol+2)=!(Number(grdIncrease.GetGridData(1,12)));
        grdSalary2.GetGridControl().ColHidden(icol+3)=!(Number(grdIncrease.GetGridData(1,13)));
        grdSalary2.GetGridControl().ColHidden(icol+4)=!(Number(grdIncrease.GetGridData(1,14)));
        grdSalary2.GetGridControl().ColHidden(icol+5)=!(Number(grdIncrease.GetGridData(1,15)));
        grdSalary2.GetGridControl().ColHidden(icol+6)=!(Number(grdIncrease.GetGridData(1,16)));
        grdSalary2.GetGridControl().ColHidden(icol+7)=!(Number(grdIncrease.GetGridData(1,17)));
        grdSalary2.GetGridControl().ColHidden(icol+8)=!(Number(grdIncrease.GetGridData(1,18)));
        grdSalary2.GetGridControl().ColHidden(icol+9)=!(Number(grdIncrease.GetGridData(1,19)));
       
        visible_grdSalary(3);
        
        }   
   else if (obj.id=="datUser_info")
   {
       
            lstOrg.SetDataText(txtdept_temp.text);            
            lstOrg2.SetDataText(txtdept_temp.text);
            datAllowance.Call("SELECT");
       
   }
   else if (obj.id=="datGet_Location_dept")
   {
        if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
            datUser_info.Call(); 
   }
   else if (obj.id=="daIncrease")
   {
        lblRecord2.text=grdSalary.rows-1 + " record(s)";
          SetGridColor();          
        
   }
    else if (obj.id=="dataSeq")
    {
    OnLoadExcel();
    }
   else if (obj.id=="datImport")
   { lblRecord2.text=grdSalary2.rows-1 + " record(s)";
     ibtnSave2.SetEnable(false);
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
    if(n==2)
    {
	        var ctrl 	= grdSalary.GetGridControl();
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
}


//----------------------------------------------------
function OnSearch(n)
{
    
        daIncrease.Call("SELECT");    
}

//-----------------------------------------------
function OnSave(n)
{
      
        if (confirm("Do you want to save? \n Bạn có muốn lưu không?"))
        {   if(Radio1.checked==true)    
                 daIncrease.Call();
            else
                  datImport.Call();
        }
       
}



//----------------------------------------------------
function OnSetSalary(n)
{
        if(n=='1')
    
          {  if (isNaN(xtxValue.text))
            {
                alert("Please input number!");
                return;   
            }   
            if (Number(xtxValue.text)<0)
            {
                alert("Please input number larger than 0!");
                return;   
            }  
          
            var ctrl = grdSalary.GetGridControl();
	        for ( var i =  0 ; i < ctrl.SelectedRows ; i++ )
	        {
		        var row = ctrl.SelectedRow(i);
		//<!--EMP_PK 0|Organization 1|W-Group 2|Emp ID 3|Full Name 4|Join Date 5|Postion 6|Level 1 7|Level 2 8|Confirm DT 9|Allow1 10|Allow2 11|Allow3 12|Allow4 13|allow5 14|Allow6 15|Allow7 16|Allow8 17|_WMON 18|E 19|E2 20|E3 21|E4 22|E5 23|E6 24|E7 25|E8 26|E9 27|E10 28|Total Increase 29|New Salary 30|Allow1 31|Allow2 32|Allow3 33|Allow4 34|allow5 35|Allow6 36|Allow7 37|Allow8 38|Conform DT 39|Salary Type 40|Employee Type 41|Change Date 42|Remark 43|Action 44|_check 45" function="HR.sp_sel_increase_salary" procedure="hr.SP_upd_month_salary-->
		        if ( row > 0 )
		        {	
		            var old_tmp,new_tmp,col;	
		            switch(lstTmp.value)
		            {
		                case "A0":
		                    col=30;
		                    break;
		                case "A1":
		                    col=31; 
		                    break;
		                case "A2":
		                   col=32; 
		                    break;    
		                case "A3":
		                   col=33;  
		                    break;  
		                case "A4":
		                   col=34;  
		                    break;  
		                case "A5":
		                   col=35;  
		                    break;  
		                case "A6":
		                    col=36; 
		                    break;  
		                case "A7":
		                   col=37; 
		                    break;  
		                case "A8":
		                    col=38;  
		                    break;  
		                 case "01":
		                    col=19;  
		                    break;
		                 case "02":
		                    col=20;  
		                    break;
		                 case "03":
		                    col=21;  
		                    break;
		                 case "04":
		                    col=22;  
		                    break;                              
		                 case "05":
		                    col=23;  
		                    break;                             
		                 case "06":
		                    col=24;  
		                    break;                              
		                 case "07":
		                    col=25;  
		                    break;                              
		                 case "08":
		                    col=26;  
		                    break;                              
		                 case "09":
		                    col=27;  
		                    break;                              
		                 case "10":
		                    col=28;  
		                    break; 
		                  case "11":
		                    col=29;  
		                    break;                                                                                                                                                       
		                }
		                new_tmp=xtxValue.text;
		            grdSalary.SetGridText(row,col,new_tmp);
		        }		
	        }
	      }
	      else
	      {
	      //alert(lstdate.value);
	      var col=39; 
	       if(lstdate.value=='01')
	        col=39;
	       else
	        col=42;
	         var ctrl = grdSalary.GetGridControl();
	        for ( var i =  0 ; i < ctrl.SelectedRows ; i++ )
	        {
		        var row = ctrl.SelectedRow(i);
		         if ( row > 0 )
		         {
		         grdSalary.SetGridText(row,col,dtSet.value);
		         }
		    }      
	      
	      }  
	    
}
//--------------------------------------------------------------


function OnLoadExcel()
{ibtnSave2.SetEnable(true);   
 var arr =new Array();

    for (var i = 10 ;i<grdIncrease.cols-1;i++)
        {   arr[i-10]=grdIncrease.GetGridData(1,i);
        
        }     
      //  alert( arr.length )   
	
	grdSalary2.ClearData();	
	try
	{
		
		var vfilename = document.all["inputfile"].value;    
		var myApp = new ActiveXObject("Excel.Application");     
		myApp.Workbooks.Open(vfilename); 
		var workSheet = myApp.ActiveSheet; 
		var maxRow =workSheet.UsedRange.Rows.Count; 		  
		
	    for (var j =2;j <= maxRow; j++) 
		{ 
		
		    var flag=true;
		    var temp=new Array();
		    temp[0]=workSheet.Cells(j,2).value;   
		    temp[1]=workSheet.Cells(j,3).value;   
		 
		    
		    if (temp[0]==""  || temp[0]==null)
			     {  alert("Emp-ID cannot be blank at row: " + j);
			     flag=false;
			     }
		    if (temp[1]=="" || temp[1]==null)
			    {	alert("Name cannot be blank at row: " + j);
			    flag=false;
			    }
		    var u=2;
		
		     for(var i=0;i<arr.length ;i++)
		      {
		          temp[i+2]='0';
		          
		          if(arr[i]=="1")
		            {  // alert(workSheet.Cells(j,u+2).value); 
                        
                        if(workSheet.Cells(j,u+2).value+""!='undefined' && workSheet.Cells(j,u+2).value+""!="" && workSheet.Cells(j,u+2).value+""!="null" )
                        {
                        if( Number(workSheet.Cells(j,u+2).value)>=0 )
		                    {temp[i+2]=workSheet.Cells(j,u+2).value;
		                  
		                    }
		                else  {  ALERT("Invalid number at row " + j);
		                      flag=false;
		                      }
		                          
		                 }      
		               u++;
		            }
		      }
		    
		    if( Number(workSheet.Cells(j,u+2).value)>=0 )
		        temp[arr.length+2]=workSheet.Cells(j,u+2).value;   
		        
		    else  {  ALERT("Invalid number at row " + j);
		                 flag=false;
		            }
		    if( workSheet.Cells(j,u+3).value!="" ||workSheet.Cells(j,u+3).value !=null )
		        temp[arr.length+3]=workSheet.Cells(j,u+3).value;   
		    else  {  alert("Date cannot be blank at row: " + j);
		                 flag=false;
		            }
		            
		                
		 //  alert(arr.length + "  --- "+workSheet.Cells(j,u+2).value  +"   " +temp + " kt  --"+temp.length )
		      
			if(flag==true)
				{grdSalary2.AddRow();
				var irow=grdSalary2.rows-1;
				temp[temp.length]=txtSeq.text;
				for(var v=0;v<temp.length ;v++)
				    grdSalary2.SetGridText(irow,v,temp[v]);
				}
				
				
			}			
		 
		
		myApp.Quit();
		lblRecord2.text=(grdSalary2.rows -1)+" rec(s).";
		   auto_resize_column(grdSalary2,0,grdSalary2.cols-1,0);   
	}
	catch(e)
	{//alert(temp);
		alert("Could not read Excel File. (or) Excel was not installed in the machine you are using or it has incompatible version?"  + e.description ); 
	myApp.Quit();
	}
}
//------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
//------------------------------------------
function OnClick(obj)
{ 
    if(obj=='1')
    {grdSalary.style.display="";
     grdSalary2.style.display="none"; 
     ibtnSearch2.SetEnable(true);
     ibtnSave2.SetEnable(true);
     ibtnDelete2.SetEnable(true);
     inputfile.disabled=true;
     ibtnProcess.SetEnable(false); 
     ibtnSetSalary2.SetEnable(true); 
     ibtnPopup.SetEnable(true); 
     ibtnSetSalary.SetEnable(true);
     ibtnReport.SetEnable(false);
     
    }
    else
    { grdSalary.style.display="none";
      grdSalary2.style.display=""; 
     ibtnSearch2.SetEnable(false);
     ibtnSave2.SetEnable(false);
     ibtnDelete2.SetEnable(false);
     inputfile.disabled=false;
     ibtnProcess.SetEnable(true); 
     ibtnSetSalary2.SetEnable(false);
     ibtnPopup.SetEnable(false);
     ibtnSetSalary.SetEnable(false);
     ibtnReport.SetEnable(true);
    }
    
}
//-----------------------------------------
function SetGridColor()
{auto_resize_column(grdSalary,0,grdSalary.GetGridControl().cols-1,0)
       for(var i=1;i<grdSalary.rows;i++)
     {
     if(grdSalary.GetGridData(i,45)=="" )
     {
        grdSalary.SetCellBgColor(i, 7,i,18, 0xFFEEFF );
        grdSalary.SetCellBgColor(i, 19,i,29, 0xffffcc );
        grdSalary.SetCellBgColor(i, 40,i,42, 0x99ccff );
     
     }
     if(grdSalary.GetGridData(i,45)=="1")
              grdSalary.SetCellBgColor(i, 0,i, grdSalary.cols-1, 0x99FFFF );
     if(grdSalary.GetGridData(i,45)=="2")      
              grdSalary.SetCellBgColor(i, 0,i, grdSalary.cols-1, 0x6633ff );
     }  
}
//----------------------------------------
function OnReport()
{ var url=System.RootURL + '/reports/ch/cs/rpt_sample_increase.aspx' ;	
	window.open(url);	
    
}
//-----------------------------------------
function OnToggle()
{
            if(img3.status == "middle")
            {
                img3.status = "large";
                img3.src = "../../../system/images/iconmaximize.gif";
			    img3.alt="Show all columns";
			    visible_grdSalary(2);
    			
            }
            else if(img3.status == "large")
            {
                img3.status = "min";
                img3.src = "../../../system/images/iconminimize.gif";
			    img3.alt="Hide column";
			    visible_grdSalary(1);
            }
            else if(img3.status == "min")
            {
                img3.status = "middle";
                img3.src = "../../../system/images/menu.gif";
			    img3.alt="Show more columns";
			    visible_grdSalary(3);
            }
    
  
}
function visible_grdSalary(n)
{
 
        switch(n)
        {
            case 1://middle
               
         grdSalary.GetGridControl().ColHidden(1)=1;
         grdSalary.GetGridControl().ColHidden(2)=1;
            
                 var icol=10; //value of old salary
                 
        grdSalary.GetGridControl().ColHidden(icol)=1;
        grdSalary.GetGridControl().ColHidden(icol+1)=1;
        grdSalary.GetGridControl().ColHidden(icol+2)=1;
        grdSalary.GetGridControl().ColHidden(icol+3)=1;
        grdSalary.GetGridControl().ColHidden(icol+4)=1;
        grdSalary.GetGridControl().ColHidden(icol+5)=1;
        grdSalary.GetGridControl().ColHidden(icol+6)=1;
        grdSalary.GetGridControl().ColHidden(icol+7)=1;
          
       
                break;
            case 2://large
            
         grdSalary.GetGridControl().ColHidden(1)=0;
         grdSalary.GetGridControl().ColHidden(2)=0;
                 var icol=5; //value of old salary      
        grdSalary.GetGridControl().ColHidden(icol)=0;
        grdSalary.GetGridControl().ColHidden(icol+1)=0;
        grdSalary.GetGridControl().ColHidden(icol+2)=0;
        grdSalary.GetGridControl().ColHidden(icol+3)=0;
        grdSalary.GetGridControl().ColHidden(icol+4)=0;
        grdSalary.GetGridControl().ColHidden(icol+5)=0;
        grdSalary.GetGridControl().ColHidden(icol+6)=0;
        grdSalary.GetGridControl().ColHidden(icol+7)=0;
        grdSalary.GetGridControl().ColHidden(icol+8)=0;
        grdSalary.GetGridControl().ColHidden(icol+9)=0;
        grdSalary.GetGridControl().ColHidden(icol+10)=0;
        grdSalary.GetGridControl().ColHidden(icol+11)=0;
        grdSalary.GetGridControl().ColHidden(icol+12)=0;       
       
                
                break;
            case 3://hide all
                //alert(3)
                grdSalary.GetGridControl().ColHidden(1)=1;
                grdSalary.GetGridControl().ColHidden(2)=1;
                var icol=5; //value of old salary      
        grdSalary.GetGridControl().ColHidden(icol)=1;
        grdSalary.GetGridControl().ColHidden(icol+1)=1;
        grdSalary.GetGridControl().ColHidden(icol+2)=1;
        grdSalary.GetGridControl().ColHidden(icol+3)=1;
        grdSalary.GetGridControl().ColHidden(icol+4)=1;
        grdSalary.GetGridControl().ColHidden(icol+5)=1;
        grdSalary.GetGridControl().ColHidden(icol+6)=1;
        grdSalary.GetGridControl().ColHidden(icol+7)=1;
        grdSalary.GetGridControl().ColHidden(icol+8)=1;
        grdSalary.GetGridControl().ColHidden(icol+9)=1;
        grdSalary.GetGridControl().ColHidden(icol+10)=1;
        grdSalary.GetGridControl().ColHidden(icol+11)=1;
        grdSalary.GetGridControl().ColHidden(icol+12)=1;
          
                
                break;    
        }

}
function OnAdd()
{var url = System.RootURL+"/form/ch/cs/chcs00200_search_increase.aspx?p_month="+dtMonthTo.value;
	var aData=new Array();
	aData = System.OpenModal(  url , 900 , 600 , 'resizable:yes;status:yes') ;
	if ( aData != null )
	{  	 
		var len=aData.length;
		var i;
		for (i=0;i<len;i++)		
		{       grdSalary.AddRow();
		        var irow=grdSalary.rows-1;
		        aRow=aData[i];
		        grdSalary.SetGridText(irow,1,aRow[0]);		// department
		        grdSalary.SetGridText(irow,2,aRow[1]);		// group
		        grdSalary.SetGridText(irow,3,aRow[2]);		// emp id
		        grdSalary.SetGridText(irow,4,aRow[3]);		// full name
		        grdSalary.SetGridText(irow,5,aRow[4]);		// abs type
		        grdSalary.SetGridText(irow,6,aRow[5]);		// abs date
		        grdSalary.SetGridText(irow,7,aRow[6]);		// remain ALE
		        grdSalary.SetGridText(irow,8,aRow[7]);		// emp pk
		        grdSalary.SetGridText(irow,9,aRow[8]);		// work shift name
		        grdSalary.SetGridText(irow,10,aRow[9]);		// wgroup pk
		        grdSalary.SetGridText(irow,11,aRow[10]);		// work shift pk
		        grdSalary.SetGridText(irow,12,aRow[11]);		// work shift pk
		        grdSalary.SetGridText(irow,13,aRow[12]);		// work shift pk
		        grdSalary.SetGridText(irow,14,aRow[13]);		// work shift pk
		        grdSalary.SetGridText(irow,15,aRow[14]);		// work shift pk
		        grdSalary.SetGridText(irow,16,aRow[15]);		// work shift pk
		        grdSalary.SetGridText(irow,17,aRow[16]);		// work shift pk
		        grdSalary.SetGridText(irow,40,aRow[17]);		// work shift pk
		        grdSalary.SetGridText(irow,41,aRow[18]);		// work shift pk
		        grdSalary.SetGridText(irow,39,aRow[19]);		// work shift pk
		        grdSalary.SetGridText(irow,44,'02');		// work shift pk
		        
		        
		        
		
	SetGridColor();             
	}
	
}

auto_resize_column(grdSalary,0,grdSalary.GetGridControl().cols-1,0)
}
function OnDelete()
{if(confirm("Do yu want delete selected rows"))
    grdSalary.DeleteRow();

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
            <dso  type="grid" function="hr_sp_sel_allowance_salary" > 
                <input bind="grdAllowance" >
                </input>
                <output  bind="grdAllowance" />
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------------------------>
<gw:data id="datInc" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="hr_sel_10030020_increase" > 
                <input bind="grdIncrease" >
                </input>
                <output  bind="grdIncrease" />
            </dso> 
        </xml> 
</gw:data>
<!--_PK 0   |Organization 1|W-Group 2|Emp ID 3|Full Name 4|Join Date 5|Postion 6|Level 1 7|Level 2 8|Confirm DT 9|Allow1 10|Allow2 11|Allow3 12|Allow4 13|allow5 14|Allow6 15|Allow7 16|Allow8 17|_WMON 18|E 19|E2 20|E3 21|E4 22|E5 23|E6 24|E7 25|E8 26|E9 27|E10 28|Total Increase 29|New Salary 30|Allow1 31|Allow2 32|Allow3 33|Allow4 34|allow5 35|Allow6 36|Allow7 37|Allow8 38|Conform DT 39|Salary Type 40|Employee Type 41|Change Date 42|Remark 43|Action 44|_check 45-->
<!--EMP_PK 0|Organization 1|W-Group 2|Emp ID 3|Full Name 4|Join Date 5|Postion 6|Level 1 7|Level 2 8|Confirm DT 9|Allow1 10|Allow2 11|Allow3 12|Allow4 13|allow5 14|Allow6 15|Allow7 16|Allow8 17|_WMON 18|E 19|E2 20|E3 21|E4 22|E5 23|E6 24|E7 25|E8 26|E9 27|E10 28|Total Increase 29|New Salary 30|Allow1 31|Allow2 32|Allow3 33|Allow4 34|allow5 35|Allow6 36|Allow7 37|Allow8 38|Conform DT 39|Salary Type 40|Employee Type 41|Change Date 42|Remark 43|Action 44|_check 45" function="HR.sp_sel_increase_salary" procedure="hr.SP_upd_month_salary-->
<!------------------------------------------>
<gw:data id="daIncrease" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,3,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44" function="hr_sel_10030020_increase_sal" procedure="hr_upd_10030020_increase_sal"> 
                <input bind="grdSalary" >
                   <input bind="lstOrg2" /> 
                   <input bind="lstWGroup2" /> 
                   <input bind="lstPosition2" /> 
                   <input bind="lstTemp2" /> 
                   <input bind="txtTemp2" /> 
                   <input bind="lstMon_Year2" /> 
                   <input bind="txtFrom_Mon_Year2" /> 
                   <input bind="txtTo_Mon_Year2" /> 
                   <input bind="lstStatus2" /> 
                   <input bind="dtFrom_JoinDate2" /> 
                   <input bind="dtTo_JoinDate2" /> 
                    <input bind="dtMonthFrom" />
                    <input bind="dtMonthTo" />
                 
                </input>
                <output  bind="grdSalary" />
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>

<gw:data id="dataSeq" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10030020_get_seq" > 
                <input>
                    <input bind="txtSeq" />
                </input> 
                <output>
                    <output bind="txtSeq" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datImport" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14" function="hr_sel_10030020_imp_increase" procedure="hr_upd_10030020_imp_increase"> 
                <input bind="grdSalary2" >
                <input bind="txtSeq" />
                 </input>
                <output  bind="grdSalary2" />
            </dso> 
        </xml> 
</gw:data>
<!-------------------data control----------------------->
<table name="Month Sal" id="MonthSal" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="Table2" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                   
                  
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td width="1%" style="border:0;" align="right" ></td>
                        <td width="9%" style="border:0;" align="right" ><a title="Click here to show Organization" onclick="OnShowPopup(3)" href="#tips" >Organization</a>                  
                        </td>
                        <td width="12%" colspan=4 style="border:0;" align="left" >
                         <gw:list  id="lstOrg2" value='ALL' maxlen = "100" styles='width:100%'onchange="" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select pk,org_nm from tco_org a where del_if=0 ORDER BY NVL(A.SEQ,9999)")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td width="5%" style="border:0;" align="right" >W-Group</td>
                        <td width="18%" style="border:0;" align="left" colspan=2 >
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
                        <td width="3%" style="border:0" align="right">
                         <gw:imgBtn img="delete" id="ibtnDelete2"   alt="Report Current salary"  onclick="OnDelete()"/>
                        </td>
                        <td width="3%"  align="right" style="border:0">
                         <gw:imgBtn img="popup" id="ibtnPopup"   alt="Add"  onclick="OnAdd()"/>
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
                        <td style="border:0;" align="right" >Month</td>
                        <td style="border:0; white-space:nowrap" align="left" colspan=2>
                        <gw:datebox id="dtMonthFrom"  onchange="" tyles="width:100%" type="month" lang="<%=Session("Lang")%>" />~
                        <gw:datebox id="dtMonthTo"  onchange="" tyles="width:100%" type="month" lang="<%=Session("Lang")%>" />
                        
                         
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
                        <td width="1%" style="border:0;" align="right" ></td>
                        <td style="border:0;" align="right" ><gw:list  id="lstTmp" value='A0' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("SELECT 'A0','Level2 Salary' from dual union all SELECT A.CODE,A.CODE_NM FROM VHR_HR_CODE A WHERE A.ID='HR0019' AND A.NUM_2=1  union all SELECT A.CODE,A.CODE_NM FROM VHR_HR_CODE A WHERE A.ID='HR0151' AND nvl(char_1,'0')=1 union all SELECT '11','Total Increase' from dual")%></data></gw:list></td>
                        <td colspan=3 style="border:0;" width="9%" align="left"><gw:textbox text=""  id="xtxValue"  styles='width:100%'/></td>
                         <td width="3%" style="border:0" align="right">
                         <gw:imgBtn img="set" id="ibtnSetSalary"    alt="Set Salary"  onclick="OnSetSalary(1)"/>
                        </td>
                        <td  style="border:0;" colspan=1 > </td>
                        
                        <td width="8%" style="border:0; white-space:nowrap">
                            <gw:list  id="lstdate" value='01' maxlen = "100" styles='width:100%' >
                        <data>|01|Confirm Date|02|Change type</data></gw:list>
                        </td>
                        <td  style="border:0;white-space:nowrap" colspan=1 > 
					         <gw:datebox id="dtSet" nullaccept  onchange="" tyles="width:100%"  lang="<%=Session("Lang")%>" />
					          </td>
					         
                        
                        <td style="border:0;white-space:nowrap" >
                        <gw:imgBtn img="set" id="ibtnSetSalary2"    alt="Set Salary"  onclick="OnSetSalary(2)"/>
                        </td>
                        <td style="border:0;white-space:nowrap" align="right"  colspan=1  > 
                        
                        <input type="radio" id="Radio1" name="option_P" value="1" checked onclick="OnClick(1)" >
                        By Hand
                        </td>
                      
                        <td style="border:0;" align="right" width="5%">
                        
                        <input type="radio" id="Radio2" name="option_P" value="2"  onclick="OnClick(2)" >
                        Exel
                        </td>
                        <td colspan=3   style="border:0" align="center">
					   <input id="inputfile" type="file" name="pic" style="width:100%"  accept="text/csv,text/xls">
					    </td>
					    
					    
                        
                        <td style="border:0;white-space:nowrap" align="left" ><gw:imgBtn img="process" id="ibtnProcess"   alt="Insert from Excell to Grid"  onclick="dataSeq.Call();"/> 
                        </td>
                         <td style="border:0;white-space:nowrap" align="left" > <gw:imgBtn img="excel" id="ibtnReport"   alt="EX file "  onclick="OnReport()"/>  </td>                     
                        <td style="border:0;" colspan=2 align="right" ><gw:label id="lblRecord2"  text="0 rec(s)" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" /></td>
                        <td align="right" style="border:0" valign="bottom"><img status="middle" id="img3" alt="Show more columns" src="../../../system/images/menu.gif" style="cursor:hand" onclick="OnToggle()"  /></td>
                        
                    </tr>
                    <tr style="border:1;width:100%;height:80%" valign="top">
                        <td colspan=20  style="width:100%;height:100%;"> 
                             <gw:grid   
                                id="grdSalary"  
                                header="_PK|Organization|W-Group|Emp ID|Full Name|Join Date|Postion|Level 1|Level 2|Confirm DT|Allow1|Allow2|Allow3|Allow4|allow5|Allow6|Allow7|Allow8|_WMON|E1|E2|E3|E4|E5|E6|E7|E8|E9|E10|Total Increase|New Salary|Allow1|Allow2|Allow3|Allow4|allow5|Allow6|Allow7|Allow8|Conform DT |_Salary Type|Employee Type|Change Date|Remark|Action|_check"
                                format="0|0|0|0|0|4|0|-0|-0|4|-0|-0|-0|-0|-0|-0|-0|-0|0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|4|2|2|4|0|2|0"  
                                aligns="0|2|2|1|0|1|0|3|3|3|1|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
                                defaults="||||||||||||||||||||||||||||||||||"  
                                editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0"  
                                widths="0|1500|1600|2500|1200|1700|1200|1200|1200|1200|1500|1700|1500|1500|1500|1500|1500|1500|0|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|0"  
                                styles="width:100%; height:100%" 
                                sorting="T" acceptNullDate   
                                
                                oncelldblclick=""
                                
                                /> 
                                
                               <gw:grid   
                                id="grdSalary2"  
                                header="Emp ID|Full Name|E1|E2|E3|E4|E5|E6|E7|E8|E9|E10|Total Increase|Confirm DT|_seq"
                                format="0|0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|0|0"  
                                aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
                                defaults="||||||||||||||"  
                                editcol="1|1|1|1|1|1|1|1|1|1|1|1|1|1|0"  
                                widths="1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|0"  
                                styles="width:100%; height:100%" 
                                sorting="T" acceptNullDate   
                                styles="display:none" 
                                oncelldblclick=""
                                
                                />   
                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table>

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
<gw:textbox id="txtSeq" styles="display:none"/>
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
    id="grdIncrease"  
    header="Code Name 1|Code Name 2|Code Name 3|Code Name 4|Code Name 5|Code Name 6|Code Name 7|Code Name 8|Code Name 9|Code Name 10|Display 1|Display 2|Display 3|Display 4|Display 5|Display 6|Display 7|Display 8|Display 9|Display 10"
    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
    aligns="0|2|2|1|0|0|1|1|2|1|0|0|0|0|0|0|0|0|0|0"  
    defaults="||||||||||||||||||"  
    editcol="0|0|0|0|0|1|1|1|1|1|0|0|0|0|0|0|0|0|0|0"  
    widths="0|1500|1600|1000|2500|1500|1700|1500|1700|1500|1500|1200|1200|1200|1200|1200|1200|1200|1200|1200"  
    styles="display:none" 
    sorting="T"    
/> 

</html>
