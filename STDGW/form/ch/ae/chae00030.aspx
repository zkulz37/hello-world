<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var byhand;
var cIdx,rIdx;
var dt_tmp;
var strcodereturn;
var user;
var rowclick;
var value_old;
var datenow;
var flag_wg=1;
var tab2=false;

var check_init=0;

var v_language = "<%=Session("SESSION_LANG")%>";
var rpt_no=0;

//tab 1
//_PK|Organization|Work Group|Emp ID|Old Code|Full Name|ID Num|Join Date|Birth Date|Place Birth|Telephone|
//Permanent Address|Present Address|Sex|Person ID|Issue Date|Place Per ID|Married|Nation|Ethenic|Religion|
//Education|Job|Position|Probation Type|Begin Probation|End  Probation|Contract Kind|Contract NO|
//Begin Contract|End Contract|Social Flag|Social No|Social Place|Social Date|Health Flag|Health No|Health Place|
//Health Date|Unemp Flag|Unemp Date|Employee Type|OT YN|Salary YN|Probation Salary|Basic Salary|
//Allow Amt1|Allow Amt2|Allow Amt3|Allow Amt4|Allow Amt5|Allow Amt6|Allow Amt7|Allow Amt8|
//Pay Type|Bank Type|Bank Branch|Account|Status|Left Date|Resign Type|Cost Group|Group Kind|Cost Center|
//Pass Port No|Pass Port Date|Remark|Union YN|Union Date|Pit No|_ByHand_YN|_PK_CostKind|_House YN|Meal YN|_PK_ORG|
//Salary Period|_Register Ins|N Country 2

var p_PK =0;
var p_Organization=1;
var p_WorkGroup= 2;
var p_EmpID=3;
var p_OldID = 4;
var p_FullName= 5;
var p_IDNum=6;
var p_JoinDate=7 ;
var p_BirthDate=8;
var p_PlaceBirth= 9;
var p_Telephone= 10;
var p_PermanentAddress=11;
var p_PresentAddress=12;
var p_Sex=13;
var p_PersonID=14;
var p_IssueDate= 15;
var p_PlacePerID=16;
var p_Married= 17;
var p_Nation= 18;
var p_Ethenic= 19;
var p_Religion= 20;
var p_Education=21;
var p_Job=22;
var p_Position= 23;
var p_ProbationType= 24;
var p_BeginProbation= 25;
var p_EndProbation= 26;
var p_ContractKind= 27;
var p_ContractNO= 28;
var p_BeginContract= 29;
var p_EndContract= 30;
var p_SocialFlag= 31;
var p_SocialNo= 32;
var p_SocialPlace= 33;
var p_SocialDate= 34;
var p_HealthFlag= 35;
var p_HealthNo= 36;
var p_HealthPlace=37;
var p_HealthDate= 38;
var p_UnempFlag= 39;
var p_UnempDate= 40;
var p_EmployeeType= 41;
var p_OTYN =42;
var p_SalaryYN= 43;
var p_ProbationSalary= 44;
var p_BasicSalary= 45;
var p_AllowAmt1= 46;
var p_AllowAmt2 =47;
var p_AllowAmt3= 48;
var p_AllowAmt4= 49;
var p_AllowAmt5= 50;
var p_AllowAmt6 =51;
var p_AllowAmt7= 52;
var p_AllowAmt8= 53;
var p_PayType= 54;
var p_BankType= 55;
var p_bank_branch=56;
var p_Account= 57;
var p_Status= 58;
var p_LeftDate= 59;
var p_ResignType= 60;
var p_CostGroup =61
var p_GroupKind= 62
var p_CostKind= 63;
var p_PassPortNo= 64;
var p_PassPortDate= 65;
var p_Remark= 66;
var p_Union= 67;
var p_union_dt=68;
var p_PitNo= 69;
var p_ByHand_YN=70;
var p_pk_CostKind=71;
var p_house_yn=72;
var p_meal_yn=73;
var p_pk_Org=74;
var p_sal_peirod=75;
var p_contract_yn=77;

//"_PK|Department|Group|Emp ID|Full Name|Join Date|Social Flag|Social No Old|Social No|Social Date|Social Place|Health Flag|Health No
//|Health Date|Health Place|Unemp Flag|Unemp Date|Social Book "   
var g2_pk = 0;
    g2_org= 1; 
    g2_work_group = 2;
    g2_emp_id = 3;
    g2_fullname = 4;
    g2_join_dt = 5;
    g2_social_flag = 6;
    g2_social_no_old =  7;
    g2_social_no = 8;
    g2_social_dt = 9;
    g2_social_place = 10;
    g2_health_flag = 11;
    g2_health_no = 12;
    g2_health_dt = 13;
    g2_health_place = 14;
    g2_unemp_flag = 15;
    g2_unemp_dt = 16;
    g2_social_book = 17;
    g2_ins_Salary = 18;
    g2_submit_dt = 19;
    g2_return_dt = 20;
    g2_month_ins = 21;
    g2_remark = 22;
    g2_description = 23;

function BodyInit()
{
    
	grdEmployee.GetGridControl().FrozenCols =6;
	grdEmployee2.GetGridControl().FrozenCols =4;
    grdEmployee.GetGridControl().ScrollTrack=true;
	grdEmployee2.GetGridControl().ScrollTrack=true;
    if (v_language!="ENG")
        System.Translate(document);
    ibtnSave.SetEnable(false);
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    user="<%=session("USER_ID")%>";
    menu_id.text=System.Menu.GetMenuID();
    BindingDataList();
    ChangeColorItem(lstOrg_Code.GetControl());
    ChangeColorItem(lstOrg_Code2.GetControl());
        
    datCheck_View.Call();
    

    //Lay ngay hien tai cho grid
    var now = new Date();
    var year = now.getFullYear();
    var month = now.getMonth()+1;
        if(month<10) month='0'+month;
    var date = now.getDate();
        if(date<10) date='0' + date;
    datenow = ''+year+month+date;
}

