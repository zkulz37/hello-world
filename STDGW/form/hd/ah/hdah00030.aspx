s<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser("hr")%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var strcodereturn;
var binit=true;
var flag_header=true;
var flag_header2=true;
var tab2=false;
function BodyInit()
{
    
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    
    SetGridHeader(grdSalary);
    
   grdSalary.GetGridControl().FrozenCols =5;
   grdSalary2.GetGridControl().FrozenCols =5;
   grdSalary3.GetGridControl().FrozenCols =5;
   grdSalary.GetGridControl().ScrollTrack=true;
   grdSalary2.GetGridControl().ScrollTrack=true;
   grdSalary3.GetGridControl().ScrollTrack=true;
   datAllowance.Call("SELECT");
   
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
        stt=0;//num column
        fg.MergeCol(stt) =true	;
        fg.Cell(0, 0, stt, 1, stt)  = "Organization";   //fg.Cell(CellPropertySettings,row, from_col, row, to_col)	
        
        stt+=1;
        fg.MergeCol(stt) =true	;
        fg.Cell(0, 0, stt, 1, stt)  = "W-Group";   
        
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
        fg.Cell(0, 0, stt, 1, stt)  = "Pro Sal";
        
        stt+=1;
        fg.MergeCol(stt) =true	;
        fg.Cell(0, 0, stt, 1, stt)  = "Contract";
        
        fg.MergeRow(0) =true	;
        stt+=1;
        if(obj==grdSalary)
        {
            fg.Cell(0, 0, stt, 0, stt+12)  = "Current Salary And Allowance Information";   
            obj.SetCellBgColor(0, stt,0, stt+12, 0x99FF99);
            obj.SetCellBgColor(1, stt,1, stt+12, 0x99FF99);
        }    
        else
        {
            fg.Cell(0, 0, stt, 0, stt+12)  = "Old Salary And Allowance Information";
            obj.SetCellBgColor(0, stt,0, stt+12, 0x99FF99);   
            obj.SetCellBgColor(1, stt,1, stt+12, 0x99FF99);
        }   
            
        fg.Cell(0, 1, stt, 1, stt) = "Position";
        
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = "Level1 Sal";
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = "Level2 Sal";
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = "Confirmed DT";
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = "Allow1";
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = "Allow2";
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = "Allow3";
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = "Allow4";
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = "Allow5";
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = "Allow6";
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = "Allow7";
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = "Allow8";
        
        stt+=1;
        if(obj==grdSalary)
        {
            fg.Cell(0, 0, stt, 0, stt+12) = dtMonth.text + " - Salary And Allowance Information";
            obj.SetCellBgColor(0, stt,0, stt+12, 0xFFCCFF);
            obj.SetCellBgColor(1, stt,1, stt+12, 0xFFCCFF);
        }    
        else
        {
            fg.Cell(0, 0, stt, 0, stt+12) = "New Salary And Allowance Information";
            obj.SetCellBgColor(0, stt,0, stt+12, 0xFFCCFF );
            obj.SetCellBgColor(1, stt,1, stt+12, 0xFFCCFF);
        }   
            
        fg.Cell(0, 1, stt, 1, stt) = "Position";
        
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = "Level1 Sal";
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = "Level2 Sal";
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = "Confirmed DT";
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = "Allow1";
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = "Allow2";
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = "Allow3";
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = "Allow4";
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = "Allow5";
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = "Allow6";
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = "Allow7";
        stt+=1;
        fg.Cell(0, 1, stt, 1, stt) = "Allow8";
        
        obj.SetCellBold(1,0,1,stt,true);
        fg.FontSize=8;
        
}
//------------------------------------
function setColor(obj)
{
    if(obj!=grdSalary3)
    {
            for(var i=1;i<obj.rows;i++)
            {
                
	            if(i>1)
	            {
	                for(var j=1;j<=12;j++)
	                {
	                    if(obj.GetGridData(i,j+6)!=obj.GetGridData(i,j+18))
	                    {
	                        obj.SetCellFontColor(i, j+6,i, j+6, 0xFF3300 );
	                      //  obj.SetCellBold(i, j+6,i, j+6,true);
	                        obj.SetCellFontColor(i, j+18,i, j+18, 0xFF3300 );
	                      //  obj.SetCellBold(i, j+18,i, j+18,true);
	                    }    
            	            
	                }
	             }   
	        } 
	  }    
	  else
	  {
	     for(var i=1;i<obj.rows;i++)
            for(var j=7;j<=17;j++)
                if(obj.GetGridData(i,j)!=obj.GetGridData(i,j-1)&&!isNaN(obj.GetGridData(i,j))&&!isNaN(obj.GetGridData(i,j-1)))//thay doi luong
                {
                    obj.SetCellFontColor(i, j,i, j, 0x300FF3 );
	                //obj.SetCellBold(i,j,i,j,true);
                }    
	    
	  }
}

