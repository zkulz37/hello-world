<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser("hr")%>

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
function BodyInit()
{
    idGrid.GetGridControl().ScrollTrack=true;
    idGrid.GetGridControl().FrozenCols =4;
    if (v_language!="ENG")
        System.Translate(document);	
          
      iduser_pk.text = "<%=session("USER_PK")%>";
      txtHr_level.text= "<%=session("HR_LEVEL")%>";
     SetGridHeader(idGrid)
     CreateGrid();
	
}

//---------------------------------------------------
function OnShowPopup()
{
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:'+window.event.screenX +';dialogTop:'+window.event.screenY +';edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {lstDept_Code.value=obj;
             txtUpperDept.text=obj;
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
        fg.Cell(0, 0, stt+6, 1, stt+6)  = "Total Salary";   //fg.Cell(0,row, from_col, row, to_col)	
        
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
        stt=0;//num column
        fg.MergeCol(stt) =true	;
        fg.Cell(0, 0, stt, 1, stt)  = "Emp ID";   //fg.Cell(0,row, from_col, row, to_col)	
        
        fg.MergeCol(stt+1) =true	;
        fg.Cell(0, 0, stt+1, 1, stt+1)  = "Emp Name";   //fg.Cell(0,row, from_col, row, to_col)	
        fg.MergeCol(stt+2) =true	;
        fg.Cell(0, 0, stt+2, 1, stt+2)  = "Section";   //fg.Cell(0,row, from_col, row, to_col)	
        fg.MergeCol(stt+3) =true	;
        fg.Cell(0, 0, stt+3, 1, stt+3)  = "Position";   //fg.Cell(0,row, from_col, row, to_col)	
        
        for (var i=0;i<numMonth;i++)
        {
            fg.MergeRow(0) =true	;
            fg.Cell(0, 0, stt+4 + 4*i, 0, stt+7 + 4*i)  = aDate[i].substr(4,2) + "/" + aDate[i].substr(0,4);   //fg.Cell(0,row, from_col, row, to_col)	
            fg.Cell(0, 1, stt+4 + 4*i, 1, stt+4 + 4*i) = "Basic";
            fg.Cell(0, 1, stt+5 + 4*i, 1, stt+5 + 4*i) = "Social";
            fg.Cell(0, 1, stt+6 + 4*i, 1, stt+ 6+ 4*i) = "Health";
            fg.Cell(0, 1, stt+7+ 4*i , 1, stt+7 + 4*i) = "Unemp";
        }
     
        obj.SetCellBold(0,1,1,3 + 4*numMonth,true);
    }
   
}