//----------------------------------
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
function OnShowPopup(m)
{     
        var strcom;
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
        //var obj  = System.OpenModal(  fpath , 300 , 200 , 'resizable:yes;status:yes');
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:'+window.event.screenX+';dialogTop:'+window.event.screenY+';edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {  if(m==2)
			{lstOrg_Code2.value = obj;
            //txtUpperOrg.text=obj;
            //datOrgData2.Call();
			}
			else
			{
			lstOrg_Code.value = obj;
            //txtUpperOrg.text=obj;
            //datOrgData.Call();
			}
			
            
        }
}
function BindingDataList()
{   
    
      var t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0021' order by code_nm")%>";
       grdEmployee.SetComboFormat(p_PlaceBirth,t1);
    
       t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0013' order by code_nm")%>";
       grdEmployee.SetComboFormat(p_SocialPlace,t1);
       t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0012' order by code_nm")%>";
       grdEmployee.SetComboFormat(p_HealthPlace,t1);
       t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0007' order by code_nm")%>";
       grdEmployee.SetComboFormat(p_Sex,t1);
        t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0014' order by code_nm")%>";
       grdEmployee.SetComboFormat(p_PlacePerID,t1);
       t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by code_nm")%>";
       grdEmployee.SetComboFormat(p_Nation,t1);
       t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0015' order by code_nm")%>";
       grdEmployee.SetComboFormat(p_Ethenic,t1);
       t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0016' order by code_nm")%>";
       grdEmployee.SetComboFormat(p_Religion,t1);
       t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0011' order by code_nm")%>";
       grdEmployee.SetComboFormat(p_Education,t1);
       t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0010' order by code_nm")%>";
       grdEmployee.SetComboFormat(p_Job,t1);
       t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm")%>";
       grdEmployee.SetComboFormat(p_Position,t1);
       t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0017' order by code_nm")%>";
       grdEmployee.SetComboFormat(p_EmployeeType,t1);
       t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0023' order by code_nm")%>";
       grdEmployee.SetComboFormat(p_PayType,t1);
       t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0020' order by code_nm")%>";
       grdEmployee.SetComboFormat(p_BankType,t1);
       t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0092' order by code_nm")%>";
       grdEmployee.SetComboFormat(p_CostGroup,t1);
       t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0093' order by code_nm")%>";
       grdEmployee.SetComboFormat(p_GroupKind,t1);
	   t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0116' order by code_nm")%>";
       grdEmployee.SetComboFormat(p_bank_branch,t1);
       
       t1 = "<%=ESysLib.SetGridColumnDataSQL("select pk,org_nm from tco_org where del_if=0 order by org_nm")%>";
       grdEmployee.SetComboFormat(p_pk_Org,t1);
	   
       t1 = "<%=ESysLib.SetGridColumnDataSQL("select v.code,v.CODE_NM||' '|| v.CHAR_1||'->'||v.CHAR_2 from vhr_hr_code v where v.id='HR0030' and v.num_1=1 and nvl(v.tco_company_pk,'" + session("COMPANY_PK") + "')='" + session("COMPANY_PK") + "' union all select null,null from dual order by 1")%>";
       grdEmployee.SetComboFormat(p_sal_peirod ,t1);
       
      // tmp="#Y;Yes|#N;No";
      // grdEmployee.SetComboFormat(p_contract_yn,tmp);// contract_yn
	   
       t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0175' order by code_nm")%>";
       grdEmployee2.SetComboFormat(g2_social_book ,t1);
	   
	   tmp="#Y;Yes|#N;No";
    grdEmployee2.SetComboFormat(g2_social_flag,tmp);//social yn
    tmp="<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0013' order by code_nm") %>";
    grdEmployee2.SetComboFormat(g2_social_place,tmp);// social place
    tmp="#Y;Yes|#N;No";
    grdEmployee2.SetComboFormat(g2_health_flag,tmp);//health yn
   tmp="<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0012' order by code_nm") %>";
    grdEmployee2.SetComboFormat(g2_health_place,tmp);// health place
    tmp="#Y;Yes|#N;No";
    grdEmployee2.SetComboFormat(g2_unemp_flag,tmp);//unEMp yn
//	tmp="#0;Not Have|#1;Have|#2;Submit|#3;Return";
//    grdEmployee2.SetComboFormat(g2_social_book,tmp);//social book
    
    
}