//----------------------------------
function OnShowPopup(n)
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:20;dialogHeight:30;dialogLeft:10;dialogTop:240;edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {
        if(n==1)
            lstOrg.value=obj;
        else if(n==2)
            lstOrg2.value=obj;
        else
            lstOrg3.value=obj;    
                
    }
    
}
//------------------------------------
function OnChangeMonth(n)
{
    if(n==1)
    {
        grdSalary.ClearData();
        grdSalary.GetGridControl().Cell(0, 0, 19, 0, 30) = "Month ("+dtMonth.text+") Information";        
    }
    
}
//----------------------------------------------------
function ChoseList_box(obj_list,value)
{
    obj_list.SetDataText(value)    ;
    obj=obj_list.GetControl()
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
        allowance_grid_control(grdSalary);
        if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
                datUser_info.Call(); 
   }
   
   else if(obj.id=="datSalary")
   {
        lblRecord.text=grdSalary.rows-2 + " rec(s)";
        if(grdSalary.rows-1>0)
        {
            SetGridHeader(grdSalary);
            setColor(grdSalary);
            Get_allowance_name(grdSalary)
            var font_size=0;
            if(img1.status=="large")
                font_size=11;
                
            auto_resize_column(grdSalary,0,grdSalary.cols-1,font_size);
             
        }   
        
        
   }
   else if (obj.id=="datUser_info")
   {
        lstOrg.SetDataText(txtDeptData.text);
        lstOrg2.SetDataText(txtDeptData.text);
        lstOrg3.SetDataText(txtDeptData.text);
        
   }
   else if(obj.id=="datSalary2")
   {
        lblRecord2.text=grdSalary2.rows-2 + " rec(s)";
        if(grdSalary2.rows-1>0)
        {
            SetGridHeader(grdSalary2);
            setColor(grdSalary2);
            Get_allowance_name(grdSalary2)
            var font_size=0;
            if(img2.status=="large")
                font_size=11;
                
            auto_resize_column(grdSalary2,0,grdSalary2.cols-1,font_size);
        }   
        
   }
   else if(obj.id=="datSalary3")
   {
        lblRecord3.text=grdSalary3.rows-1 + "(s)";
        setColor(grdSalary3);
        var font_size=0;
        if(img3.status=="large")
                font_size=11;
        auto_resize_column(grdSalary3,0,grdSalary3.cols-1,font_size);
   }
}
//---------------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
    if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
//--------------------------------------------------
function allowance_grid_control(obj)
{
    var icol=11; //value of allowance col
        obj.SetGridText(1,icol,grdAllowance.GetGridData(1,0));
        obj.SetGridText(1,icol+1,grdAllowance.GetGridData(1,1));
        obj.SetGridText(1,icol+2,grdAllowance.GetGridData(1,2));
        obj.SetGridText(1,icol+3,grdAllowance.GetGridData(1,3));
        obj.SetGridText(1,icol+4,grdAllowance.GetGridData(1,4));
        obj.SetGridText(1,icol+5,grdAllowance.GetGridData(1,5));
        obj.SetGridText(1,icol+6,grdAllowance.GetGridData(1,6));
        obj.SetGridText(1,icol+7,grdAllowance.GetGridData(1,7));
        obj.GetGridControl().ColHidden(icol)=!(Number(grdAllowance.GetGridData(1,8)));
        obj.GetGridControl().ColHidden(icol+1)=!(Number(grdAllowance.GetGridData(1,9)));
        obj.GetGridControl().ColHidden(icol+2)=!(Number(grdAllowance.GetGridData(1,10)));
        obj.GetGridControl().ColHidden(icol+3)=!(Number(grdAllowance.GetGridData(1,11)));
        obj.GetGridControl().ColHidden(icol+4)=!(Number(grdAllowance.GetGridData(1,12)));
        obj.GetGridControl().ColHidden(icol+5)=!(Number(grdAllowance.GetGridData(1,13)));
        obj.GetGridControl().ColHidden(icol+6)=!(Number(grdAllowance.GetGridData(1,14)));
        obj.GetGridControl().ColHidden(icol+7)=!(Number(grdAllowance.GetGridData(1,15)));
        
        icol=23;
        obj.SetGridText(1,icol,grdAllowance.GetGridData(1,0));
        obj.SetGridText(1,icol+1,grdAllowance.GetGridData(1,1));
        obj.SetGridText(1,icol+2,grdAllowance.GetGridData(1,2));
        obj.SetGridText(1,icol+3,grdAllowance.GetGridData(1,3));
        obj.SetGridText(1,icol+4,grdAllowance.GetGridData(1,4));
        obj.SetGridText(1,icol+5,grdAllowance.GetGridData(1,5));
        obj.SetGridText(1,icol+6,grdAllowance.GetGridData(1,6));
        obj.SetGridText(1,icol+7,grdAllowance.GetGridData(1,7));
        obj.GetGridControl().ColHidden(icol)=!(Number(grdAllowance.GetGridData(1,8)));
        obj.GetGridControl().ColHidden(icol+1)=!(Number(grdAllowance.GetGridData(1,9)));
        obj.GetGridControl().ColHidden(icol+2)=!(Number(grdAllowance.GetGridData(1,10)));
        obj.GetGridControl().ColHidden(icol+3)=!(Number(grdAllowance.GetGridData(1,11)));
        obj.GetGridControl().ColHidden(icol+4)=!(Number(grdAllowance.GetGridData(1,12)));
        obj.GetGridControl().ColHidden(icol+5)=!(Number(grdAllowance.GetGridData(1,13)));
        obj.GetGridControl().ColHidden(icol+6)=!(Number(grdAllowance.GetGridData(1,14)));
        obj.GetGridControl().ColHidden(icol+7)=!(Number(grdAllowance.GetGridData(1,15)));
}
//-------------------------------------------------
function Get_allowance_name(obj)
{
    var icol=11; //value of allowance col
        obj.SetGridText(1,icol,grdAllowance.GetGridData(1,0));
        obj.SetGridText(1,icol+1,grdAllowance.GetGridData(1,1));
        obj.SetGridText(1,icol+2,grdAllowance.GetGridData(1,2));
        obj.SetGridText(1,icol+3,grdAllowance.GetGridData(1,3));
        obj.SetGridText(1,icol+4,grdAllowance.GetGridData(1,4));
        obj.SetGridText(1,icol+5,grdAllowance.GetGridData(1,5));
        obj.SetGridText(1,icol+6,grdAllowance.GetGridData(1,6));
        obj.SetGridText(1,icol+7,grdAllowance.GetGridData(1,7));
        
        icol=23;
        obj.SetGridText(1,icol,grdAllowance.GetGridData(1,0));
        obj.SetGridText(1,icol+1,grdAllowance.GetGridData(1,1));
        obj.SetGridText(1,icol+2,grdAllowance.GetGridData(1,2));
        obj.SetGridText(1,icol+3,grdAllowance.GetGridData(1,3));
        obj.SetGridText(1,icol+4,grdAllowance.GetGridData(1,4));
        obj.SetGridText(1,icol+5,grdAllowance.GetGridData(1,5));
        obj.SetGridText(1,icol+6,grdAllowance.GetGridData(1,6));
        obj.SetGridText(1,icol+7,grdAllowance.GetGridData(1,7));
        
}        

