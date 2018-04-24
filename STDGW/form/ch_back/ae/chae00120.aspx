<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>

//tab resign
var p_select=0;
var p_department=1;
var p_group=2;
var p_emp_id=3;
var p_full_name=4;
var p_join_dt=5;
var p_left_dt=6;
var p_resign_type=7;
var p_remark=8;
var p_ale_last_year=9;
var p_remain_ale=10;
var p_remain_ale_amt=11;
var p_severance_flag=12;
var p_salary=13;
var p_severance_mon=14;
var p_not_unemp_mon=15;
var p_severance_mon_total=16;
var p_severance_amt=17;
var p_seniority_amt=18;
var p_health_yn=19;
var p_return_health_card=20;
var p_not_timely=21;
var p_deduct_mon=22;
var p_return_card=23;
var p_cal_sal=24;
var p_equip1=25;
var p_equip1_amt=26;
var p_equip2=27;
var p_equip2_amt=28;
var p_equip3=29;
var p_equip3_amt=30;
var p_equip4=31;
var p_equip4_amt=32;
var p_equip5=33;
var p_equip5_amt=34;
var p_equip6=35;
var p_equip6_amt=36;
var p_equip7=37;
var p_equip7_amt=38;
var p_equip8=39;
var p_equip8_amt=40;
var p_emp_pk=41;
var p_by_hand=42;
var p_resign_pk=43;


var strcodereturn;
var v_language = "<%=Session("SESSION_LANG")%>";
var l_col_seniority_amt = 18,
    l_col_iEquip1 =25,
    l_col_employee_pk = 41,
    l_col_resign_pk = 43;