function ChoseList_box(obj_list,value)
{
    
    obj_list.SetDataText(value);
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
            ibtnSave2.style.display = "none";
        }
        datAllowance.Call();
   }
   else if (obj.id=="datDeptData")
   {
        if(txtHr_level.text=="6")
                txtDeptData.text=txtDeptData.text+"|ALL|Select All";
            lstOrg_Code.SetDataText(txtDeptData.text)    ;
            
              obj=lstOrg_Code.GetControl()
		    if (obj.options.length ==2)
			    obj.options.selectedIndex=0;
		    else
			    obj.options.selectedIndex=0;
   
   }
  
   else if (obj.id=="datAllowance")
   {
        var icol=p_AllowAmt1; //value of allowance col
        grdEmployee.SetGridText(0,icol,grdAllowance.GetGridData(1,0));
        grdEmployee.SetGridText(0,icol+1,grdAllowance.GetGridData(1,1));
        grdEmployee.SetGridText(0,icol+2,grdAllowance.GetGridData(1,2));
        grdEmployee.SetGridText(0,icol+3,grdAllowance.GetGridData(1,3));
        grdEmployee.SetGridText(0,icol+4,grdAllowance.GetGridData(1,4));
        grdEmployee.SetGridText(0,icol+5,grdAllowance.GetGridData(1,5));
        grdEmployee.SetGridText(0,icol+6,grdAllowance.GetGridData(1,6));
        grdEmployee.SetGridText(0,icol+7,grdAllowance.GetGridData(1,7));
        grdEmployee.GetGridControl().ColHidden(icol)=!(Number(grdAllowance.GetGridData(1,8)));
        grdEmployee.GetGridControl().ColHidden(icol+1)=!(Number(grdAllowance.GetGridData(1,9)));
        grdEmployee.GetGridControl().ColHidden(icol+2)=!(Number(grdAllowance.GetGridData(1,10)));
        grdEmployee.GetGridControl().ColHidden(icol+3)=!(Number(grdAllowance.GetGridData(1,11)));
        grdEmployee.GetGridControl().ColHidden(icol+4)=!(Number(grdAllowance.GetGridData(1,12)));
        grdEmployee.GetGridControl().ColHidden(icol+5)=!(Number(grdAllowance.GetGridData(1,13)));
        grdEmployee.GetGridControl().ColHidden(icol+6)=!(Number(grdAllowance.GetGridData(1,14)));
        grdEmployee.GetGridControl().ColHidden(icol+7)=!(Number(grdAllowance.GetGridData(1,15)));
        datSal_security.Call();
    
   }
   else if (obj.id=="datSal_security")
   {
       if(txt_sal_security.text=='N') 
       {
            var icol=p_ProbationSalary; //value of probation salary
            for (var i=0;i<=9;i++)
                grdEmployee.GetGridControl().ColHidden(icol+i)=1;
       }
       if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	    {
            datUser_info.Call();     	    
	    }
		else
			check_init=1;
   }
   else if (obj.id=="datUser_info")
   {
       
            lstOrg_Code.SetDataText(txtdept_temp.text);            
            lstOrg_Code2.SetDataText(txtdept_temp.text);

            ChangeColorItem(lstOrg_Code.GetControl());
            ChangeColorItem(lstOrg_Code2.GetControl());

			onChange_org();
   }
   else if (obj.id=="datGet_period")
   {
		var t=txtlst_period.text;
            var s="";
            t=t.substring(5,t.length);
            var arr=t.split("|");
            var i=0;
            while(i<arr.length)
            {
                s+="#"+arr[i]+";"+arr[i+1]+"|";
                i+=2;
            }
            s=s.substring(0,s.length-1);
            grdEmployee.SetComboFormat(p_sal_peirod,s);
			onGetWorkGroup(1);
   }
	else if(obj.id=="datIns")
   {
    lblRecord2.text=grdEmployee2.rows-1 + " record(s).";
    auto_resize_column(grdEmployee2,0,grdEmployee2.cols-1,9);    
    if(grdEmployee2.rows>1)
        grdEmployee2.SetCellBgColor(1,g2_social_flag,grdEmployee2.rows -1 ,g2_description,0xFFEEFF);
        grdEmployee2.SetCellBgColor(1,g2_social_book,grdEmployee2.rows -1 ,g2_social_book,0xBAEDD3);
   
   }
   else if (obj.id=="datEmp_Management")
   {
        if (grdEmployee.rows>1)
        {
            ibtnSave.SetEnable(true);
            SetColRow();
        }
        else
        {
            ibtnSave.SetEnable(false);
            
        }
        lblRecord.text=grdEmployee.rows-1 + " record(s).";
        auto_resize_column(grdEmployee,0,grdEmployee.cols-1,9);    
   }
   else if (obj.id=="datFind_Report")
   {
        var url=System.RootURL;
        switch (rpt_no)
        {
        
            case 1:
            {
                
                url=url + '/reports/ch/ae/'+txtReport_tmp.text+'?p1=' + lstGrp_Code.value + '&p2=' + lstNation.value + '&p3=' + lstTemp.value + '&p4=' + txtTemp.text + '&p5=' + dtFrom_JoinDate.value + '&p6=' + dtTo_JoinDate.value ;
                url=url + '&p7=' + lstSalaryYN.value + '&p8=' +lstPosition.value + '&p9=' + lstPay_Type.value + '&p10=' + lstContract_Kind.value + '&p11=' + dtFrom_BeginContract.value + '&p12=' + dtTo_BeginContract.value;
                url=url + '&p13=' + lstSex.value  +'&p14=' + lstInsuranceYN.value  + '&p15=' + lstStatus.value  +'&p16=' + dtFrom_LeftDate.value + '&p17=' + dtTo_LeftDate.value +  '&p18=' + dtFrom_BirthDate.value  ;
                url=url + '&p19=' + lstOTYN.value  + '&p20=' + dtTo_BirthDate.value  +'&p21=' + lstOrg_Code.value + '&p22=' + txt_sal_security.text ;
                url=url + '&p23=' + lstJob.value  + '&p24=' + lstEducation.value;
                url=url + '&p25=' + lstUnion.value; 
                url=url + '&p26=' + lstBirth_Month.value ;
                
                break;
            }
            
            case 2:
            {
                
                url=url + '/reports/ch/ae/'+txtReport_tmp.text+'?p1=' + lstGrp_Code.value + '&p2=' + lstNation.value + '&p3=' + lstTemp.value + '&p4=' + txtTemp.text + '&p5=' + dtFrom_JoinDate.value + '&p6=' + dtTo_JoinDate.value ;
                url=url + '&p7=' + lstSalaryYN.value + '&p8=' +lstPosition.value + '&p9=' + lstPay_Type.value + '&p10=' + lstContract_Kind.value + '&p11=' + dtFrom_BeginContract.value + '&p12=' + dtTo_BeginContract.value;
                url=url + '&p13=' + lstSex.value  +'&p14=' + lstInsuranceYN.value  + '&p15=' + lstStatus.value  +'&p16=' + dtFrom_LeftDate.value + '&p17=' + dtTo_LeftDate.value +  '&p18=' + dtFrom_BirthDate.value  ;
                url=url + '&p19=' + lstOTYN.value  + '&p20=' + dtTo_BirthDate.value  +'&p21=' + lstOrg_Code.value + '&p_user=' + user + '&p22=' + txt_sal_security.text ;
                url=url + '&p23=' + lstJob.value  + '&p24=' + lstEducation.value;
                url=url + '&p25=' + lstUnion.value; 
                url=url + '&p26=' + lstBirth_Month.value ;
                break;
            }

            case 3:
            {

                url = url + '/reports/ch/ae/' + txtReport_tmp.text + '?p1=' + lstOrg_Code2.value + '&p2=' + lstGrp_Code2.value + '&p3=' + lstNation2.value + '&p4=' + lstTemp2.value + '&p5=' + txtTemp2.text + '&p6=' + dtFrom_JoinDate2.value + '&p7=' + dtTo_JoinDate2.value;
                url = url + '&p8=' + lstInsuranceYN2.value + '&p9=' + lstStatus2.value + '&p10=' + dtFrom_LeftDate2.value + '&p11=' + dtTo_LeftDate2.value + '&p12=' + lstSocialBook.value + '&p13=' + lstSocial.value + '&p14=' + lstHealth.value;
                url = url + '&p15=' + lstUnemp.value + '&p16=' + lstSocialNo.value + '&p17=' + dtFrom_BeginContract2.value + '&p18=' + dtTo_BeginContract2.value;

                break;
            }
        }
        
        window.open(url); 
   }
   else if (obj.id=="datCheck_Exist_Empid")
   {
        if(txtResult.text=="1")
        {
            alert("Emp ID has exist. Please try again!\nEmp ID này đã tồn tại. Xin nhập lại!");
            grdEmployee.SetGridText(rIdx,p_EmpID,dt_tmp);
            return;
        }
   }
   else if (obj.id=="datGet_Org")
   {

      grdEmployee.SetGridText(rowclick,p_Organization,txtOrgNM.text);
      if(txtHR0211_YN.text=="Y") //co su dung mapping pl
      {
        grdEmployee.SetGridText(rowclick,p_CostGroup,txtCostGroup.text);
        grdEmployee.SetGridText(rowclick,p_GroupKind,txtCostType.text);
        grdEmployee.SetGridText(rowclick,p_pk_CostKind,txtCostCenter_pk.text);
        grdEmployee.SetGridText(rowclick,p_CostKind,txtCostCenter_nm.text);
      }  
   }
   else if (obj.id=="datWorkGroup_info")
   {
		
		if(flag_wg==1)
        {
			lstGrp_Code.SetDataText(txtwg_tmp.text+ "|ALL|Select All");
            lstGrp_Code.value='ALL';
        }
		else
        {
			lstGrp_Code2.SetDataText(txtwg_tmp.text+ "|ALL|Select All");
            lstGrp_Code2.value='ALL';
        }
		
      //grdEmployee.SetGridText(rowclick,p_Organization,txtOrgNM.text);
	  check_init=1;
   }
   
   
}


function onGetWorkGroup(p)
{
	flag_wg=p;
	if(flag_wg==1)
	{
		txtOrgPK.text=lstOrg_Code.value;
		if(txtOrgPK.text!='ALL')
			datWorkGroup_info.Call();
	}
	else
	{
		txtOrgPK.text=lstOrg_Code2.value;
		if(txtOrgPK.text!='ALL')
			datWorkGroup_info.Call();
	}
		
}

//---------------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
//------------------------------------------------
function SetColRow()
{
    grdEmployee.SetCellBgColor(1,p_OldID,grdEmployee.rows -1 ,p_OldID,0xFFEEFF);
    grdEmployee.SetCellBgColor(1,p_IDNum,grdEmployee.rows -1 ,p_IDNum,0xFFEEFF);
    grdEmployee.SetCellBgColor(1,p_PlaceBirth,grdEmployee.rows -1 ,p_Position,0xFFEEFF);
    grdEmployee.SetCellBgColor(1,p_SocialFlag,grdEmployee.rows -1 ,p_SocialFlag,0xFFEEFF);
    grdEmployee.SetCellBgColor(1,p_HealthFlag,grdEmployee.rows -1 ,p_SalaryYN,0xFFEEFF);
    grdEmployee.SetCellBgColor(1,p_PayType,grdEmployee.rows -1 ,p_Account,0xFFEEFF);
    grdEmployee.SetCellBgColor(1,p_PassPortNo,grdEmployee.rows -1 ,p_meal_yn,0xFFEEFF);
    grdEmployee.SetCellBgColor(1,p_SocialNo,grdEmployee.rows -1 ,p_HealthDate,0xFFEEFF);
    
 
    
}

