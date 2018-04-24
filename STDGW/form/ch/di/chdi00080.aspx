﻿<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var startTime,interval_time
var dt_tmp
var opt_value=1
var arr_col    =new Array();
var binit_date = true;
var v_language = "<%=Session("SESSION_LANG")%>";
var aDate=new Array();
var numMonth;
var imp_seq;
var flag_add= false;
function BodyInit()
{
    idGrid.GetGridControl().ScrollTrack=true;
    idGrid.GetGridControl().FrozenCols =4;
    if (v_language!="ENG")
        System.Translate(document);	
          
      iduser_pk.text = "<%=session("USER_PK")%>";
      txtHr_level.text= "<%=session("HR_LEVEL")%>";
      menu_id.text=System.Menu.GetMenuID();
     SetGridHeader(idGrid)
     CreateGrid();

     ChangeColorItem(lstDept_Code.GetControl());
     ChangeColorItem(lstDept_Code1.GetControl());

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
//---------------------------------------------------
function OnShowPopup(n)
{
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:'+window.event.screenX +';dialogTop:'+window.event.screenY +';edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {
            if(n==1)
                lstDept_Code.value=obj;
            else   
                lstDept_Code1.value=obj; 
             
            // datDeptData.Call();
        }
}
//------------------------------------------------------------------------------------
function OnChangeDept()
{
    //txtDept.text=lstDept_Code.value;
    //datGroupData.Call();
}
//------------------------------------------------------------------------------------

//-------------------------------------------------
function SetGridHeader(obj)
{
    var stt;
    
    if (obj==idGrid)
    {
        var fg=obj.GetGridControl(); 	  
        if (binit_date==true)
        {
            fg.rows=fg.rows+1;
            //binit_date=false;
        }
        fg.FixedRows = 2;
        fg.FixCols=1;
        fg.MergeCells =5	;
        stt=0;//num column
        fg.MergeCol(stt) =true	;
        fg.Cell(0, 0, stt, 1, stt)  = "Emp ID";   //fg.Cell(0,row, from_col, row, to_col)	
        
        fg.MergeCol(stt+1) =true	;
        fg.Cell(0, 0, stt+1, 1, stt+1)  = "Emp Name";   //fg.Cell(0,row, from_col, row, to_col)	
        fg.MergeCol(stt+2) =true	;
        fg.Cell(0, 0, stt+2, 1, stt+2)  = "Section";   //fg.Cell(0,row, from_col, row, to_col)	
        fg.MergeCol(stt+3) =true	;
        fg.Cell(0, 0, stt+3, 1, stt+3)  = "Position";   //fg.Cell(0,row, from_col, row, to_col)	
        fg.MergeCol(stt+4) =true	;
        fg.Cell(0, 0, stt+4, 1, stt+4)  = "Basic Wage";   //fg.Cell(0,row, from_col, row, to_col)	
        fg.MergeCol(stt+5) =true	;
        fg.Cell(0, 0, stt+5, 1, stt+5)  = "Long Service";   //fg.Cell(0,row, from_col, row, to_col)	
        fg.MergeCol(stt+6) =true	;
        fg.Cell(0, 0, stt+6, 1, stt+6)  = "Insurance Salary";   //fg.Cell(0,row, from_col, row, to_col)	
        
        fg.MergeRow(0) =true	;
        fg.Cell(0, 0, stt+7, 0, stt+9)  = "Payment Employee";   //fg.Cell(0,row, from_col, row, to_col)	
        fg.Cell(0, 1, stt+7, 1, stt+7) = "Social";
        fg.Cell(0, 1, stt+8, 1, stt+8) = "Health";
        fg.Cell(0, 1, stt+9, 1, stt+9) = "Unemployee";
        
       fg.MergeRow(0) =true	;
        fg.Cell(0, 0, stt+10, 0, stt+12)  = "Payment Employer";   //fg.Cell(0,row, from_col, row, to_col)	
        fg.Cell(0, 1, stt+10, 1, stt+10) = "Social";
        fg.Cell(0, 1, stt+11, 1, stt+11) = "Health";
        fg.Cell(0, 1, stt+12, 1, stt+12) = "Unemployee";
        
           
        fg.MergeCol(stt+13) =true	;
        fg.Cell(0, 0, stt+13, 1, stt+13)  = "Total Payment";   //fg.Cell(0,row, from_col, row, to_col)	
        fg.MergeCol(stt+14) =true	;
        fg.Cell(0, 0, stt+14, 1, stt+14)  = "Total Payment";   //fg.Cell(0,row, from_col, row, to_col)	
        
        obj.SetCellBold(1,1,1,stt+14,true);
        //fg.Cell(0, 0, 1, 0) = "Department"
    }
    else
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
        stt=1;//num column
        fg.MergeCol(stt-1) =true	;
        fg.Cell(0, 0, stt, 1, stt-1)  = "PK";   //fg.Cell(0,row, from_col, row, to_col)	
        fg.MergeCol(stt) =true	;
        fg.Cell(0, 0, stt, 1, stt)  = "Emp ID";   //fg.Cell(0,row, from_col, row, to_col)	
        
        fg.MergeCol(stt+1) =true	;
        fg.Cell(0, 0, stt+1, 1, stt+1)  = "Emp Name";   //fg.Cell(0,row, from_col, row, to_col)	
        fg.MergeCol(stt+2) =true	;
        fg.Cell(0, 0, stt+2, 1, stt+2)  = "Section";   //fg.Cell(0,row, from_col, row, to_col)	
        fg.MergeCol(stt+3) =true	;
        fg.Cell(0, 0, stt+3, 1, stt+3)  = "Position";   //fg.Cell(0,row, from_col, row, to_col)	
        fg.MergeCol(stt+4) =true	;
        fg.Cell(0, 0, stt+4, 1, stt+4)  = "Sequence";   //fg.Cell(0,row, from_col, row, to_col)
        for (var i=0;i<numMonth;i++)
        {
            fg.MergeRow(0) =true	;
            fg.Cell(0, 0, stt+5 + 4*i, 0, stt+8 + 4*i)  = aDate[i].substr(4,2) + "/" + aDate[i].substr(0,4);   //fg.Cell(0,row, from_col, row, to_col)	
            fg.Cell(0, 1, stt+5 + 4*i, 1, stt+5 + 4*i) = "Basic";
            fg.Cell(0, 1, stt+6 + 4*i, 1, stt+6 + 4*i) = "Social";
            fg.Cell(0, 1, stt+7 + 4*i, 1, stt+7 + 4*i) = "Health";
            fg.Cell(0, 1, stt+8+ 4*i , 1, stt+8 + 4*i) = "Unemp";
        }
     
        obj.SetCellBold(0,1,1,5 + 4*numMonth,true);
    }
   
}