//----------------------------------------------------
function OnSearch(obj_dat)
{
    obj_dat.Call("SELECT");
}
//-------------------------------------------------------------
function PrintSelection(grid, Row1, Col1, Row2, Col2)
{
    
        // save current settings
        var fg=grid.GetGridControl();
        var hl, tr, lc, rd
        hl = fg.HighLight;
        tr = fg.TopRow;
        lc = fg.LeftCol;
        rd = fg.Redraw
        fg.HighLight = 0
        fg.Redraw = 0
    
        // hide non-selected rows and columns
        /*
        for(var i = fg.FixedRows;i<=fg.Rows-1;i++)
            if(i<Row1 || i>Row2)
                fg.RowHidden(i) = true;
        
        for(i = fg.FixedCols;i<=fg.Cols-1;i++)
            if(i<Col1 || i>Col2)
                fg.ColHidden(i) = true;
        */
    
        // scroll to top left corner
    /*    fg.TopRow = fg.FixedRows
        fg.LeftCol = fg.FixedCols*/
    
        // print visible area
       // fg.PrintGrid("test",true,2,10,10);//PrintGrid [ DocName As String ], [ hien thi dialog may in As Boolean ], [ kieu in dung hay ngang As Integer ], [ canh trai phai As Long ], [ canh tren duoi As Long ]
    
        // restore control
      /*  fg.RowHidden(-1) = false
        fg.ColHidden(-1) = false
        fg.TopRow = tr;
        fg.LeftCol = lc;*/
        fg.HighLight = hl;
        fg.Redraw = rd;
}
function print_grid(obj)
{
    /*
    PrintSelection(obj,0,0,obj.rows,obj.cols);
    obj.GetGridControl().PrintGrid("test",true,2,0,0);//PrintGrid [ DocName As String ], [ hien thi dialog may in As Boolean ], [ kieu in dung hay ngang As Integer ], [ canh trai phia As Long ], [ canh tren duoi As Long ]
    var colw=0;
    var c
    for(var i=0;i<obj.cols-1;i++)
       if(obj.GetGridControl().ColHidden(i)==false)
       {
            colw+=obj.GetGridControl().ColWidth(i);
            if(colw>12240)//8.5 * 1440
            {
                c=i;
                break;
            }
                
       }
    //letter 8.5 - 11
    //A4     8.27 - 11.69
     alert(c);
     //obj.GetGridControl().PrintGrid("test",true,2,0,0);  
     //grdSalary.GetGridControl().FontSize =30;
       */
    
}
function OnReport(obj)
{
   if(obj==1) //tab thu nhat
        var url =System.RootURL + '/reports/ch/cs/rpt_salary_summary.aspx?org='+lstOrg.value+'&wg='+lstWGroup.value+'&pos='+lstPosition.value+'&lsttmp='+lstTemp.value+'&txttmp='+txtTemp.text+'&dtyear='+dtMonth.value+'&contract='+lstContract_Type.value+'&status='+lstStatus.value+'&fromjoin='+dtFrom_JoinDate.value+'&tojoin='+dtTo_JoinDate.value+'&lstmoney='+lstMoney.value+'&lstmon_year='+lstMon_Year.value+'&from_mon_year='+txtFrom_Mon_Year.text+'&to_mon_year='+txtTo_Mon_Year.text+'&lstSal='+lstTmp.value+'&fromsal='+txtFromSalary.text+'&tosal='+txtToSalary.text;
   else if (obj==2) // tab thu 2
        var url =System.RootURL + '/reports/ch/cs/rpt_salary_change.aspx?org='+lstOrg2.value+'&wg='+lstWGroup2.value+'&pos='+lstPosition2.value+'&lsttmp='+lstTemp2.value+'&txttmp='+txtTemp_2.text+'&dtyear='+dtMonth2.value+'&contract='+lstContract_Type2.value+'&status='+lstStatus2.value+'&fromjoin='+dtFrom_JoinDate2.value+'&tojoin='+dtTo_JoinDate2.value+'&lstmoney='+lstMoney2.value
   else if(obj==3) //tab thu 3
       var url =System.RootURL + '/reports/ch/cs/rpt_salary_year.aspx?org='+lstOrg3.value+'&wg='+lstWGroup3.value+'&pos='+lstPosition3.value+'&lsttmp='+lstTemp3.value+'&txttmp='+txtTemp3.text+'&dtyear='+dtYear3.value+'&contract='+lstContract_Type3.value+'&status='+lstStatus3.value+'&fromjoin='+dtFrom_JoinDate3.value+'&tojoin='+dtTo_JoinDate3.value+'&lstmoney='+lstMoney3.value   
   window.open(url);
}
function OnToggle(n)
{
    switch(n)
    {
        case 1:
            if(img1.status == "min")
            {
                img1.status = "large";
                img1.src = "../../../system/images/iconmaximize.gif";
			    img1.alt="Show more columns";
			    visible_grdSalary(grdSalary,2);
    			
            }
            else if(img1.status == "large")
            {
                img1.status = "min";
                img1.src = "../../../system/images/close_popup.gif";
			    img1.alt="Hide column";
			    visible_grdSalary(grdSalary,1);
            }
            break;
       case 2:
            if(img2.status == "min")
            {
                img2.status = "large";
                img2.src = "../../../system/images/iconmaximize.gif";
			    img2.alt="Show more columns";
			    visible_grdSalary(grdSalary2,2);
            }
            else if(img2.status == "large")
            {
                img2.status = "min";
                img2.src = "../../../system/images/close_popup.gif";
			    img2.alt="Hide column";
			    visible_grdSalary(grdSalary2,1);
            }
           
            break;   
       case 3:
            if(img3.status == "min")
            {
                img3.status = "large";
                img3.src = "../../../system/images/iconmaximize.gif";
			    img3.alt="Show more columns";
			    visible_grdSalary(grdSalary3,2);
            }
            else if(img3.status == "large")
            {
                img3.status = "min";
                img3.src = "../../../system/images/close_popup.gif";
			    img3.alt="Hide column";
			    visible_grdSalary(grdSalary3,1);
            }
           
            break;        
       
    }    
    
  
}
function visible_grdSalary(obj,n)
{
   
        switch(n)
        {
            case 1://middle
               
                obj.GetGridControl().ColHidden(0)=0;
                
                obj.GetGridControl().ColHidden(4)=0;
                obj.GetGridControl().ColHidden(5)=0;
                if(obj!=grdSalary3)
                    obj.GetGridControl().ColHidden(6)=0;
                auto_resize_column(obj,0,obj.cols-1,8);      
                break;
            case 2://hide all
                //alert(3)
                obj.GetGridControl().ColHidden(0)=1;
                if(obj!=grdSalary3)
                    obj.GetGridControl().ColHidden(1)=1;
            
                obj.GetGridControl().ColHidden(4)=1;
                obj.GetGridControl().ColHidden(5)=1;
                if(obj!=grdSalary3)
                    obj.GetGridControl().ColHidden(6)=1;
                    
                auto_resize_column(obj,0,obj.cols-1,11); //obj,col1,col2,font_size  
                break;    
        }
    
}
//-------------------------------------------------------------
function onPage_active()
{
    if(tabMain.GetCurrentPageNo()==1)
    {
        if(tab2==false)
        {
           SetGridHeader(grdSalary2);
           allowance_grid_control(grdSalary2);
           tab2=true;
            //txtDept.text=lstOrg2.value;
         }   
        
    }
}
//------------------------------------------
function  OnClickGrid(n)
{
    switch(n)
    {
        case 1:
            if (event.col<=3) // emp id, hoac ten 
            {
                var emp_id=grdSalary.GetGridData(event.row,2);
                var fpath = System.RootURL + "/form/ch/cs/chcs0020_salary_his.aspx?emp_id=" + emp_id;
                window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:60;dialogHeight:25;dialogLeft:100;dialogTop:230;edge:sunken;scroll:yes;unadorned:yes;help:no');
            }
            else if(event.col>7) // 
            {
                var emp_id=grdSalary.GetGridData(event.row,2);
                var fpath = System.RootURL + "/form/ch/cs/chcs0020_salary.aspx?emp_id=" + emp_id;
                window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:60;dialogHeight:25;dialogLeft:100;dialogTop:230;edge:sunken;scroll:yes;unadorned:yes;help:no');
            }
            break;
        case 2:
                var emp_id=grdSalary.GetGridData(event.row,2);
                var fpath = System.RootURL + "/form/ch/cs/chcs0020_salary.aspx?emp_id=" + emp_id;
                window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:60;dialogHeight:25;dialogLeft:100;dialogTop:230;edge:sunken;scroll:yes;unadorned:yes;help:no');
            break;    
    }    
}