var flag_tab=1;
var check_init=0; 	
function BodyInit()
{
    
    if (v_language!="ENG")
        System.Translate(document);
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    menu_id.text=System.Menu.GetMenuID();
    grdEmployee.GetGridControl().FrozenCols =5;
    grdBreakContract.GetGridControl().FrozenCols =4;
    OnOption(option_P,1,dtMonth,lstQuarter,dtYear,dtFromDate,dtToDate)
    OnOption(option_P,1,dtMonth_B,lstQuarter_B,dtYear_B,dtFromDate_B,dtToDate_B)
      seniority_amt="<%=ESysLib.SetDataSQL("select nvl(num_3,0) from vhr_hr_code where id='HR0006' and code='10'")%>";
     <%=ESysLib.SetGridColumnComboFormat( "grdEmployee" , 7 ,  "select code,CODE_NM from vhr_hr_code where id='HR0004' order by code_nm ") %>; 
     <%=ESysLib.SetGridColumnComboFormat( "grdBreakContract" , 5 ,  "select code,CODE_NM from vhr_hr_code where id='HR0004' order by code_nm ") %>; 
     
     grdEmployee.SetComboFormat(p_return_health_card,"#Y;Yes|#N;No|#C;Not Yet");
     
     ChangeColorItem(lstOrg.GetControl());
     ChangeColorItem(lstOrg2.GetControl());

    if(seniority_amt ==0)
    {
        grdEmployee.GetGridControl().ColHidden(l_col_seniority_amt) = true;
    }
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
   if(obj.id == "datCheck_View")
   {
        if(txtFlag_View.text == 'Y')
        {
            ibtnSave.style.display = "none";
            ibtnSave_B.style.display = "none";
            idBtnCalSer.style.display = "none";
            idBtnCalSer_B.style.display = "none";
        }
        if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	    {
            datUser_info.Call();     	    
	    }
        else
	        datEquip.Call("SELECT");
        
   }
   else if (obj.id=="datEquip")
   {
        grdEmployee.SetGridText(0,l_col_iEquip1,grdReturn.GetGridData(1,0));
        grdEmployee.SetGridText(0,l_col_iEquip1+2,grdReturn.GetGridData(1,1));
        grdEmployee.SetGridText(0,l_col_iEquip1+4,grdReturn.GetGridData(1,2));
        grdEmployee.SetGridText(0,l_col_iEquip1+6,grdReturn.GetGridData(1,3));
        grdEmployee.SetGridText(0,l_col_iEquip1+8,grdReturn.GetGridData(1,4));
        grdEmployee.SetGridText(0,l_col_iEquip1+10,grdReturn.GetGridData(1,5));
        grdEmployee.SetGridText(0,l_col_iEquip1+12,grdReturn.GetGridData(1,6));
        grdEmployee.SetGridText(0,l_col_iEquip1+14,grdReturn.GetGridData(1,7));
        grdEmployee.GetGridControl().ColHidden(l_col_iEquip1)=!(grdReturn.GetGridData(1,0)!='');
        grdEmployee.GetGridControl().ColHidden(l_col_iEquip1+1)=!(grdReturn.GetGridData(1,0)!='');
        
        grdEmployee.GetGridControl().ColHidden(l_col_iEquip1+2)=!(grdReturn.GetGridData(1,1)!='');
        grdEmployee.GetGridControl().ColHidden(l_col_iEquip1+3)=!(grdReturn.GetGridData(1,1)!='');
        
        grdEmployee.GetGridControl().ColHidden(l_col_iEquip1+4)=!(grdReturn.GetGridData(1,2)!='');
        grdEmployee.GetGridControl().ColHidden(l_col_iEquip1+5)=!(grdReturn.GetGridData(1,2)!='');
        
        grdEmployee.GetGridControl().ColHidden(l_col_iEquip1+6)=!(grdReturn.GetGridData(1,3)!='');
        grdEmployee.GetGridControl().ColHidden(l_col_iEquip1+7)=!(grdReturn.GetGridData(1,3)!='');
        
        grdEmployee.GetGridControl().ColHidden(l_col_iEquip1+8)=!(grdReturn.GetGridData(1,4)!='');
        grdEmployee.GetGridControl().ColHidden(l_col_iEquip1+9)=!(grdReturn.GetGridData(1,4)!='');
        
        grdEmployee.GetGridControl().ColHidden(l_col_iEquip1+10)=!(grdReturn.GetGridData(1,5)!='');
        grdEmployee.GetGridControl().ColHidden(l_col_iEquip1+11)=!(grdReturn.GetGridData(1,5)!='');
        
        grdEmployee.GetGridControl().ColHidden(l_col_iEquip1+12)=!(grdReturn.GetGridData(1,6)!='');
        grdEmployee.GetGridControl().ColHidden(l_col_iEquip1+13)=!(grdReturn.GetGridData(1,6)!='');
        
        grdEmployee.GetGridControl().ColHidden(l_col_iEquip1+14)=!(grdReturn.GetGridData(1,7)!='');        
        grdEmployee.GetGridControl().ColHidden(l_col_iEquip1+15)=!(grdReturn.GetGridData(1,7)!='');
		onChange_org(0,lstOrg);
   }
   else if (obj.id=="datResignedEmployee")
   {
        lblRecord.text=grdEmployee.rows-1 + " record(s)";
        auto_resize_column(grdEmployee,0,grdEmployee.cols-1,9)
   }
   else if (obj.id=="datBreakContract")
   {
        lblRecord_B.text=grdBreakContract.rows-1 + " record(s)";
        auto_resize_column(grdBreakContract,0,grdBreakContract.cols-1,9)
   }
   else if (obj.id=="datCal_All")
   {
        if (txtResult.text=="1")
        {
            alert("Calculating is sucessful!\nTính toán thành công!");
            datResignedEmployee.Call("SELECT");
        }    
        else
            alert("Calculate have error, pls call admin!\n Tính toán bị lỗi, hãy gọi người quản trị");
   }
   else if (obj.id=="datUser_info")
       {
            lstOrg.SetDataText(txtdept_temp.text);            
            lstOrg2.SetDataText(txtdept_temp.text);

            ChangeColorItem(lstOrg.GetControl());
            ChangeColorItem(lstOrg2.GetControl());

            datEquip.Call("SELECT");
       }
   else if (obj.id=="datFind_Report")
       {
           var url;
            
            if (rpt_no==1)
            {
                if (txtOption.text == 1)    //month
                {
					url =System.RootURL + '/reports/ch/ae/'+ txtReport_tmp.text +'?p_tco_dept_pk=' + lstOrg.value + '&p_thr_wgroup_pk=' + lstWorkGroup.value + '&p_search=' + lstTemp.value + '&p_input=' + txtTemp.text + '&p_from=' + '&p_to=' + '&p_month=' + dtMonth.value + "&p_return_card=" + lstReturn_Card.value + "&p_health_card=" + lstHealth_Card.value +  "&p_type=" + lstType.value;
					url += '&p_nation=' + lstNation.value + '&p_health_yn=' + lstHealth_yn.value ; 
				}
                else if (txtOption.text == 3)  //from date and to date
                {
					url =System.RootURL + '/reports/ch/ae/'+ txtReport_tmp.text +'?p_tco_dept_pk=' + lstOrg.value + '&p_thr_wgroup_pk=' + lstWorkGroup.value + '&p_search=' + lstTemp.value + '&p_input=' + txtTemp.text + '&p_from=' +  dtFromDate.value +'&p_to=' + dtToDate.value + '&p_month=' + "&p_return_card=" + lstReturn_Card.value + "&p_health_card=" + lstHealth_Card.value + "&p_type=" + lstType.value;             
					url += '&p_nation=' + lstNation.value + '&p_health_yn=' + lstHealth_yn.value ;
				}
                else  //quater
                {
                    var fromdt,todt;
                    if (lstQuarter.value =="I")
                    {
                        fromdt=String(dtYear.value) + "0101";
                        todt=String(dtYear.value) + "0331";    
                    }
                    else if (lstQuarter.value =="II")
                    {
                        fromdt=String(dtYear.value) + "0401";
                        todt=String(dtYear.value) + "0630";    
                    }
                    else if (lstQuarter.value =="III")
                    {
                        fromdt=String(dtYear.value) + "0701";
                        todt=String(dtYear.value) + "0930";    
                    }
                    else
                    {
                        fromdt=String(dtYear.value) + "1001";
                        todt=String(dtYear.value) + "1231";    
                    }
                    url =System.RootURL + '/reports/ch/ae/'+ txtReport_tmp.text +'?p_tco_dept_pk=' + lstOrg.value + '&p_thr_wgroup_pk=' + lstWorkGroup.value + '&p_search=' + lstTemp.value + '&p_input=' + txtTemp.text + '&p_from=' +  fromdt +'&p_to=' + todt + '&p_month=' + "&p_return_card=" + lstReturn_Card.value + "&p_health_card=" + lstHealth_Card.value +  "&p_type=" + lstType.value;             
                    url += '&p_nation=' + lstNation.value + '&p_health_yn=' + lstHealth_yn.value ;
                }
                
            }    
            else if(rpt_no==2)
            {
                var pk_list="";
                for (var i=1;i<=grdEmployee.rows-1;i++)
                {
                   if (grdEmployee.GetGridData(i,0)!="0")      
                        if (grdEmployee.GetGridData(i,l_col_resign_pk)!="")
                            pk_list += grdEmployee.GetGridData(i,l_col_resign_pk) + ",";  
                }                
                if (pk_list=="")
                {
                    alert("Please select employees");
                    return;
                }
                url =System.RootURL + '/reports/ch/ae/'+ txtReport_tmp.text+'?pk_list='+pk_list;
                //alert(url);
                //return;
            }
            else
            {
                if (txtOption.text == 1)    //month
				{
                    url =System.RootURL + '/reports/ch/ae/'+txtReport_tmp.text+'?p_tco_dept_pk=' + lstOrg2.value + '&p_thr_wgroup_pk=' + lstWorkGroup_B.value + '&p_search=' + lstTemp_B.value + '&p_input=' + txtTemp_B.text + '&p_from=' + '&p_to=' + '&p_month=' + dtMonth_B.value + "&p_contract_type=" + lstContract_Type_B.value + "&p_break_contract=" + lstBreak_Con_B.value  + "&p_type=" + lstType.value;
					url += '&p_nation=' + lstNation_B.value ;
				}
                else if (txtOption.text == 3)
				{
                    url =System.RootURL + '/reports/ch/ae/'+ txtReport_tmp.text +'?p_tco_dept_pk=' + lstOrg2.value + '&p_thr_wgroup_pk=' + lstWorkGroup_B.value + '&p_search=' + lstTemp_B.value + '&p_input=' + txtTemp_B.text + '&p_from=' +  dtFromDate_B.value + '&p_to=' + dtToDate_B.value + '&p_month=' + "&p_contract_type=" + lstContract_Type_B.value + "&p_break_contract=" + lstBreak_Con_B.value +  "&p_type=" + lstType.value;
					url += '&p_nation=' + lstNation_B.value ;
				}
                else  //quater
                {
                    var fromdt,todt;
                    if (lstQuarter_B.value =="I")
                    {
                        fromdt=String(dtYear_B.value) + "0101";
                        todt=String(dtYear_B.value) + "0331";    
                    }
                    else if (lstQuarter_B.value =="II")
                    {
                        fromdt=String(dtYear_B.value) + "0401";
                        todt=String(dtYear_B.value) + "0630";    
                    }
                    else if (lstQuarter_B.value =="III")
                    {
                        fromdt=String(dtYear_B.value) + "0701";
                        todt=String(dtYear_B.value) + "0930";    
                    }
                    else
                    {
                        fromdt=String(dtYear_B.value) + "1001";
                        todt=String(dtYear_B.value) + "1231";    
                    }
                    url =System.RootURL + '/reports/ch/ae/'+ txtReport_tmp.text +'?p_tco_dept_pk=' + lstOrg2.value + '&p_thr_wgroup_pk=' + lstWorkGroup_B.value + '&p_search=' + lstTemp_B.value + '&p_input=' + txtTemp_B.text + '&p_from=' +  fromdt +'&p_to=' + todt + '&p_month=' + "&p_contract_type=" + lstContract_Type_B.value + "&p_break_contract=" + lstBreak_Con_B.value +  "&p_type=" + lstType.value;            
                    url += '&p_nation=' + lstNation_B.value;
                }
            }   
            window.open(url);
       } 
	else if (obj.id=="datWorkGroup_info")
	   {
			switch (flag_tab) 
			{
				case 0:
				{
					lstWorkGroup.SetDataText(txtwg_tmp.text + "|ALL|Select All");
                    lstWorkGroup.value ="ALL";
					lstWorkGroup_B.SetDataText(txtwg_tmp.text + "|ALL|Select All");
                    lstWorkGroup_B.value ="ALL";
                    break;
				}
				case 1:
				{
					lstWorkGroup.SetDataText(txtwg_tmp.text + "|ALL|Select All");
                    lstWorkGroup.value ="ALL";
					break;
				}	
				case 2:
				{
					lstWorkGroup_B.SetDataText(txtwg_tmp.text + "|ALL|Select All");
                    lstWorkGroup_B.value ="ALL";
					break;
				}
			}
			check_init=1; 
			
	   }
}
//------------------------------------------------
function OnChangeDept(deptobj)
{
    txtDept_PK.text=deptobj.value;
    datTeamData.Call();
}
//------------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
    if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