function OnDataReceive(obj)
{
       if(obj.id == "datCheck_View")
       {
            if(txtFlag_View.text == 'Y')
            {
                ibtnSave.style.display = "none";
                ibtnDel.style.display = "none";


                btnSave.style.display = "none";
                btnAdd.style.display = "none";
                ibtnSave_Imp.style.display = "none";
                ibtnProcess_Imp.style.display = "none";
            }
            if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	        {
                datUser_info.Call();     	    
	        }
            
       }
       else if (obj.id=="datUser_info")
       {
            lstDept_Code.SetDataText(txtDeptData.text);
            lstDept_Code1.SetDataText(txtDeptData.text);
            
            ChangeColorItem(lstDept_Code.GetControl());
            ChangeColorItem(lstDept_Code1.GetControl());

            onChange_org(3,lstDept_Code);
       }
       else if (obj.id=="datIns_Month")
       {
            idRecord.text=idGrid.rows-2+" Rec(s)";
            SetGridHeader(idGrid)
            datGetInformation.Call(); 
            //auto_resize_column(grdEmployee,0,grdEmployee.cols-1,9);    
            auto_resize_column(idGrid,0,idGrid.cols-1,9);
       }
       
       else if (obj.id=="datFind_Report")
       {
            var url;
            if (tabMain.GetCurrentPageNo()==0)
                url =System.RootURL + '/reports/ch/di/'+txtReport_tmp.text+'?l_rpt_month=' + idWorkMon.value + '&l_tco_org=' + lstDept_Code.value+ '&l_work_group='+lstGrp_Code.value +'&l_search='+idSearch.value+'&l_temp='+idtxtTmp.text +'&p_include='+ lstInclude.value +'&p_nation='+ lstNation.value ;
            else
                url =System.RootURL + '/reports/ch/di/'+txtReport_tmp.text+'?l_rpt_from_month=' + dtFromMonth.value + '&l_rpt_to_month=' + dtToMonth.value + '&l_tco_org=' + lstDept_Code1.value+ '&l_work_group='+lstGrp_Code1.value +'&l_search='+idSearch1.value+'&l_temp='+idtxtTmp1.text +'&p_include='+ lstInclude.value +'&p_nation='+ lstNation.value ;
            window.open(url);    
       }
       else if (obj.id=="datIns_Month_Sum")
       {
            SetGridHeader(idGrid1);
            //idGrid1.GetGridControl().ColHidden(2)=false;
            //idGrid1.GetGridControl().ColHidden(3)=false;
            idRecord1.text=idGrid1.rows-2+" Rec(s)";
            auto_resize_column(idGrid1,0,idGrid1.cols-1,9);
//            for(var i=0; i<numMonth; i++)
//            {  
//                var color =(i%2)?0xBAEDD3:0xFFEEFF;
//                idGrid1.SetCellBgColor(2,6+4*i,idGrid1.rows -1 ,10+4*i,color);
//               
//            }
       }
       else if (obj.id=="datInsMonth1"||obj.id=="datInsMonth2"||obj.id=="datInsMonth3"||obj.id=="datInsMonth4"||obj.id=="datInsMonth5"||obj.id=="datInsMonth6")
       {
            SetGridHeader(idGrid1);
            idGrid1.GetGridControl().ColHidden(2)=false;
           // idGrid1.GetGridControl().ColHidden(3)=false;
            idRecord1.text=idGrid1.rows-2+" Rec(s)";
            auto_resize_column(idGrid1,0,idGrid1.cols-1,9);
            for(var i=0; i<numMonth; i++)
            {
                var color =(i%2)?0xBAEDD3:0xFFEEFF;
                idGrid1.SetCellBgColor(2,6+4*i,idGrid1.rows -1 ,10+4*i,color);
               
            }
       }
       else if(obj.id == "datGetInformation")
       {
           
       }
       else if(obj.id =="datWorkGroup_info")
        {
            if(flag_tab =="1")
            {
		        lstGrp_Code.SetDataText(txtwg_tmp.text + "|ALL|Select All");
		        lstGrp_Code.value="ALL";

            }
            else if(flag_tab =="2")
            {
                lstGrp_Code1.SetDataText(txtwg_tmp.text + "|ALL|Select All");
		        lstGrp_Code1.value="ALL";
           
            }
            else if(flag_tab =="3")
            {
                lstGrp_Code.SetDataText(txtwg_tmp.text + "|ALL|Select All");
		        lstGrp_Code.value="ALL";
                lstGrp_Code1.SetDataText(txtwg_tmp.text + "|ALL|Select All");
		        lstGrp_Code1.value="ALL";
            }
            //datOrg_Company.Call();
        }
	   else if(obj.id =="datOrg_Company")
       {
           
       }
}     
function SetColRow()
{
    idGrid.SetCellBgColor(1,5,idGrid.rows -1 ,7,0xFFEEFF);
    idGrid.SetCellBgColor(1,12,idGrid.rows -1 ,13,0xFFEEFF);
    idGrid.SetCellBgColor(1,15,idGrid.rows -1 ,15,0xFFEEFF);
    idGrid.SetCellBgColor(1,20,idGrid.rows -1 ,21,0xFFEEFF);
    
}
//------------------------------------------------------------------------------------
function OnSearch(iact)
{
    if (iact==1)
        datIns_Month.Call("SELECT");  
    else
    {
        datIns_Month_Sum.Call("SELECT");
    }
  
}