function OnDataReceive(obj)
{
         if (obj.id=="datDeptData")
       {
            if(txtHr_level.text=="6")
                txtDeptData.text=txtDeptData.text+"|ALL|Select All";
            lstDept_Code.SetDataText(txtDeptData.text)    ;
            
              obj=lstDept_Code.GetControl()
		    if (obj.options.length ==2)
			    obj.options.selectedIndex=0;
		    else
			    obj.options.selectedIndex=0;
            datGroupData.Call();
       }
       else if (obj.id=="datGroupData")
       {
            lstGrp_Code.SetDataText(txtGroupData.text);
            var obj=lstGrp_Code.GetControl()
		    if (obj.options.length ==2)
			    obj.options.selectedIndex=0;
		    else
			    obj.options.selectedIndex=obj.options.length-1;
			
			datGetInformation.Call(); 
       }
       else if (obj.id=="datUser_info")
       {
            datGroupData.Call();
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
                url =System.RootURL + '/reports/ch/di/'+txtReport_tmp.text+'?l_rpt_month=' + idWorkMon.value + '&l_tco_org=' + lstDept_Code.value+ '&l_work_group='+lstGrp_Code.value +'&l_serach='+idSearch.value+'&l_temp='+idtxtTmp.text +'&p_include='+ lstInclude.value +'&p_nation='+ lstNation.value ;
            else
                url =System.RootURL + '/reports/ch/di/'+txtReport_tmp.text+'?l_rpt_from_month=' + dtFromMonth.value + '&l_rpt_to_month=' + dtToMonth.value + '&l_tco_org=' + lstDept_Code1.value+ '&l_work_group='+lstGrp_Code1.value +'&l_search='+idSearch1.value+'&l_temp='+idtxtTmp1.text +'&p_include='+ lstInclude.value +'&p_nation='+ lstNation.value ;
            window.open(url);    
       }
       else if (obj.id=="datIns_Month_Sum")
       {
            SetGridHeader(idGrid1);
            idRecord1.text=idGrid1.rows-2+" Rec(s)";
            auto_resize_column(idGrid1,0,idGrid1.cols-1,9);
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
        //CreateGrid();
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
                txtReport_tmp.text="rpt_insurance_month.aspx";
            else if (obj==1)
                txtReport_tmp.text="rpt_insurance_month_sum.aspx";
            else if(obj==2)
                txtReport_tmp.text="rpt_template_ins_sum.aspx";
			else if(obj==3)
				{
					var mon1 = dtFromMonth.value;
					var mon2 = dtToMonth.value;
					if( mon1.substr(0,4) == mon2.substr(0,4))
					{
						var url =System.RootURL + '/reports/ch/di/rpt_insurance_year_sum_vhpc.aspx?p_year='+ mon2.substr(0,4) ;
						window.open(url); 
						return;
					}
					else
					
					{
						alert("You have to choose in year!\n Bạn phải chọn tháng trong cùng năm");
						return;
					}
				}
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
    var sHeader="EMP_ID|FULL_NAME|SECTION|POSTION"
    var sFormat="0|0|0|0"
    var sWidth="1000|1000|1000|1000"
    var sAlign="1|0|0|0"
   for (var i=0;i<numMonth;i++)
   {
        sHeader=sHeader + "|Basic"  + i + "|Social"  + i + "|Health" + i + "|UnEmp" + i ;
        sFormat=sFormat + "|1|1|1|1";
        sWidth=sWidth + "|1000|1000|1000|1000";
        sAlign=sAlign + "|1|1|1|1";
   }     
   
   idGrid1.setHeader(sHeader);
   idGrid1.setFormat(sFormat);
   idGrid1.setWidth(sWidth);
   idGrid1.setAlign(sAlign);
   SetGridHeader(idGrid1);
   
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
//------------------------------
function OnLoadExcel()
{
    var cnt;
    cnt=true;
    
        idGrid.ClearData();
        var myApp = new ActiveXObject("Excel.Application");     
        var vfilename = document.all["inputfile"].value;    
       /*if (!CheckValidFile(vfilename) || vfilename =="")
        {
            alert("Please select excel file");
            return;
        }
        try
        {
            myApp.Workbooks.Open(vfilename); 
            var workSheet = myApp.ActiveSheet; 
            var vemp_id,vtotal, vemp_name, vadj_date, vtax_yn, vnote;
            var maxRow =workSheet.UsedRange.Rows.Count;    
            var maxCol =workSheet.UsedRange.Cols.Count;    
            for (var j =3;j <=maxRow; j++) 
            { 
                vemp_id=workSheet.Cells(j,1).value;                        
                vemp_name=workSheet.Cells(j,2).value;
                if (vemp_id=="" )
                {   
                    alert("Please input card id at row " + j);
                    cnt=false;
                }
                else if (vemp_name=="")
                {
                    alert("Please input name row " + j);
                    cnt=false;
                }
                for (var cl=3;cl<=maxCol;cl++)
                {
                    v_sal=workSheet.Cells(j,cl).value;
                    if (isNaN(v_sal))
                    {
                        alert("Please input salary value at row " + j + " and col " + cl);
                        cnt=false;       
                    }    
                }    
                if (cnt==true)
                {                             
                    idGrid.AddRow();
                    var irow=idGrid.rows-1;
                    idGrid.SetGridText(irow,1,vemp_id);
                    idGrid.SetGridText(irow,2,vemp_name);
                    for (var cl=0;cl<=numMonth*4;cl++)
                    {
                        v_sal=workSheet.Cells(j,cl+3).value;
                        idGrid.SetGridText(irow,cl+3,v_sal);
                    }
                }
            } 
            myApp.Quit();
        }
        catch(e)
        {
            alert("Could not read Excel File. (or) Excel was not installed in the machine you are using or it has incompatible version?"); 
        }
        datImport.Call();
    */
}

</script>

<body>
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr.sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="lstDept_Code" />
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
<gw:data id="datGroupData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="hr.sp_pro_group_data_all" > 
                <input>
                    <input bind="lstDept_Code" /> 
                </input> 
                <output>
                    <output bind="txtGroupData" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datGetInformation" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR.sp_pro_ins_mon_info" > 
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
<gw:data id="datIns_Month" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,4,5,6,7,12,13,15,20,21,22,23,24,25" function="HR.sp_sel_ins_month_vhpc" > 
                <input bind="idGrid" >
                    <input bind="idWorkMon" /> 
                    <input bind="lstDept_Code" />
                    <input bind="lstGrp_Code" />
                    <input bind="idSearch" />
                    <input bind="idtxtTmp" />
					<input bind="lstNation" />
					<input bind="lstInclude" />
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datIns_Month_Sum" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,4,5,6,7,12,13,15,20,21,22,23,24,25" function="HR.sp_sel_ins_month_sum" > 
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
<gw:tab id="tabMain"  border=1 style="width:100%;height:100%;" >
<table name="Detail" style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
    <tr  style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1">
        <td>
	        <table style="width:100%;height:10%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
	        <tr style="height:7%;border:1">	
		        <td align=right style="width:5%;border:1" ><b>Month</b></td>
		        <td align=right style="width:10%;border:1"><gw:datebox id="idWorkMon" lang="<%=Session("Lang")%>"  onchange="onchange_month()" type=month></gw:datebox></td>
		        <td align=right style="width:10%;border:0" ><a title="Click here to show Organization" onclick="OnShowPopup()" href="#tips" ><b>Organization</b></a></td>
		        <td align=right style="width:20%;border:0"><gw:list  id="lstDept_Code"  value="ALL" styles='width:100%' onchange="OnChangeDept()" >
                        <data>
                            <%=ESysLib.SetListDataSQL("select a.pk,a.org_nm from comm.tco_org a where a.del_if=0 connect by prior  a.pk=a.p_pk start with nvl(a.p_pk,0)=0")%>|ALL|Select All
                        </data>
                    </gw:list>
                </td>
		        <td align=right style="width:5%;border:0"><b>WorkGroup</b></td>
		        <td  align=right style="width:15%;border:0"><gw:list  id="lstGrp_Code"  value="ALL" styles='width:100%' >
                       <data><%=ESysLib.SetListDataSQL("SELECT pk,workGroup_NM FROM Thr_work_Group WHERE DEL_IF = 0  order by workGroup_NM")%>|ALL|Select All</data>
                       </gw:list>
                </td>
		        <td align=right style="width:5%;border:0"><b>Search</b></td>
		        <td  align=right style="width:10%;border:0"><gw:list  id="idSearch" value="1" styles='width:100%' onChange="">
                        <data>|1|Emp ID|2|Card ID|3|Name</data></gw:list>
                </td>
		        <td  align=right style="width:10%;border:0"><gw:textbox id="idtxtTmp" maxlen = "50" styles="width:98%" onenterkey="OnSearch(1)" /></td>
		        <td align=right style="width:1%;border:0"><gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="Search" onclick="OnSearch(1)" /></td>
		        <td align=right style="width:1%;border:0"></td>
		        <td align=right style="width:1%;border:0"></td>
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
		        <td align=right style="width:5%;border:0"><b></b></td>
		        <td  align=right style="width:15%;border:0">
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
		         <td colspan=3 align=left style="border:0" ><b style="color=#FF3300"><gw:label id="idRecord" text="" styles="width:100%" ></gw:label></b></td>

		        <td  align=right style="border:0"></td>     
        		
            </tr>	
	        </table>
	        <table id="tbl" style="width:100%;height:86%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
		        <tr style="height:100%">
			        <td id="master" width="100%">
				        <gw:grid id='idGrid'
                            header='EMP_ID|FULL_NAME|SECTION|POSTION|_BASIC_WAGE|_LONG_SERVICE|TOTAL_SALARY|SOCIAL_5%|HEALTH_1%|UNEMPLOYEE_1%|SOCIAL_20%|HEALTH_2%|UNEMPLOYEE_1%|TOTAL_PAYMENT|_INS_PK'
                            format='0|0|0|0|0|0|1|1|1|1|1|1|1|1|1'
                            aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                            defaults='||||||||||||||'
                            editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
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
	        <tr style="height:7%;border:1">	
		        <td align=right style="width:5%;border:1" ><b>Month</b></td>
		        <td align=right style="width:10%;border:1"><gw:datebox id="dtFromMonth" lang="<%=Session("Lang")%>" type="month" onchange="CreateGrid()"></gw:datebox></td>
		        <td align=right style="width:3%;border:1"><b>~</b></td>
		        <td align=right style="width:10%;border:1"><gw:datebox id="dtToMonth" lang="<%=Session("Lang")%>" type="month" onchange="CreateGrid()"></gw:datebox></td>
		        <td align=right style="width:10%;border:0" ><a title="Click here to show Organization" onclick="OnShowPopup()" href="#tips" ><b>Organization</b></a></td>
		        <td align=right style="width:15%;border:0"><gw:list  id="lstDept_Code1"  value="ALL" styles='width:100%' onchange="OnChangeDept()" >
                        <data>
                            <%=ESysLib.SetListDataSQL("select a.pk,a.org_nm from comm.tco_org a where a.del_if=0 connect by prior  a.pk=a.p_pk start with nvl(a.p_pk,0)=0")%>|ALL|Select All
                        </data>
                    </gw:list>
                </td>
		        <td align=right style="width:7%;border:0"><b>WorkGroup</b></td>
		        <td  align=right style="width:13%;border:0"><gw:list  id="lstGrp_Code1"  value="ALL" styles='width:100%' >
                       <data><%=ESysLib.SetListDataSQL("SELECT pk,workGroup_NM FROM Thr_work_Group WHERE DEL_IF = 0  order by workGroup_NM")%>|ALL|Select All</data>
                       </gw:list>
                </td>
		        <td align=right style="width:5%;border:0"><b>Search</b></td>
		        <td  align=right style="width:6%;border:0"><gw:list  id="idSearch1" value="1" styles='width:100%' onChange="">
                        <data>|1|Emp ID|2|Card ID|3|Name</data></gw:list>
                </td>
		        <td  align=right style="width:10%;border:0"><gw:textbox id="idtxtTmp1" maxlen = "50" styles="width:98%" onenterkey="OnSearch(2)" /></td>
		        <td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnSearch1" alt="Search" img="search" text="Search" onclick="OnSearch(2)" /></td>
		        <td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnRpt1" alt="Report Month Summary" img="excel" text="Report" onclick="OnPrint(1)" /></td>
		        <td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnRpt2" alt="Report Year Summary" img="excel" text="Report" onclick="OnPrint(3)" /></td>
            </tr>	
            <tr>
                 <td align=right style="border:0" colspan=2  ><b>Excel File</b></td>
                 <td align=left style="border:0" colspan=4><input id="inputfile" type="file" size="60"  accept="application/msexcel"  ></td>
                 <td align=left style="border:0" ><gw:imgBtn id="ibtnSampleRpt" alt="Sample file" img="excel" text="Report" onclick="OnPrint(2)" /></td>
                 <td align=left style="border:0" style="text-align:right">
                    <gw:imgBtn img="process" id="ibtnProcess"   alt="Insert from Excell"  onclick="OnLoadExcel()"/>
                 </td> 
                <td align=right colspan=5 style="border:0"><b style="color=#FF3300"><gw:label id="idRecord1" text="" styles="width:100%" ></gw:label></b>
                </td>
            </tr>
            
	        </table>
	        <table id="Table1" style="width:100%;height:86%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
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
	
</body>
</html>