//-----------------------------------------------
function OnReport(obj)
{
	if(check_init==1)
	{
		rpt_no=obj;
		var url;
		
		if (obj==1)
		{
			txtReport_tmp.text="rpt_employee_resign.aspx";
			txtOrg_tmp_pk.text=lstOrg.value; 
		}	
		else if (obj==2)
		{
			txtReport_tmp.text="rpt_employee_resign_form.aspx"; 
			txtOrg_tmp_pk.text=lstOrg.value; 		
		}	
		else
		{
			txtReport_tmp.text="rpt_employee_resign_break_contract.aspx";
			txtOrg_tmp_pk.text=lstOrg2.value; 
		}	
		datFind_Report.Call();
	}	
}

//-----------------------------------------------
function OnSearch()
{
	if(check_init==1)
	{
		if (tabMain.GetCurrentPageNo()==0)
		{
			if (option_P[0].checked==true)
			{
				txtTemp1.text="1";
				txtTemp2.text=dtMonth.value;
			}
			else if (option_P[1].checked==true)
			{
				txtTemp1.text=lstQuarter.value;
				txtTemp2.text=dtYear.value;
			}
			else if (option_P[2].checked==true)
			{
				txtTemp1.text=dtFromDate.value;
				txtTemp2.text=dtToDate.value;
			}
			
			datResignedEmployee.Call("SELECT");
		}
		else
		{
			if (option_B[0].checked==true)
			{
				txtTemp1.text="1";
				txtTemp2.text=dtMonth_B.value;
			}
			else if (option_B[1].checked==true)
			{
				txtTemp1.text=lstQuarter_B.value;
				txtTemp2.text=dtYear_B.value;
			}
			else if (option_B[2].checked==true)
			{
				txtTemp1.text=dtFromDate_B.value;
				txtTemp2.text=dtToDate_B.value;
			}
			
			datBreakContract.Call("SELECT");
		}
	}	
}