function onchange_month()
{
    datGetInformation.Call();
}
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
/*
function on_click_grid()
{
    arr_col[event.col]=idGrid.GetGridData(event.row,event.col);
    
}*/
//--------------------------------
function OnPrint(obj)
{
    if (obj==0)
        txtReport_tmp.text="rpt_insurance_month_new.aspx";
    else if (obj==1)
        txtReport_tmp.text="rpt_insurance_month_sum.aspx";
    else if(obj==2)
        txtReport_tmp.text="rpt_template_ins_sum.aspx";
	datFind_Report.Call();
    
}
//-------------------------
function MapDate()
{
    var dFrom,dTo,i,nDate;
    dFrom=dtFromMonth.value;
    dTo=dtToMonth.value;
    numMonth=0;
    for (nDate=dFrom;nDate<=dTo;nDate=AddMonths(nDate,1))
    {
        
        aDate[numMonth]=nDate;
        numMonth=numMonth+1;
    }
    
    
}
//----------------------------------------
function CreateGrid()
{
    MapDate();
    var sHeader="_PK|EMP_ID|FULL_NAME|_MONTH_FROM|_MONTH_TO|_SEQUENCE" //SECTION & POSITION luu tam gia tri from month an to month khi add
    var sFormat="0|0|0|0|0|0"
    var sWidth="0|1000|1000|1000|1000|1000"
    var sAlign="0|1|0|0|0|0"
   for (var i=0;i<numMonth;i++)
   {
        sHeader=sHeader + "|Basic"  + i + "|Social"  + i + "|Health" + i + "|UnEmp" + i ;
        sFormat=sFormat + "|-0|-0|-0|-0";
        sWidth=sWidth + "|1000|1000|1000|1000";
        sAlign=sAlign + "|1|1|1|1";
   }     
   
   idGrid1.setHeader(sHeader);
   idGrid1.setFormat(sFormat);
   idGrid1.setWidth(sWidth);
   idGrid1.setAlign(sAlign);
   for (var i=1;i<numMonth;i++)
        idGrid1.GetGridControl().ColHidden(10 +4*(i-1))=false;
   SetGridHeader(idGrid1);
   if (imgMaster.status == "collapse" )
        OnToggle();

   if(idGrid1.rows>1)
   {
        
        for(var i=2; i<idGrid1.rows; i++)
           {
                if(idGrid1.GetGridData(i,0)=="")
                {
                    idGrid1.SetGridText(i,3,dtFromMonth.value) ;
                    idGrid1.SetGridText(i,4,dtToMonth.value) ;
                }
           }
   }
   
}
function AddMonths(yyyymm,imonth)
{
    var syear=Number(yyyymm.substr(0,4));
    var smonth=Number(yyyymm.substr(4,2));
    smonth=smonth+1;
    if (smonth>12)
    {
        smonth=smonth-12;
        syear=syear+1
    }
    return String(syear) + addZero(smonth);
}
//-----------------------------
function addZero(num)//9=09
{
    if(Number(num)<10)
    {
	   return '0' + num;
	}
	else
	{
	   return  '' + num;
	}
 } 
 //------------------------------------------