//----------------------------------------------------
function OnSearch()
{
        if(check_init==1)
			datEmp_Management.Call("SELECT");
}
//-------------------------------------------------------------
function SelectOption(obj)
{
    if (obj==1)
    {
        txtOption.text="1";
        lstTemp.SetEnable(false);
        txtTemp.SetEnable(false);
        txtEmpID.SetEnable(true);
        txtTemp.text="";
        txtEmpID.GetControl().select();
    }
    else
    {
        txtOption.text="2";
        lstTemp.SetEnable(true);
        txtTemp.SetEnable(true);
        txtEmpID.SetEnable(false);
        txtEmpID.text="";
        txtTemp.GetControl().select();
    }
}
//------------------------------------------------------------
function doSelectAll()
{	
	var tmp;
	if( idCheckAll.GetData()=='T')
		tmp=-1;
	else
		tmp=0;
	for (var i=1; i<grdEmployee.rows; i++)
		grdEmployee.SetGridText( i , 0,tmp );
}
//-----------------------------------------------
function OnReport(obj)
{
    var url=System.RootURL;
    rpt_no=obj;
	if(check_init==1)
	{
		switch (obj)
		{
		
			case 1:
			{
				//txtReport_tmp.text="rpt_employee_list.aspx";
				txtReport_tmp.text="r.aspx";
				
				break;
			}
			case 2:
			{
				txtReport_tmp.text="rpt_employee_detail_list.aspx";
				break;
			}
		    case 3:
		    {
		        txtReport_tmp.text = "rpt_employee_insurance.aspx";
		        break;
		    }
		}
	
		txtOrg_tmp_pk.text=lstOrg_Code.value; 
		datFind_Report.Call();
	}
    
    
    
    
}
//-----------------------------------------------
function OnSave()
{

	if(check_init==1)
	{
        if (confirm("Do you want to save?"))
            datEmp_Management.Call();
	}		
}
//-----------------------------------------------
function CheckUpdate()
{

    var rowvalue;
    for (var i=1;i<grdEmployee.rows;i++)
    {
        if (grdEmployee.GetRowStatus(i)==16)
        {
//            rowvalue=grdEmployee.GetGridData(i,p_Telephone);
//            if (isNaN(rowvalue) && rowvalue!="") //telephone
//            {
//                alert("Please input number in row " + i + " and column Telephone");
//                return false;
//            }
//            rowvalue=grdEmployee.GetGridData(i,p_PersonID); //person id
           
            if (isNaN(rowvalue)  && rowvalue!="")
            {
                alert("Please input number in row " + i + " and column Person ID");
                return false;
            }
//            rowvalue=grdEmployee.GetGridData(i,p_SocialNo); //Social No
//            if (isNaN(rowvalue)  && rowvalue!="")
//            {
//                alert("Please input number in row " + i + " and column Social No");
//                return false;
//            }
//            rowvalue=grdEmployee.GetGridData(i,p_HealthNo); //Health No
//            if (isNaN(rowvalue)  && rowvalue!="")
//            {
//                alert("Please input number in row " + i + " and column Health No");
//                return false;
//            }
//            
//            rowvalue=grdEmployee.GetGridData(i,p_Account); //Health No
//            if (isNaN(rowvalue)  && rowvalue!="")
//            {
//                alert("Please input number in row " + i + " and column Account");
//                return false;
//            }
//            rowvalue=grdEmployee.GetGridData(i,p_PitNo); //Health No
//            if (isNaN(rowvalue)  && rowvalue!="")
//            {
//                alert("Please input number in row " + i + " and column PitNo");
//                return false;
//            }
//            
        }
    }
    return true;
}
function OnChangeBand()
{
    //datBand_GradeData.Call();
}
function On_click()
{
    dt_tmp = grdEmployee.GetGridData(event.row,event.col);
    byhand = grdEmployee.GetGridData(event.row,p_ByHand_YN);
    rIdx = event.row;
    cIdx = event.col;
}
function On_AfterEdit()
{   
    
    if(cIdx==p_EmpID)
    {
            tmpEmpID.text= grdEmployee.GetGridData(event.row,p_EmpID);
            if(tmpEmpID.text=="")
            {
                alert("Emp ID not blank!\nEmp ID không được bỏ trống!")
                grdEmployee.SetGridText(rIdx,p_EmpID,dt_tmp);
            }
            if(tmpEmpID.text != dt_tmp)
            {
                if(byhand=="N")
                {
                    alert("Emp ID has automatic created, not edit!\nEmp ID này đã được tạo tự động vì thế không thể sửa!")
                    grdEmployee.SetGridText(rIdx,p_EmpID,dt_tmp);
                    return;
                }
                else 
                datCheck_Exist_Empid.Call();
            }       
    }
}

function Popup()
{
    var col=event.col;
    if(col==p_CostKind)
    {
        var fpath = System.RootURL + "/form/ch/ae/chae00010_cost_center.aspx?id="+ grdEmployee.GetGridData(event.row,p_pk_CostKind)+"&company_pk=" +  "<%=Session("COMPANY_PK")%>";
        var obj  = System.OpenModal(  fpath , 900 , 600 , 'resizable:yes;status:yes');
        if (obj!=null)
        {
            if(obj[0]!=grdEmployee.GetGridData(event.row,p_CostKind))
            {
			    //txtCost_Center_pk.text=obj[0]
			    grdEmployee.SetGridText(event.row,col,obj[1]);
			    grdEmployee.SetGridText(event.row,p_pk_CostKind,obj[0]);
            }
        }    
    }
    else if(col==p_Organization)
    {
        
        var strcom;
        var fpath = System.RootURL + "/form/ch/ae/chae00030_org.aspx?";
        var obj  = System.OpenModal(  fpath , 700 , 600 , 'resizable:yes;status:yes');
        //var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:10;dialogTop:330;edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {
            rowclick= event.row;
             txtOrgPK.text = obj;
			 grdEmployee.SetGridText(event.row,p_pk_Org,txtOrgPK.text);
           
            datGet_Org.Call();
            
            
        }    
    }
}
//-----------------------------------------------
//-------------------------------------------------------------
function OnSearchIns()
{ datIns.Call("SELECT");
}
function OnSaveIns()
{ if (confirm("Do you want to save?"))
        datIns.Call();
}