//-----------------------------------------------------
function OnSave(grdobj,datobj)
{
    if (grdobj.rows>1)
        if (confirm("Do you want to save\n Bạn muốn lưu không?"))
            datobj.Call();
        
}
//-----------------------------------------------------
function OnOption(option,obj,vdtMonth,vlstQuarter,vdtYear,vdtFromDate,vdtToDate)
{
    txtOption.text = obj;
    if (obj==1)
    {
       
        vdtMonth.SetEnable(true);
        vlstQuarter.SetEnable(false);
        vdtYear.SetEnable(false);
        vdtFromDate.SetEnable(false);
        vdtToDate.SetEnable(false);
        
    }
    else if (obj==2)
    {
        vdtMonth.SetEnable(false);
        vlstQuarter.SetEnable(true);
        vdtYear.SetEnable(true);
        vdtFromDate.SetEnable(false);
        vdtToDate.SetEnable(false);
    }
    else
    {
        vdtMonth.SetEnable(false);
        vlstQuarter.SetEnable(false);
        vdtYear.SetEnable(false);
        vdtFromDate.SetEnable(true);
        vdtToDate.SetEnable(true);
        
    }
}
//----------------------------------------
function ShowDetail(grd_obj,emp_pk_obj)
{
    var itype,isal,iale,ileft_dt;
    if (grd_obj==grdEmployee)
    {
        itype=7; //resign type column
        iale=10;
        isal=17;
        ileft_dt=6;
    }
    else
    {
        itype=5; //resign type column
        isal=3;
    }
    if (event.col==itype ) // double on resign type column
    {
        var code=grd_obj.GetGridData(event.row,itype);
        var id="HR0004";
        var fpath = System.RootURL + "/form/ch/cs/chcs0020_code.aspx?code=" + code + "&id=" + id;
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:30;dialogHeight:25;dialogLeft:300;dialogTop:230;edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {
            if(obj[0]!=code)
            {
                grd_obj.SetGridText(event.row,itype,obj[0]);
                grd_obj.SetCellBgColor(event.row, itype,event.row, itype, 0xcc99ff );
                grd_obj.SetCellBold(event.row,itype,event.row,itype,true);
            }
        
        }
    }
    else if (event.col==iale && grd_obj==grdEmployee) // double on remain ale column
    {
        var emp_pk=grd_obj.GetGridData(event.row,emp_pk_obj);
        var left_dt=grd_obj.GetGridData(event.row,ileft_dt);
        var fpath = System.RootURL + "/form/ch/ae/chae00120_ale.aspx?emp_pk=" + emp_pk + "&year=" + left_dt.substr(0,4);
        window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:30;dialogHeight:25;dialogLeft:300;dialogTop:230;edge:sunken;scroll:yes;unadorned:yes;help:no');
    }
    else if (event.col==isal) // double on salary column
    {
        var emp_pk=grd_obj.GetGridData(event.row,emp_pk_obj);
        
        var fpath = System.RootURL + "/form/ch/ae/chae00120_salary.aspx?emp_pk=" + emp_pk ;
        window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:50;dialogHeight:25;dialogLeft:100;dialogTop:230;edge:sunken;scroll:yes;unadorned:yes;help:no');
    }
}
//----------------------------------
function OnCal_ALL()
{
    if (confirm("Do you want to calcualte all again?\n Bạn có muốn tính lại cho tất cả không?"))
    {
        datCal_All.Call();
    }
}
//----------------------------------
function onPage_active()
{
    
}
//------------------------------------
function OnCal_Break_Contract()
{
    if (confirm("Calculate all employee in list will take a long time, Do you want to continue?\nCông việc thực hiện một khoảng thời gian, Bạn có muốn tiếp tục không?"))
    {
        for (var i=0;i<grdBreakContract.rows;i++)
        {
                grdBreakContract.SetRowStatus(i,16);
        }
    }    
    datBreakContract.Call();
}

function OnSetGrid(obj_checkbox,obj_grd,obj_col)
{	
    var tmp;
    if( obj_checkbox.GetData()=='T')
		tmp=-1;
	else
		tmp=0;
    var ctrl = obj_grd.GetGridControl();
    
    if (ctrl.SelectedRows>0)
    {
	    for ( var i =  0 ; i < ctrl.SelectedRows ; i++ )
		    {
			    var row = ctrl.SelectedRow(i);
			    if ( row > 0 )
			    {		
				    obj_grd.SetGridText(row,obj_col,tmp);
			    }
		    }
	}
	else
	{
	    for ( var i =  1 ; i < ctrl.rows ; i++ )
				    obj_grd.SetGridText(i,obj_col,tmp);
	}
}