function Hide_Col(objflag)
{
   for (var i=0;i<numMonth;i++)
   {
        idGrid1.GetGridControl().ColHidden(3 +4*(i+1))=objflag;
        idGrid1.GetGridControl().ColHidden(4 +4*(i+1))=objflag;
        idGrid1.GetGridControl().ColHidden(5 +4*(i+1))=objflag;
        
   }     
   
}

//----------------------------------------------

function OnToggle()
{
        if(imgMaster.status == "expand")
        {
            imgMaster.status = "collapse";
			Hide_Col(true);
            imgMaster.src = "../../../system/images/iconmaximize.gif";
			imgMaster.alt="UnHide Col";
			
        }
        else
        {
            imgMaster.status = "expand";
            Hide_Col(false);
            imgMaster.src = "../../../system/images/close_popup.gif";
			imgMaster.alt="Hide Col";
			
        }
}
function CheckValidFile(vfile)
{
    var sext1,sext2;
    sext1=vfile.substring(vfile.length-4,vfile.length);
    sext2=vfile.substring(vfile.length-5,vfile.length);
    if (sext1!=".xls" && sext2!=".xlsx")
        return false;
    return true;
}
//------------------------------
function OnLoadExcel()
{
    var cnt;
    cnt=true;
    var save_no = new Date().getTime();
	if (numMonth!=6)
    {
        alert("Please select six month to import! \n Vui lòng chọn 6 tháng để tải dữ liệu!");
        return;
    }
     
    idGrid1.ClearData();
    var myApp = new ActiveXObject("Excel.Application");     
    var vfilename = document.all["inputfile"].value;    
   if (!CheckValidFile(vfilename) || vfilename =="")
    {
        alert("Please select excel file");
        return;
    }
    try
    {
        if (imgMaster.status == "expand" )
            OnToggle();
        lstDept_Code1.value="ALL";
        lstGrp_Code1.value="ALL";
        idtxtTmp1.text="";
        myApp.Workbooks.Open(vfilename); 
        var workSheet = myApp.ActiveSheet; 
        var vemp_id,vemp_name, vadj_date, vtax_yn, vnote;
        var maxRow =workSheet.UsedRange.Rows.Count;    
        var maxCol =workSheet.UsedRange.Columns.Count; 
        for (var j =4;j <=maxRow; j++) 
        { 
            vemp_id=workSheet.Cells(j,1).value;                        
            vemp_name=workSheet.Cells(j,2).value;
            if (vemp_id=="" )
            {   
                alert("Please input card id at row " + j);
                return;
            }
            idGrid1.AddRow();
            var irow=idGrid1.rows-1;
            idGrid1.SetGridText(irow,1,vemp_id);
            idGrid1.SetGridText(irow,2,vemp_name);
            
            idGrid1.GetGridControl().ColHidden(3)=true;
            idGrid1.GetGridControl().ColHidden(4)=true;
            idGrid1.GetGridControl().ColHidden(5)=true;
            idGrid1.SetGridText(irow,3,dtFromMonth.value);
            idGrid1.SetGridText(irow,4,dtToMonth.value);

            idGrid1.SetGridText(irow,5,save_no) // luu sequence
            for (var cl=0;cl<numMonth;cl++)
            {
                if (cl+3<=maxCol)
                    v_sal=workSheet.Cells(j,cl+3).value;
                else
                    v_sal="#N/A";
                idGrid1.SetGridText(irow,6 + cl*4,v_sal);
            }

            txtSequence.text = save_no;
        } 
        auto_resize_column(idGrid1,0,idGrid1.cols-1,0);
        myApp.Quit();
    }
    catch(e)
    {
        alert("Could not read Excel File. (or) Excel was not installed in the machine you are using or it has incompatible version?"); 
        myApp.Quit();
    }
        
    
}