function OnChangeKind()
{datChangeKind.Call();
}
function CheckIns()
{
    if(event.col==g2_social_dt || event.col==g2_health_dt || event.col==g2_unemp_dt)
    {
        tmp=grdEmployee2.GetGridData(event.row,event.col);
        if(Trim(tmp)=="")
            return;
        if(tmp.length!=7||tmp.substring(2,3)!='/'||isNaN(tmp.substring(0,2))||isNaN(tmp.substring(3,7)))
        {
            alert("Incorrect type or month. (mm/yyyy)\nBạn nhập kiểu tháng không đúng.(mm/yyyy)");
            grdEmployee2.SetGridText(event.row,event.col,"");
        }   
      }  
    else if(event.col == g2_social_book)
    {
        var value = grdEmployee2.GetGridData(event.row, event.col);
        var book_no = grdEmployee2.GetGridData(event.row, g2_social_no);
        if((value == '03'|| value=='04' ||value=='05') && book_no=='')
        {
            alert("Book No have not yet.\nSố sổ bảo hiểm chưa có");
            grdEmployee2.SetGridText(event.row, event.col, value_old);
            return;
        }
        if(value == '05') // return
        {
            grdEmployee2.SetGridText(event.row, g2_return_dt, datenow);
        }
    }
    else if(event.col == g2_return_dt)
    {
        if(grdEmployee2.GetGridData(event.row, g2_social_book)!='04')
        {
            alert("Status social book is not return.");
            grdEmployee2.SetGridText(event.row, g2_return_dt, '');
            return;
        }
    }
    else if(event.col == g2_month_ins)
    {
        if(Number(grdEmployee2.GetGridData(event.row, g2_month_ins))<0 )
        {
            alert("You have to input number lager 0\nBạn phải nhập số lớn hơn 0");
            grdEmployee2.SetGridText(event.row, g2_month_ins, '');
            return;
        }
        else if(isNaN(grdEmployee2.GetGridData(event.row, g2_month_ins)))
        {
            alert("You have to input is number\nBạn phải nhập số");
            grdEmployee2.SetGridText(event.row, g2_month_ins, '');
            return;
        }
    }
}
function On_BeforeEditIns()
{
    if(event.col == g2_social_book)
    {
        value_old = grdEmployee2.GetGridData(event.row, event.col);
    }
}
function OnSetGrird(obj)
 {
 var ctrl=grdEmployee2.GetGridControl(); 
      if (ctrl.SelectedRows>0)
	    { 
	    var  tmp,col;
	    if(obj=='1')//yn
	        {
	           if(lstIns1.value=="2")//social
	                col= g2_social_flag;
	           if(lstIns1.value=="1")//health
	                col= g2_health_flag;  	               	        
	           if(lstIns1.value=="3")//unemp
	                 col= g2_unemp_flag;
	           tmp=lstIns2.value;       	               	        
			}
		if(obj=='2')//no
	        {
	            if(lstIns3.value=="2")//social
	                col= g2_social_no;
	           if(lstIns3.value=="1")//health
	                col= g2_health_no;  	               	        
	            tmp=txtIns4.text;       	               	        
	           	        
			}
		if(obj=='3')//place
	        {
	         if(lstIns5.value=="2")//social
	                col= g2_social_place;
	           if(lstIns5.value=="1")//health
	                col= g2_health_place;  	               	        
	           if(lstIns5.value=="3")//Social Book
	                col= g2_social_book;  	               	        
	            tmp=lstIns6.value;    	
	           	        
			}
		if(obj=='4') //date
	        {
	          if(lstIns7.value=="2")//social
	                col= g2_social_dt;
	           if(lstIns7.value=="1")//health
	                col=g2_health_dt;  	               	        
	           if(lstIns7.value=="3")//unemp
	                 col=g2_unemp_dt;
	           tmp=dtInsMonth.text;      
	           	        
			}			
	       for ( var i =  0 ; i < ctrl.SelectedRows ; i++ )
		        {
			        var row = ctrl.SelectedRow(i);
			        if ( row > 0 )
			        {		
				        grdEmployee2.SetGridText(row,col,tmp);
			        }
		        }
	    }
 }
function onChange_org()
{
		datGet_period.Call();
}

function onPageActive()
{
	if(tabMain.GetCurrentPageNo()==1)
    {
        if(tab2==false)
        {
			onGetWorkGroup(2);
			tab2=true;
		}
	}	
		
}
</script>
<body style=" margin-bottom:0; margin-top:0; margin-right:0; margin-left:0" >
<!-------------------data control----------------------->
<gw:data id="datCheck_View" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="process" procedure="hr_sp_pro_check_view"  > 
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

<!-------------------data control----------------------->

<gw:data id="datChangeKind" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="HR_LST_10010003_CHANGE_INS" > 
                <input>
                    <input bind="lstIns5" /> 
                </input> 
                <output>
                    <output bind="lstIns6" />
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
<!------------------------------------->

<gw:data id="datGet_Org" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_SP_PRO_ORG_PL" > 
                <input>
                    <input bind="txtOrgPK" />
                </input> 
                <output>
                    <output bind="txtOrgNM" />
                    <output bind="txtCostGroup" />
                    <output bind="txtCostType" />
                    <output bind="txtCostCenter_pk" />
                    <output bind="txtCostCenter_nm" />
                    <output bind="txtHR0211_YN" />
                </output>
            </dso> 
        </xml> 
</gw:data>


<!------------------------------------------>
<gw:data id="datWorkGroup_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="HR_SP_SEL_WG_ROLE"  > 
                <input>
                    <input bind="txtOrgPK" />
                </input> 
                <output>
                    <output bind="txtwg_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------->

<gw:data id="datEmp_Management" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,3,4,6,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,31,32,33,34,35,36,37,38,39,40,41,42,43,54,55,56,57,61,62,64,65,66,67,68,69,71,72,73,74,75,76,77" function="HR_SEL_10010003_EMP_MANAGEMENT" procedure="HR_UPD_10010003_EMP_MANAGEMENT"> 
                <input bind="grdEmployee" >
                    <input bind="lstOrg_Code" />
                    <input bind="lstGrp_Code" />
                    <input bind="lstNation" />
                    <input bind="lstTemp" />
                    <input bind="txtTemp" />
                    <input bind="dtFrom_JoinDate" />
                    <input bind="dtTo_JoinDate" />
                    <input bind="lstSalaryYN" />
                    <input bind="lstPosition" />
                    <input bind="lstPay_Type" />
                    <input bind="lstContract_Kind" />
                    <input bind="dtFrom_BeginContract" />
                    <input bind="dtTo_BeginContract" />
                    <input bind="lstSex" />
                    <input bind="lstInsuranceYN" />
                    <input bind="lstStatus" />
                    <input bind="dtFrom_LeftDate" />
                    <input bind="dtTo_LeftDate" />
                    <input bind="dtFrom_BirthDate" />
                    <input bind="dtTo_BirthDate" />
                    <input bind="lstOTYN" />
                    <input bind="lstUnion" />
                    <input bind="lstJob" />
                    <input bind="lstEducation" />
                    <input bind="lstBirth_Month"/>
                    
                </input>
                <output  bind="grdEmployee" />
                
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
<!------------------------------------------>
<gw:data id="datFind_Report" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_PRO_FIND_REPORT_2" > 
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
<!------------------------------------------>
<gw:data id="datSal_security" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="process" procedure="HR_PRO_10010003_SAL_DISPLAY"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="txt_sal_security" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!--------Check EmpID exist---------------------------------->
<gw:data id="datCheck_Exist_Empid" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="process" procedure="HR_SP_PRO_CHECK_EMP_ID"  > 
                <input>
                    <input bind="tmpEmpID" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datGet_period" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="HR_SP_GET_PERIOD_BY_ORG"  > 
                <input>
                    <input bind="lstOrg_Code" />
                </input> 
                <output>
                    <output bind="txtlst_period" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------------>
<gw:data id="datIns" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23" function="HR_SEL_10010003_EMP_INS" procedure="HR_UPD_10010003_EMP_INS"> 
                <input bind="grdEmployee2" >
                    <input bind="lstOrg_Code2" />
                    <input bind="lstGrp_Code2" />
                    <input bind="lstNation2" />
                    <input bind="lstTemp2" />
                    <input bind="txtTemp2" />
                    <input bind="dtFrom_JoinDate2" />
                    <input bind="dtTo_JoinDate2" />
                    <input bind="lstInsuranceYN2" />
                    <input bind="lstStatus2" />
                    <input bind="dtFrom_LeftDate2" />
                    <input bind="dtTo_LeftDate2" />
					<input bind="lstSocialBook" />
					<input bind="lstSocial" />
					<input bind="lstHealth" />
					<input bind="lstUnemp" />
					<input bind="lstSocialNo" />
					<input bind="dtFrom_BeginContract2" />
					<input bind="dtTo_BeginContract2" />
                </input>
                <output  bind="grdEmployee2" />
            </dso> 
        </xml> 