//-----------------------------------------------
function OnShowPopup(n)
{
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:60;dialogTop:200;edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {
            if(n==1)
			{
				lstOrg1.value=obj;
				onChange_org(1,lstOrg1);
			}	
			else  
			{
				lstOrg2.value=obj;   
				onChange_org(2,lstOrg2);
			}	
        }
}

function onChange_org(tab,obj)
{
	flag_tab=tab;
	txtorg_tmp.text=obj.value;
	datWorkGroup_info.Call();
	
}

function OnSetGrird()
 {
    var ctrl=grdEmployee.GetGridControl(); 
    if (ctrl.SelectedRows>0)
	{ 	    	    	
	       for ( var i =  0 ; i < ctrl.SelectedRows ; i++ )
		    {
			    var row = ctrl.SelectedRow(i);
			    if ( row > 0 )
			    {		
				    grdEmployee.SetGridText(row,p_deduct_mon,txtDeduct_mon.text);
			    }
		    }
	}
 }



//-----------------------
function checkNumber()
 {
    if(isNaN(txtDeduct_mon.text))
    {
        txtDeduct_mon.SetDataText("");
        alert("You must input number value for field deduct mon");
        return;
    }
 }

</script>
<body >
<!-------------------data control----------------------->
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
<gw:data id="datWorkGroup_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="HR_SP_SEL_WG_ROLE"  > 
                <input>
                    <input bind="txtorg_tmp" />
                </input> 
                <output>
                    <output bind="txtwg_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datEquip" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="HR_SEL_10010012_EQUIP_RETURN" > 
                <input bind="grdReturn" >
                </input>
                <output  bind="grdReturn" />
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------->
<gw:data id="datCal_All" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_PRO_10010012_CAL_ALL" > 
                <input>
                    <input bind="txtTemp1" /> 
                    <input bind="txtTemp2" /> 
                    <input bind="lstOrg" /> 
                    <input bind="lstWorkGroup" /> 
                    <input bind="lstType" /> 
                    <input bind="lstTemp" /> 
                    <input bind="txtTemp" /> 
                    <input bind="lstReturn_Card" /> 
                    <input bind="lstHealth_Card" /> 
					<input bind="lstNation" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------------------------------->
<gw:data id="datResignedEmployee" onreceive="OnDataReceive(this)"  > 
        <xml> 
           <dso  type="grid"  function="HR_SEL_10010012_RESIGNED_EMP" parameter="6,7,8,10,11,12,14,15,17,18,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43" procedure="HR_UPD_10010012_RESIGNED_EMP"> 
                <input bind="grdEmployee">
                    <input bind="txtTemp1" /> 
                    <input bind="txtTemp2" /> 
                    <input bind="lstOrg" /> 
                    <input bind="lstWorkGroup" /> 
                    <input bind="lstType" /> 
                    <input bind="lstTemp" /> 
                    <input bind="txtTemp" /> 
                    <input bind="lstReturn_Card" /> 
                    <input bind="lstHealth_Card" /> 
					<input bind="lstNation" />
                    <input bind="lstHealth_yn" />
					
                </input> 
                <output bind="grdEmployee"/>
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------------------------------->
<gw:data id="datBreakContract" onreceive="OnDataReceive(this)"  > 
        <xml> 
           <dso  type="grid"  function="HR_SEL_10010012_BREAK_CONTRACT" parameter="0,5,7,8,9,10,11,13,14" procedure="HR_UPD_10010012_BREAK_CONTRACT"> 
                <input bind="grdBreakContract">
                    <input bind="txtTemp1" /> 
                    <input bind="txtTemp2" /> 
                    <input bind="lstOrg2" /> 
                    <input bind="lstWorkGroup_B" /> 
                    <input bind="lstType_B" /> 
                    <input bind="lstTemp_B" /> 
                    <input bind="txtTemp_B" /> 
                    <input bind="lstContract_Type_B" /> 
                    <input bind="lstBreak_Con_B" />  
					<input bind="lstNation_B" />
					
                </input> 
                <output bind="grdBreakContract"/>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="HR_SP_SEL_USER_ROLE2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="txtdept_temp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------>
<gw:data id="datFind_Report" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_SP_PRO_FIND_REPORT_2" > 
                <input>
                    <input bind="txtReport_tmp" /> 
                    <input bind="txtOrg_tmp_pk" />
                </input> 
                <output>
                    <output bind="txtReport_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!-------------------data control----------------------->