function OnSave(obj)
{
   
    if (confirm("Do you want to save?"))
    if(obj=="1")
            datIns_Month_Sum_Imp.Call(); // import from excel
    else if(obj=="2")
    {
        if(numMonth=="1")
            datInsMonth1.Call();
        else if(numMonth == "2")
            datInsMonth2.Call();
        else if(numMonth == "3")
            datInsMonth3.Call();
        else if(numMonth == "4")
            datInsMonth4.Call();
        else if(numMonth == "5")
            datInsMonth5.Call();
        else if(numMonth == "6")
            datInsMonth6.Call();
    }       
}
//----------------------------------------------------
function OnAdd()
{
   
    ctrl =idGrid1.GetGridControl();
    if(ctrl.rows>1)
    { 
        for(var j=1; j<ctrl.rows-1; j++)
        {
           if(idGrid1.GetGridData(j,0)!="")
           {
                idGrid1.RemoveRowAt(j);
                j--;
           }
        }
        idRecord.text = "0 (recs)";
    }
     CreateGrid();
    if (imgMaster.status == "expand" )
        OnToggle();
    var rowid,k,tmp;
	var url = "/form/ch/di/chdi00080_add_emp.aspx";
	var aData=new Array();
	aData = System.OpenModal( System.RootURL + url , 900 , 600 , 'resizable:yes;status:yes') ;
	if ( aData != null )
	{  	 
		var len=aData.length;
		var i;
        var save_no = new Date().getTime();
		for (i=0;i<len;i++)		
		{
	            idGrid1.AddRow();
		        var irow=idGrid1.rows-1;
		        aRow=aData[i];
		        
		        idGrid1.SetGridText(irow,1,aRow[0]);		// emp_id
		        idGrid1.SetGridText(irow,2,aRow[1]);		// full_name
                idGrid1.SetGridText(irow,3,dtFromMonth.value);		// from
                idGrid1.SetGridText(irow,4,dtToMonth.value);		// end
		        idGrid1.SetGridText(irow,5,save_no) // luu sequence    
		}
        txtSequence.text = save_no;
        auto_resize_column(idGrid1,0,idGrid1.cols-1,0);
        flag_add = true;
	}	


}
function OnUpdate()
{
    if (confirm("Do you want to save?"))
        datIns_Month.Call();
}
function OnDelete()
{
    if (confirm("Do you want to delete?"))
    idGrid.DeleteRow();
}
function onChange_org(tab,obj)
{
	flag_tab=tab;
	txtorg_tmp.text=obj.value;
	datWorkGroup_info.Call();
}
</script>

<body>
<!-----------------Get ID company theo Organization ------------------------>
<gw:data id="datCheck_View" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="process" procedure="sp_pro_check_view"  > 
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
<gw:data id="datOrg_Company" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="sp_pro_get_company" > 
                <input>
                    <input bind="txtorg_tmp" /> 
                </input> 
                <output>
                    <output bind="txtCompany_PK" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------main control---------------------->
<gw:data id="datWorkGroup_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_sel_wg_role"  > 
                <input>
                    <input bind="txtorg_tmp" />
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
                    <output bind="txtDeptData" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datGetInformation" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_sp_pro_ins_mon_info" > 
                <input>
                    <input bind="idWorkMon" /> 
                    <input bind="lstDept_Code" />
                    <input bind="lstGrp_Code" />
                </input> 
                <output>
                    <output bind="idEmployees" />
                    <output bind="idAmount" />
                    <output bind="txtMonth_flag" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------>