</gw:data>

<!-------------------data control----------------------->
<gw:tab id="tabMain"  border=1 style="width:100%;height:100%;" onpageactivate="onPageActive()"  >   
  <table name="Employee Management" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="tblexp" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td width="9%" style="border:0;" align="right" >
                          <a title="Click here to show Organization" onclick="OnShowPopup(1)" href="#tips" >Oganization</a></td>
                        <td width="20%" colspan=2 style="border:0;" align="left" >
                         <gw:list  id="lstOrg_Code" value='ALL' maxlen = "100" styles='width:100%'onchange="onChange_org()" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td width="11%" style="border:0;" align="right" >Work Group</td>
                        <td width="20%" colspan=2 style="border:0;" align="left" ><gw:list  id="lstGrp_Code" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("select a.PK,a.WORKGROUP_NM from thr_work_group a where a.del_if=0 order by a.WORKGROUP_NM")%>|ALL|Select All</data></gw:list>
                        </td>
                        <td width="10%" style="border:0;" align="right">Birth Date</td>
				        <td  width="7%" style="border:0;"><gw:datebox id="dtFrom_BirthDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				        <td  width="1%" style="border:0;" align="center">~</td>
				        <td width="7%" style="border:0;"><gw:datebox id="dtTo_BirthDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
                         
                        
                        <td width="4%" style="border:0;" align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch()"/>
                        </td>
                        <td width="3%" style="border:0" align="right">
                         <gw:imgBtn img="save" id="ibtnSave"    alt="Save"  onclick="OnSave()"/>
                        </td>
                        <td width="3%" style="border:0" align="right">
                         <gw:imgBtn img="excel" id="ibtnSumPrinter"    alt="Summmary Report"  onclick="OnReport(1)"/>
                        </td>
                        <td width="6%" style="border:0" align="right">
                         <gw:imgBtn img="excel" id="ibtnDetPrinter"    alt="Detail Report"  onclick="OnReport(2)"/>
                        </td>
                       
                    </tr>
                    <tr style="border:0;width:100%;height:5%" valign="middle" >
                        <td  style="border:0" align="right" valign="middle">Salary</td>
					    <td  style="border:0" width="13%">
					    <gw:list  id="lstSalaryYN" value='ALL' maxlen = "100" styles='width:100%' >
                            <data>LIST|Y|Yes|N|No|ALL|Select All</data> </gw:list>
				        </td>
				        <td  width="5%" style="border:0;" align="right" >OT</td>
                        <td  width="13%" style="border:0" align="right">
                         <gw:list  id="lstOTYN" value="ALL" styles='width:100%' onchange=""> 
							        <data>LIST|Y|Yes|N|No|ALL|Select All</data> 
					        </gw:list>
                        </td>
                        
                         <td width="7%" style="border:0;" align="right" >Pay type</td>
                        <td  style="border:0;" align="left" >
                         <gw:list  id="lstPay_Type" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0023' order by code_nm" )%>|ALL|Select All</data></gw:list>
                        </td>
                        <td  style="border:0;" align="right">Join Date</td>
				        <td  style="border:0;"><gw:datebox id="dtFrom_JoinDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				        <td  style="border:0;" align="center">~</td>
				        <td  style="border:0;"><gw:datebox id="dtTo_JoinDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
                        <td   style="border:0;" align="right" >Sex</td>
                        <td colspan=3 style="border:0" align="right">
                         <gw:list  id="lstSex" value="ALL" styles='width:100%' onchange=""> 
							        <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0007' order by code_nm" )%>|ALL|Select All</data></gw:list>
                        </td>
                    </tr>
                    <tr>
                        <td  style="border:0;" align="right" >Position </td>
                        <td  style="border:0;" align="left" >
                         <gw:list  id="lstPosition" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm" )%>|ALL|Select All</data></gw:list>
                        </td>
				        <td  width="7%" style="border:0;" align="right" >
                            Insurance</td>
                        <td width="11%" style="border:0;" align="left" >
                         <gw:list  id="lstInsuranceYN" value='ALL' maxlen = "100" styles='width:100%'>
                            <data>LIST|Y|Yes|N|No|ALL|Select All</data> 
                        </gw:list>
                        </td>
                        <td style="border:0" align="right" valign="middle">Contract</td>
				        <td  style="border:0"> 
					        <gw:list  id="lstContract_Kind" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0001' order by code_nm" )%>|ALL|Select All</data></gw:list>
                        </td>
                        <td style="border:0;" align="right">Begin CT</td>
				        <td style="border:0;" ><gw:datebox id="dtFrom_BeginContract" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				        <td  style="border:0;" align="center">~</td>
				        <td style="border:0;"><gw:datebox id="dtTo_BeginContract" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
                        <td   style="border:0;" align="right" >Union</td>
                        <td colspan=3 style="border:0" align="right">
                         <gw:list  id="lstUnion" value="ALL" styles='width:100%' onchange=""> 
							        <data>|Y|Yes|N|No|ALL|Select All</data></gw:list>
                        </td>
                    </tr>
                    <tr style="border:0;width:100%;height:5%" valign="middle" >
                        
                        <td  style="border:0;" align="right" >Search by</td>
                        <td  style="border:0;" align="left" >
                         <gw:list  id="lstTemp" value="2" styles='width:100%' onchange=""> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Personal ID|5|Old Code</data> 
					        </gw:list>
                        </td>
                        <td colspan=2 width="13%" align=right style="border:0"> 
					        <gw:textbox id="txtTemp" onenterkey   ="OnSearch()" styles="width:95%"/>
				        </td>
                        <td  style="border:0;" align="right" >Status</td>
                        <td  style="border:0;" align="left" >
                         <gw:list  id="lstStatus" value='A' maxlen = "100" styles='width:100%'>
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0022' order by code_nm")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                       
                        <td  style="border:0" align="right" valign="middle">Left Date</td>
                        <td style="border:0;"><gw:datebox id="dtFrom_LeftDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				        <td  width="3%" style="border:0;" align="center">~</td>
				        <td style="border:0;"><gw:datebox id="dtTo_LeftDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
                        <td colspan=4 style="border:0;" align="center" ></td>
                    </tr>
                     <tr style="border:0;width:100%;height:5%" valign="middle" >
                        <td style="border:0;" align="right" >Nation</td>
                        <td style="border:0;" align="left" >
                            <gw:list  id="lstNation" value='01' maxlen = "100" styles='width:100%' >
                                <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by code_nm" )%>|ALL|Select All</data></gw:list>
                        </td>
                        <td   style="border:0;" align="right" >Job </td>
                        <td  style="border:0" align="right"><gw:list  id="lstJob"  value="ALL" styles='width:100%' >
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0010' order by seq")%>|ALL|Select All
                            </data>
                            </gw:list>
                        </td>
                        <td  style="border:0;" align="right" >Education</td>
                        <td  style="border:0;" align="left" ><gw:list  id="lstEducation" value="ALL" maxlen = "10" styles='width:100%' > 
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0011' order by seq")%>|ALL|Select All
                            </data>
                            </gw:list>
                         </td>
                        <td  style="border:0" align="right" valign="middle"> Birth Month</td>
                        <td  style="border:0;" align="center" ><gw:list  id="lstBirth_Month" value="ALL" maxlen = "10" styles='width:100%' > 
                            <data>
                                |01|01|02|02|03|03|04|04|05|05|06|06|07|07|08|08|09|09|10|10|11|11|12|12|ALL|Select All
                            </data>
                            </gw:list>
                         </td>
                        <td colspan=5 style="border:0;" align="center" ><gw:label id="lblRecord"  text="0 record(s)." maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:13" />
                        </td>
                    </tr>
                   
                    <tr style="border:1;width:100%;height:75%" valign="top">
                        <td colspan=14 style="width:100%;height:100%;"> 
                             <gw:grid   
                                id="grdEmployee"  
                                header="_PK|Organization|Work Group|Emp ID|Old Code|Full Name|ID Num|Join Date|Birth Date|Place Birth|Telephone|Permanent Address|Present Address|Sex|Person ID|Issue Date|Place Per ID|Married|Nation|Ethenic|Religion|Education|Job|Position|Probation Type|Begin Probation|End  Probation|Contract Kind|Contract NO|Begin Contract|End Contract|Social Flag|Social No|Social Place|Social Date|Health Flag|Health No|Health Place|Health Date|Unemp Flag|Unemp Date|Employee Type|OT YN|Salary YN|Probation Salary|Basic Salary|Allow Amt1|Allow Amt2|Allow Amt3|Allow Amt4|Allow Amt5|Allow Amt6|Allow Amt7|Allow Amt8|Pay Type|Bank Type|Bank Branch|Account|Status|Left Date|Resign Type|Cost Group|Group Kind|Cost Center|Pass Port No|Pass Port Date|Remark|Union YN|Union Date|Pit No|_ByHand_YN|_PK_CostKind|_House YN|Meal YN|_PK_ORG|Salary Period|_Register Ins|N Country 2"   
                                format="0|0|0|0|0|0|0|4|0|0|0|0|0|0|0|4|0|3|0|0|0|0|0|0|0|4|4|0|0|4|4|3|0|0|4|3|0|0|4|3|4|0|3|3|1|1|1|1|1|1|1|1|1|1|0|0|0|0|0|0|0|2|2|0|0|4|0|3|4|0|0|0|3|3|2|2|3|0"  
                                aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"    
                                defaults="||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"    
                               editcol="0|0|0|1|1|0|1|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0|0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|0|0|0|0|0|0|0|0|0|0|0|1|1|1|1|0|0|0|1|1|0|1|1|1|1|1|1|0|0|1|1|1|1|1|1"  
                                widths="1500|1500|1500|1500|1500|2500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|500|500|1500|1500|1500|1500|500|500|1500|1500|500|500|500|1000"  
                                styles="width:100%; height:100%"   acceptNullDate
                                onafteredit="On_AfterEdit()"
                                onentercell = "On_click()"
                                oncelldblclick = "Popup()"
                                sorting="T"/> 
                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table>
	 <table name="Set Insurance" id="Ins" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="Table2" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td colspan=5 width="10%" style="border:0;" align="right" ><a title="Click here to show Organization" onclick="OnShowPopup(2)" href="#tips" >
                            Organization </a>                  
                        </td>
                        <td colspan=6 width="12%" style="border:0;" align="left" >
                         <gw:list  id="lstOrg_Code2" value='ALL' maxlen = "100" styles='width:100%'onchange="onGetWorkGroup(2)" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        
                        <td colspan=9 width="18%" style="border:0;" align="left" >
                         <gw:list  id="lstGrp_Code2" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select a.PK,a.WORKGROUP_NM from thr_work_group a where a.del_if=0 order by a.WORKGROUP_NM" )%>|ALL|WG-Select All</data></gw:list>
                        </td>
                         <td colspan=3 width="6%" style="border:0;" align="right" >Nation</td>
                        <td colspan=5 width="10%" style="border:0;" align="left" >
                         <gw:list  id="lstNation2" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by code_nm" )%>|ALL|Select All</data></gw:list>
                        </td>
                        <td colspan=4 width="8%" style="border:0;" align="right">Join Date</td>
				        <td colspan=4  width="8%" style="border:0;"><gw:datebox id="dtFrom_JoinDate2" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				        <td  width="2%" style="border:0;" align="center">~</td>
				        <td colspan=4 width="8%" style="border:0;"><gw:datebox id="dtTo_JoinDate2" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
                         
                        <td colspan=3 width="6%" style="border:0;" align="left" >Insurance</td>
                        <td colspan=3 width="6%" style="border:0" align="left"><gw:list  id="lstInsuranceYN2" value='ALL' maxlen = "100" styles='width:100%'>
                            <data>LIST|Y|Yes|N|No|ALL|Select All</data> 
							 
                        </gw:list></td>
						<td colspan=1  width="2%" style="border:0" align="right"><gw:imgBtn img="search" id="ibtnSearch2"   alt="Search"  onclick="OnSearchIns()"/>                        </td>
                        <td colspan=1  width="2%" style="border:0" align="right"><gw:imgBtn img="save" id="ibtnSave2"    alt="Save"  onclick="OnSaveIns()"/></td>
                        <td colspan=1  width="2%" style="border:0" align="right"><gw:imgBtn img="excel" id="ibtnIns"    alt="Report"  onclick="OnReport(3)"/></td>
				   </tr>
                    <tr style="border:0;width:100%;height:5%" valign="middle" >
                        <td colspan=5  style="border:0" align="right" valign="middle">Search by</td>
					    <td colspan=6 style="border:0">
					        <gw:list  id="lstTemp2" value="2" styles='width:100%' onchange=""> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Personal ID|5|Old Code</data> 
					        </gw:list>
				        </td>
                        <td colspan=9 align=right style="border:0"> 
					        <gw:textbox id="txtTemp2" onenterkey   ="OnSearchIns()" styles="width:100%"/>
				        </td>
                        
                         <td colspan=3 style="border:0;" align="right" >Status</td>
                        <td colspan=5  style="border:0;" align="left" ><gw:list  id="lstStatus2" value='A' maxlen = "100" styles='width:100%'>
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0022' order by code_nm")%>|ALL|Select All
                            </data>
                        </gw:list></td>
                        <td colspan=4  style="border:0;" align="right">Left Date</td>
				        <td colspan=4  style="border:0;"><gw:datebox id="dtFrom_LeftDate2" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				        <td  style="border:0;" align="center">~</td>
				        <td colspan=4  style="border:0;"><gw:datebox id="dtTo_LeftDate2" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
                        
						<td colspan=3 width="6%" style="border:0;" align="left" >Social Book</td>
                        <td colspan=3 width="6%" style="border:0" align="left"><gw:list  id="lstSocialBook" value='ALL' maxlen = "100" styles='width:100%'>
                            <data>
                                <%= ESysLib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0175' order by code_nm")%>|ALL|Select All
                            </data> 
							 
                        </gw:list></td>
						<td colspan=3 style="border:0" align="right"><gw:label id="lblRecord2"  text="0 record(s)." maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" /></td>
                        
						
                    </tr>
                    
                     <tr style="border:0;width:100%;height:5%" valign="middle" >
                        <td colspan=5  style="border:0" align="right" valign="middle">Social</td>
                        
					    <td colspan=4 style="border:0">
					        <gw:list  id="lstSocial" value='ALL' maxlen = "100" styles='width:100%'>
                                <data>LIST|Y|Yes|N|No|ALL|Select All</data>
                            </gw:list>
				        </td>
				        
				        <td colspan=2 style="border:0">
					        
				        </td>
                        <td colspan=4 align=right style="border:0">
                            Health 
					        
				        </td>
				        <td colspan=5 align=right style="border:0"> 
					        <gw:list  id="lstHealth" value='ALL' maxlen = "100" styles='width:100%'>
                                <data>LIST|Y|Yes|N|No|ALL|Select All</data>
                            </gw:list>
				        </td>
                        
                         <td colspan=3 style="border:0;" align="right" >Unemployee</td>
                        <td colspan=5  style="border:0;" align="left" >
                            <gw:list  id="lstUnemp" value='ALL' maxlen = "100" styles='width:100%'>
                                <data>LIST|Y|Yes|N|No|ALL|Select All</data>
                            </gw:list>
                        </td>
                        <td colspan=4  style="border:0;" align="right">Begin Contract</td>
				        <td colspan=4  style="border:0;"><gw:datebox id="dtFrom_BeginContract2" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /> </td>
				        <td  style="border:0;" align="center">~</td>
				        <td colspan=4  style="border:0;"><gw:datebox id="dtTo_BeginContract2" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
                        
						<td colspan=3 width="6%" style="border:0;" align="left" >Social No</td>
                        <td colspan=3 width="6%" style="border:0" align="left"><gw:list  id="lstSocialNo" value='ALL' maxlen = "100" styles='width:100%'>
                                <data>LIST|Y|Yes|N|No|ALL|Select All</data>
                            </gw:list></td>
						<td colspan=3 style="border:0" align="right"></td>
                        
						
                    </tr>
                    <tr style="border:0;width:100%;height:5%" valign="middle" >
                        <td colspan=5  style="border:0" align="right" valign="middle">
                            <gw:list  id="lstIns1" value="1" styles='width:100%' onchange=""> 
							        <data>LIST|1|Health YN|2|Social YN|3|Unemp YN</data> 
					        </gw:list>
					        </td>
					    <td colspan=3 style="border:0">
					        <gw:list  id="lstIns2" value="Y" styles='width:100%' onchange=""> 
							        <data>LIST|Y|Yes|N|No</data> 
					        </gw:list>
				        </td>
				        <td colspan=3  style="border:0" align="left"><gw:imgBtn img="set" id="ibtnSet1"   alt="Set Grid"  onclick="OnSetGrird(1)"/></td>
                        <td colspan=4 align=right style="border:0"> 
                            <gw:list  id="lstIns3" value="1" styles='width:100%' onchange=""> 
							        <data>LIST|1|Health No|2|Social No</data> 
					        </gw:list>
				        </td>
                        
                         <td colspan=5 style="border:0;" align="right" >
                             <gw:textbox id="txtIns4"  styles="width:95%"/>
					        </td>
					        
					      <td colspan=3  style="border:0" align="left"><gw:imgBtn img="set" id="ibtnSet2"   alt="Set Grid"  onclick="OnSetGrird(2)"/></td>
                        <td colspan=5  style="border:0;" align="left" ><gw:list  id="lstIns5" value="1" styles='width:100%' onchange="OnChangeKind()"> 
							        <data>LIST|1|Health Place|2|Social Place|3|Social Book</data> 
					                </gw:list>
					     </td>
					     <td colspan=9  style="border:0;" align="left" ><gw:list  id="lstIns6"  styles='width:100%' onchange=""> 
							        <data><%=Esyslib.SetListDataSQL("SELECT CODE,CODE_NM FROM VHR_HR_CODE A WHERE A.ID='HR0012' ORDER BY A.SEQ" )%></data></gw:list>
					                </gw:list>
					      </td>   
					      <td colspan=2  style="border:0" align="left"><gw:imgBtn img="set" id="ibtnSet3"   alt="Set Grid"  onclick="OnSetGrird(3)"/></td>
                        <td colspan=4  style="border:0;" align="right"><gw:list  id="lstIns7" value="1" styles='width:100%' onchange=""> 
							        <data>LIST|1|Health Date|2|Social Date|3|Unemp</data> 
					        </gw:list></td>
				        <td colspan=4  style="border:0;"><gw:datebox id="dtInsMonth" styles="width:100%" lang="<%=Session("Lang")%>" type="month" /></td>
				        <td colspan=2  style="border:0" align="left"><gw:imgBtn img="set" id="ibtnSet4"   alt="Set Grid"  onclick="OnSetGrird(4)"/></td>
				       
                        
                    </tr>
                   
                   
                    <tr style="border:1;width:100%;height:80%" valign="top">
                        <td colspan=50 style="width:100%;height:100%;"> 
                             <gw:grid   
                                id="grdEmployee2"  
                                header="_PK|Department|Group|Emp ID|Full Name|Join Date|Social Flag|Social No Old|Social No|Social Date|Social Place|Health Flag|Health No|Health Date|Health Place|Unemp Flag|Unemp Date|Social Book|Ins Salary|Submit Book Date|Return Book Date|Month INS|Remark|Description"   
							   format="0|0|0|0|0|4|2|0|0|0|2|2|0|0|2|2|0|2|-0|4|4|0|0|0"  
                               aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|1|1|1|1|0|0"    
                                defaults="|||||||||||||||||||||||"    
                               editcol="0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1"  
                                widths="0|2000|2000|2000|2000|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500"  
                                styles="width:100%; height:100%"   
                                acceptNullDate
                                sorting="T"
                                onafteredit="CheckIns()"
                                onbeforeedit="On_BeforeEditIns()"
                                
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
<gw:textbox id="txtOption" text="1" styles="display:none"/> 
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
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
<gw:textbox id="txtReport_tmp" styles="display:none"/>
  <gw:textbox id="txt_sal_security" styles="display:none"/>
