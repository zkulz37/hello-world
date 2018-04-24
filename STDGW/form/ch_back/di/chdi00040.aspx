
<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var binit=true;
var v_language = "<%=Session("SESSION_LANG")%>";
var emp_pk_list;
var rpt_no=0;
var ctl
function BodyInit()
{
    grdEmployee.GetGridControl().FrozenCols =5;
    grdEmployee_02a1.GetGridControl().FrozenCols =3;
    grdEmployee_02a2.GetGridControl().FrozenCols =4;
    grdEmployee_03aTS1.GetGridControl().FrozenCols =3;
    grdEmployee.GetGridControl().ScrollTrack=true;
    grdEmployee_02a1.GetGridControl().ScrollTrack=true;
    grdEmployee_02a2.GetGridControl().ScrollTrack=true;
    grdEmployee_03aTS1.GetGridControl().ScrollTrack=true;
     if (v_language!="ENG")
        System.Translate(document);	
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    OnChangeOptMonth(2);
    OnChangeOptEmpID(2);

    ChangeColorItem(lstOrg.GetControl());
    ChangeColorItem(lstOrg_2.GetControl());
    ChangeColorItem(lstOrg_3.GetControl());
    ChangeColorItem(lstOrg_4.GetControl());
   
    if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
                datUser_info.Call(); 
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
//-------------------------------
function OnSearch(datobj)
{
    datobj.Call("SELECT");
}
//-------------------------------
function OnDataReceive(obj)
{
    if (obj.id=="datEmpDeclaration")
    {
        lblRecord.text=grdEmployee.rows-1 + " rec(s)";
        auto_resize_column(grdEmployee,0,grdEmployee.cols-1,0);
    }
	else if (obj.id=="datTeamData")
   {
//        switch (tabMain.GetCurrentPageNo())
//        {
//            case 0:
//                ChoseList_box(lstWG,txtGroupData.text);
//                break;
//            case 1:
//                ChoseList_box(lstWG_2,txtGroupData.text);
//                break;
//            case 2:
//                ChoseList_box(lstWG_3,txtGroupData.text);
//                break;
//			case 3:
//                ChoseList_box(lstWG_4,txtGroupData.text);
//                break;
//        }  
//        if (binit==true)
//        {
//            binit=false;
//            ChoseList_box(lstWG,txtGroupData.text);
//            ChoseList_box(lstWG_2,txtGroupData.text);
//            ChoseList_box(lstWG_3,txtGroupData.text);
//			ChoseList_box(lstWG_4,txtGroupData.text);
//        }
        
   }
   else if (obj.id=="datInsurance02a")
    {
        lblRecordIns_2.text=grdEmployee_02a1.rows-1 + " rec(s)";
        auto_resize_column(grdEmployee_02a1,0,grdEmployee_02a1.cols-1,0);
    }
   else if (obj.id=="datEmployee02a")
    {
        lblRecord_2.text=grdEmployee_02a2.rows-1 + " rec(s)";
        auto_resize_column(grdEmployee_02a2,0,grdEmployee_02a2.cols-1,0);
    }
   
   else if (obj.id=="datFind_Report")
   {
        var url;
        switch(rpt_no)
        {
            case 1: //TK1_TS report
                url =System.RootURL + '/reports/ch/di/'+txtReport_tmp.text+'?emp_pk=' + emp_pk_list + "&rpt_type=" + lstReportType.value +'&company_pk=' + txtCompany_PK.text;
                break;
            case 11: //01-TBH report
                url =System.RootURL + '/reports/ch/di/'+txtReport_tmp.text+'?emp_pk=' + emp_pk_list +'&company_pk=' + txtCompany_PK.text;
                break;
                
            case 2: //2a-TBH report
                url =System.RootURL + '/reports/ch/di/'+txtReport_tmp.text+'?l_rpt_month=' + dtReportMonth_2.value + '&l_times=' +  lst_TimesIns_2.value+'&company_pk=' + txtCompany_PK.text;
                break;
           case 3: //3a-TBH report
                url =System.RootURL + '/reports/ch/di/'+txtReport_tmp.text+'?l_rpt_month=' + dtReportMonth_3.value + '&l_times=' +  lst_TimesIns_3.value + '&company_pk=' + txtCompany_PK.text;
                break;
           case 4: //3a-TBH report
                url =System.RootURL + '/reports/ch/di/'+txtReport_tmp.text+'?l_rpt_month=' + dtReportMonth_4.value + '&l_times=' +  lst_TimesIns_4.value +'&company_pk=' + txtCompany_PK.text;
                break;
         }       
        window.open(url);    
   }
   else if (obj.id=="datUser_info")
   {
       
            lstOrg.SetDataText(txtdept_temp.text);
            lstOrg_2.SetDataText(txtdept_temp.text);            
            lstOrg_3.SetDataText(txtdept_temp.text);            
            lstOrg_4.SetDataText(txtdept_temp.text);      
            
            ChangeColorItem(lstOrg.GetControl());
            ChangeColorItem(lstOrg_2.GetControl());
            ChangeColorItem(lstOrg_3.GetControl());
            ChangeColorItem(lstOrg_4.GetControl());

            onChange_org(5,lstOrg);
           

   }
   else if (obj.id=="datEmployee03aTS")
   {
       
        lblRecord_3.text=grdEmployee_03aTS2.rows-1 + " rec(s)";
        auto_resize_column(grdEmployee_03aTS2,0,grdEmployee_03aTS2.cols-1,0);
   }
   else if (obj.id=="datInsurance03aTS")
   {
       
        lblRecordIns_3.text=grdEmployee_03aTS1.rows-1 + " rec(s)";
        auto_resize_column(grdEmployee_03aTS1,0,grdEmployee_03aTS1.cols-1,0);
   }
   else if (obj.id=="datInsurance03aDE")
   {
       
        lblRecordIns_4.text=grdEmployee_03aDE1.rows-1 + " rec(s)";
        auto_resize_column(grdEmployee_03aDE1,0,grdEmployee_03aDE1.cols-1,0);
   }
   else if (obj.id=="datEmployee03aDE")
   {
       
        lblRecord_4.text=grdEmployee_03aDE2.rows-1 + " rec(s)";
        auto_resize_column(grdEmployee_03aDE2,0,grdEmployee_03aDE2.cols-1,0);
   }
   
   else if (obj.id=="datWorkGroup_info")
   {
        if(flag_tab =="1")
        {
		    lstWG.SetDataText(txtwg_tmp.text + "|ALL|Select All");
		    lstWG.value="ALL";
        }
        else if(flag_tab =="2")
        {
            lstWG_2.SetDataText(txtwg_tmp.text + "|ALL|Select All");
		    lstWG_2.value="ALL";
        }
        else if(flag_tab =="3")
        {
            lstWG_3.SetDataText(txtwg_tmp.text + "|ALL|Select All");
		    lstWG_3.value="ALL";
        }
        else if(flag_tab =="4")
        {
            lstWG_4.SetDataText(txtwg_tmp.text + "|ALL|Select All");
		    lstWG_4.value="ALL";
        }
        else if(flag_tab =="5")
        {
            lstWG.SetDataText(txtwg_tmp.text + "|ALL|Select All");
		    lstWG.value="ALL";
            lstWG_2.SetDataText(txtwg_tmp.text + "|ALL|Select All");
		    lstWG_2.value="ALL";
            lstWG_3.SetDataText(txtwg_tmp.text + "|ALL|Select All");
		    lstWG_3.value="ALL";
            lstWG_4.SetDataText(txtwg_tmp.text + "|ALL|Select All");
		    lstWG_4.value="ALL";
        }
        datOrg_Company.Call();
	}	
    else if(obj.id =="datOrg_Company")
    {
       
    }
}
//-------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
//--------------------------------
function OnPrint(obj)
{
    switch (tabMain.GetCurrentPageNo())
    {
        case 0:
            txtDept.text=lstOrg.value ;
            break;
        case 1:
            txtDept.text=lstOrg_2.value ;
            break;
        case 2:
            txtDept.text=lstOrg_3.value ;
            break;
		case 3:
            txtDept.text=lstOrg_4.value ;
            break;
    }    
    
    rpt_no=obj;
    switch(rpt_no)
    {
        case 1: //Declaration Report
        {
           emp_pk_list="";
            for (var i=1;i<=grdEmployee.rows-1;i++)
            {
                if (grdEmployee.GetGridData(i,0)=="-1")
                {
                    emp_pk_list = emp_pk_list + grdEmployee.GetGridData(i,20) + ",";
                }   
            }
            if (emp_pk_list=="")
            {
                alert("Please choose employees to print");
                return;
            }
            else
            {
                emp_pk_list=emp_pk_list.substr(0,emp_pk_list.length-1);
                txtReport_tmp.text="rpt_TK1_TS.aspx";
                datFind_Report.Call();
            }
            break;        
        }  
        case 11: //Declaration Report
        {
           emp_pk_list="";
            for (var i=1;i<=grdEmployee.rows-1;i++)
            {
                if (grdEmployee.GetGridData(i,0)=="-1")
                {
                    emp_pk_list = emp_pk_list + grdEmployee.GetGridData(i,20) + ",";
                }   
            }
            if (emp_pk_list=="")
            {
                alert("Please choose employees to print");
                return;
            }
            else
            {
                emp_pk_list=emp_pk_list.substr(0,emp_pk_list.length-1);
                 txtReport_tmp.text="rpt_02_SBH.aspx";
                datFind_Report.Call();
            }
            break;        
        }  
        case 2: //02a-TBH Report
        {
            txtReport_tmp.text="rpt_02a_TBH.aspx";
            datFind_Report.Call();
            break;        
        }  
        case 3: //03a-TBH Report
        {
            txtReport_tmp.text="rpt_03a_TBH.aspx";
            datFind_Report.Call();
            break;        
        }
        case 4: //03a-TBH Report
        {
            txtReport_tmp.text="rpt_03a_TBH.aspx";
            datFind_Report.Call();
            break;        
        }     
        
    }
    
    
}

//------------------------------------

//-------------------------------------------------------------
function ChoseList_box(obj_list,value)
{
    var obj;
    obj_list.SetDataText(value)    ;
    obj=obj_list.GetControl()
	if (obj.options.length ==2)
		obj.options.selectedIndex=0;
	else
		obj.options.selectedIndex=obj.options.length-1;
}
//-------------------------------------------------------------
function OnChangeOptMonth(obj)
{
    txtOptionMonth.text=obj;
    if (obj==1)
    {
        dtInsuranceMonth.SetEnable(true);
        dtFromJoinDate.SetEnable(false);
        dtToJoinDate.SetEnable(false);
        dtFromSTContract.SetEnable(false);
        dtToSTContract.SetEnable(false);
    }
    else
    {
        dtInsuranceMonth.SetEnable(false);
        dtFromJoinDate.SetEnable(true);
        dtToJoinDate.SetEnable(true);
        dtFromSTContract.SetEnable(true);
        dtToSTContract.SetEnable(true);
    }
}
//-------------------------------------------------------------
function OnChangeOptEmpID(obj)
{
    txtOptEmpID.text=obj;
    if (obj==1)
    {
        txtEmpID_IN.SetEnable(true);
        txtEmpID.SetEnable(false);
        txtEmpID_IN.GetControl().focus();
    }
    else
    {
        txtEmpID_IN.SetEnable(false);
        txtEmpID.SetEnable(true);
        txtEmpID.GetControl().focus();
    }
}
//------------------------------------------------------------
function doSelectAll()
{	
	var tmp;
	if( chkCheckAll.GetData()=='T')
		tmp=-1;
	else
		tmp=0;
     var ctrl = grdEmployee.GetGridControl();
    if (ctrl.SelectedRows >0)
        
	    for ( var i =  0 ; i < ctrl.SelectedRows ; i++ )
		    {
			    var row = ctrl.SelectedRow(i);
			    if ( row > 0 )
			    {		
				    grdEmployee.SetGridText(row,0,tmp);
			    }	
		    }
	else
	    for ( var i =  1 ; i < grdEmployee.rows ; i++ )
		    {
				    grdEmployee.SetGridText(i,0,tmp);
		    }
}
//----------------------------------
function OnChangeMonth(objrptMonth,objinsMonth)
{
    objinsMonth.value=objrptMonth.value;
}
//-----------------------------------
function OnConpareGrids(objgrd1,objgrd2,icol_grid1,icol_grid2,scolor)
{
    var i,j;
    var bexist;
    bexist=false;
    for(i=1;i<objgrd1.rows;i++)
    {
        bexist=false;
        for(j=1;j<objgrd2.rows && bexist==false;j++)
        {
            if (objgrd2.GetGridData(j,icol_grid2)==objgrd1.GetGridData(i,icol_grid1))
                bexist=true;
        }
        if (bexist==false)
            objgrd1.SetCellBgColor(i,0,i, objgrd1.cols-1, scolor);
    }
    
}
//-----------------
function OnCompare(objgrd1,objgrd2,icol_grid1,icol_grid2)
{
    OnConpareGrids(objgrd1,objgrd2,icol_grid1,icol_grid2,0xcc99ff );
    OnConpareGrids(objgrd2,objgrd1,icol_grid2,icol_grid1,0x99ff99 );
}

function OnChangeDept(obj)
{
    
    switch (tabMain.GetCurrentPageNo())
    {
        case 0:
            txtDept.text=lstOrg.value ;
            break;
        case 1:
            txtDept.text=lstOrg_2.value ;
            break;
        case 2:
            txtDept.text=lstOrg_3.value ;
            break;
		case 3:
            txtDept.text=lstOrg_4.value ;
            break;
    }    
    //datTeamData.Call();
}

function OnShowPopup(n)
{
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:20;dialogHeight:30;dialogLeft:10;dialogTop:240;edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {
        if(n==1)
            lstOrg.value=obj;
        if(n==2)
            lstOrg_2.value=obj;        
        if(n==3)
            lstOrg_3.value=obj;
        if(n==4)
            lstOrg_4.value=obj;                    
    }    
}/**/
function onChange_org(tab,obj)
{
	flag_tab=tab;
	txtorg_tmp.text=obj.value;
	datWorkGroup_info.Call();
	
}
</script>

<body style=" margin-bottom:0; margin-top:0; margin-right:0" >
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

<gw:data id="datEmpDeclaration" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid"  function="HR_SEL_10040004" > 
                <input bind="grdEmployee">
                    <input bind="lstOrg" /> 
                    <input bind="lstWG" /> 
                    <input bind="dtReportMonth" /> 
                    <input bind="txtOptionMonth" /> 
                    <input bind="dtInsuranceMonth" /> 
                    <input bind="dtFromJoinDate" /> 
                    <input bind="dtToJoinDate" /> 
                    <input bind="dtFromSTContract" /> 
                    <input bind="dtToSTContract" /> 
                    <input bind="txtOptEmpID" /> 
                    <input bind="txtEmpID_IN" /> 
                    <input bind="txtEmpID" />
					<input bind="lstNation" />
                    <input bind="lstSocila_YN" />
                </input> 
                <output bind="grdEmployee"/>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------>
<gw:data id="datFind_Report" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sp_pro_find_report_2" > 
                <input>
                    <input bind="txtReport_tmp" /> 
                    <input bind="txtDept" />
                </input> 
                <output>
                    <output bind="txtReport_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------->
<gw:data id="datInsurance02a" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid"  function="HR_SEL_10040004_1" > 
                <input bind="grdEmployee_02a1">
                    <input bind="lstOrg_2" /> 
                    <input bind="lstWG_2" /> 
                    <input bind="dtInsuranceMonth_2" /> 
                    <input bind="txtEmpIDIns_2" />
                    <input bind="lst_Times_2" />
					<input bind="lstNation_2" />
                </input> 
                <output bind="grdEmployee_02a1"/>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------->
<gw:data id="datEmployee02a" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid"  function="HR_SEL_10040004_2" > 
                <input bind="grdEmployee_02a2">
                    <input bind="lstOrg_2" /> 
                    <input bind="lstWG_2" /> 
                    <input bind="dtReportMonth_2" /> 
                    <input bind="dtFromJoinDate_2" /> 
                    <input bind="dtToJoinDate_2" /> 
                    <input bind="dtFromSTContract_2" /> 
                    <input bind="dtToSTContract_2" /> 
                    <input bind="txtEmpID_2" />
					<input bind="lstNation_2" />
                </input> 
                <output bind="grdEmployee_02a2"/>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------->
<gw:data id="datEmployee03aTS" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid"  function="HR_SEL_10040004_3" > 
                <input bind="grdEmployee_03aTS2">
                    <input bind="lstOrg_3" /> 
                    <input bind="lstWG_3" /> 
                    <input bind="dtReportMonth_3" /> 
                    <input bind="dtFromSTDate_3" /> 
                    <input bind="dtToSTDate_3" /> 
                    <input bind="dtFromETDate_3" /> 
                    <input bind="dtToETDate_3" /> 
                    <input bind="txtEmpID_3" />
					<input bind="lstNation_3" />
                </input> 
                <output bind="grdEmployee_03aTS2"/>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------->
<gw:data id="datInsurance03aTS" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid"  function="HR_SEL_10040004_4" > 
                <input bind="grdEmployee_03aTS1">
                    <input bind="lstOrg_3" /> 
                    <input bind="lstWG_3" /> 
                    <input bind="dtInsuranceMonth_3" /> 
                    <input bind="txtEmpIDIns_3" />
                    <input bind="lst_Times_3" />
                    <input bind="lst_Type_3" />
					<input bind="lstNation_3" />
                </input> 
                <output bind="grdEmployee_03aTS1"/>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------->
<gw:data id="datEmployee03aDE" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid"  function="HR_SEL_10040004_5" > 
                <input bind="grdEmployee_03aDE2">
                    <input bind="lstOrg_4" /> 
                    <input bind="lstWG_4" /> 
                    <input bind="dtReportMonth_4" /> 
                    <input bind="dtFromJoinDate_4" /> 
                    <input bind="dtToJoinDate_4" /> 
                    <input bind="dtFromLeftDate_4" /> 
                    <input bind="dtToLeftDate_4" /> 
                    <input bind="txtEmpID_4" />
					<input bind="lstNation_4" />
                </input> 
                <output bind="grdEmployee_03aDE2"/>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------->
<gw:data id="datInsurance03aDE" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid"  function="HR_SEL_10040004_6" > 
                <input bind="grdEmployee_03aDE1">
                    <input bind="lstOrg_4" /> 
                    <input bind="lstWG_4" /> 
                    <input bind="dtInsuranceMonth_4" /> 
                    <input bind="txtEmpIDIns_4" />
                    <input bind="lst_Times_4" />
					<input bind="lstNation_4" />
                </input> 
                <output bind="grdEmployee_03aDE1"/>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datTeamData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="hr_sp_pro_team_data_all" > 
                <input>
                    <input bind="txtDept" /> 
                </input> 
                <output>
                    <output bind="txtGroupData" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!-----------------Get ID company theo Organization ------------------------>
<gw:data id="datOrg_Company" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_sp_pro_get_company" > 
                <input>
                    <input bind="txtorg_tmp" /> 
                </input> 
                <output>
                    <output bind="txtCompany_PK" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!--------------------main table----------------------------------->
<gw:tab id="tabMain"  border=1 styles="width:90%;height:100%" onpageactivate=""    > 
    <table name="01" id="management" cellpadding="0"  cellspacing="0" border=1 style="width:100%;height:100%">
        <tr  style="width:100%;height:100%" valign="top">
            <td  style="width:100%;height:100%">
                <table width="100%" id="tblexp" style="height:15%" border=0 cellpadding="0" cellspacing="0">
				<tr width="100%">
					<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
					<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
					<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
					<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
					<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
					<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
					<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
					<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
					<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
					<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
				</tr>
                    <tr style="border:0;width:100%" valign="middle"  >
                        <td colspan="5" align="right" ><a title="Click here to show Organization" onclick="OnShowPopup(1)" href="#tips" >Organization</a></td>
                        <td colspan="10" align="left" >
                         <gw:list  id="lstOrg" value='ALL' maxlen = "100" styles='width:100%'onchange="onChange_org(1,lstOrg)" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td colspan="5"  align="right" colspan=2 >Work-Group</td>
                        <td colspan="10" align="left" colspan=2>
                         <gw:list  id="lstWG" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("SELECT pk,workgroup_NM FROM Thr_work_Group WHERE DEL_IF = 0 order by workgroup_id" )%>|ALL|Select All</data></gw:list>
                        </td>
                        <td colspan="5"  align="right" >Report Month</td>
                        <td colspan="5" align="left" colspan=2>
                         <gw:datebox id="dtReportMonth" type="month" onchange="OnChangeMonth(dtReportMonth,dtInsuranceMonth)"  lang="<%=Session("Lang")%>"/></td>
                        <td  colspan="3"  align=right><font color="black">Type</td>
			            <td align="left" colspan="3" >
                         <gw:list  id="lstReportType" value='1' maxlen = "100" styles='width:100%' >
                            <data>
                                |0|Two Part|1|Info Emp|2|Phụ Lục 1|3|Phụ Lục 2
                            </data>
                        </gw:list>
                        </td>
						<td colspan = "1"></td>
                        <td colspan="1"  align="right">
                            <gw:imgBtn img="Search" id="ibtnSearch"    alt="Search"  onclick="OnSearch(datEmpDeclaration)"/>
                        </td>
                        <td colspan="1" align="right">
                            <gw:imgBtn img="excel" id="ibtnReport"    alt="Tờ khai"  onclick="OnPrint(1)"/>
                        </td>
                        <td colspan="1" align="right">
                            <gw:imgBtn img="excel" id="ibtnReport1"    alt="Danh sách lao động đề nghị cấp tờ khai."  onclick="OnPrint(11)"/>
                        </td>
                        
                    </tr>
                    <tr style="border:1;width:100%" valign="middle"  >
						<td colspan="4"> </td>
                        <td colspan="1" align="right" style="border-right:0"><input type="radio" name="optMonth"  onclick="OnChangeOptMonth(1)"></td>
						<td align="right" colspan="5"><font color="black">Insurance Month</td>
                        <td colspan="5" > <gw:datebox id="dtInsuranceMonth" type="month"   lang="<%=Session("Lang")%>"/></td>										
                        <td align="right" colspan="2" align="right" style="border-right:0"><input type="radio" checked name="optMonth"  onclick="OnChangeOptMonth(2)" ></td>
						<td    align=right colspan="3" ><font color="black">Join Date</td>
                        <td  colspan="4"> <gw:datebox id="dtFromJoinDate" nullaccept styles='width:100%'   lang="<%=Session("Lang")%>"/></td>
			            <td colspan="2" align=center>~</td>
                         <td colspan="4" > <gw:datebox id="dtToJoinDate" nullaccept styles='width:100%' lang="<%=Session("Lang")%>"/></td>
						<td   align=right colspan="5"><font color="black">Start Contract</td>
                       <td colspan="4"><gw:datebox id="dtFromSTContract"  styles='width:100%' nullaccept  lang="<%=Session("Lang")%>"/>  </td>						
			           <td  align=center colspan="1">~</td>
			           <td width="17%" colspan="4"> <gw:datebox id="dtToSTContract" nullaccept styles='width:100%' lang="<%=Session("Lang")%>"/>  </td>
                    </tr>
				   
					 <tr align=top cellpadding="0" cellspacing="0" >
					    <td style="border:0" align="left" colspan="3"><gw:checkbox id="chkCheckAll" value="F" onclick="doSelectAll()" ></gw:checkbox ></td>
				        <td align="right" style="border-right:0" colspan="2"><input type="radio" name="optEmpID"  onclick="OnChangeOptEmpID(1)"></td>
						<td align="right" colspan="5"><font color="black">Emp ID (in)</td>
						<td colspan="5"> <gw:textbox id="txtEmpID_IN" styles='width:100%'/></td>
						<td  colspan="2" align="right" style="border-right:0"><input type="radio" name="optEmpID" checked onclick="OnChangeOptEmpID(2)"></td>
						<td  align=right colspan="3"><font color="black">Emp ID</td>
						<td colspan="10" ><gw:textbox id="txtEmpID" styles='width:100%'/></td>
						<td colspan="5" align="right">Nation</td>
						<td colspan="4"><gw:list id="lstNation" styles="color:black;width:100%" value="01" onchange=""> 
							   <data>
									<%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by code_nm")%>|ALL|Select All ...
								</data>
						   </gw:list > 
						</td>
						<td  colspan="4"  align=right><font color="black">Social No YN</td>
			            <td align="left" colspan="3" >
                         <gw:list  id="lstSocila_YN" value='3' maxlen = "100" styles='width:100%' >
                            <data>
                                |1|Yes|2|No|3|Select All
                            </data>
                        </gw:list>
                        </td>
						<td colspan="5" align="right" >
                           <gw:label id="lblRecord"  text="0 rec(s)" maxlen = "100" styles="color:red;width:100%;font-weight: bold;font-size:12" /></td>
                        
					</tr>
			     </table>
                 <table cellspacing=0 cellpadding=0 style="height:85%" width=100% border=1>
                    <tr style="border:1;width:100%;height:100%" valign="top">
                        <td  style="width:100%;height:100%;"> 
                          <gw:grid id='grdEmployee'
                            header='Select|Team/Section|Emp ID|Full Name|Male|Female|Birth Date|Ethnic|Nation|Permanent Addr|Current Addr|Person ID|Person ID Place|Issued Date|Health No|Health Place|Start Month|End Month|Postion|SALARY|_EmpPK'
                            format='3|0|0|0|0|0|0|0|0|0|0|0|0|4|0|0|0|0|0|1|0'
                            aligns='0|0|0|0|1|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                            defaults='|||||||||||||||||||||'
                            editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                            widths='1000|1500|1000|2500|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                            sorting='T'
                            styles='width:100%; height:100%'
                            />
                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table>
    <table name="02a" id="Table1" width="100%" cellpadding="0"  cellspacing="0" border=1 style="height:100%">
        <tr  style="width:100%;height:100%" valign="top">
            <td  style="width:100%;height:100%">
				<table width="100%" id="Table2" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                    <tr width="100%">
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
					</tr>
					<tr style="border:0;width:100%" valign="middle"  style="height:5%">
                        <td colspan="5" align="right" style="border:0"><a title="Click here to show Organization" onclick="OnShowPopup(2)" href="#tips" >Organization</a></td>
                        <td colspan="8" align="left" style="border:0">
                         <gw:list  id="lstOrg_2" value='ALL' maxlen = "100" styles='width:100%'onchange="onChange_org(2,lstOrg_2)" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td colspan="5"  align="right" style="border:0" >Work-Group</td>
                        <td colspan="8" align="left" style="border:0">
                         <gw:list  id="lstWG_2" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("SELECT pk,workgroup_NM FROM Thr_work_Group WHERE DEL_IF = 0 order by workgroup_id" )%>|ALL|Select All</data></gw:list>
                        </td>
						<td colspan="3" style="border:0" align = "right">Nation</td>
						<td colspan="4"><gw:list id="lstNation_2" styles="color:black;width:100%" value="01" onchange=""> 
						   <data>
								<%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by code_nm")%>|ALL|Select All ...
							</data>
					   </gw:list > </td>
                        <td colspan="5" align="right" style="border:0">Report Month</td>
                        <td colspan="4" align="left" style="border:0">
                         <gw:datebox id="dtReportMonth_2" type="month"  onchange="OnChangeMonth(dtReportMonth_2,dtInsuranceMonth_2)"  lang="<%=Session("Lang")%>"/></td>
                        <td align=center colspan="3"><b>Times</b></td>
		                <td align=left colspan="3"><gw:list  id="lst_TimesIns_2" onchange="OnChangeMonth(lst_TimesIns_2,lst_Times_2)" maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("SELECT B.CODE,B.CODE_NM FROM VHR_HR_CODE B WHERE B.ID='HR0042' ORDER BY B.CODE")%></data></gw:list></td>
		
                        <td colspan="1" align="right" style="border:0">
                            <gw:imgBtn img="create" id="ibtnCompare_2"    alt="Compare"  onclick="OnCompare(grdEmployee_02a1,grdEmployee_02a2,1,1)"/>
                        </td>
                        <td colspan="1" align="right" style="border:0">
                            <gw:imgBtn img="excel" id="ibtnReport_2"    alt="Report"  onclick="OnPrint(2)"/>
                        </td>
                    </tr>
                    <tr style="height:95%" >
                        <td colspan="25" colspan=4 style="height:100%">
                            <table cellspacing=0 cellpadding=0  width=100% style="height:100%" border=1>
                                <tr align=top cellpadding="0" cellspacing="0" style="height:6%">
				                    <td align="right"  width="25%" style="border:0"><font color="black">Insurance Month</td>
						            <td width="25%" style="border:0"> <gw:datebox id="dtInsuranceMonth_2" type="month"    lang="<%=Session("Lang")%>"/></td>										
						            <td    align=right width="15%" style="border:0"><font color="black">Emp ID</td>
		    	                    <td  width="25%" style="border:0"> <gw:textbox id="txtEmpIDIns_2" styles='width:100%' onenterkey="OnSearch(datInsurance02a)"/></td>
		    	                    <td width="10%" style="border:0" align="right">
                                        <gw:imgBtn img="Search" id="ibtnSearchIns_2"    alt="Search"  onclick="OnSearch(datInsurance02a)"/>
                                    </td>
					            </tr>
					            <tr align=top cellpadding="0" cellspacing="0" style="height:6%">
				                    <td align=center style="width:10%;border:0"><b>Times</b></td>
		                            <td align=left style="width:10%;border:0"><gw:list  id="lst_Times_2"  maxlen = "100" styles='width:100%' >
                                        <data><%=ESysLib.SetListDataSQL("SELECT B.CODE,B.CODE_NM FROM VHR_HR_CODE B WHERE B.ID='HR0042' ORDER BY B.CODE")%></data></gw:list></td>
				                    <td align="right"  colspan=3 style="border:0"><gw:label id="lblRecordIns_2"  text="0 rec(s)" maxlen = "100" styles="color:red;width:100%;font-weight: bold;font-size:12" /></td>
						           
					            </tr>
					            <tr style="border:1;width:100%;height:88%" valign="top">
                                    <td  style="width:100%;height:100%;"  colspan=5> 
                                      <gw:grid id='grdEmployee_02a1'
                                        header='Team/Section|Emp ID|Full Name|Social No|Health No|Birth Date|Female|Person ID|Address|Health Place|Salary|From Month|Health Increase|Social Increase'
                                        format='0|0|0|0|0|0|0|0|0|0|1|0|1|1'
                                        aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                        defaults='|||||||||||||'
                                        editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                        widths='1000|1000|1980|1350|1380|1305|555|1335|1440|1500|1410|1035|1000|1000'
                                        sorting='T'
                                        styles='width:100%; height:100%'
                                        />
                                    </td>
                                </tr>
                            </table> 
                        </td>
                        
                        <td colspan="25"  colspan=6  style="height:100%">
                            <table cellspacing=0 cellpadding=0  width=100%  border=1 style="height:100%">
                                <tr align=top cellpadding="0" cellspacing="0" style="height:6%">
				                    <td align="right"  width="20%" style="border:0" ><font color="black">Join Date</td>
						            <td  width="20%" style="border:0"> <gw:datebox id="dtFromJoinDate_2" nullaccept styles='width:100%'   lang="<%=Session("Lang")%>"/></td>										
						            <td   width="7%" style="border:0" align=center ><font color="black">~</td>
		    	                    <td  width="20%" style="border:0"> <gw:datebox id="dtToJoinDate_2" nullaccept styles='width:100%'   lang="<%=Session("Lang")%>"/></td>
		    	                    <td style="border:0"   align=right width="8%" ><font color="black">Emp ID</td>
		    	                    <td style="border:0" width="17%"> <gw:textbox id="txtEmpID_2" styles='width:100%' onenterkey="OnSearch(datEmployee02a)"/></td>
		    	                    <td width="8%" style="border:0"  align="right">
                                        <gw:imgBtn img="Search" id="ibtnSearch_2"    alt="Search"  onclick="OnSearch(datEmployee02a)"/>
                                    </td>
					            </tr>
					            <tr align=top cellpadding="0" cellspacing="0" style="height:6%">
				                    <td align="right"   style="border:0"><font color="black">Start Contract</td>
						            <td  style="border:0" > <gw:datebox id="dtFromSTContract_2" nullaccept styles='width:100%'   lang="<%=Session("Lang")%>"/></td>										
						            <td  style="border:0"   align=center ><font color="black">~</td>
		    	                    <td style="border:0" > <gw:datebox id="dtToSTContract_2" nullaccept styles='width:100%'   lang="<%=Session("Lang")%>"/></td>
		    	                    <td colspan=3 style="border:0"  align="right">
                                        <gw:label id="lblRecord_2"  text="0 rec(s)" maxlen = "100" styles="color:red;width:100%;font-weight: bold;font-size:12" /></td>
					            </tr>
					            <tr style="border:1;width:100%;height:88%" valign="top">
                                    <td  style="width:100%;" colspan=7> 
                                       <gw:grid id='grdEmployee_02a2'
                                        header='Team/Section|Emp ID|Full Name|Join Date|Birth Dte|Female|Person ID|Address'
                                        format='0|0|0|0|0|0|0|0'
                                        aligns='0|0|0|0|0|0|0|0'
                                        defaults='|||||||'
                                        editcol='0|0|0|0|0|0|0|0'
                                        widths='1000|1000|1980|1350|1380|1305|555|1335'
                                        sorting='T'
                                        styles='width:100%; height:100%'
                                            />
                                    </td>
                                </tr>
                            </table> 
                        </td>
                        
                        
                    </tr>
				 </table>
                 
            </td>
        </tr>
    </table>
    <table name="03a(M)" id="Table3" width="100%" cellpadding="0"  cellspacing="0" border=1 style="height:100%">
        <tr  style="width:100%;height:100%" valign="top">
            <td  style="width:100%;height:100%">
                <table width="100%" id="Table4" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                    <tr width="100%">
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
					</tr>
					<tr style="border:0;width:100%" valign="middle"  style="height:5%">
                        <td colspan="5" align="right" style="border:0"><a title="Click here to show Organization" onclick="OnShowPopup(3)" href="#tips" >Organization</a></td>
                        <td colspan="8" align="left" style="border:0">
                         <gw:list  id="lstOrg_3" value='ALL' maxlen = "100" styles='width:100%'onchange="onChange_org(3,lstOrg_3)" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td colspan="5"  align="right" style="border:0" >Work-Group</td>
                        <td colspan="8" align="left" style="border:0">
                         <gw:list  id="lstWG_3" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("SELECT pk,workgroup_NM FROM Thr_work_Group WHERE DEL_IF = 0 order by workgroup_id" )%>|ALL|Select All</data></gw:list>
                        </td>
						<td colspan="3" style="border:0" align = "right">Nation</td>
						<td colspan="4"><gw:list id="lstNation_3" styles="color:black;width:100%" value="01" onchange=""> 
						   <data>
								<%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by code_nm")%>|ALL|Select All ...
							</data>
					   </gw:list > </td>
                        <td colspan="5" align="right" style="border:0">Report Month</td>
                        <td colspan="4" align="left" style="border:0">
                         <gw:datebox id="dtReportMonth_3" type="month" onchange="OnChangeMonth(dtReportMonth_3,dtInsuranceMonth_3)"  lang="<%=Session("Lang")%>"/></td>
                        <td colspan="2" align=center style="border:0"><b>Times</b></td>
		                <td colspan="4" align=left style="border:0"><gw:list  id="lst_TimesIns_3" onchange="OnChangeMonth(lst_TimesIns_3,lst_Times_3)" maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("SELECT B.CODE,B.CODE_NM FROM VHR_HR_CODE B WHERE B.ID='HR0042' ORDER BY B.CODE")%></data></gw:list></td>
		
		                <td colspan="1" align="right" style="border:0">
                            <gw:imgBtn img="create" id="ibtnCompare_3"    alt="Compare"  onclick="OnCompare(grdEmployee_03aTS1,grdEmployee_03aTS2,1,1)"/>
                        </td>
                        <td colspan="1" align="right" style="border:0">
                            <gw:imgBtn img="excel" id="ibtnReport_3"    alt="Report"  onclick="OnPrint(3)"/>
                        </td>
                    </tr>
                    <tr style="height:95%" >
                        <td colspan="25" style="height:100%">
                            <table cellspacing=0 cellpadding=0  width=100% style="height:100%" border=1>
                                <tr align=top cellpadding="0" cellspacing="0" style="height:6%">
				                    <td align="right"  width="25%" style="border:0"><font color="black">Insurance Month</td>
						            <td width="25%" style="border:0"> <gw:datebox id="dtInsuranceMonth_3" type="month"  lang="<%=Session("Lang")%>"/></td>										
						            <td    align=right width="15%" style="border:0"><font color="black">Emp ID</td>
		    	                    <td  width="25%" style="border:0"> <gw:textbox id="txtEmpIDIns_3" styles='width:100%' onenterkey="OnSearch(datInsurance03aTS)"/></td>
		    	                    <td width="10%" style="border:0" align="right">
                                        <gw:imgBtn img="Search" id="ibtnSearchIns_3"    alt="Search"  onclick="OnSearch(datInsurance03aTS)"/>
                                    </td>
					            </tr>
					            <tr align=top cellpadding="0" cellspacing="0" style="height:6%">
				                    <td align=center style="width:10%;border:0"><b>Times</b></td>
		                            <td align=left style="width:10%;border:0"><gw:list  id="lst_Times_3"  maxlen = "100" styles='width:100%' >
                                        <data><%=ESysLib.SetListDataSQL("SELECT B.CODE,B.CODE_NM FROM VHR_HR_CODE B WHERE B.ID='HR0042' ORDER BY B.CODE")%></data></gw:list></td>
				                    <td align=center style="width:10%;border:0"><b>Type</b></td>
		                            <td align=left style="width:10%;border:0"><gw:list  id="lst_Type_3"  maxlen = "100" styles='width:100%' >
                                        <data><%=ESysLib.SetListDataSQL("SELECT B.CODE,B.CODE_NM FROM VHR_HR_CODE B WHERE B.ID='HR0041' and code in ('02','06') ORDER BY B.CODE")%></data></gw:list></td>
				                    
				                    <td align="right"  colspan=3 style="border:0"><gw:label id="lblRecordIns_3"  text="0 rec(s)" maxlen = "100" styles="color:red;width:100%;font-weight: bold;font-size:12" /></td>
						           
					            </tr>
					            <tr style="border:1;width:100%;height:88%" valign="top">
                                    <td  style="width:100%;height:100%;"  colspan=5> 
                                      <gw:grid id='grdEmployee_03aTS1'
                                            header='workgroup_nm|EMP_ID|FULL_NAME|SOCIAL_NO|NEW_SAL|OLD_SAL|FROM_MONTH|TO_MONTH|RATE(%)|RETURN_HEALTH_CARD_YN|NUMBER_MONTH'
                                            format='0|0|0|0|1|1|0|0|0|0|0'
                                            aligns='0|0|0|0|0|0|0|0|0|0|0'
                                            defaults='||||||||||'
                                            editcol='0|0|0|0|0|0|0|0|0|0|0'
                                            widths='1530|1410|2640|1410|1455|1410|1380|1320|1000|1380|1000'
                                            sorting='T'
                                            styles='width:100%; height:100%'
                                            />
                                    </td>
                                </tr>
                            </table> 
                        </td>
                        
                        <td colspan="25" style="height:100%">
                            <table cellspacing=0 cellpadding=0  width=100%  border=1 style="height:100%">
                                <tr align=top cellpadding="0" cellspacing="0" style="height:6%">
				                    <td align="right"  width="20%" style="border:0" ><font color="black">Start Date</td>
						            <td  width="20%" style="border:0"> <gw:datebox id="dtFromSTDate_3" nullaccept styles='width:100%'   lang="<%=Session("Lang")%>"/></td>										
						            <td   width="7%" style="border:0" align=center ><font color="black">~</td>
		    	                    <td  width="20%" style="border:0"> <gw:datebox id="dtToSTDate_3" nullaccept styles='width:100%'   lang="<%=Session("Lang")%>"/></td>
		    	                    <td style="border:0"   align=right width="8%" ><font color="black">Emp ID</td>
		    	                    <td style="border:0" width="17%"> <gw:textbox id="txtEmpID_3" styles='width:100%' onenterkey="OnSearch(datEmployee03aTS)"/></td>
		    	                    <td width="8%" style="border:0"  align="right">
                                        <gw:imgBtn img="Search" id="ibtnSearch_3"    alt="Search"  onclick="OnSearch(datEmployee03aTS)"/>
                                    </td>
					            </tr>
					            <tr align=top cellpadding="0" cellspacing="0" style="height:6%">
				                    <td align="right"   style="border:0"><font color="black">End Date</td>
						            <td  style="border:0" > <gw:datebox id="dtFromETDate_3" nullaccept styles='width:100%'   lang="<%=Session("Lang")%>"/></td>										
						            <td  style="border:0"   align=center ><font color="black">~</td>
		    	                    <td style="border:0" > <gw:datebox id="dtToETDate_3" nullaccept styles='width:100%'   lang="<%=Session("Lang")%>"/></td>
		    	                    <td colspan=3 style="border:0"  align="right">
                                        <gw:label id="lblRecord_3"  text="0 rec(s)" maxlen = "100" styles="color:red;width:100%;font-weight: bold;font-size:12" /></td>
					            </tr>
					            <tr style="border:1;width:100%;height:88%" valign="top">
                                    <td  style="width:100%;" colspan=7> 
                                       <gw:grid id='grdEmployee_03aTS2'
                                        header='Team/Section|EMP ID|FULL NAME|JOIN DATE|ABSENCE TYPE|START DATE|END DATE'
                                        format='0|0|0|4|0|4|4'
                                        aligns='0|0|0|0|0|0|0'
                                        defaults='||||||'
                                        editcol='0|0|0|0|0|0|0'
                                        widths='1680|1005|2565|1200|2025|1755|1000'
                                        sorting='T'
                                        styles='width:100%; height:100%'
                                        />
                                    </td>
                                </tr>
                            </table> 
                        </td>
                    </tr>
				 </table>
            </td>
        </tr>
    </table>
    <table name="03a(R)" id="Table5" width="100%" cellpadding="0"  cellspacing="0" border=1 style="height:100%">
        <tr  style="width:100%;height:100%" valign="top">
            <td  style="width:100%;height:100%">
                <table width="100%" id="Table6" style="height:100%" border=1 cellpadding="0" cellspacing="0">
					<tr width="100%">
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
						<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
					</tr>
                    <tr style="border:0;width:100%" valign="middle"  style="height:5%">
                        <td colspan="5" style="border:0"><a title="Click here to show Organization" onclick="OnShowPopup(4)" href="#tips" >Organization</a></td>
                        <td colspan="8"  align="left" style="border:0">
                         <gw:list  id="lstOrg_4" value='ALL' maxlen = "100" styles='width:100%'onchange="onChange_org(4,lstOrg_4)" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td colspan="5" align="right" style="border:0" >Work-Group</td>
                        <td colspan="8" align="left" style="border:0">
                         <gw:list  id="lstWG_4" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("SELECT pk,workgroup_NM FROM Thr_work_Group WHERE DEL_IF = 0 order by workgroup_id" )%>|ALL|Select All</data></gw:list>
                        </td>
						<td colspan="3" align="right" style="border:0" ><font color="black"><b >Nation </b></td>
						<td colspan="4"><gw:list id="lstNation_4" styles="color:black;width:100%" value="01" onchange=""> 
							   <data>
									<%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by code_nm")%>|ALL|Select All ...
								</data>
						   </gw:list > 
						</td>
                        <td colspan="5" align="right" style="border:0">Report Month</td>
                        <td colspan="4" align="left" style="border:0">
                         <gw:datebox id="dtReportMonth_4" type="month" onchange="OnChangeMonth(dtReportMonth_4,dtInsuranceMonth_4)"  lang="<%=Session("Lang")%>"/></td>
                        <td colspan="2" align=center style="border:0"><b>Times</b></td>
		                <td colspan="4" align=left style="border:0"><gw:list  id="lst_TimesIns_4" onchange="OnChangeMonth(lst_TimesIns_4,lst_Times_4)" maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("SELECT B.CODE,B.CODE_NM FROM VHR_HR_CODE B WHERE B.ID='HR0042' ORDER BY B.CODE")%></data></gw:list></td>
		                <td colspan="1" align="right" style="border:0">
                            <gw:imgBtn img="create" id="ibtnCompare_4"    alt="Compare"  onclick="OnCompare(grdEmployee_03aDE1,grdEmployee_03aDE2,1,1)"/>
                        </td>
                        <td colspan="1" align="right" style="border:0">
                            <gw:imgBtn img="excel" id="ibtnReport_4"    alt="Report"  onclick="OnPrint(4)"/>
                        </td>
                    </tr>
                    <tr style="height:95%" >
                        <td colspan="25" colspan=4 style="height:100%">
                            <table cellspacing=0 cellpadding=0  width=100% style="height:100%" border=1>
                                <tr align=top cellpadding="0" cellspacing="0" style="height:6%">
				                    <td align="right"  width="25%" style="border:0"><font color="black">Insurance Month</td>
						            <td width="25%" style="border:0"> <gw:datebox id="dtInsuranceMonth_4" type="month"   lang="<%=Session("Lang")%>"/></td>										
						            <td    align=right width="15%" style="border:0"><font color="black">Emp ID</td>
		    	                    <td  width="25%" style="border:0"> <gw:textbox id="txtEmpIDIns_4" styles='width:100%' onenterkey="OnSearch(datInsurance03aDE)"/></td>
		    	                    <td width="10%" style="border:0" align="right">
                                        <gw:imgBtn img="Search" id="ibtnSearchIns_4"    alt="Search"  onclick="OnSearch(datInsurance03aDE)"/>
                                    </td>
					            </tr>
					            <tr align=top cellpadding="0" cellspacing="0" style="height:6%">
				                    <td align=center style="width:10%;border:0"><b>Times</b></td>
		                            <td align=left style="width:10%;border:0"><gw:list  id="lst_Times_4"  maxlen = "100" styles='width:100%' >
                                        <data><%=ESysLib.SetListDataSQL("SELECT B.CODE,B.CODE_NM FROM VHR_HR_CODE B WHERE B.ID='HR0042' ORDER BY B.CODE")%></data></gw:list></td>
				                    <td align=center style="width:10%;border:0"></td>
		                            <td align=left style="width:10%;border:0"></td>
				                    <td align="right"  colspan=3 style="border:0"><gw:label id="lblRecordIns_4"  text="0 rec(s)" maxlen = "100" styles="color:red;width:100%;font-weight: bold;font-size:12" /></td>
						           
					            </tr>
					            <tr style="border:1;width:100%;height:88%" valign="top">
                                    <td  style="width:100%;height:100%;"  colspan=7> 
                                      <gw:grid id='grdEmployee_03aDE1'
                                            header='GROUP NM|EMP ID|FULL NAME|SOCIAL NO|NEW SALARY|OLD SALARY|FROM MONTH|TO MONTH|PERCENT|RETURN TICKET|MONTHS'
                                            format='0|0|0|0|1|1|0|0|0|0|0'
                                            aligns='0|0|0|0|0|0|0|0|0|0|0'
                                            defaults='||||||||||'
                                            editcol='0|0|0|0|0|0|0|0|0|0|0'
                                            widths='1530|1410|2640|1410|1455|1410|1380|1320|1000|1380|1000'
                                            sorting='T'
                                            styles='width:100%; height:100%'
                                            />
                                    </td>
                                </tr>
                            </table> 
                        </td>
                        
                        <td colspan="25" colspan=6  style="height:100%">
                            <table cellspacing=0 cellpadding=0  width=100%  border=1 style="height:100%">
                                <tr align=top cellpadding="0" cellspacing="0" style="height:6%">
				                    <td align="right"  width="20%" style="border:0" ><font color="black">Join Date</td>
						            <td width="20%" style="border:0"> <gw:datebox id="dtFromJoinDate_4" nullaccept styles='width:100%'   lang="<%=Session("Lang")%>"/></td>										
						            <td width="7%" style="border:0" align=center ><font color="black">~</td>
		    	                    <td width="20%" style="border:0"> <gw:datebox id="dtToJoinDate_4" nullaccept styles='width:100%'   lang="<%=Session("Lang")%>"/></td>
		    	                    <td style="border:0" align=right width="8%" ><font color="black">Emp ID</td>
		    	                    <td style="border:0" width="17%"> <gw:textbox id="txtEmpID_4" styles='width:100%' onenterkey="OnSearch(datEmployee03aDE)"/></td>
		    	                    <td width="8%" style="border:0"  align="right">
                                        <gw:imgBtn img="Search" id="ibtnSearch_4"    alt="Search"  onclick="OnSearch(datEmployee03aDE)"/>
                                    </td>
					            </tr>
					            <tr align=top cellpadding="0" cellspacing="0" style="height:6%">
				                    <td align="right"   style="border:0"><font color="black">Left Date</td>
						            <td  style="border:0" > <gw:datebox id="dtFromLeftDate_4" nullaccept styles='width:100%'   lang="<%=Session("Lang")%>"/></td>										
						            <td  style="border:0"   align=center ><font color="black">~</td>
		    	                    <td style="border:0" > <gw:datebox id="dtToLeftDate_4" nullaccept styles='width:100%'   lang="<%=Session("Lang")%>"/></td>
		    	                    <td colspan=3 style="border:0"  align="right">
                                        <gw:label id="lblRecord_4"  text="0 rec(s)" maxlen = "100" styles="color:red;width:100%;font-weight: bold;font-size:12" /></td>
					            </tr>
					            <tr style="border:1;width:100%;height:88%" valign="top">
                                    <td  style="width:100%;" colspan=7> 
                                       <gw:grid id='grdEmployee_03aDE2'
                                        header='GROUP |EMP ID|FULL NAME|JOIN DATE|LEFT DATE'
                                        format='0|0|0|0|0'
                                        aligns='0|0|0|0|0'
                                        defaults='||||'
                                        editcol='0|0|0|0|0'
                                        widths='1680|1005|2565|1200|2025'
                                        sorting='T'
                                        styles='width:100%; height:100%'
                                        />
                                    </td>
                                </tr>
                            </table> 
                        </td>
                    </tr>
				 </table>
            </td>
        </tr>
    </table>
</gw:tab>
 
</body>
 
<gw:textbox id="txtOptionMonth" styles="display:none" text="1"/>
<gw:textbox id="txtOptEmpID" styles="display:none" text="1"/>
<gw:textbox id="txtReport_tmp" styles="display:none" text="1"/>
<gw:textbox id="txtDept" styles="display:none"/>	
<gw:textbox id="txtDeptData" styles="display:none"/>
<gw:textbox id="txtUpperDept" styles="display:none"/>
<gw:textbox id="txtGroupData" styles="display:none"/>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/> 
<gw:textbox id="txtdept_temp" styles="display:none"/> 

<gw:textbox id="txtorg_tmp" styles="display:none"/>
<gw:textbox id="txtwg_tmp" styles="display:none"/> 

<gw:textbox id="txtCompany_PK" styles="display:none"/>
</html>