<gw:data id="datFind_Report" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sp_pro_find_report" > 
                <input>
                    <input bind="txtReport_tmp" /> 
                </input> 
                <output>
                    <output bind="txtReport_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datIns_Month" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"   parameter="6,14" function="HR_SEL_10040008" procedure="HR_UPD_10040008" > 
                <input bind="idGrid" >
                    <input bind="idWorkMon" /> 
                    <input bind="lstDept_Code" />
                    <input bind="lstGrp_Code" />
                    <input bind="idSearch" />
                    <input bind="idtxtTmp" />
					<input bind="lstNation" />
					<input bind="lstInclude" />
                    <input bind="lstImport" />
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datIns_Month_Sum" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="1,3,4,5,6,10,14,18,22,26" function="HR_SEL_10040008_1" procedure="HR_UPD_10040008_1" > 
                <input bind="idGrid1" >
                    <input bind="dtFromMonth" /> 
                    <input bind="dtToMonth" /> 
                    <input bind="lstDept_Code1" />
                    <input bind="lstGrp_Code1" />
                    <input bind="idSearch1" />
                    <input bind="idtxtTmp1" />
                </input>
                <output  bind="idGrid1" />
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datIns_Month_Sum_Imp" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="1,3,4,5,6,10,14,18,22,26" function="HR_SEL_10040008_2" procedure="HR_UPD_10040008_1" >
                <input bind="idGrid1" >
                    <input bind="dtFromMonth" /> 
                    <input bind="dtToMonth" /> 
                    <input bind="txtSequence" />
                </input>
                <output  bind="idGrid1" />
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datInsMonth1" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="1,3,4,5,6" function="HR_SEL_10040008_2" procedure="HR_UPD_10040008_2" > 
                <input bind="idGrid1" >
                    <input bind="dtFromMonth" /> 
                    <input bind="dtToMonth" />
                    <input bind="txtSequence" /> 
                </input>
                <output  bind="idGrid1" />
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datInsMonth2" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="1,3,4,5,6,10" function="HR_SEL_10040008_2" procedure="HR_UPD_10040008_3" > 
                <input bind="idGrid1" >
                    <input bind="dtFromMonth" /> 
                    <input bind="dtToMonth" />
                    <input bind="txtSequence" /> 
                </input>
                <output  bind="idGrid1" />
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datInsMonth3" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="1,3,4,5,6,10,14" function="HR_SEL_10040008_2" procedure="HR_UPD_10040008_4" > 
                <input bind="idGrid1" >
                    <input bind="dtFromMonth" /> 
                    <input bind="dtToMonth" />
                    <input bind="txtSequence" /> 
                </input>
                <output  bind="idGrid1" />
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datInsMonth4" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="1,3,4,5,6,10,14,18" function="HR_SEL_10040008_2" procedure="HR_UPD_10040008_5" > 
                <input bind="idGrid1" >
                    <input bind="dtFromMonth" /> 
                    <input bind="dtToMonth" />
                    <input bind="txtSequence" /> 
                </input>
                <output  bind="idGrid1" />
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datInsMonth5" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="1,3,4,5,6,10,14,18,22" function="HR_SEL_10040008_2" procedure="HR_UPD_10040008_6" > 
                <input bind="idGrid1" >
                    <input bind="dtFromMonth" /> 
                    <input bind="dtToMonth" />
                    <input bind="txtSequence" /> 
                </input>
                <output  bind="idGrid1" />
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datInsMonth6" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="1,3,4,5,6,10,14,18,22,26" function="HR_SEL_10040008_2" procedure="HR_UPD_10040008_7" > 
                <input bind="idGrid1" >
                    <input bind="dtFromMonth" /> 
                    <input bind="dtToMonth" />
                    <input bind="txtSequence" /> 
                </input>
                <output  bind="idGrid1" />
            </dso> 
        </xml> 