<gw:textbox id="txtOrgData" styles="display:none"/>
<gw:textbox id="txtUpperOrg" styles="display:none"/>
<gw:textbox id="txtEmpID" styles="display:none"/>
<gw:textbox id="txtResult" styles="display:none"/>
<gw:textbox id="tmpEmpID" styles="display:none"/>
<gw:textbox id="txtOrgPK" styles="display:none"/>
<gw:textbox id="txtOrgNM" styles="display:none"/>
<gw:textbox id="txtOrg_tmp_pk" text="" styles="display:none"  />
<gw:textbox id="txtdept_temp" styles="display:none"/>
<gw:textbox id="txtlst_period" styles="display:none"/>
<gw:textbox id="txtwg_tmp" styles="display:none"/>
    
<gw:textbox id="menu_id" text="" styles="display:none"  />
<gw:textbox id="txtFlag_View" text="" styles="display:none"  />    
<gw:textbox id="txtCostGroup" text="" styles="display:none"  />
<gw:textbox id="txtCostType" text="" styles="display:none"  />
<gw:textbox id="txtCostCenter_pk" text="" styles="display:none"  />
<gw:textbox id="txtCostCenter_nm" text="" styles="display:none"  />
<gw:textbox id="txtHR0211_YN" text="" styles="display:none"  />

</html>