<gw:tab id="tabMain"  border=1 style="width:100%;height:100%;" onpageactivate="onPage_active()" >
   <table name="Resigned Employee" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="tblexp" style="height:100%" border=0 cellpadding="0" cellspacing="0">
					<tr width="100%">
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					</tr>
                    <tr>
					    <td colspan="10" align="right"><input type="radio" id="Radio2" checked name="option_P" value="3" onclick="OnOption(option_P,1,dtMonth,lstQuarter,dtYear,dtFromDate,dtToDate)"><strong><font color="#000000">Month</font></strong></td>					
					    <td colspan="13" align="center">
								    <gw:datebox styles="width:50%" lang="<%=Session("Lang")%>"  id="dtMonth" type="month">
						</gw:datebox>
					    </td>
					    
					    <td colspan="10" align=right><input type="radio"  id="Radio1" name="option_P" value="2" onclick="OnOption(option_P,2,dtMonth,lstQuarter,dtYear,dtFromDate,dtToDate)"><strong><font color="#000000">Quarter</font></strong></td>					
					    <td  colspan="24" align="center" valign="top">
								    <gw:list id="lstQuarter" styles="width:100%">
										    <data>DATA|I|Qu&#253; I|II|Qu&#253; II|III|Qu&#253; III|IV|Qu&#253; IV</data>
								    </gw:list>
					    </td>
					    <td colspan="7" align="right"><strong><font color="#000000">Year</font></strong></td>
					    <td colspan="10"  align="center">
							    <gw:datebox lang="<%=Session("Lang")%>"  id="dtYear" styles="width:50%" type="year">
							    </gw:datebox>
					    </td>
					    <td colspan="5" align="right"><input type="radio"  id="idOption" name="option_P" value="1" onclick="OnOption(option_P,3,dtMonth,lstQuarter,dtYear,dtFromDate,dtToDate)"><strong><font color="#000000">Date</font></strong></td>
					    <td colspan="10" align="left" >
								    <gw:datebox styles="width:60%" lang="<%=Session("Lang")%>"  id="dtFromDate" type="date">
								    </gw:datebox>
					    </td>
					    <td colspan="2" align="center"><strong><font color="#000000"> ~ </font></strong></td>
					    <td colspan="9"><gw:datebox styles="width:60%" lang="<%=Session("Lang")%>"  id="dtToDate" type="date">
								    </gw:datebox>
					    </td>
					    							
				    </tr>
					<tr width="100%" height="2%"><td></td></tr>
					<tr>
					    
						<td colspan="10" align="right"><a title="Click here to show organization" onclick="OnShowPopup(1)" href="#tips" style="text-decoration : none; color=#0000FF">Organization</a></td>
						<td colspan="15">
							<gw:list  id="lstOrg" value='ALL' maxlen = "100" styles='width:100%' onchange="onChange_org(1,lstOrg)" >
								<data>
									<%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
								</data>
							</gw:list>
						</td>
						<td colspan="8" align="right">Work Group</td>
						<td colspan="24"> <gw:list  id="lstWorkGroup" value='ALL' maxlen = "100" styles='width:100%' >
                            <data>
									<%=ESysLib.SetListDataSQL("SELECT PK, WORKGROUP_NM FROM THR_WORK_GROUP WHERE DEL_IF = 0")%>|ALL|Select All
							</data></gw:list>
						</td>
						<td colspan="7" align="right" >Nation</td>
                        <td colspan="10" align="left" ><gw:list  id="lstNation" value='01' maxlen = "100" styles='width:100%' >
							<data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by code_nm" )%>|ALL|Select All</data></gw:list>
                        </td>
						<td  colspan="5" align="right" >Type</td>
                        <td  colspan="10"  align="left" >
							 <gw:list  id="lstType" value='ALL' maxlen = "100" styles='width:100%' >
								<data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0004' order by code_nm")%>|ALL|Select All</data></gw:list>
                        </td>
                        <td colspan="2" align="center">Health YN</td>
                        <td colspan="9" align="left" > <gw:list  id="lstHealth_yn" value='ALL' maxlen = "100" styles='width:100%' >
								<data>
									|Y|Yes|N|No|ALL|Select All
								</data>
							</gw:list></td>
					</tr>
					<tr width="100%" height="2%"><td></td></tr>
                    <tr style="border:0;width:100%" valign="center" >
                         <td colspan="2"  align="right" valign="middle">  <gw:checkbox  id="chkSelect" value="F"  onclick="OnSetGrid(chkSelect,grdEmployee,0)" >
                            
                        </gw:checkbox></td>
                        <td colspan="8"  align="right" valign="middle">Search by</td>
					    <td colspan="7"  style="border:0">
					        <gw:list  id="lstTemp" value="2" styles='width:100%' onchange=""> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID</data> 
					        </gw:list>
				        </td>
                         <td colspan="8"> 
					        <gw:textbox id="txtTemp" onenterkey   ="OnSearch()" styles='width:100%'/>
				        </td>
						<td colspan="8"  align="right" >Return Card</td>
						<td colspan="7" align="left" > <gw:list  id="lstReturn_Card" value='ALL' maxlen = "100" styles='width:100%' >
								<data>
									|Y|Yes|N|No|ALL|Select All
								</data>
							</gw:list></td>
						<td  colspan="10" align="right" >Return Health Card</td>
                        <td  colspan="7"  align="left" > <gw:list  id="lstHealth_Card" value='ALL' maxlen = "100" styles='width:100%' >
                            <data> |Y|Yes|N|No|ALL|Select All</data></gw:list>	
                        </td>
                        <td colspan="7"  align="right" >Deduct mon</td>
						<td colspan="8" align="left" > <gw:textbox id="txtDeduct_mon"  styles='width:100%' onchange="checkNumber()"/></td>
                        <td colspan="2" align="left" > <gw:imgBtn img="set" id="ibtnSet"   alt="Set Grid"  onclick="OnSetGrird()"/></td>
						<td colspan="1" align="center"></td>
						<td colspan="2"></td>
                        <td colspan="7"  align="center" ><gw:icon id="idBtnCalSer"   styles='width:80%' img="in"  text="Calc ALL"  onclick="OnCal_ALL()"/>
                         </td>
						<td colspan="2" align="right" width="4%">
                         <gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch()"/>
                        </td>
                        <td  colspan="2" align="right" width="3%">
                         <gw:imgBtn img="save" id="ibtnSave"    alt="Save"  onclick="OnSave(grdEmployee,datResignedEmployee)"/>
                        </td>
                        <td colspan="2" align="right" width="3%">
                         <gw:imgBtn img="excel" id="ibtnPrinter"    alt="Report"  onclick="OnReport(1)"/>
                        </td>
                        <td colspan="2" align="center">
                            <gw:imgBtn img="excel" id="ibtnPrintResignedForm"
                                alt="Resign Form Report"  onclick="OnReport(2)"/>
                        </td>
						<td colspan="10" align="center"><gw:label id="lblRecord"  text="0 record(s)" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" /></td>
                    </tr>
					
					<tr width="100%" height="1%"><td></td></tr>
					<tr style="width:100%;height:100%" valign="top">
                        <td colspan="100" style="width:100%;height:100%"> 
                          <gw:grid id="grdEmployee" 
					        header="Select|_Department|Group|Emp ID|Full Name|Join Date|Left Date|Resign Type|Remark|ALE Last Year|Remain ALE|Remain ALE AMT|Severance Flag|_Salary|Severance Month|Not UnEmp Month|Severance Month Total|Severance Amount|Seniority AMT|Health YN|Return Health Card|Not Timely|Deduct Months|_Return Card|_Calculate Salary|EQUIP 1|Amount|EQUIP 2|Amount|EQUIP 3|Amount|EQUIP 4|Amount|EQUIP 5|Amount|EQUIP 6|Amount|EQUIP 7|Amount|EQUIP 8|Amount|_EMP_PK|By Hand|_RESIGN_PK" 
					        format="3|0|0|0|0|4|4|2|1|1|0|1|3|1|0|0|0|1|1|0|2|3|0|3|3|3|1|3|1|3|1|3|1|3|1|3|1|3|1|3|1|0|3|0" 
					        aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
					        defaults="|||||||||||||||||||||||||||||||||||||||||||" 
					       editcol="1|0|0|0|0|0|0|1|1|1|1|1|1|0|1|1|0|1|1|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1" 
					        widths="700|1500|1500|1000|2500|1200|1200|2500|1300|1200|1200|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1500|1500|1200|1500" 
					        styles="width:100%; height:100%"
					        sorting="T" acceptNullDate 
					         oncelldblclick="ShowDetail(grdEmployee,l_col_employee_pk)" />				                         
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table name="Break Contract" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table style="width:100%;height:100%" id="Table1" style="height:15%" border=0 cellpadding="0" cellspacing="0">
					<tr width="100%">
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
						<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					</tr>
                    <tr>
					    <td colspan="10" align=right><input type="radio" id="Radio3" checked name="option_B" value="3" onclick="OnOption(option_B,1,dtMonth_B,lstQuarter_B,dtYear_B,dtFromDate_B,dtToDate_B)"><strong><font color="#000000">Month</font></strong></td>					
					    <td colspan="15"  align="center">
								    <gw:datebox styles="width:50%" lang="<%=Session("Lang")%>"  id="dtMonth_B" type="month">
						</gw:datebox>
					    </td>
					    
					    <td colspan="10" align=right><input type="radio"  id="Radio4" name="option_B" value="2" onclick="OnOption(option_B,2,dtMonth_B,lstQuarter_B,dtYear_B,dtFromDate_B,dtToDate_B)"><strong><font color="#000000">Quarter</font></strong></td>					
					    <td colspan="15" align="center" valign="top">
								    <gw:list id="lstQuarter_B" styles="width:100%">
										    <data>DATA|I|Qu&#253; I|II|Qu&#253; II|III|Qu&#253; III|IV|Qu&#253; IV</data>
								    </gw:list>
					    </td>
					    <td colspan="10" align="right"><strong><font color="#000000">Year</font></strong></td>
					    <td colspan="15" align="center">
							    <gw:datebox lang="<%=Session("Lang")%>"  id="dtYear_B" styles="width:100%" type="year">
							    </gw:datebox>
					    </td>
					    <td colspan="5"  align="right"><input type="radio"  id="Radio5" name="option_B" value="1" onclick="OnOption(option_B,3,dtMonth_B,lstQuarter_B,dtYear_B,dtFromDate_B,dtToDate_B)"><strong><font color="#000000">Date</font></strong></td>
					    <td colspan="9" align="left" >
								    <gw:datebox styles="width:100%" lang="<%=Session("Lang")%>"  id="dtFromDate_B" type="date">
								    </gw:datebox>
					    </td>
					    <td colspan="1" align="center"><strong><font color="#000000"> ~ </font></strong></td>
					    <td colspan="10"s colspan=3><gw:datebox styles="width:100%" lang="<%=Session("Lang")%>"  id="dtToDate_B" type="date">
								    </gw:datebox>
					    </td>
					    							
				    </tr>		
					<tr width="100%" height="2%"><td></td></tr>
					<tr>
						<td colspan="10" align="right"><a title="Click here to show organization" onclick="OnShowPopup(2)" href="#tips" style="text-decoration : none; color=#0000FF">Organization</a></td>
						<td colspan="15">
							<gw:list  id="lstOrg2" value='ALL' maxlen = "100" styles='width:100%' onchange="onChange_org(2,lstOrg2)" >
								<data>
									<%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
								</data>
							</gw:list>
						</td>
						<td colspan="10" align="right">Work Group</td>
						<td colspan="15">  <gw:list  id="lstWorkGroup_B" value='ALL' maxlen = "100" styles='width:100%' >
                            <data>
									<%=ESysLib.SetListDataSQL("SELECT PK, WORKGROUP_NM FROM THR_WORK_GROUP WHERE DEL_IF = 0")%>|ALL|Select All
							</data></gw:list>
						</td>
						<td colspan="10" align="right" >Nation</td>
                        <td colspan="15" align="left" ><gw:list  id="lstNation_B" value='01' maxlen = "100" styles='width:100%' >
							<data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by code_nm" )%>|ALL|Select All</data></gw:list></td>
						</td>
						<td colspan="10" align="right" >Type</td>
                        <td colspan="16" align="left" ><gw:list  id="lstType_B" value='ALL' maxlen = "100" styles='width:100%' >
								<data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0004' order by code_nm")%>|ALL|Select All</data></gw:list>
                       </td>
						
					</tr>
					<tr width="100%" height="2%"><td></td></tr>
					<tr style="border:0;width:100%" valign="center" >
                        <td colspan="10"  align="right" valign="middle">Search by</td>
					    <td colspan="7"  style="border:0">
					        <gw:list  id="lstTemp_B" value="2" styles='width:100%' onchange=""> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID</data> 
					        </gw:list>
				        </td>
                         <td colspan="8"> 
					        <gw:textbox id="txtTemp_B" onenterkey   ="OnSearch()" styles='width:100%'/>
				        </td>
						<td colspan="10"  align="right" >Contract Type</td>
						<td colspan="15" align="left" > <gw:list  id="lstContract_Type_B" value='ALL' maxlen = "100" styles='width:100%' >
                            <data>
                                |Y|Yes|N|No|ALL|Select All
                            </data> </gw:list></td>
						<td  colspan="10" align="right" >Break Contract</td>
                        <td  colspan="15"  align="left" > <gw:list  id="lstBreak_Con_B" value='ALL' maxlen = "100" styles='width:100%' >
                            <data> |Y|Yes|N|No|ALL|Select All</data></gw:list>
							  </td>
						<td colspan="1" align="center"></td>
						<td colspan="1"></td>
                        <td  align="center" colspan="10"><gw:icon id="idBtnCalSer_B"   styles='width:80%' img="in"  text="Calc ALL"  onclick="OnCal_Break_Contract()"/>
                         </td>
                        <td  align="right"  colspan="2">
                         <gw:imgBtn img="search" id="ibtnSearch_B"   alt="Search"  onclick="OnSearch()"/>
                        </td>
                        <td   align="right"  colspan="2">
                         <gw:imgBtn img="save" id="ibtnSave_B"    alt="Save"  onclick="OnSave(grdBreakContract,datBreakContract)"/>
                        </td>
                        <td  align="right"  colspan="2">
                         <gw:imgBtn img="excel" id="ibtnPrinter_B"    alt="Report"  onclick="OnReport(3)"/>
                        </td>
						<td colspan="8" align="center"><gw:label id="lblRecord_B"  text="0 record(s)" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" /></td>
						
                    </tr>
                 <tr width="100%" height="1%"><td></td></tr>
					<tr style="width:100%;height:100%" valign="top">
                        <td colspan="100" style="width:100%;height:100%"> 
                           <gw:grid id="grdBreakContract" 
					        header="_Emp PK|Team/Section|Emp ID|Full Name|Join Date|Resign Type|Contract No.|Deduct Days(Rule)|Break Contract|Notice Date|Left Date|Deduct Days|_Basic Salary|Deduct Amount|Input by Hand" 
					        format="0|0|0|0|4|2|0|0|3|4|4|0|1|1|3" 
					        aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
					        defaults="||||||||||||||" 
					        editcol="0|0|0|0|0|0|0|0|1|1|0|0|0|1|1" 
					        widths="1000|1500|1000|2500|1200|1200|2500|1300|1200|1500|1500|1500|1800|1800|1500" 
					        styles="width:100%; height:100%" 
					        sorting="T" acceptNullDate 
					        oncelldblclick="ShowDetail(grdBreakContract,0)" />				                         
                        </td>
                    </tr>
					
                </table>
            </td>
        </tr>
    </table>