</script>
<body style=" margin-bottom:0; margin-top:0; margin-right:0" >
<!-------------------data control----------------------->
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr.sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="txtDeptData" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------------------------>
<gw:data id="datAllowance" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="hr.sp_sel_allowance_salary" > 
                <input bind="grdAllowance" >
                </input>
                <output  bind="grdAllowance" />
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------------>
<gw:data id="datSalary" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid" function="hr.sp_sel_salary_sum"> 
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
                   <input bind="txtFromSalary" /> 
                   <input bind="txtToSalary" /> 
                   <input bind="dtMonth" />
                   <input bind="lstMoney" />
                   <input bind="lstTmp" />
                </input>
                <output  bind="grdSalary" />
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>
<gw:data id="datSalary2" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid" function="hr.sp_sel_salary_change"> 
                <input bind="grdSalary2" >
                   <input bind="lstOrg2" /> 
                   <input bind="lstWGroup2" /> 
                   <input bind="lstPosition2" /> 
                   <input bind="lstTemp2" /> 
                   <input bind="txtTemp_2" /> 
                   <input bind="dtMonth2" /> 
                   <input bind="lstContract_Type2" /> 
                   <input bind="lstStatus2" /> 
                   <input bind="dtFrom_JoinDate2" /> 
                   <input bind="dtTo_JoinDate2" /> 
                   <input bind="lstMoney2" />
                </input>
                <output  bind="grdSalary2" />
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>
<gw:data id="datSalary3" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid" function="hr.sp_sel_salary_year"> 
                <input bind="grdSalary3" >
                   <input bind="lstOrg3" /> 
                   <input bind="lstWGroup3" /> 
                   <input bind="lstPosition3" /> 
                   <input bind="lstTemp3" /> 
                   <input bind="txtTemp3" /> 
                   <input bind="dtYear3" /> 
                   <input bind="lstContract_Type3" /> 
                   <input bind="lstStatus3" /> 
                   <input bind="dtFrom_JoinDate3" /> 
                   <input bind="dtTo_JoinDate3" /> 
                   <input bind="lstMoney3" />
                </input>
                <output  bind="grdSalary3" />
            </dso> 
        </xml> 