</gw:data>
<gw:tab id="tabMain"  border=1 style="width:100%;height:100%;" >
<table name="Detail" style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
    <tr  style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1">
        <td>
	        <table style="width:100%;height:10%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
	        <tr style="height:7%;border:1">	
		        <td align=right style="width:5%;border:1" ><b>Month</b></td>
		        <td align=right style="width:10%;border:1"><gw:datebox id="idWorkMon" lang="<%=Session("Lang")%>"  onchange="onchange_month()" type=month></gw:datebox></td>
		        <td align=right style="width:10%;border:0" ><a title="Click here to show Organization" onclick="OnShowPopup(1)" href="#tips" ><b>Organization</b></a></td>
		        <td align=right style="width:20%;border:0"><gw:list  id="lstDept_Code"  value="ALL" styles='width:100%' onchange="onChange_org(1,lstDept_Code)" >
                        <data>
                            <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                        </data>
                    </gw:list>
                </td>
		        <td align=right style="width:5%;border:0"><b>WorkGroup</b></td>
		        <td  align=right style="width:15%;border:0" ><gw:list  id="lstGrp_Code"  value="ALL" styles='width:100%' >
                       <data><%=ESysLib.SetListDataSQL("SELECT pk,workGroup_NM FROM Thr_work_Group WHERE DEL_IF = 0  order by workGroup_NM")%>|ALL|Select All</data>
                       </gw:list>
                </td>
		        <td align=right style="width:5%;border:0"><b>Search</b></td>
		        <td  align=right style="width:10%;border:0"><gw:list  id="idSearch" value="1" styles='width:100%' onChange="">
                        <data>|1|Emp ID|2|Card ID|3|Name</data></gw:list>
                </td>
		        <td  align=right style="width:10%;border:0"><gw:textbox id="idtxtTmp" maxlen = "50" styles="width:98%" onenterkey="OnSearch(1)" /></td>
		        <td align=right style="width:1%;border:0"><gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="Search" onclick="OnSearch(1)" /></td>
		        <td align=right style="width:1%;border:0"><gw:imgBtn id="ibtnSave" alt="Save" img="save" text="Save" onclick="OnUpdate()" /></td>
		        <td align=right style="width:1%;border:0"><gw:imgBtn id="ibtnDel" alt="Delete" img="delete" text="Save" onclick="OnDelete()" /></td>
		        <td  align=right style="width:1%;border:0" ><gw:imgBtn id="ibtnRpt" alt="Report" img="excel" text="Report" onclick="OnPrint(0)" /></td>
            </tr>	
			<tr style="height:7%;border:1">	
		        <td align=right style="width:5%;border:1" ><b>Nation</b></td>
		        <td align=right style="width:10%;border:1"><gw:list  id="lstNation"  value="ALL" styles='width:100%'  >
                        <data>
                            |01|Việt Nam|02|Korean|ALL|Select All
                        </data>
                    </gw:list></td>
		        <td align=right style="width:10%;border:0" ><b>Include</b></td>
		        <td align=right style="width:20%;border:0"><gw:list  id="lstInclude"  value="1" styles='width:100%'  >
                        <data>
							|1| |2|Giảm lao động bị trừ tiền thẻ
                        </data>
                    </gw:list>
                </td>
		        <td align=right style="width:5%;border:0"><b>Import YN</b></td>
		        <td  align=right style="width:15%;border:0">
                    <gw:list  id="lstImport"  value="ALL" styles='width:100%'  >
                        <data>
                            |Y|Yes|N|No|ALL|Select All
                        </data>
                    </gw:list>
                </td>
		        <td align=right style="width:5%;border:0"><b></b></td>
		        <td  align=right style="width:10%;border:0">
                </td>
		        <td  align=right style="width:10%;border:0"></td>
		        <td align=right style="width:1%;border:0"></td>
		        <td align=right style="width:1%;border:0"></td>
		        <td align=right style="width:1%;border:0"></td>
		        <td  align=right style="width:1%;border:0" ></td>
            </tr>	
            <tr style="height:7%;border:1">	
		        <td  colspan=2 align=right style="border:0"><b>Employee(s)</b></td>
                <td  colspan=2 align=left style="border:0"><b style="color=#FF3300"><gw:label id="idEmployees" text="" styles="width:100%" ></gw:label></b></td>
		        <td align=right style="border:0"><b>Amount</b></td>
		        <td colspan=2 align=left style="border:0"><b style="color=#FF3300"><gw:label id="idAmount" text="" styles="width:100%" ></gw:label></b></td>
		         <td colspan=3 align=left style="border:0" ><b style="color=#FF3300"><gw:label id="idRecord" text="" styles="color:red;width:100%;font-weight: bold;font-size:12" ></gw:label></b></td>
		        <td  align=right style="border:0"></td>     
            </tr>	
	        </table>
	        <table id="tbl" style="width:100%;height:86%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
		        <tr style="height:100%">
			        <td id="master" width="100%">
				        <gw:grid id='idGrid'
                            header='EMP_ID|FULL_NAME|SECTION|POSTION|_BASIC_WAGE|_LONG_SERVICE|TOTAL_SALARY|SOCIAL_5%|HEALTH_1%|UNEMPLOYEE_1%|SOCIAL_20%|HEALTH_2%|UNEMPLOYEE_1%|TOTAL_PAYMENT|_INS_PK'
                            format='0|0|0|0|0|0|-0|-0|-0|-0|-0|-0|-0|-0|-0'
                            aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                            defaults='||||||||||||||'
                            editcol='0|0|0|0|0|0|1|0|0|0|0|0|0|0|0'
                            widths='1000|3000|2000|1500|0|0|2000|1500|1500|1500|1500|1500|1500|2000|0'
                            sorting='T'
                            styles='width:100%; height:100%'
                            />
			        </td>
		        </tr>	
	        </table>
	    </td>
	</tr>