</gw:tab>
</body>
<gw:textbox id="txtdept_temp" styles="display:none"/>
<gw:textbox id="txtDept_PK" styles="display:none"/>
<gw:textbox id="txtOption" text="1" styles="display:none"/> 
<gw:textbox id="txtUpperDept" styles="display:none"/>
<gw:textbox id="txtGroupData" styles="display:none"/>
<gw:textbox id="txtTemp1" styles="display:none"/>
<gw:textbox id="txtTemp2" styles="display:none"/>
<gw:textbox id="txtResult" styles="display:none" text="0"/>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
<gw:textbox id="txtReport_tmp" styles="display:none"/>
<gw:textbox id="txtOrg_tmp_pk" text="" styles="display:none"  />
<gw:textbox id="txtorg_tmp" styles="display:none"/>
<gw:textbox id="txtwg_tmp" styles="display:none"/> 
<gw:textbox id="menu_id" text="" styles="display:none"  />
<gw:textbox id="txtFlag_View" text="" styles="display:none"  />
<gw:grid   
    id="grdReturn"  
    header="Code Name 1|Code Name 2|Code Name 3|Code Name 4|Code Name 5|Code Name 6|Code Name 7|Code Name 8"
    format="0|0|0|0|0|0|0|0"  
    aligns="0|2|2|1|0|0|1|1"  
    defaults="|||||||"  
    editcol="0|0|0|0|0|1|1|1"  
    widths="1500|1500|1600|1000|2500|1500|1700|1500"  
    styles="display:none" 
    sorting="T"    
/> 
</html>