</gw:data>

<!-------------------data control----------------------->
<gw:tab id="tabMain"  border=1 style="width:100%;height:100%;" onpageactivate="onPage_active()"  > 
   <table name="Salary" id="tblSalary" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;" valign="top">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="tblexp" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td width="9%" style="border:0;" align="right" ><a title="Click here to show organization" onclick="OnShowPopup(1)" href="#tips" >
                            <b>Organization&nbsp;</b></a>                  
                        </td>
                        <td width="12%" colspan=3 style="border:0;" align="left" >
                         <gw:list  id="lstOrg" value='ALL' maxlen = "100" styles='width:100%'onchange="" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select pk,org_nm from comm.tco_org a where del_if=0 order by nvl(a.seq,0)")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td width="10%" style="border:0;" align="right" ><b>W-Group</b></td>
                        <td width="12%" style="border:0;" align="left"  >
                         <gw:list  id="lstWGroup" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("select pk,workgroup_nm from thr_work_group a where a.del_if=0 order by a.workgroup_id")%>|ALL|Select All</data>
                        </gw:list>
                        </td>
                         <td width="7%" style="border:0;" align="right" ><b>Position &nbsp;</b>        
                        </td>
                        <td width="11%" style="border:0;" align="left" >
                         <gw:list  id="lstPosition" value='ALL' maxlen = "100" styles='width:100%' >
                           <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm")%>|ALL|Select All
                            </data></gw:list>
                        </td>
                        
                        <td  style="border:0"  width="9%"  align="right" valign="middle"> <b>Search by &nbsp;</b></td>
					    <td  style="border:0" width="10%" >
					        <gw:list  id="lstTemp" value="2" styles='width:100%' onchange=""> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID</data> 
					        </gw:list>
				        </td>
                        <td width="11%"  colspan=2 style="border:0" > 
					        <gw:textbox id="txtTemp" onenterkey   ="OnSearch(datSalary)" styles='width:100%'/>
				        </td>
				         
                        <td width="6%" style="border:0;" align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch(datSalary)"/>
                        </td>
                        <td width="3%" style="border:0" align="right">
                         <gw:imgBtn img="excel" id="ibtnReport"    alt="Report"  onclick="OnReport(1)"/>
                        </td>
                        
                    </tr>
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td style="border:0;" align="right" > <gw:list  id="lstMon_Year" value='MON' maxlen = "100" styles='width:90%'>
                            <data>|MON|Months|YEAR|Years</data>     </gw:list>
                        </td>
                        <td  style="border:0;" width="5%" align="left" ><gw:textbox id="txtFrom_Mon_Year"  styles='width:100%'/>
                        </td>
                         <td style="border:0;" width="1%" align="center" ><b>~</b>
                        </td>
                         <td style="border:0;" width="5%"  align="left" ><gw:textbox id="txtTo_Mon_Year"  styles='width:100%'/>
                        </td>
                        <td style="border:0;" align="right" ><b>Contract Type &nbsp;</b>        
                        </td>
                        <td style="border:0;" align="left" >
                         <gw:list  id="lstContract_Type" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0001' order by code_nm")%>|ALL|Select All</data></gw:list>
                        </td>
                        <td  style="border:0"   align="right"><b>Status &nbsp;</b>
					    </td>
                        <td style="border:0"> 
					        <gw:list  id="lstStatus" value='A' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0022' order by code_nm" )%>|ALL|Select All</data></gw:list>
                        </td>
                         <td style="border:0;" align="right" ><b>Join Date &nbsp;</b>        
                        </td>
                        <td style="border:0;" align="left" >
                         <gw:datebox id="dtFrom_JoinDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" />
                        </td>
                        <td style="border:0;"  align="center" ><b>~</b></td>
                        <td  style="border:0;"  align="left" >
                         <gw:datebox id="dtTo_JoinDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" />
                        </td>
                       
                    </tr>
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                    
                        <td colspan=1 style="border:0;"  align="left"></td>
                        <td colspan=3 style="border:0" align="right">Money Kind</td>
                        <td style="border:0" align="right"><gw:list  id="lstMoney" value='01' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0040' order by code" )%>|ALL|Select All</data></gw:list></td>
                        <td colspan=2 style="border:0" align="right"><b style="color:#cc0066; font-size:12">Salary Month &nbsp;</b> </td>
					    <td style="border:0"> 
					         <gw:datebox id="dtMonth"  onchange="OnChangeMonth(1)" tyles="width:100%" type="month" lang="<%=Session("Lang")%>" /></td>
                        <td style="border:0;" align="right" ><gw:list  id="lstTmp" value='A0' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("SELECT 'A','Level1 Salary' from dual union SELECT 'A0','Level2 Salary' from dual union SELECT A.CODE,A.CODE_NM FROM VHR_HR_CODE A WHERE A.ID='HR0019' AND A.NUM_2=1")%></data></gw:list></td>
                        <td  style="border:0;" width="9%" align="center"><gw:textbox text=""  id="txtFromSalary"  styles='width:90%'/></td>
                        <td style="border:0;" align="center"  > <b>~</b>       
                        </td>
                        <td style="border:0;" align="left"> <gw:textbox text="" onenterkey="OnSearch(datSalary)" id="txtToSalary"  styles='width:95%'/>
                        </td>
                        <td style="border:0;" colspan=2 align="center" ><gw:label onenterkey="OnSearch(datSalary)" id="lblRecord"  text="0 rec(s)" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" /></td>
                        <td align="right" style="border:0" valign="bottom"><img status="min" id="img1" alt="Show more columns" src="../../../system/images/close_popup.gif" style="cursor:hand" onclick="OnToggle(1)"  /></td>
                        
                    </tr>
                    <tr style="border:1;width:100%;height:85%" valign="top">
                        <td colspan=20  style="width:100%;height:100%;"> 
                             <gw:grid   
                                id="grdSalary"  
                                header="Organization|W-Group|Emp ID|Full Name|Join Date|Prob Salary|Contract|Postion1|Level1|Level2|Confirm|Allow1|Allow2|Allow3|Allow4|allow5|Allow6|Allow7|Allow8|Postion2|Level1|Level2|Confirm|Allow1|Allow2|Allow3|Allow4|allow5|Allow6|Allow7|Allow8|_SEQ"
                                format="0|0|0|0|0|1|0|0|1|1|0|1|1|1|1|1|1|1|1|0|1|1|0|1|1|1|1|1|1|1|1|0"  
                                aligns="2|2|1|2|1|3|1|1|3|3|1|3|3|3|3|3|3|3|3|1|3|3|1|3|3|3|3|3|3|3|3|0"  
                                defaults="|||||||||||||||||||||||||||||||"  
                                editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
                                widths="1500|1600|1000|2500|1200|1300|1300|1300|1300|1300|1300|1000|1000|1000|1000|1000|1000|1000|1000|1300|1300|1300|1300|1000|1000|1000|1000|1000|1000|1000|1000|1000|0"  
                                styles="width:100%; height:100%" 
                                sorting="T"   
                                 oncelldblclick="OnClickGrid(1)"
                                /> 
                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table>
   <table name="Salary Change" id="tblIncSal" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;" valign="top">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="Table2" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td width="9%" style="border:0;" align="right" ><a title="Click here to show organization" onclick="OnShowPopup(2)" href="#tips" >
                            <b>Organization &nbsp;</b></a>                  
                        </td>
                        <td width="12%" colspan=3 style="border:0;" align="left" >
                         <gw:list  id="lstOrg2" value='ALL' maxlen = "100" styles='width:100%'onchange="" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select pk,org_nm from comm.tco_org a where del_if=0 order by a.org_id")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td width="8%" style="border:0;" align="right" ><b>W-Group</b>        
                        </td>
                        <td width="12%" style="border:0;" align="left"  >
                         <gw:list  id="lstWGroup2" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("select pk,workgroup_nm from thr_work_group a where a.del_if=0 order by a.workgroup_id")%>|ALL|Select All</data></gw:list>
                        </td>
                         <td width="7%" style="border:0;" align="right" ><b>Position &nbsp;</b>        
                        </td>
                        <td width="11%" style="border:0;" align="left" >
                         <gw:list  id="lstPosition2" value='ALL' maxlen = "100" styles='width:100%' >
                           <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm")%>|ALL|Select All
                            </data></gw:list>
                        </td>
                        
                        <td  style="border:0"  width="7%"  align="right" valign="middle"> <b>Search by &nbsp;</b>   </td>
					    <td  style="border:0" width="8%" >
					        <gw:list  id="lstTemp2" value="2" styles='width:100%'> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID</data> 
					        </gw:list>
				        </td>
                        <td width="5%"  colspan=2 style="border:0" > 
					        <gw:textbox id="txtTemp_2" onenterkey   ="OnSearch(datSalary2)" styles='width:100%'/>
				        </td>
				         <td colspan=7 width="14%" style="border:0;" align="right" >&nbsp;</td>
                        <td width="2%" style="border:0;" align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch2"   alt="Search"  onclick="OnSearch(datSalary2)"/>
                        </td>
                        <td width="2%" style="border:0" align="right">
                         <gw:imgBtn img="excel" id="ibtnReport2"    alt="Report"  onclick="OnReport(2)"/>
                        </td>
                        
                    </tr>
                    <tr style="border:1;width:100%;height:5%" valign="center" >
                        <td style="border:0;" align="right" ><b style="color:#cc0066; font-size:12">Month &nbsp;</b> 
                        </td>
                        <td  style="border:0;" width="5%" align="left" colspan=3><gw:datebox id="dtMonth2"  onchange="OnChangeMonth()" tyles="width:100%" type="month" lang="<%=Session("Lang")%>" /></td>
                        <td style="border:0;" align="right" ><b>Contract</b>        
                        </td>
                        <td style="border:0;" align="left" >
                         <gw:list  id="lstContract_Type2" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0001' order by code_nm")%>|ALL|Select All</data></gw:list>
                        </td>
                        <td  style="border:0"   align="right"><b>Status &nbsp;</b>
					    </td>
                        <td style="border:0"> 
					        <gw:list  id="lstStatus2" value='A' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0022' order by code_nm" )%>|ALL|Select All</data></gw:list>
                        </td>
                         <td style="border:0;" align="right" ><b>Join Date &nbsp;</b>        
                        </td>
                        <td style="border:0;" align="left" >
                         <gw:datebox id="dtFrom_JoinDate2" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" />
                        </td>
                        <td style="border:0;"  align="center" ><b>~</b></td>
                        <td  style="border:0;"  align="left" >
                         <gw:datebox id="dtTo_JoinDate2" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" />
                        </td>
                        <td  colspan=2 style="border:0;" align="right" ><b>Money:</b></td>
                        <td  colspan=4 style="border:0;"  align="center" ><gw:list  id="lstMoney2" value='01' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0040' order by code_nm")%>|ALL|Select All</data></gw:list></td>
                       <td style="border:0;" colspan=5 align="center" ><gw:label id="lblRecord2"  text="0 rec(s)" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" /></td>
                       <td align="right" style="border:0" valign="bottom"><img status="min" id="img2" alt="Show more columns" src="../../../system/images/close_popup.gif" style="cursor:hand" onclick="OnToggle(2)"  /></td>
                    </tr>
                    
                    <tr style="border:1;width:100%;height:85%" valign="top">
                        <td colspan=25  style="width:100%;height:100%;"> 
                             <gw:grid   
                                id="grdSalary2"  
                                header="Organization|W-Group|Emp ID|Full Name|Join Date|Prob Salary|Contract|Postion1|Level1|Level2|Confirm|Allow1|Allow2|Allow3|Allow4|allow5|Allow6|Allow7|Allow8|Postion2|Level1|Level2|Confirm|Allow1|Allow2|Allow3|Allow4|allow5|Allow6|Allow7|Allow8|_SEQ"
                                format="0|0|0|0|0|1|0|0|1|1|0|1|1|1|1|1|1|1|1|0|1|1|0|1|1|1|1|1|1|1|1|0"  
                                aligns="2|2|1|2|1|3|1|1|3|3|1|3|3|3|3|3|3|3|3|1|3|3|1|3|3|3|3|3|3|3|3|0"   
                                defaults="|||||||||||||||||||||||||||||||0"  
                                editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
                                widths="1500|1600|1000|2500|1200|1300|1300|1300|1300|1300|1300|1000|1000|1000|1000|1000|1000|1000|1000|1300|1300|1300|1300|1000|1000|1000|1000|1000|1000|1000|1000|1000|0"  
                                styles="width:100%; height:100%" 
                                sorting="T"   
                                oncelldblclick="OnClickGrid(2)"
                                /> 
                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table> 
    <table name="Salary Year" id="tblSalYear" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;" valign="top">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="Table3" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td width="8%" colspan=4 style="border:0;" align="right" ><a title="Click here to show organization" onclick="OnShowPopup(3)" href="#tips" >
                            <b>Organization</a>                  
                        </td>
                        <td width="24%" colspan=12 style="border:0;" align="left" >
                             <gw:list  id="lstOrg3" value='ALL' maxlen = "100" styles='width:100%'onchange="" >
                                <data>
                                    <%=ESysLib.SetListDataSQL("select pk,org_nm from comm.tco_org a where del_if=0 order by a.org_id")%>|ALL|Select All
                                </data>
                            </gw:list>
                        </td>
                        <td width="6%" colspan=3 style="border:0;" align="right" ><b>W-Group</b></td>
                        <td width="10%" colspan=5 style="border:0;" align="left" >
                         <gw:list  id="lstWGroup3" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("select pk,workgroup_nm from thr_work_group a where a.del_if=0 order by a.workgroup_id")%>|ALL|Select All</data></gw:list>
                        </td>
                         <td width="6%" colspan=3 style="border:1;" align="right" ><b>Position</b></td>
                        <td width="10%" colspan=5 style="border:1;" align="left" >
                             <gw:list  id="lstPosition3" value='ALL' styles='width:100%' >
                               <data>
                                    <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm")%>|ALL|Select All
                                </data></gw:list>
                        </td>
                        <td  style="border:0"  width="10%" colspan=5 align="right" valign="middle">Search by</td>
					    <td  style="border:0" colspan=4 width="8%" >
					        <gw:list  id="lstTemp3" value="2" styles='width:100%'> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID</data> 
					        </gw:list>
				        </td>
                        <td width="8%" align=center  colspan=4 style="border:0" > 
					        <gw:textbox id="txtTemp3" onenterkey   ="OnSearch(datSalary3)" styles='width:95%'/>
				        </td>
                        <td width="2%" style="border:0;" align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch3"   alt="Search"  onclick="OnSearch(datSalary3)"/>
                        </td>
                        <td colspan=2 width="4%" style="border:0" align="right">
                         <gw:imgBtn img="excel" id="ibtnReport3"    alt="Report"  onclick="OnReport(3)"/>
                        </td>
                    </tr>
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td colspan=4 style="border:0;" align="right" ><b style="color:#cc0066; font-size:12">Year</b></td>
                        <td colspan=4 style="border:0;" align="left" ><gw:datebox id="dtYear3"  onchange="OnChangeMonth()" tyles="width:100%" type="year" lang="<%=Session("Lang")%>" /></td>
                        <td colspan=3 style="border:0;" align="right" ><b>Contract</b></td>
                        <td colspan=5 style="border:0;" align="left" >
                         <gw:list  id="lstContract_Type3" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0001' order by code_nm")%>|ALL|Select All</data></gw:list>
                        </td>
                        <td colspan=3 style="border:0"  align="right"><b>Status</b></td>
                        <td colspan=5 style="border:0"> 
					        <gw:list  id="lstStatus3" value='A' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0022' order by code_nm" )%>|ALL|Select All</data></gw:list>
                        </td>
                         <td colspan=3 style="border:0;" align="right" ><b>Join Date </b></td>
                        <td colspan=4 style="border:0;" align="left" ><gw:datebox id="dtFrom_JoinDate3" nullaccept styles="width:60%" lang="<%=Session("Lang")%>" /></td>
                        <td colspan=2 style="border:0;"  align="center" ><b>~</b></td>
                        <td colspan=4 style="border:0;"  align="left" >
                            <gw:datebox id="dtTo_JoinDate3" nullaccept styles="width:60%" lang="<%=Session("Lang")%>" />
                        </td>
                         <td align=center  colspan=4 style="border:0" >Money</td>
                         <td align=center  colspan=4 style="border:0" ><gw:list  id="lstMoney3" value='01' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0040' order by code_nm")%>|ALL|Select All</data></gw:list></td>
                       <td style="border:0" colspan=3 align="center" ><gw:label id="lblRecord3"  text="0 rec(s)" maxlen = "100" styles="color:red;width:100%;font-weight: bold;font-size:12" /></td>
                       
                       <td colspan=1 align="right" style="border:0" valign="bottom"><img status="min" id="img3" alt="Show more columns" src="../../../system/images/close_popup.gif" style="cursor:hand" onclick="OnToggle(3)"  /></td>
                    </tr>
                    <tr style="border:1;width:100%;height:85%" valign="top">
                        <td colspan=50  style="width:100%;height:100%;"> 
                             <gw:grid   
                                id="grdSalary3"  
                                header="Organization|W-Group|Emp ID|Full Name|Join Date|Contract Type|January|February|March|April|May|June|July|August|Septemper|October|November|December"
                                format="0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1"  
                                aligns="2|2|1|0|1|1|3|3|3|1|0|0|0|0|0|0|0|0"  
                                defaults="||||||||||||||||"  
                                editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
                                widths="1500|1600|1000|2500|1500|1700|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200"  
                                styles="width:100%; height:100%" 
                                sorting="T"   
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
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>

                       
 <gw:grid   
    id="grdAllowance"  
    header="Code Name 1|Code Name 2|Code Name 3|Code Name 4|Code Name 5|Code Name 6|Code Name 7|Code Name 8|Display 1|Display 2|Display 3|Display 4|Display 5|Display 6|Display 7|Display 7"
    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
    aligns="0|2|2|1|0|0|1|1|2|1|0|0|0|0|0|0"  
    defaults="||||||||||||||"  
    editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
    widths="0|1500|1600|1000|2500|1500|1700|1500|1700|1500|1500|1200|1200|1200|1200|1200"  
    styles="display:none" 
    sorting="T"    
/> 
</html>