</table>
<table name="Summary" style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
    <tr  style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1">
        <td>
	        <table style="width:100%;height:10%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
	        <tr style="height:5%;border:1">	
		        <td align=right style="width:5%;border:1" ><b>Month</b></td>
		        <td align=right style="width:10%;border:1"><gw:datebox id="dtFromMonth" lang="<%=Session("Lang")%>" type="month" onchange="CreateGrid()"></gw:datebox></td>
		        <td align=right style="width:1%;border:1"><b>~</b></td>
		        <td align=right style="width:10%;border:1"><gw:datebox id="dtToMonth" lang="<%=Session("Lang")%>" type="month" onchange="CreateGrid()"></gw:datebox></td>
		        <td align=right style="width:10%;border:0" ><a title="Click here to show Organization" onclick="OnShowPopup(2)" href="#tips" ><b>Organization</b></a></td>
		        <td align=right style="width:15%;border:0"><gw:list  id="lstDept_Code1"  value="ALL" styles='width:100%' onchange="onChange_org(2,lstDept_Code1)" >
                        <data>
                            <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                        </data>
                    </gw:list>
                </td>
		        <td align=right style="width:7%;border:0" colspan=2><b>WorkGroup</b></td>
		        <td  align=right style="width:13%;border:0"><gw:list  id="lstGrp_Code1"  value="ALL" styles='width:100%' >
                       <data><%=ESysLib.SetListDataSQL("SELECT pk,workGroup_NM FROM Thr_work_Group WHERE DEL_IF = 0  order by workGroup_NM")%>|ALL|Select All</data>
                       </gw:list>
                </td>
		        <td align=right style="width:5%;border:0"><b>Search</b></td>
		        <td  align=right style="width:6%;border:0"><gw:list  id="idSearch1" value="1" styles='width:100%' onChange="">
                        <data>|1|Emp ID|2|Card ID|3|Name</data></gw:list>
                </td>
		        <td  align=right style="width:9%;border:0"><gw:textbox id="idtxtTmp1" maxlen = "50" styles="width:98%" onenterkey="OnSearch(2)" /></td>
		        <td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnSearch1" alt="Search" img="search" text="Search" onclick="OnSearch(2)" /></td>
		        <td align=right style="width:3%;border:0"><gw:imgbtn id="btnAdd" img="new" alt="Add" onclick="OnAdd()" /></td>
		        <td align=right style="width:3%;border:0"><gw:imgbtn id="btnSave" img="save" alt="Save" onclick="OnSave(2)" /></td>
		        <td align=right style="width:3%;border:0"></td>
            </tr>	
            <tr>
                 <td align=right style="border:0" colspan=2  ><b>Excel File</b></td>
                 <td align=left style="border:0" colspan=4><input id="inputfile" type="file" size="60"  accept="application/msexcel"  ></td>
                 <td align=left style="border:0" ><gw:imgBtn id="ibtnSampleRpt" alt="Sample file" img="excel" text="Report" onclick="OnPrint(2)" /></td>
                 <td align=left style="border:0" style="text-align:left">
                    <gw:imgBtn img="process" id="ibtnProcess_Imp"   alt="Insert from Excell"  onclick="OnLoadExcel()"/>
                 </td> 
                 <td align=left style="border:0" style="text-align:left">
                    <gw:imgBtn img="save" id="ibtnSave_Imp"   alt="Save"  onclick="OnSave(1)"/>
                 </td> 
                <td align=right colspan=3 style="border:0"><b style="color=#FF3300"><gw:label id="idRecord1" text="" styles="color:red;width:100%;font-weight: bold;font-size:12" ></gw:label></b>
                </td>
                <td align=right colspan=1 style="border:0">
                
                </td>
                 <td align=right colspan=1 style="border:0">
                    <gw:imgBtn id="ibtnRpt1" alt="Report Month Summary" img="excel" text="Report" onclick="OnPrint(1)" />
                </td>
                 <td align=right colspan=1 style="border:0">
                <img status="collapse" id="imgMaster" alt="Show Detail Items" src="../../../system/images/iconmaximize.gif" style="cursor:hand" onclick="OnToggle()"  />
                </td>
            </tr>
            
	        </table>
	        <table id="Table1" style="width:100%;height:90%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
		        <tr style="height:100%">
			        <td id="Td1" width="100%">
				        <gw:grid id='idGrid1'
                            sorting='T'
                            styles='width:100%; height:100%'
                            />
			        </td>
		        </tr>	
        		
	        </table>
	    </td>
	</tr>
</table>
</gw:tab>
	<gw:textbox id="txtMonth_flag" styles="display:none"/>
    <gw:textbox id="txtDeptData" styles="display:none"/>
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtGroupData" styles="display:none"/>
    <gw:textbox id="iduser_pk" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
    <gw:textbox id="txtReport_tmp" styles="display:none"/>
    <gw:textbox id="txtSequence" styles="display:none"/>
	
    <gw:textbox id="txtorg_tmp" styles="display:none"/>
    <gw:textbox id="txtwg_tmp" styles="display:none"/>

    <gw:textbox id="txtCompany_PK" styles="display:none"/>
    <gw:textbox id="txtOrg_Temp" styles="display:none"/>
    <gw:textbox id="menu_id" text="" styles="display:none"  />
    <gw:textbox id="txtFlag_View" text="" styles="display:none"  /> 

</body>
</html>

