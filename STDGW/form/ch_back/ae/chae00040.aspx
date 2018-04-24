<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var binit=true;
var v_language = "<%=Session("SESSION_LANG")%>";
var emp_pk_list;
var labour_pk_list;
var rpt_no=0;
//column of manage tab
var   icmjoin_dt=4
var   icmcreate_contract=6
var   icmprob_type=7
var   icmoldcontract_type=8
var   icmnewcontract_type=9
var   icmbegin_probation=10
var   icmend_probation=11
var   icmbegin_contract=12
var   icmend_contract=13
var   icmget_salary=14
var   icmallow_amt1=16
var   icapprove=28   
var flag_tab=1;
var check_init=0;


var c_tab2_Select_1=0;
    c_tab2_emp_pk_1=22,
    c_tab2_allow_amt1_1=14,
    c_tab2_contract_code_1=25,
    c_tab2_probation_code_1=26;

var c_tab2_emp_pk_2=23,
    c_tab2_allow_amt1_2=15,
    c_tab2_contract_code_2=25;


var c_tab3_allow_amt1_1=14,
    c_tab3_emp_pk=23,
    c_tab3_contract_code=25;    
    
var c_tab4_sign_dt_1=9,
    c_tab4_contract_dt_1=11,
    c_tab4_allow_amt1_1=13,
    c_tab4_emp_pk_1=21,
    c_tab4_appendix_time_1=22,
    c_tab4_contract_code_1=23;

var c_tab4_emp_pk_2=20,   
   c_tab4_allow_amt1_2=14;
    
function BodyInit()
{
    
    if (v_language!="ENG")
        System.Translate(document);
    OnToggle();
    OnToggle_A();
    grdLabourContract.GetGridControl().FrozenCols =5;
    grdLBReport.GetGridControl().FrozenCols =5;
    grdLBPreparation.GetGridControl().FrozenCols =5;
    grdLabourContract.GetGridControl().ScrollTrack=true;
    grdLBReport.GetGridControl().ScrollTrack=true;
    grdLBPreparation.GetGridControl().ScrollTrack=true;
    grdAppendix.GetGridControl().FrozenCols =6;
    grdAppendix.GetGridControl().ScrollTrack=true;
    grdAppendix_His.GetGridControl().FrozenCols =6;
    grdAppendix_His.GetGridControl().ScrollTrack=true;
    grdLBHisReport.GetGridControl().FrozenCols =5;
    grdLBHisReport.GetGridControl().ScrollTrack=true;
    
    BindingData();
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    txtCompany_pk.text= "<%=session("COMPANY_PK")%>";
    

    menu_id.text=System.Menu.GetMenuID();

    ChangeColorItem(lstOrg_Code_M.GetControl());
    ChangeColorItem(lstOrg_Code_R.GetControl());
    ChangeColorItem(lstOrg_Code_P.GetControl());
    ChangeColorItem(lstOrg_Code_A.GetControl());
    ChangeColorItem(lstOrg_Code_His.GetControl());


    datCheck_View.Call();
}
//-------------------------------------------------------------------------
function BindingData()
{
    <%=ESysLib.SetGridColumnComboFormat( "grdLabourContract" , 7 , "select a.code,a.code_nm from vhr_hr_code a where a.id='HR0002' ORDER BY A.seq") %>; 
    <%=ESysLib.SetGridColumnComboFormat( "grdLabourContract" , 8 , "select a.code,a.code_nm from vhr_hr_code a where a.id='HR0001' ORDER BY A.seq") %>; 
    <%=ESysLib.SetGridColumnComboFormat( "grdLabourContract" ,9 , "select a.code,a.code_nm from vhr_hr_code a where a.id='HR0001' ORDER BY A.seq") %>; 
    <%=ESysLib.SetGridColumnComboFormat( "grdAppendix" ,6 , "select a.code,a.code_nm from vhr_hr_code a where a.id='HR0001' ORDER BY A.seq") %>; 
    <%=ESysLib.SetGridColumnComboFormat( "grdLBPreparation" ,13 , "select a.code,a.code_nm from vhr_hr_code a where a.id='HR0001' and code <>'01' ORDER BY A.seq") %>; 
    <%=ESysLib.SetGridColumnComboFormat( "grdAppendix_His" ,7 , "select a.code,a.code_nm from vhr_hr_code a where a.id='HR0001' ORDER BY A.seq") %>; 
    
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

//---------------------------------------------------------------------------
function OnShowPopup(n)
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:'+window.event.screenX+';dialogTop:'+window.event.screenY+';edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {txtUpperOrg.text=obj;
        if(n==1)
            {  txtActive_tab.text="1";
            lstOrg_Code_M.value=obj;
			onChange_org(1,lstOrg_Code_M);
            }
        else if(n==2)
            {txtActive_tab.text="2";
            lstOrg_Code_R.value=obj;
			onChange_org(2,lstOrg_Code_R);
            }
        else if(n==3)
            {txtActive_tab.text="3";
            lstOrg_Code_P.value=obj;
			onChange_org(3,lstOrg_Code_P);
			}
        else if (n==4)
            {txtActive_tab.text="4";
            lstOrg_Code_A.value=obj;    
			onChange_org(4,lstOrg_Code_A);
            }      
        else
            {txtActive_tab.text="5";
            lstOrg_Code_His.value=obj;    
			onChange_org(5,lstOrg_Code_His);
            }                           
            
      //datOrgData.Call();
    }
    
}
//-------------------------------------------------------------
function ChoseList_box(obj_list,value)
{
    obj_list.SetDataText(value)    ;
    obj=obj_list.GetControl();
	if (obj.options.length ==2)
		obj.options.selectedIndex=0;
	else
		obj.options.selectedIndex=obj.options.length-1;
}
//-------------------------------------------------------------
function OnDataReceive(obj)
{
   if(obj.id == "datCheck_View")
    {
        if(txtFlag_View.text == 'Y')
        {
            ibtnSave.style.display = "none";
            ibtnSave_A.style.display = "none";
            ibtnSave_P.style.display = "none";

            ibtnDelete.style.display = "none";
            ibtnDelete_A.style.display = "none";
        }
        datAllowance.Call();
    }
   else if (obj.id=="datAllowance")
   {
        
        BindingCol(grdLabourContract,icmallow_amt1); //tab1
        BindingCol(grdLBReport,c_tab2_allow_amt1_1); //tab2
		BindingCol(grdLBHist,c_tab2_allow_amt1_2);	//tab2
		BindingCol(grdLBPreparation,c_tab3_allow_amt1_1); //tab3 
        BindingCol(grdAppendix,c_tab4_allow_amt1_1);    //tab4
        BindingCol(grdLBHisReport,c_tab4_allow_amt1_2); //tab4
        if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	    {
            datUser_info.Call();     	    
	    }
		else
		{
			check_init=1;
		}
        
   }
   else if (obj.id=="datLabourContractManage")
   {
        lblRecord_M.text=grdLabourContract.rows -1 + " record(s).";
        chkCheckCreate.value='F';
        chkGetSalary.value='F';     
        
   for(var i=1 ; i< grdLabourContract.rows ;i++)
    {   if( grdLabourContract.GetGridData(i,28)=='-1') 
            grdLabourContract.SetCellBgColor(i,0,i,28,0xFFEEFF);
          }   
   }
   else if (obj.id=="datLabourContractReport")
   {
        lblRecord_R.text=grdLBReport.rows -1 + " record(s).";
        chkCheckReport.value='F';
   }
   else if (obj.id=="datAppendixContract")
   {
        lblRecord_A.text=grdAppendix.rows -1 + " record(s).";
   }
   else if (obj.id=="datLabourContractHis")
   {
        lblRecord_H.text=grdLBHist.rows -1 + " record(s).";
        
   }
   else if (obj.id=="datLabourContractPre")
   {
        lblRecord_P.text=grdLBPreparation.rows -1 + " record(s).";
        if (grdLBPreparation.rows==1)
            chkCheckPre.value='F';
        else
            chkCheckPre.value='T';
   }  
   else if (obj.id=="datUser_info")
   {
        lstOrg_Code_M.SetDataText(txtDeptData.text);
        lstOrg_Code_R.SetDataText(txtDeptData.text);
        lstOrg_Code_P.SetDataText(txtDeptData.text);
        lstOrg_Code_A.SetDataText(txtDeptData.text);
        lstOrg_Code_His.SetDataText(txtDeptData.text);
        txtDept.text=lstOrg_Code_M.value;

        ChangeColorItem(lstOrg_Code_M.GetControl());
        ChangeColorItem(lstOrg_Code_R.GetControl());
        ChangeColorItem(lstOrg_Code_P.GetControl());
        ChangeColorItem(lstOrg_Code_A.GetControl());
        ChangeColorItem(lstOrg_Code_His.GetControl());

        onChange_org(0,lstOrg_Code_M);
   }
   else if (obj.id=="datWorkGroup_info")
   {
		switch (flag_tab) 
		{
			case 0:
			{
				lstGrp_Code_M.SetDataText(txtwg_tmp.text + "|ALL|Select All");
                lstGrp_Code_M.value ="ALL";
				lstGrp_Code_R.SetDataText(txtwg_tmp.text + "|ALL|Select All");
                lstGrp_Code_R.value ="ALL";
				lstGrp_Code_P.SetDataText(txtwg_tmp.text + "|ALL|Select All");
                lstGrp_Code_P.value ="ALL";
				lstGrp_Code_A.SetDataText(txtwg_tmp.text + "|ALL|Select All");
                lstGrp_Code_A.value ="ALL";
                lstGrp_Code_His.SetDataText(txtwg_tmp.text + "|ALL|Select All");
                lstGrp_Code_His.value ="ALL";
				break;
			}
			case 1:
			{
				lstGrp_Code_M.SetDataText(txtwg_tmp.text + "|ALL|Select All");
                lstGrp_Code_M.value ="ALL";
				break;
			}	
			case 2:
			{
				lstGrp_Code_R.SetDataText(txtwg_tmp.text + "|ALL|Select All");
                lstGrp_Code_R.value ="ALL";
				break;
			}
			case 3:
			{
				lstGrp_Code_P.SetDataText(txtwg_tmp.text + "|ALL|Select All");
                lstGrp_Code_P.value ="ALL";
				break;
			}
			case 4:
			{
				lstGrp_Code_A.SetDataText(txtwg_tmp.text + "|ALL|Select All");
                lstGrp_Code_A.value ="ALL";
				break;
			}
            case 5:
			{
				lstGrp_Code_His.SetDataText(txtwg_tmp.text + "|ALL|Select All");
                lstGrp_Code_His.value ="ALL";
				break;
			}
		}
		check_init=1;
		
   }
   else if (obj.id=="datLBReport")
   {
        datFind_Report.Call();
   }
   else if (obj.id=="datLBHisReport")
   {
        datFind_HisReport.Call();
   }
   else if (obj.id=="datFind_Report")
   {
        var url;
        //alert(rpt_no);
        //alert(txtReport_tmp.text);       
        switch(rpt_no)
        {
            case 1: //current report
                    //txtReport_tmp.text="rpt_labour_contract.aspx";                    
                      url =System.RootURL + '/reports/ch/ae/'+txtReport_tmp.text+'?emp_pk=' + emp_pk_list+'&appendix_type=0' + '&contract_type=' + txtContract_Type.text;                   
                    break;
                  
            case 2: //current labour contract list
                url =System.RootURL + '/reports/ch/ae/'+txtReport_tmp.text+'?p_tco_dept_pk=' + lstOrg_Code_R.value + '&p_thr_group_pk=' + lstGrp_Code_R.value  + '&p_chktemp=' + lstTemp_R.value + '&p_temp=' + txtTemp_R.text + '&p_probation_type=' + lstKindPB_R.value + '&p_from_begin_probation=' + dtFromBProbation_R.value;
                url=url + '&p_to_begin_probation=' + dtToBProbation_R.value + '&p_from_end_probation=' + dtFromEProbation_R.value + '&p_to_end_probation=' + dtToEProbation_R.value + '&p_contract_type=' + lstKindLB_R.value +  '&p_from_begin_contract=' + dtFromBContract_R.value +  '&p_to_begin_contract=' + dtToBContract_R.value + '&p_from_end_contract=' + dtFromEContract_R.value + '&p_to_end_contract=' + dtToEContract_R.value + '&p_status=' + lstStatus2.value ;
                break;
            case 3: //history report
                url =System.RootURL + '/reports/ch/ae/'+ txtReport_tmp.text +'?emp_pk=' + emp_pk_list_his +'&appendix_type=0 ' + '&contract_type=' + txtContract_Type.text;
                break;
            case 4: //labour contract preparation
                if (FindSameType(grdLBPreparation,c_tab3_contract_code)==false)
                {                    
                    alert("Have to print the same type of report!" + "\n"  + "Phải chọn cùng một kiểu của loại hợp đồng!");
                    break;
                }
                else                   
                    url =System.RootURL + '/reports/ch/ae/'+txtReport_tmp.text+'?&p_contract_type=' + lstKindLB_P.value + '&emp_pk=' + emp_pk_list;
                break; 
            case 5:
                url =System.RootURL + '/reports/ch/ae/'+txtReport_tmp.text+'?emp_pk=' + emp_pk_list + '&appendix_type=1';                 
                break;
            case 6:
                url =System.RootURL + '/reports/ch/ae/'+txtReport_tmp.text+'?emp_pk=' + emp_pk_list + '&appendix_type=1';;                 
                break;  
            case 7:
                url =System.RootURL + '/reports/ch/ae/'+txtReport_tmp.text+'?emp_pk=' + emp_pk_list + '&appendix_type=1';;                 
                break; 
            case 8: //appendix report posco LT
                    //txtReport_tmp.text="rpt_labour_contract.aspx";
                    url =System.RootURL + '/reports/ch/ae/'+txtReport_tmp.text+'?emp_pk=' + emp_pk_list+'&appendix_type=0' + '&contract_type=' + txtContract_Type.text;
                    break;  
            case 9: //current foreigner report
                    //txtReport_tmp.text="rpt_labour_contract.aspx";
                    url =System.RootURL + '/reports/ch/ae/'+txtReport_tmp.text+'?emp_pk=' + emp_pk_list+'&appendix_type=0' + '&contract_type=' + txtContract_Type.text;
                    break;             
         }       
        window.open(url);    
   }
   else if (obj.id=="datFind_HisReport")
   {
        var url;
        //alert(rpt_no);
        //alert(txtReport_tmp.text);       
        switch(rpt_no)
        {
            case 1: //history report
                    //txtReport_tmp.text="rpt_labour_contract.aspx";                    
                      url =System.RootURL + '/reports/ch/ae/'+txtReport_tmp.text+'?emp_pk=' + emp_pk_list+'&appendix_type=0' + '&contract_type=' + txtContract_Type.text;                   
                    break;
                  
            case 2: //History labour contract list
                url =System.RootURL + '/reports/ch/ae/'+txtReport_tmp.text+'?p_tco_dept_pk=' + lstOrg_Code_R.value + '&p_thr_group_pk=' + lstGrp_Code_R.value  + '&p_chktemp=' + lstTemp_R.value + '&p_temp=' + txtTemp_R.text + '&p_probation_type=' + lstKindPB_R.value + '&p_from_begin_probation=' + dtFromBProbation_R.value;
                url=url + '&p_to_begin_probation=' + dtToBProbation_R.value + '&p_from_end_probation=' + dtFromEProbation_R.value + '&p_to_end_probation=' + dtToEProbation_R.value + '&p_contract_type=' + lstKindLB_R.value +  '&p_from_begin_contract=' + dtFromBContract_R.value +  '&p_to_begin_contract=' + dtToBContract_R.value + '&p_from_end_contract=' + dtFromEContract_R.value + '&p_to_end_contract=' + dtToEContract_R.value + '&p_status=' + lstStatus2.value ;
                break;
              
            case 7:
                url =System.RootURL + '/reports/ch/ae/'+txtReport_tmp.text+'?emp_pk=' + emp_pk_list + '&appendix_type=1';;                 
                break; 
            case 8: //appendix report posco LT
                    //txtReport_tmp.text="rpt_labour_contract.aspx";
                    url =System.RootURL + '/reports/ch/ae/'+txtReport_tmp.text+'?emp_pk=' + emp_pk_list+'&appendix_type=0' + '&contract_type=' + txtContract_Type.text;
                    break;  
            case 9: //current foreigner report
                    //txtReport_tmp.text="rpt_labour_contract.aspx";
                    url =System.RootURL + '/reports/ch/ae/'+txtReport_tmp.text+'?emp_pk=' + emp_pk_list+'&appendix_type=0' + '&contract_type=' + txtContract_Type.text;
                    break;             
         }       
        window.open(url);    
   }
   else if (obj.id=="datOrgData")
   {   
   txtOrgData.text=txtOrgData.text+"|ALL|Select All";
     if(txtActive_tab.text=="1")
         {  
            lstOrg_Code_M.SetDataText(txtOrgData.text);
            lstOrg_Code_M.value= txtUpperOrg.text;
          }
        else if(txtActive_tab.text=="2")
            {
             lstOrg_Code_R.SetDataText(txtOrgData.text);
             lstOrg_Code_R.value= txtUpperOrg.text;
            }
        else if(txtActive_tab.text=="3")
            {
              lstOrg_Code_P.SetDataText(txtOrgData.text);
              lstOrg_Code_P.value= txtUpperOrg.text;
             }
        else
            {  lstOrg_Code_A.SetDataText(txtOrgData.text);
               lstOrg_Code_A.value= txtUpperOrg.text;
             }
	}
    else if (obj.id=="datLabourContractHis2")
   {
        lblRecord_His.text=grdLBHisReport.rows -1 + " record(s).";
        
   }
}

function onChange_org(tab,obj)
{
	flag_tab=tab;
	
	txtOrg_tmp.text=obj.value;
	datWorkGroup_info.Call();
	
}

//-------------------------------------------------
function OnSetLBType(obj_grd,obj_col)
{
    var tmp;
    tmp=lstKindLB_Set.value;    
    var ctrl = obj_grd.GetGridControl();
	for ( var i =  0 ; i < ctrl.SelectedRows ; i++ )
		{
			var row = ctrl.SelectedRow(i);
			if ( row > 0 )
			{		
				obj_grd.SetGridText(row,obj_col,tmp);
			}	
		}
}
//--------------------------------------------------
function BindingCol(obj,icol)
{
    obj.SetGridText(0,icol,lblA1.text);
    obj.SetGridText(0,icol+1,lblA2.text);
    obj.SetGridText(0,icol+2,lblA3.text);
    obj.SetGridText(0,icol+3,lblA4.text);
    obj.SetGridText(0,icol+4,lblA5.text);
    obj.SetGridText(0,icol+5,lblA6.text);
    obj.SetGridText(0,icol+6,lblA7.text);
    obj.SetGridText(0,icol+7,lblA8.text);
    obj.GetGridControl().ColHidden(icol)=!(Number(lblDisplay1.text));
    obj.GetGridControl().ColHidden(icol+1)=!(Number(lblDisplay2.text));
    obj.GetGridControl().ColHidden(icol+2)=!(Number(lblDisplay3.text));
    obj.GetGridControl().ColHidden(icol+3)=!(Number(lblDisplay4.text));
    obj.GetGridControl().ColHidden(icol+4)=!(Number(lblDisplay5.text));
    obj.GetGridControl().ColHidden(icol+5)=!(Number(lblDisplay6.text));
    obj.GetGridControl().ColHidden(icol+6)=!(Number(lblDisplay7.text));
    obj.GetGridControl().ColHidden(icol+7)=!(Number(lblDisplay8.text));
}

//------------------------------------------------
function OnToggle()
{
    
    if(imgArrow.status == "expand")
    {
        tblHist.style.display="none";
        imgArrow.status = "collapse";
        imgArrow.alt="Show old contract";
        imgArrow.src = "../../../system/images/iconmaximize.gif";
        tblReport.style.height="100%";
        tblMainHist.style.height="78%";
        tblHist.style.height="0%";
        
    }
    else
    {
        tblHist.style.display="";
        imgArrow.status = "expand";
        imgArrow.alt="Hide old contract";
        imgArrow.src = "../../../system/images/close_popup.gif";
        tblReport.style.height="100%";
        tblMainHist.style.height="48%";
        tblHist.style.height="30%";
        if (grdLBReport.row>0)
        {
            txtEmp_PK.text=grdLBReport.GetGridData(grdLBReport.row,c_tab2_emp_pk_1);
            datLabourContractHis.Call("SELECT");
        }
        
    }
    
}
//------------------------------------------------

function OnToggle_A()
{
    
    if(imgArrow_A.status == "expand")
    {
        idAppendix_His.style.display="none";
        imgArrow_A.status = "collapse";
        imgArrow_A.src = "../../../system/images/iconmaximize.gif";
        idAppendix.style.height="100%";
        idAppendix_Main.style.height="76%";
        idAppendix_His.style.height="0%";
        
    }
    else
    {
        idAppendix_His.style.display="";
        imgArrow_A.status = "expand";
        imgArrow_A.src = "../../../system/images/close_popup.gif";
        idAppendix.style.height="100%";
        idAppendix_Main.style.height="40%";
        idAppendix_His.style.height="36%";
        if (grdLBReport.row>0)
        {
            txtEmp_PK.text=grdLBReport.GetGridData(grdLBReport.row,c_tab2_emp_pk_1);
            datLabourContractHis.Call("SELECT");
        }
        
    }
    
}

//-----------------------------------------------------
function OnSearch(obj_data)
{
	if(check_init==1)
	{
		if (obj_data==datLabourContractPre && lstKindLB_P.value=="ALL")
		{
			alert("Have to select a type of labour contract Kind!" + "\n" + "Bạn phải chọn một loại hợp đồng!");
			
		}
		else if (obj_data==datLabourContractPre && (dtFromSign.value=="" || dtToSign.value==""))
		{
				alert("Have to input date of period of signing!" + "\n" + "Bạn phải nhập ngày ký hợp đồng!");
		}
		else    
			obj_data.Call("SELECT");
	}		
        
}
//-----------------------------------------------------
function OnSave(objid)
{
	if(check_init==1)
	{
		switch (objid)
		{
			case 1:
				if(confirm("Do you want to save contract ?" + "\n" + "Bạn có muốn cập nhật hợp đồng không?") &&  CheckBeforeSave())
				{
					datLabourContractManage.Call();
				}
				break;
			case 2:
				if(confirm("Do you want to save contract ?" + "\n" + "Bạn có muốn cập nhật hợp đồng không?") )
				{
					datLabourContractPre.Call();
				}
				break;
			case 3:
				if(confirm("Do you want to save appendix contract ?" + "\n" + "Bạn có muốn cập nhật phụ lục hợp đồng không?") &&  CheckBeforeSave())
				{
					datAppendixContract.Call();
				} 
				break;
				 
		}
	}	
}

//---------------------------------------------------------
function OnDelete()
{
	if(check_init==1)
	{
		if(confirm("Do you want to delete this contract ?" + "\n" + "Bạn có muốn xóa hợp đồng này không?"))
		{
			grdLabourContract.DeleteRow();
		}
	}	
}
//---------------------------------------------------------
function OnDelete_A()
{
    if(confirm("Do you want to delete this appendix contract ?" + "\n" + "Bạn có muốn xóa phụ lục hợp đồng này không?"))
    {
        grdAppendix.DeleteRow();
    }
}
//--------------------------
function CheckBeforeSave()
{
    var p_create_new;
    var p_old_contract_type;
    var p_new_contract_type,p_begin_pro,p_end_pro,p_begin_con,p_end_con;
    for(var i=1;i<grdLabourContract.rows;i++)
    {
        if (grdLabourContract.GetRowStatus(i)==16)
        {
            p_join_dt=grdLabourContract.GetGridData(i,icmjoin_dt); //column create new
            p_join_dt=String(p_join_dt.substr(6,4)) + String(p_join_dt.substr(3,2)) + String(p_join_dt.substr(0,2));
            p_create_new=grdLabourContract.GetGridData(i,icmcreate_contract); //column create new
            p_old_contract_type=grdLabourContract.GetGridData(i,icmoldcontract_type); //column old_contract_type
            p_new_contract_type=grdLabourContract.GetGridData(i,icmnewcontract_type); //column new_contract_type
            p_begin_pro=grdLabourContract.GetGridData(i,icmbegin_probation); //column begin probation
            p_end_pro=grdLabourContract.GetGridData(i,icmend_probation); //column end probation
            p_begin_con=grdLabourContract.GetGridData(i,icmbegin_contract); //column begin contract
            p_end_con=grdLabourContract.GetGridData(i,icmend_contract); //column end contract
            if (Number(p_join_dt) > Number(p_begin_pro) || Number(p_join_dt) > Number(p_end_pro) || ( Number(p_join_dt) > Number(p_begin_con) && p_begin_con !='') || (Number(p_join_dt) > Number(p_end_con) && p_end_con !=''))
            {
                alert("Join Date can not larger than Contract signed date at row " + i + "\n" + "Ngày vào không thể lớn hơn ngày ký hợp đồng tại dòng " + i );
                return false;
            }
            if ( Number(p_begin_pro) > Number(p_end_pro)  || (Number(p_begin_con) > Number(p_end_con)  && p_end_con !='') )
            {
                alert("Start Date can not larger than End Date at row " + i + "\n" + "Ngày bắt đầu ký hợp đồng không thể nhỏ hơn ngày kết thúc tại dòng " + i );
                return false;
            }
            if ((p_create_new==-1) && (p_old_contract_type == p_new_contract_type ) && p_new_contract_type !='05')
            {
                alert("Have to choose another contract type if you want to create new contract at row " + i + "\n" + "Để tạo hợp đồng mới bạn phải chọn loại hợp đồng mới tại dòng " + i );
                return false;
            }
            else if ((p_create_new==0) && (p_old_contract_type != p_new_contract_type))
            {
                alert("Have to choose old contract type if you wan't to create new contract at row " + i + "\n" + "Phải chọn hợp đồng cũ nếu không tạo hợp đồng mới tại dòng " + i );
                return false;
            }
        }
    }
    return true;
}

//------------------------------------------------------------------------------------
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

//----------------------------------------------------------------------------------
function OnPrint(obj)
{ 
    if(tabMain.GetCurrentPageNo()==0)
            {
                txtActive_tab.text="1";
                txtOrg_tmp.text =lstOrg_Code_M.value;
                
			}
        else if(tabMain.GetCurrentPageNo()==1)
            {
                txtActive_tab.text="2";
                txtOrg_tmp.text =lstOrg_Code_R.value;
			// alert(lstOrg_Code_R.value +"  "  +tabMain.GetCurrentPageNo());                
            }
        else if(tabMain.GetCurrentPageNo()==2)
            {txtActive_tab.text="3";
            txtOrg_tmp.text =lstOrg_Code_P.value;
			}
        else 
            {txtActive_tab.text="4";
            txtOrg_tmp.text =lstOrg_Code_A.value;    			
            }  
       
            //alert("test");      
           // alert(txtOrg_tmp.text +"  "  +tabMain.GetCurrentPageNo());                
   
    rpt_no=obj;
        
        if(rpt_no=='1')
        { 
            /*var fpath = System.RootURL + "/form/ch/ae/chae00030_reports_list.aspx?formID=chae00040&rpt_no=1";
              var obj1=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:20;dialogHeight:14;dialogLeft:900;dialogTop:330;edge:sunken;scroll:yes;unadorned:yes;help:no');
            if (obj1!=null )
            {
             txtReport_tmp.text=  obj1[1];
             rpt_no=Number(obj1[0]); 
             
            }
            else return;*/
            txtReport_tmp.text=lstReport_type.value;
        }
        
        //alert("rpt_no: " + rpt_no);
        //alert("temp.text: "+txtReport_tmp.text);
        switch(rpt_no)
        {
            case 1: //current report
                if (FindSameType(grdLBReport,c_tab2_contract_code_1)==false)
                {
                    alert("Have to print the same type of report!" + "\n"  + "Phải chọn cùng một kiểu của loại hợp đồng!");
                    return;
                }
                else
                {
                    emp_pk_list="";
                    
                    for (var i=1;i<=grdLBReport.rows-1;i++)
                    {
                        if (grdLBReport.GetGridData(i,0)=="-1")
                        {
                            emp_pk_list = emp_pk_list + grdLBReport.GetGridData(i,c_tab2_emp_pk_1) + ",";
                            txtContract_Type.text=grdLBReport.GetGridData(i,c_tab2_contract_code_1);
                            txtProbation_Type.text=grdLBReport.GetGridData(i,c_tab2_probation_code_1);
                        }   
                    }
                    if (emp_pk_list=="")
                        alert("Please choose employees to print");
                    else
                    {
                        emp_pk_list=emp_pk_list.substr(0,emp_pk_list.length-1);
						txtOrg_tmp.text=lstOrg_Code_R.value; 
                        //datLBReport.Call();
                        datFind_Report.Call();
                    }
                }    
                break;
            case 2: //current labour contract list
            {
                txtReport_tmp.text="rpt_list_lb.aspx";
				txtOrg_tmp.text=lstOrg_Code_R.value; 
                datFind_Report.Call();
                break;
            }
            case 3: //history report
			{
                emp_pk_list_his="";
                for (var i=1;i<=grdLBHist.rows-1;i++)
                    {
                        if (grdLBHist.GetGridData(i,0)=="-1")
                        {
                            emp_pk_list_his = emp_pk_list_his + grdLBHist.GetGridData(i,c_tab2_emp_pk_2) + ",";
                            txtContract_Type.text=grdLBHist.GetGridData(i,c_tab2_contract_code_2);
                        }   
                    }
                    
                    if (emp_pk_list_his=="")
                        alert("Please choose employees to print");
                    else
                    {
                        emp_pk_list_his=emp_pk_list_his.substr(0,emp_pk_list_his.length-1);
						txtOrg_tmp.text=lstOrg_Code_R.value;
						
                        /*if (v_language!="KOR")
                            datLBReport.Call();
                        else
                        {
                            
                            if (txtContract_Type.text=="01") //thu viec
                                txtReport_tmp.text="rpt_probation_contract_korean.aspx";
                            else    
                                txtReport_tmp.text="rpt_labour_contract_korean.aspx";
                            datFind_Report.Call();
                        }*/
                        txtReport_tmp.text=lstReport_type_hist.value;
                        datFind_Report.Call();
                    }
                break;
			}
            case 4: //labour contract preparation
                if (FindSameType(grdLBPreparation,c_tab3_contract_code)==false)
                {
                    alert("Have to print the same type of report!" + "\n"  + "Phải chọn cùng một kiểu của loại hợp đồng!");
                    break;
                }
                else 
                {
                    emp_pk_list="";
                    
                    for (var i=1;i<=grdLBPreparation.rows-1;i++)
                    {
                        if (grdLBPreparation.GetGridData(i,0)=="-1")
                        {
                            emp_pk_list = emp_pk_list + grdLBPreparation.GetGridData(i,c_tab3_emp_pk) + ",";                        
                        }   
                    }
                    if (emp_pk_list=="")
                        {alert("Please choose employees to print");
                        return;
                        }
                    else
                    {
                        emp_pk_list=emp_pk_list.substr(0,emp_pk_list.length-1);
                        if (lstKindLB_P.value=="01")
                            txtReport_tmp.text="rpt_lb_signning_pro.aspx";
                        else
                            txtReport_tmp.text="rpt_lb_signning.aspx";
                    }
					txtOrg_tmp.text=lstOrg_Code_P.value;
                    datFind_Report.Call();
                 }
                break;
           case 5:  // appendix contract
                  emp_pk_list="";
                  appendix_times="";
                    
                    for (var i=1;i<=grdAppendix.rows-1;i++)
                    {
                        if (grdAppendix.GetGridData(i,0)=="-1")
                        {
                            emp_pk_list = emp_pk_list + grdAppendix.GetGridData(i,c_tab4_contract_code_1) + ",";
                           
                        }   
                    }
                 if (emp_pk_list=="")
                        alert("Please choose employees to print");
                 else
                 {
                        emp_pk_list=emp_pk_list.substr(0,emp_pk_list.length-1);
                        txtReport_tmp.text = lstAppendixReportType.value;// "rpt_appendix_contract.aspx";
                        //url =System.RootURL + '/reports/ch/ae/rpt_appendix_contract.aspx?emp_pk=' + emp_pk_list;
                        //window.open(url); 
						txtOrg_tmp.text=lstOrg_Code_A.value;
                        datFind_Report.Call();
                 }
                break;   
            case 6:  // appendix contract history
                  emp_pk_list="";
                  appendix_times="";
                    
                    for (var i=1;i<=grdAppendix_His.rows-1;i++)
                    {
                        if (grdAppendix_His.GetGridData(i,0)=="-1")
                        {
                            emp_pk_list = emp_pk_list + grdAppendix_His.GetGridData(i,c_tab4_emp_pk_2) + ",";
                           
                        }   
                    }
                 
                 if (emp_pk_list=="")
                        alert("Please choose employees to print");
                 else
                 {
                        emp_pk_list=emp_pk_list.substr(0,emp_pk_list.length-1);
                        txtReport_tmp.text = lstAppendixReportType.value; //"rpt_appendix_contract.aspx";
                        //url =System.RootURL + '/reports/ch/ae/rpt_appendix_contract.aspx?emp_pk=' + emp_pk_list;
                        //window.open(url); 
						txtOrg_tmp.text=lstOrg_Code_A.value;
                        datFind_Report.Call();
                 }
                break;
            case 7: // labour decide
                    emp_pk_list="";
                    
                    for (var i=1;i<=grdLBReport.rows-1;i++)
                    {
                        if (grdLBReport.GetGridData(i,0)=="-1")
                        {
                            emp_pk_list = emp_pk_list + grdLBReport.GetGridData(i,c_tab2_emp_pk_1) + ",";
                            txtContract_Type.text=grdLBReport.GetGridData(i,c_tab2_contract_code_1);
                            txtProbation_Type.text=grdLBReport.GetGridData(i,c_tab2_probation_code_1);
                        }   
                    }
                    if (emp_pk_list=="")
                        alert("Please choose employees to print");
                    else
                    {
                        emp_pk_list=emp_pk_list.substr(0,emp_pk_list.length-1);
                        txtReport_tmp.text="rpt_Labour_Decide.aspx";
						txtOrg_tmp.text=lstOrg_Code_R.value;
                        datFind_Report.Call();
                    } 
                    break;
               case 8: //posco LT
                if (FindSameType(grdLBReport,c_tab2_contract_code_1)==false)
                {
                    alert("Have to print the same type of report!" + "\n"  + "Phải chọn cùng một kiểu của loại hợp đồng!");
                    return;
                }
                else
                {
                    emp_pk_list="";
                    
                    for (var i=1;i<=grdLBReport.rows-1;i++)
                    {
                        if (grdLBReport.GetGridData(i,0)=="-1")
                        {
                            emp_pk_list = emp_pk_list + grdLBReport.GetGridData(i,c_tab2_emp_pk_1) + ",";
                            txtContract_Type.text=grdLBReport.GetGridData(i,c_tab2_contract_code_1);
                            txtProbation_Type.text=grdLBReport.GetGridData(i,c_tab2_probation_code_1);
                        }   
                    }
                    if (emp_pk_list=="")
                        alert("Please choose employees to print");
                    else
                    {
                        emp_pk_list=emp_pk_list.substr(0,emp_pk_list.length-1);
						txtOrg_tmp.text=lstOrg_Code_M.value; 
                        datFind_Report.Call();
                    }
                }    
                break;
                case 9: //current foreigner report
                if (FindSameType(grdLBReport,c_tab2_contract_code_1)==false)
                {
                    alert("Have to print the same type of report!" + "\n"  + "Phải chọn cùng một kiểu của loại hợp đồng!");
                    return;
                }
                else
                {
                    emp_pk_list="";
                    
                    for (var i=1;i<=grdLBReport.rows-1;i++)
                    {
                        if (grdLBReport.GetGridData(i,0)=="-1")
                        {
                            emp_pk_list = emp_pk_list + grdLBReport.GetGridData(i,c_tab2_emp_pk_1) + ",";
                            txtContract_Type.text=grdLBReport.GetGridData(i,c_tab2_contract_code_1);
                            txtProbation_Type.text=grdLBReport.GetGridData(i,c_tab2_probation_code_1);
                        }   
                    }
                    if (emp_pk_list=="")
                        alert("Please choose employees to print");
                    else
                    {
                        emp_pk_list=emp_pk_list.substr(0,emp_pk_list.length-1);
						txtOrg_tmp.text=lstOrg_Code_R.value; 
                        txtForeignerYN.text='Y';
                        datLBReport.Call();
                    }
                }    
                break; /**/   
           
			
        }
    
    
}

function OnPrintHis(obj)
{     
	var url = System.RootURL;
    txtActive_tab.text="5";
    txtOrg_tmp.text =lstOrg_Code_His.value;    			                               
    rpt_no=obj;
	
	url = url + '/Reports/ch/ae/rpt_Labour_Contract_History.aspx' + '?p_tco_org_pk=' + lstOrg_Code_His.value + '&p_thr_wg_pk=' + lstGrp_Code_His.value + '&p_chktemp=' + lstTemp_His.value+'&p_temp='+txtTemp_His.text+'&p_contract_type='+lstKindLB_His.value+'&p_from_begin_contract='+dtFromBContract_His.value+'&p_to_begin_contract='+dtToBContract_His.value+'&p_status='+lstStatusHis.value;
	System.OpenTargetPage( url , 'newform' );
	
	    


}
//-------------------------------------------------------------------------------------
function FindSameType(obj_grid,col) //check report of grid just one labour contract type
{
    var irow;
    irow=0;
    for (var i=1;i<=obj_grid.rows-1;i++)
    {
        if (obj_grid.GetGridData(i,0)=="-1")
        {
            if (obj_grid.GetGridData(i,col) !=obj_grid.GetGridData(irow,col) && irow !=0)
                return false;
            irow=i;
            
        }
    }
    return true;
    
}
//-----------------------------------labour contract report -------------------------

function OnClick_grdLBReport()
{
    
    //xac dinh loai report muon in
    var ctrl=grdLBReport.GetGridControl();
    var tmp,tmp2;
    var l_found=0;
    var lstctl;
    
    if(ctrl.col==c_tab2_Select_1)
    {
        if(ctrl.row>1)
        {
            lstctl=lstReport_type.GetControl();
            tmp=grdLBReport.GetGridData(ctrl.row,c_tab2_contract_code_1);
            tmp2=lstReport_type.GetText().substr(0, 2);
            for (var i = 0; i < lstctl.options.length; i++)
            {
                if(l_found==0 && tmp==lstctl.options.item(i).text.substr(0, 2)) // so ky tu dau cua code HR0212 la contract code
                {
                    l_found=1; //set phan tu dau tien
                    if(tmp!=tmp2)
                        lstctl.options.selectedIndex=i;
                }
            }    
        }
    }
    
    if (imgArrow.status=="expand")
    {
        txtEmp_PK.text=grdLBReport.GetGridData(ctrl.row,c_tab2_emp_pk_1);
        datLabourContractHis.Call("SELECT");
    }
}
//-------------------------check select column of grid labour contract history-------------------
function AfterSelectHist() 
{
    
        if (grdLBHist.col==0)
        {
            var i,icurrow;
            icurrow=grdLBHist.row;
            if ( grdLBHist.GetGridData(icurrow,0)==-1)
                for (i=1;i<=grdLBHist.rows-1;i++)
                    if (icurrow!=i) 
                        grdLBHist.SetGridText(i,0,"0");
        }
    
}
//------------Appendix Contract----------------
function OnHistAppendixContract()
{
    if (imgArrow_A.status=="expand")
    {
        txtEmp_PK_A.text=grdAppendix.GetGridData(grdAppendix.row,c_tab4_emp_pk_1);
        txtAppendix_Times_A.text=grdAppendix.GetGridData(grdAppendix.row,c_tab4_appendix_time_1); 
        txtContract_Type_A.text = grdAppendix.GetGridData(grdAppendix.row,c_tab4_contract_code_1);
        datAppendixContractHis.Call("SELECT");
    }
}

function OnSetDate()
{
	if(idSetDate.value=="")
	{
		alert("Signature date cannot be blank");
		return;
	}
	var ctrl = grdAppendix.GetGridControl();    
    if (ctrl.SelectedRows>0)
    {
	    for ( var i =  0 ; i < ctrl.SelectedRows ; i++ )
		    {
			    var row = ctrl.SelectedRow(i);
			    if ( row > 0 )
			    {		
				    grdAppendix.SetGridText(row,c_tab4_sign_dt_1,idSetDate.value);
			    }
		    }
	}	
	
}

function OnGetContractDate()
{
	var ctrl = grdAppendix.GetGridControl();  
	var is_check=0;
	if(chkGetContactDate.value=='T')
		is_check=-1;
	else
		is_check=0;
    if (ctrl.SelectedRows>0)
    {
	    for ( var i =  0 ; i < ctrl.SelectedRows ; i++ )
		    {
			    var row = ctrl.SelectedRow(i);
			    if ( row > 0 )
			    {		
				    grdAppendix.SetGridText(row,c_tab4_contract_dt_1,is_check);
			    }
		    }
	}	
}
//-------------------------------------------------------------------------------------
</script>

<body style=" margin-bottom:0; margin-top:0; margin-right:0" >
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
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="HR_SP_SEL_USER_ROLE2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="txtDeptData" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------->
<gw:data id="datAllowance" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_PRO_10010004_ALLOWANCE_LB" > 
                <input>
                    <input bind="txtAllowance" /> 
                    <input bind="txtCompany_pk" /> 
                </input> 
                <output>
                    <output bind="lblA1" />
                    <output bind="lblA2" />
                    <output bind="lblA3" />
                    <output bind="lblA4" />
                    <output bind="lblA5" />
                    <output bind="lblA6" />
                    <output bind="lblA7" />
                    <output bind="lblA8" />
                    <output bind="lblDisplay1" />
                    <output bind="lblDisplay2" />
                    <output bind="lblDisplay3" />
                    <output bind="lblDisplay4" />
                    <output bind="lblDisplay5" />
                    <output bind="lblDisplay6" />
                    <output bind="lblDisplay7" />
                    <output bind="lblDisplay8" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------>
<gw:data id="datLBReport" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_PRO_10010004_GET_LB_REPORT" > 
                <input>
                    <input bind="txtProbation_Type" /> 
                    <input bind="txtContract_Type" /> 
                    <input bind="txtForeignerYN" />                     
                </input> 
                <output>
                    <output bind="txtReport_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datLBHisReport" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_PRO_10010004_GET_LB_REPORT" > 
                <input>
                    <input bind="txtProbation_Type" /> 
                    <input bind="txtContract_Type" /> 
                    <input bind="txtForeignerYN" />                     
                </input> 
                <output>
                    <output bind="txtReport_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!-----------------------tab labour contract manage------------------------------->
<gw:data id="datLabourContractManage" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" parameter="2,4,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28" function="HR_SEL_10010004_MANAGE " procedure="HR_UPD_10010004_MANAGE"> 
                <input bind="grdLabourContract">
                    <input bind="lstOrg_Code_M" /> 
                    <input bind="lstGrp_Code_M" /> 
                    <input bind="lstTemp_M" /> 
                    <input bind="txtTemp_M" /> 
                    <input bind="lstKindPB_M" /> 
                    <input bind="dtFromBProbation_M" /> 
                    <input bind="dtToBProbation_M" /> 
                    <input bind="dtFromEProbation_M" /> 
                    <input bind="dtToEProbation_M" /> 
                    <input bind="lstKindLB_M" />
                    <input bind="dtFromBContract_M" /> 
                    <input bind="dtToBContract_M" /> 
                    <input bind="dtFromEContract_M" /> 
                    <input bind="dtToEContract_M" /> 
                    <input bind="lstStatus1" />
                </input> 
                <output bind="grdLabourContract"/>
            </dso> 
        </xml> 
</gw:data>
<!-----------------------tab labour contract report------------------------------->
<gw:data id="datLabourContractReport" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid"  function="HR_SEL_10010004_REPORT" > 
                <input bind="grdLBReport">
                    <input bind="lstOrg_Code_R" /> 
                    <input bind="lstGrp_Code_R" /> 
                    <input bind="lstTemp_R" /> 
                    <input bind="txtTemp_R" /> 
                    <input bind="lstKindPB_R" /> 
                    <input bind="dtFromBProbation_R" /> 
                    <input bind="dtToBProbation_R" /> 
                    <input bind="dtFromEProbation_R" /> 
                    <input bind="dtToEProbation_R" /> 
                    <input bind="lstKindLB_R" />
                    <input bind="dtFromBContract_R" /> 
                    <input bind="dtToBContract_R" /> 
                    <input bind="dtFromEContract_R" /> 
                    <input bind="dtToEContract_R" /> 
                    <input bind="lstStatus2" />
                </input> 
                <output bind="grdLBReport"/>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------------------------>
<gw:data id="datLabourContractHis" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid"  function="HR_SEL_10010004_HIS" > 
                <input bind="grdLBHist">
                    <input bind="txtEmp_PK" /> 
                </input> 
                <output bind="grdLBHist"/>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datLabourContractHis2" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid"  function="HR_SEL_10010004_HIS2" > 
                <input bind="grdLBHisReport">
                    <input bind="lstOrg_Code_His" /> 
                    <input bind="lstGrp_Code_His" /> 
                    <input bind="lstTemp_His" /> 
                    <input bind="txtTemp_His" /> 
                    <%--<input bind="lstKindPB_His" /> 
                    <input bind="dtFromBProbation_His" /> 
                    <input bind="dtToBProbation_His" /> 
                    <input bind="dtFromEProbation_His" /> 
                    <input bind="dtToEProbation_His" /> --%>
                    <input bind="lstKindLB_His" />
                    <input bind="dtFromBContract_His" /> 
                    <input bind="dtToBContract_His" /> 
                 <%--   <input bind="dtFromEContract_His" /> 
                    <input bind="dtToEContract_His" /> --%>
                    <input bind="lstStatusHis" /> 
                </input> 
                <output bind="grdLBHisReport"/>
            </dso> 
        </xml> 
</gw:data>
<!-----------------------tab labour contract preparation------------------------------->
<gw:data id="datLabourContractPre" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid"  function="HR_SEL_10010004_PRE" > 
                <input bind="grdLBPreparation">
                    <input bind="lstOrg_Code_P" /> 
                    <input bind="lstGrp_Code_P" /> 
                    <input bind="lstTemp_P" /> 
                    <input bind="txtTemp_P" /> 
                    <input bind="lstKindLB_P" />
                    <input bind="dtFromSign" /> 
                    <input bind="dtToSign" /> 
                    <input bind="lstStatus3" />
                </input> 
                <output bind="grdLBPreparation"/>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------>
<gw:data id="datFind_Report" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_SP_PRO_FIND_REPORT_2" > 
                <input>
                    <input bind="txtReport_tmp" /> 
                    <input bind="txtOrg_tmp" /> 
                </input> 
                <output>
                    <output bind="txtReport_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------>
<gw:data id="datFind_HisReport" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_SP_PRO_FIND_REPORT_2" > 
                <input>
                    <input bind="txtReport_tmp" /> 
                    <input bind="txtOrg_tmp" /> 
                </input> 
                <output>
                    <output bind="txtReport_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!-------------Tab Appendix Contract----------------->
<gw:data id="datAppendixContract" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" parameter="3,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23" function="HR_SEL_10010004_APPENDIX" procedure="HR_UPD_10010004_APPENDIX"> 
                <input bind="grdAppendix">
                    <input bind="lstOrg_Code_A" /> 
                    <input bind="lstGrp_Code_A" /> 
                    <input bind="lstTemp_A" /> 
                    <input bind="txtTemp_A" /> 
                    <input bind="lstKindLB_A" />
                    <input bind="lstStatus_A" /> 
                    <input bind="lstHaveAppendix_A" />
					<input bind="idBeginProb_A_1" />
					<input bind="idBeginProb_A_2" />
					<input bind="idEndProb_A_1" />
					<input bind="idEndProb_A_2" />					
					<input bind="idBeginContract_A_1" />
					<input bind="idBeginContract_A_2" />
					<input bind="idEndContract_A_1" />
					<input bind="idEndContract_A_2" />
                </input> 
                <output bind="grdAppendix"/>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------>
<gw:data id="datOrgData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="HR_SP_PRO_DEPT_DATA_ALL" > 
                <input>
                    <input bind="txtUpperOrg" /> 
                </input> 
                <output>
                    <output bind="txtOrgData" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datWorkGroup_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="HR_SP_SEL_WG_ROLE"  > 
                <input>
                    <input bind="txtOrg_tmp" />
                </input> 
                <output>
                    <output bind="txtwg_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------------------------------------------>

<gw:data id="datAppendixContractHis" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid"  function="HR_SEL_10010004_APPENDIX_his" > 
                <input bind="grdAppendix_His">
                    <input bind="txtEmp_PK_A" /> 
                    <input bind="txtAppendix_Times_A" />
                    <input bind="txtContract_Type_A" />
                </input> 
                <output bind="grdAppendix_His"/>
            </dso> 
        </xml> 
</gw:data>

<!--------------------main table----------------------------------->
<gw:tab id="tabMain"  border=1 style="width:100%;height:100%;" onpageactivate=""  > 

    <table name="Manage" id="management" width="100%" cellpadding="0"  cellspacing="0" border=1 style="height:100%">
        <tr  style="width:100%;height:100%" valign="top">
            <td  style="width:100%;height:100%">
                <table width="100%" id="tblexp" style="height:23%" border=0 cellpadding="0" cellspacing="0">
                    <tr style="border:0;width:100%" valign="middle"  >
                        <td width="14%"  align="right" ><a title="Click here to show Organization" onclick="OnShowPopup(1)" href="#tips" >
                            Organization </a>                  
                        </td>
                        <td width="15%"  align="left" >
                         <gw:list  id="lstOrg_Code_M" value='ALL' maxlen = "100" styles='width:100%'onchange="onChange_org(1,lstOrg_Code_M);" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td width="10%"  align="right" >W-Group</td>
                        <td width="21%" colspan=3 align="left" >
                         <gw:list  id="lstGrp_Code_M" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("SELECT pk,WorkGroup_NM FROM Thr_Work_Group WHERE DEL_IF = 0 order by workGroup_id")%>|ALL|Select All</data></gw:list>
                        </td>
                       
                        <td width="9%" style="border:0" align="right" valign="middle">Search by</td>
				       <td width="10%" style="border:0">
				            <gw:list  id="lstTemp_M" value="2" styles='width:100%' onchange=""> 
						            <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Contract NO</data> 
				            </gw:list>
			            </td>
			            <td  width="8%"  colspan=2 style="border:0"> 
				            <gw:textbox id="txtTemp_M" onenterkey   ="OnSearch(datLabourContractManage)" styles='width:100%'/>
			            </td>
			            <td width="4%"  align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch_M"   alt="Search"  onclick="OnSearch(datLabourContractManage)"/>
                        </td>
                        <td width="3%" style="border:0" align="right">
                         <gw:imgBtn img="save" id="ibtnSave"    alt="Save"  onclick="OnSave(1)"/>
                        </td>
                        <td width="3%"  align="right" >
                         <gw:imgBtn img="delete" id="ibtnDelete"   alt="Delete"  onclick="OnDelete()"/>
                        </td>
                        <td width="3%"  align="right" ></td>
                    </tr>
				    <tr align=top cellpadding="0" cellspacing="0" >
						<td align="right"  ><font color="black">Probation Type</td>
						
						<td  >
							<gw:list id="lstKindPB_M"  value="ALL" styles='width:100%'>	
								<data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0002' ORDER BY A.seq")%>|ALL|Select All</data>
							</gw:list > 										
						</td>
						<td    align=right><font color="black">Begin Probation</td>
		    	        <td  width="10%"> <gw:datebox id="dtFromBProbation_M" nullaccept styles='width:80%'   lang="<%=Session("Lang")%>"/></td>
			            <td  width="1%" align=center>~</td>
			            <td  width="10%"> <gw:datebox id="dtToBProbation_M" nullaccept styles='width:80%' lang="<%=Session("Lang")%>"/>
			
						<td  align=right><font color="black">End Probation</td>
						<td  ><gw:datebox id="dtFromEProbation_M"  styles='width:80%' nullaccept  lang="<%=Session("Lang")%>"/>  </td>						
			            <td  width="1%" align=center>~</td>
			            <td  width="10%"> <gw:datebox id="dtToEProbation_M" nullaccept styles='width:80%' lang="<%=Session("Lang")%>"/>  </td>
			            <td  align=right><font color="black">Status</td>
			            <td colspan=3  align=right><font color="black"><gw:list id="lstStatus1"  value="ALL" styles='width:100%'>	
								<data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0022' ORDER BY A.seq")%>|ALL|Select All</data>
							</gw:list > </td>
					</tr>
					<tr align=top >
						<td align="right" ><font color="black">Contract Type</font></td>
						<td >
							<gw:list id="lstKindLB_M"  value="ALL" styles='width:100%'>	
								<data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0001' ORDER BY A.seq")%>|ALL|Select All</data>
							</gw:list > 										
						</td>
						<td align=right  ><font color="black">Begin Contract</td>
			            <td  > <gw:datebox id="dtFromBContract_M" nullaccept styles='width:80%'   lang="<%=Session("Lang")%>"/></td>
			            <td   align=center>~</td>
			            <td  > <gw:datebox id="dtToBContract_M" nullaccept styles='width:80%' lang="<%=Session("Lang")%>"/>
						</td>
						
						<td    align=right><font color="black">End Contract</td>
						<td   ><gw:datebox id="dtFromEContract_M"  styles='width:80%' nullaccept  lang="<%=Session("Lang")%>"/>  </td>						
			            <td   align=center>~</td>
			            <td  > <gw:datebox id="dtToEContract_M" nullaccept styles='width:80%' lang="<%=Session("Lang")%>"/>  </td>
						<td colspan=3 align=right><gw:label id="lblRecord_M"  text="0 record(s)." maxlen = "100" styles="color:red;width:100%;font-weight: bold;font-size:12" /></td>
					</tr>
					<tr align=top >
					    <td align=right style="color:RED"><font color="black" >SET GRID COLUMN</font></td>
						<td align=right><font color="black" >Create LB</font><gw:checkbox id="chkCheckCreate" value="F" onclick="OnSetGrid(chkCheckCreate,grdLabourContract,icmcreate_contract)" ></gw:checkbox ></td>
						<td colspan=2 align="right" >Change Contract Type</td>
						<td   colspan=2 align=right colspan=3><gw:list id="lstKindLB_Set"  value="ALL" styles='width:100%'>	
								<data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0001' ORDER BY A.seq")%></data>
							</gw:list > 	</td>
					    <td  align="center" >
                         <gw:imgBtn img="set" id="ibtnSet_M"   alt="Set Grid"  onclick="OnSetLBType(grdLabourContract,icmnewcontract_type)"/>
                        </td>
                        <td colspan=3 ><font color="black" >Get Salary</font><gw:checkbox id="chkGetSalary" value="F" onclick="OnSetGrid(chkGetSalary,grdLabourContract,icmget_salary)" ></gw:checkbox ></td>
						<td colspan=1 style="white-space:nowrap" ><font color="black" >Approve</font><gw:checkbox id="chkApprove" value="F" onclick="OnSetGrid(chkApprove,grdLabourContract,icapprove)" ></gw:checkbox ></td>
					</tr>
			     </table>
                 <table cellspacing=0 cellpadding=0 style="height:77%" width=100% border=1>
                    <tr style="border:1;width:100%;height:100%" valign="top">
                        <td  style="width:100%;height:100%;"> 
                            <gw:grid   
						        id="grdLabourContract"  
						        header="Organization|_W-Group|Emp ID|Full Name|D.O.J|Contract No|Create New|Probation Kind|_Old Kind of LC|Contract Kind|Start Probation|End Probation|Start Contract|End Contract|Get Salary|Salary|ALLOW1|ALLOW2|ALLOW3|ALLOW4|ALLOW5|ALLOW6|ALLOW7|ALLOW8|_EMP_PK|TIMES|_PK|Note|Approved"   
						        format="0|0|0|0|4|0|3|2|2|2|4|4|4|4|3|-0|-0|-0|-0|-0|-0|-0|-0|-0|0|0|0|0|3"  
						        aligns="2|0|1|0|0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|0|0"  
						        defaults="||||||||||||||||||||||||||||"  
						        editcol="0|0|0|0|0|1|1|1|1|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|0|0|0|1|1"  
						        widths="1500|1500|1200|2500|1200|1500|1200|1500|2500|1200|1500|1500|1500|1500|1500|1500|2000|1500|1500|1500|1500|1500|1500|1500|0|0|0|1500|1500"  
						        styles="width:100%; height:100%"   
						        sorting="T"   
						        acceptNullDate
						        /> 
                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table>


    <table name="Report" id="tblReport"  width="100%" cellpadding="0"  cellspacing="0" border=1 style="height:98%;">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="Table2" style="height:17%" border=0 cellpadding="0" cellspacing="0">
                    <tr style="border:0;width:100%;height:5%" valign="center"  >
                        <td width="14%"  align="right" ><a title="Click here to show Organization" onclick="OnShowPopup(2)" href="#tips" >
                            Organization </a>                  
                        </td>
                        <td width="15%"  align="left" >
                         <gw:list  id="lstOrg_Code_R" value='ALL' maxlen = "100" styles='width:100%'onchange="onChange_org(2,lstOrg_Code_R);" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td width="10%"  align="right" >W-Group</td>
                        <td width="21%"  colspan=3 align="left" >
                         <gw:list  id="lstGrp_Code_R" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("SELECT pk,WorkGroup_NM FROM Thr_Work_Group WHERE DEL_IF = 0 order by workGroup_id")%>|ALL|Select All</data></gw:list>
                        </td>
                       
                        <td width="9%" style="border:0" align="right" valign="middle">Search by</td>
					   <td width="8%" style="border:0">
					        <gw:list  id="lstTemp_R" value="2" styles='width:100%' onchange=""> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Contract NO</data> 
					        </gw:list>
				        </td>
				        <td width="11%" colspan=2 style="border:0"> 
					        <gw:textbox id="txtTemp_R" onenterkey   ="OnSearch(datLabourContractReport)" styles='width:100%'/>
				        </td>
                        <td width="7%"  align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch_R"   alt="Search"  onclick="OnSearch(datLabourContractReport)"/>
                        </td>
                        
                        
                         <td width="6%" style="border:0" align="right">&nbsp;</td>

                        <td width="6%" style="border:0" align="right">
                         <gw:imgBtn id="ibtnPrint_R2" alt="Contract List" img="excel" text="Print Labour" onclick="OnPrint(2)"/>
                        </td>
                    </tr>
					<tr  style="border:0;width:100%;height:5%" align=top cellpadding="0" cellspacing="0" >
						<td align="right" ><font color="black">Probation Type</td>
						<td  >
							<gw:list id="lstKindPB_R"  value="ALL" styles='width:100%'>	
								<data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0002' ORDER BY A.seq")%>|ALL|Select All</data>
							</gw:list > 										
						</td>
						<td    align=right><font color="black">Begin Probation</td>
			            <td width="10%"> <gw:datebox id="dtFromBProbation_R" nullaccept styles='width:80%'   lang="<%=Session("Lang")%>"/></td>
			            <td width="1%" align=center>~</td>
			            <td width="10%"> <gw:datebox id="dtToBProbation_R" nullaccept styles='width:80%' lang="<%=Session("Lang")%>"/></td>
						<td  align=right><font color="black">End Probation</td>
						<td ><gw:datebox id="dtFromEProbation_R"  styles='width:80%' nullaccept  lang="<%=Session("Lang")%>"/>  </td>						
		                <td  width="1%" align=center>~</td>
		                <td   width="8%"> <gw:datebox id="dtToEProbation_R" nullaccept styles='width:80%' lang="<%=Session("Lang")%>"/>  </td>
		                <td  align=right><font color="black">Status</td>
			            <td colspan=3  align=right><font color="black"><gw:list id="lstStatus2"  value="A" styles='width:100%'>	
								<data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0022' ORDER BY A.seq")%>|ALL|Select All</data>
							</gw:list > </td>
					</tr>
					<tr  style="border:0;width:100%;height:5%" align=top >
					    <td>
					        <table width="100%" style="height:100%">
					            <tr>
					                <td  align="center"><gw:checkbox id="chkCheckReport" value="F" onclick="OnSetGrid(chkCheckReport,grdLBReport,0)" ></gw:checkbox ></td>
						            <td align="right" ><font color="black">Contract Type</font></td>
					            </tr>
					        </table>
					    </td>
						<td width="15%" >
							<gw:list id="lstKindLB_R"  value="ALL"  styles='width:100%'>	
								<data><%=Esyslib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0001' ORDER BY A.seq")%>|ALL|Select All</data>
							</gw:list > 										
						</td>
						<td align=right  ><font color="black">Begin Contract</td>
		                <td  width="10%"> <gw:datebox id="dtFromBContract_R" nullaccept styles='width:80%'   lang="<%=Session("Lang")%>"/></td>
		                <td   width="1%" align=center>~</td>
		                <td  width="10%"> <gw:datebox id="dtToBContract_R" nullaccept styles='width:80%' lang="<%=Session("Lang")%>"/>
						<td    align=right><font color="black">End Contract</td>
						<td   ><gw:datebox id="dtFromEContract_R"  styles='width:80%' nullaccept  lang="<%=Session("Lang")%>"/>  </td>						
			            <td  width="1%" align=center>~</td>
			            <td width="10%" > <gw:datebox id="dtToEContract_R" nullaccept styles='width:80%' lang="<%=Session("Lang")%>"/>  </td>
			            <td  colspan=3 align="right">&nbsp;</td>
						<td align="right" valign="bottom" ><img status="expand" id="imgArrow" src="../../../system/images/iconmaximize.gif" alt="Show old contract "  style="cursor:hand" onclick="OnToggle()"  /> </td>
					</tr>
					<tr  style="border:0;width:100%;height:5%" align=top >
					    <td colspan=2>&nbsp;</td>
					    <td align=right><b>Reports Type</b></td>
						<td colspan=3>
							<gw:list id="lstReport_type"  styles='width:100%'>	
								<data><%=Esyslib.SetListDataSQL("select a.char_1,a.code_nm from vhr_hr_code a where a.id='HR0212' and nvl(a.tco_company_pk,'" + session("COMPANY_PK") + "')='" + session("COMPANY_PK") + "' ORDER BY a.seq")%></data>
							</gw:list > 										
						</td>
						 <td style="border:0" align="right">
                            <gw:imgBtn id="ibtnPrint_R1" alt="Contract Report" img="excel" text="Print Labour" onclick="OnPrint(1)"/>
                        </td>
						<td colspan=8 align=center><gw:label id="lblRecord_R"  text="0 record(s)." maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" /></td>
					</tr>
			        
				</table>
                <table id="tblMainHist" cellspacing=0 cellpadding=0 style="height:48%" width=100% border=1>
                    <tr valign="top">
                        <td  style="width:100%;height:100%;"> 
                            <gw:grid   
	                            id="grdLBReport"  
	                            header="Select|Organization|_W-Group|Emp ID|Full Name|D.O.J|Contract No|Probation Kind|Contract Kind|Start Probation|End Probation|Start Contract|End Contract|Salary|ALLOW1|ALLOW2|ALLOW3|ALLOW4|ALLOW5|ALLOW6|ALLOW7|ALLOW8|_EMP_PK|TIMES|_PK|_Contract Type|_Probation_Type|_Nation"   
	                            format="3|0|0|0|0|4|0|0|0|0|0|0|-0|-0|-0|-0|-0|-0|-0|-0|-0|0|0|0|0|0|0|0"  
	                            aligns="1|2|2|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
	                            acceptNullDate
	                            defaults="||||||||||||||||||||||||||||"  
	                            editcol="1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
	                            widths="800|1700|1700|1200|2500|1200|2000|2500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|2000|1500|1500|1500|1500|0|0|0"  
	                            styles="width:100%; height:100%"   
	                            sorting="T"   
	                            oncellclick = "OnClick_grdLBReport()" /> 

                        </td>
                    </tr>
               </table> 
               <table id="tblHist" cellspacing=0 align = top cellpadding=0 style="width:100%;height:30%" border=1 >				
		            <tr style="width:100%;height:20%">	
		                <td width="15%" align=right><b>Reports Type</b></td>
						<td width="20%">
							<gw:list id="lstReport_type_hist"  styles='width:100%'>	
								<data><%=Esyslib.SetListDataSQL("select a.char_1,a.code_nm from vhr_hr_code a where a.id='HR0212' and nvl(a.tco_company_pk,'" + session("COMPANY_PK") + "')='" + session("COMPANY_PK") + "' ORDER BY a.seq")%></data>
							</gw:list > 										
						</td>
						<td width="5%"  style="border:0" align="right">		
			                <gw:imgBtn id="ibtnPrint_H" alt="Contract Report" img="excel" text="Print History Labour" onclick="OnPrint(3)"/>				
			            </td>
			            <td width="60%" align="right" style="border:0"><gw:label id="lblRecord_H" text="0 record(s)." maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12"></gw:label></td>													
			            			
			        </tr>
			       
	                <tr style="width:100%;height:80%">
	                    <td colspan=4 >		
		                   <gw:grid   
	                            id="grdLBHist"  
	                            header="Select|Organization|_W-Group|Emp ID|Full Name|_Job|D.O.J|Contract No|Probation Kind|Contract Kind|Start Probation|End Probation|Start Contract|End Contract|Salary|ALLOW1|ALLOW2|ALLOW3|ALLOW4|ALLOW5|ALLOW6|ALLOW7|ALLOW8|_EMP_PK|TIMES|_Contract Type"   
	                            format="3|0|0|0|0|0|0|0|0|0|0|0|0|-0|-0|-0|-0|-0|-0|-0|-0|-0|0|0|0|0"  
	                            aligns="1|2|2|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
	                            acceptNullDate
	                            defaults="||||||||||||||||||||||||||"  
	                            editcol="1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
	                            widths="800|1700|1700|1200|2500|2000|1200|2000|2500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|2000|1500|1500|1500|1500"  
	                            styles="width:100%; height:100%"   
	                            sorting="T"   
	                            oncellclick="AfterSelectHist()"/> 
		                </td>
	                </tr>	
                </table>
            </td>
        </tr>
    </table>
       
<table name="Preparation" id="Table3"  width="100%" cellpadding="0"  cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="Table1" style="height:12%" border=0 cellpadding="0" cellspacing="0">
                    <tr style="border:0;width:100%;height:5%" valign="center"  >
                        <td width="14%" colspan="2" align="right" ><a title="Click here to show Organization" onclick="OnShowPopup(3)" href="#tips" >
                            Organization </a>                
                        </td>
                        <td width="15%"  align="left" >
                         <gw:list  id="lstOrg_Code_P" value='ALL' maxlen = "100" styles='width:100%'onchange="onChange_org(3,lstOrg_Code_P);" >
                            <data>
                              <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td width="6%"  align="right" >Group</td>
                        <td width="15%" colspan=3  align="left" >
                         <gw:list  id="lstGrp_Code_P" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("SELECT pk,WorkGroup_NM FROM Thr_Work_Group WHERE DEL_IF = 0 order by WorkGroup_id")%>|ALL|Select All</data></gw:list>
                        </td>
                       <td width="7%"  align="right" >Status</td>
                       <td width="10%" align=right><font color="black"><gw:list id="lstStatus3"  value="A" styles='width:100%'>	
								<data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0022' ORDER BY A.seq")%>|ALL|Select All</data>
							</gw:list > </td>
                        <td width="8%"  colspan=1 style="border:0" align="right" valign="middle">Search by</td>
					   <td width="7%" style="border:0">
					        <gw:list  id="lstTemp_P" value="2" styles='width:100%' onchange=""> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Contract NO</data> 
					        </gw:list>
				        </td>
				        <td colspan=2 width="6%"  style="border:0"> 
					        <gw:textbox id="txtTemp_P" onenterkey   ="OnSearch(datLabourContractPre)" styles='width:100%'/>
				        </td>
						<td width="4%">
						</td>
                        <td width="3%"  align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch_P"   alt="Search"  onclick="OnSearch(datLabourContractPre)"/>
                        </td>
                        <td width="3%"  align="right" >
                         <gw:imgBtn img="save" id="ibtnSave_P"   alt="Save"  onclick="OnSave(2)"/>
                        </td>
                        <td width="3%" style="border:0" align="right">
                         <gw:imgBtn id="idBtnPrint_P" alt="Print Current Labour" img="excel" text="Print Labour" onclick="OnPrint(4)"/>	
                        </td>
                        <td width="3%" style="border:0" align="right">
                        </td>
                    </tr>
					<tr style="border:0;width:100%;height:5%" align=top cellpadding="0" cellspacing="0" >
					    <td width="2%" align="center"  style="border:0"><gw:checkbox id="chkCheckPre" value="F" onclick="OnSetGrid(chkCheckPre,grdLBPreparation,0)"></gw:checkbox ></td>		 
						<td align="right" width="12%" >Current Contract</td>
						<td  >
							<gw:list id="lstKindLB_P"  value="ALL" styles='width:100%'>	
								<data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0001' ORDER BY A.seq")%>|ALL|Select All</data>
							</gw:list > 										
						</td>
						<td  colspan=6 align=right style="color:Blue; font-size:13"><font color="black" >PERIOD OF SIGNING LABOUR CONTRACT</font></td>
						<td width="8%" align=right style="color:Blue; font-size:13"><font color="black" >From</font></td>
						<td  width="7%"><gw:datebox id="dtFromSign"  styles='width:80%' nullaccept  lang="<%=Session("Lang")%>"/>  </td>						
						<td  width="3%" align=center>To</td>
						<td  width="7%"> <gw:datebox id="dtToSign" nullaccept styles='width:80%' lang="<%=Session("Lang")%>"/>  </td>
						<td colspan=5  align=right><gw:label id="lblRecord_P"  text="0 row(s)." maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" /></td>
					</tr>
				</table>
                <table cellspacing=0 cellpadding=0 style="height:88%" width=100% border=1>
                    <tr style="border:1;width:100%;height:100%" valign="top">
                        <td  style="width:100%;height:100%;"> 
                            <gw:grid   
	                            id="grdLBPreparation"  
	                            header="Select|_PK|Group|Emp ID|Full Name|D.O.J|Contract No|_Probation Kind|Contract Kind|Start Probation|End Probation|Start Contract|End Contract|Next Contract|Salary|ALLOW1|ALLOW2|ALLOW3|ALLOW4|ALLOW5|ALLOW6|ALLOW7|ALLOW8|_EMP_PK|TIMES|_Contract Type"   
	                            format="3|0|0|0|0|4|0|0|0|0|0|0|1|2|1|1|1|1|1|1|1|1|0|0|0|0"  
	                            aligns="1|2|2|0|0|0|0|0|0|0|0|0|0|1|0|0|0|0|0|0|0|0|0|0|0|0"  
	                            acceptNullDate
	                            defaults="||||||||||||||||||||||||||"  
	                            editcol="1|0|0|0|0|0|0|0|0|0|0|0|0|1|0|0|0|0|0|0|0|0|0|0|0|0"  
	                            widths="800|1700|1700|1200|2500|1200|1600|1600|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|2000|1500|1500|1500|1500"  
	                            styles="width:100%; height:100%"   
	                            sorting="T"   
	                            /> 
                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table> 	
	<table name="Append" id="idAppendix"  width="100%" cellpadding="0"  cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr>
            <td>
                <table width="100%" id="idApp" style="height:24%" border=0 cellpadding="0" cellspacing="0">
                    <tr style="border:0;width:100%;" valign="middle"  >
                        <td width="12%"  align="right" ><a title="Click here to show" onclick="OnShowPopup(4)" href="#tips" >
                            Organization </a>                  
                        </td>
                        <td width="20%" colspan="3"  align="left" >
                         <gw:list  id="lstOrg_Code_A" value='ALL' maxlen = "100" styles='width:100%'onchange="onChange_org(4,lstOrg_Code_A);" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td width="10%"  align="right" >Group</td>
                        <td width="22%" colspan=3 align="left" >
                         <gw:list  id="lstGrp_Code_A" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("SELECT pk,WorkGroup_NM FROM Thr_work_Group WHERE DEL_IF = 0 order by WorkGroup_id")%>|ALL|Select All</data></gw:list>
                       </td>
                       
                        <td width="10%" style="border:0" align="right" valign="middle">Search by</td>
				       <td width="10%" style="border:0">
				            <gw:list  id="lstTemp_A" value="2" styles='width:100%' onchange=""> 
						            <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Contract NO</data> 
				            </gw:list>
			            </td>
			            <td  width="10%"  colspan=2 style="border:0"> 
				            <gw:textbox id="txtTemp_A" onenterkey   ="OnSearch(datAppendixContract)" styles='width:100%'/>
			            </td>
			            <td width="2%"  align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch_A"   alt="Search"  onclick="OnSearch(datAppendixContract)"/>
                        </td>
                        <td width="2%" style="border:0" align="right">
                         <gw:imgBtn img="save" id="ibtnSave_A"    alt="Save"  onclick="OnSave(3)"/>
                        </td>
                        <td width="2%"  align="right" >
                         <gw:imgBtn img="delete" id="ibtnDelete_A"   alt="Delete"  onclick="OnDelete_A()"/>
                        </td>
                        <td width="2%"  style="border:0" align="right">		
			                
			            </td>
						 						
                        
                    </tr>
					
					<tr style="border:0;width:100%;" valign="middle"  >
                        <td width="12%"  align="right" >
                            <table width="100%" style="height:100%">
					            <tr>
					                
						            <td align="right" ><font color="black">Contract Type</font></td>
					            </tr>
					        </table>                 
                        </td>
                        <td width="20%"  colspan="3" align="left" >
                         <gw:list id="lstKindLB_A"  value="ALL" styles='width:100%'>	
								<data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0001' ORDER BY A.seq")%>|ALL|Select All</data>
							</gw:list >
                        </td>
                        <td width="10%"  align="right" >Begin Prob</td>
                        <td align="left" width="8%" >
						<gw:datebox id="idBeginProb_A_1" nullaccept styles='width:80%' lang="<%=Session("Lang")%>"/>
                        </td>
						<td align="center" width="6%"  >~</td>
                       <td align="left" width="8%"  >
						<gw:datebox id="idBeginProb_A_2" nullaccept styles='width:80%' lang="<%=Session("Lang")%>"/>
                        </td>
                        <td width="10%" style="border:0" align="right" valign="middle">End Prob</td>
				       <td width="10%" style="border:0">
				       <gw:datebox id="idEndProb_A_1" nullaccept styles='width:80%' lang="<%=Session("Lang")%>"/>     
			            </td>
			            <td  width="1%"  colspan=1 style="border:0" align="center">~</td>
						<td width="9%" >
						<gw:datebox id="idEndProb_A_2" nullaccept styles='width:80%' lang="<%=Session("Lang")%>"/>
						</td>
			            <td width="6%" colspan="3" align="right" >
                         <gw:label id="lblRecord_A"  text="0 row(s)." maxlen = "100" styles="color:red;width:100%;font-weight: bold;font-size:12" />
                        </td>
                        
                        <td width="2%"  style="border:0" align="right">	
							<img status="expand" id="imgArrow_A" src="../../../system/images/iconmaximize.gif" alt="Show Appendix"  style="cursor:hand" onclick="OnToggle_A()"  />						
			            </td>							                       
                    </tr>									
                    <tr style="border:0;width:100%;" valign="middle"  >
						<td width="12%" align="right" >Status</td>
						<td width="8%" align="left">
							<gw:list id="lstStatus_A"  value="A" styles='width:100%'>	
							<data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0022' ORDER BY A.seq")%>|ALL|Select All</data>
							</gw:list > 
						</td>
						<td width="5%" align="right">Exists</td>
						<td width="7%">
							<gw:list  id="lstHaveAppendix_A" value="ALL" styles='width:100%' onchange=""> 
							<data>LIST|Y|Yes|N|No|ALL|Select All</data> 
							</gw:list>
						</td>
                                               	
						<td width="10%"  align="right" >Begin Contract</td>
                        <td width="8%" align=right><font color="black">
						<gw:datebox id="idBeginContract_A_1" nullaccept styles='width:80%' lang="<%=Session("Lang")%>"/>	
						</td>
						<td width="6%" style="border:0" align="center">~</td>
				        <td width="8%" style="border:0">
				            <gw:datebox id="idBeginContract_A_2" nullaccept styles='width:80%' lang="<%=Session("Lang")%>"/>
			            </td>
						
					   <td width="10%" style="border:0" align="right" valign="middle">End Contract</td>
				       <td width="10%" style="border:0">
				       <gw:datebox id="idEndContract_A_1" nullaccept styles='width:80%' lang="<%=Session("Lang")%>"/>     
			            </td>
			            <td  width="1%"  colspan=1 style="border:0" align="center">~</td>
						<td width="9%" >
						<gw:datebox id="idEndContract_A_2" nullaccept styles='width:80%' lang="<%=Session("Lang")%>"/>
						</td>											
                    </tr>
					<tr style="border:0;width:100%;" valign="middle"  >
						
						<td  colspan="2" align="right" >Select All <gw:checkbox id="chkCheckReport_A" value="F" onclick="OnSetGrid(chkCheckReport_A,grdAppendix,0)" ></gw:checkbox >
						    Create new<gw:checkbox id="chkAppendix" value="F" onclick="OnSetGrid(chkAppendix,grdAppendix,8)" ></gw:checkbox ></td>
						<td colspan="2"  align="right">Get Sal <gw:checkbox id="chkGetSalary_A" value="F" onclick="OnSetGrid(chkGetSalary_A,grdAppendix,10)" ></gw:checkbox ></td>																								
						<td width="10%"  align="right" >Get Contract dt</td>
                        <td width="8%" align="left"><gw:checkbox id="chkGetContactDate" value="F" onclick="OnGetContractDate()" ></gw:checkbox >												
						</td>
						<td width="6%" style="border:0" align="right">
						Set dt
						</td>
						<td width="8%" style="border:0">
				            <gw:datebox id="idSetDate" nullaccept styles='width:80%' lang="<%=Session("Lang")%>"/> 
			            </td>
						
					   <td width="10%" style="border:0" align="left" valign="middle">
					        <gw:imgBtn img="set" id="ibtnSetDate"   alt="Set Date"  onclick="OnSetDate()"/></td>
				       <td >
							<gw:list id="lstAppendixReportType" styles='width:100%'>	
							<data><%=ESysLib.SetListDataSQL("select char_2, code_nm from vhr_hr_code a where a.id='HR0156' and char_4=4 and char_1='chae00040'")%></data>
							</gw:list > 
						</td>	
                        <td align="left">		
			                <gw:imgBtn id="ibtnPrint_A" alt="Print Appendix Contract" img="excel" text="Print Appendix Contract" onclick="OnPrint(5)"/>				
			            </td>																											
					</tr>
                </table>
                <table id="idAppendix_Main" cellspacing=0 cellpadding=0 style="height:40%" width=100% border=1>
                    <tr style="border:1;width:100%;height:100%" valign="top">
                        <td  style="width:100%;height:100%;">
                           <gw:grid   
	                            id="grdAppendix"  
	                            header="Select|_Department|Group|Emp ID|Full Name|Contract No|Contract Kind|Appendix No|Create New|Singature Date|Get Sal|Get Contract Dt|Salary|ALLOW1|ALLOW2|ALLOW3|ALLOW4|ALLOW5|ALLOW6|ALLOW7|ALLOW8|_EMP_PK|TIMES|_CONTRACT_PK|_APPENDIX_PK"   
	                            format="3|0|0|0|0|0|0|0|3|4|3|3|1|1|1|1|1|1|1|1|1|1|1|1|1"  
	                            aligns="1|0|0|0|0|0|0|0|1|0|1|1|0|0|0|0|0|0|0|0|0|0|0|0|0"  
	                            acceptNullDate
	                            defaults="|||||||||||||||||||||||||"  
	                            editcol="1|0|0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|0|0|0|0"  
	                            widths="800|1700|1700|1700|2500|2000|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|2000|1500|1500|1500|1500|1500"  
	                            styles="width:100%; height:100%"   
	                            sorting="T"   
	                            oncellclick = "OnHistAppendixContract()" 
	                            /> 
		                </td>                        
                    </tr>    
                </table>
                <table id="idAppendix_His" cellspacing=0 cellpadding=0 style="height:36%" width=100% border=1>
                    <tr style="width:80%;height:20%">		
			            <td width="75%" align="right" style="border:0"><gw:label id="lblRecord_His_A" text="0 row(s)." maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12"></gw:label></td>													
			            <td width="5%"  style="border:0" align="right">		
			                <gw:imgBtn id="ibtnPrint_A_H" alt="Print Appendix History" img="excel" text="Print Appendix History" onclick="OnPrint(6)"/>				
			            </td>			
			        </tr>
                    <tr style="border:1;width:100%;height:80%" valign="top">
                        <td  colspan="5" style="width:100%;height:100%;">
                           <gw:grid   
	                            id="grdAppendix_His"  
	                            header="Select|Department|Group|Emp ID|Full Name|Appendix No|Contract No|Contract Kind|Singature Date|Salary|ALLOW1|ALLOW2|ALLOW3|ALLOW4|ALLOW5|ALLOW6|ALLOW7|ALLOW8|_EMP_PK|TIMES|_APPENDIX_PK"   
	                            format="3|0|0|0|0|0|0|0|4|1|1|1|1|1|1|1|1|1|1|1|1"  
	                            aligns="1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
	                            acceptNullDate
	                            defaults="|||||||||||||||||||||"  
	                            editcol="1|0|0|0|0|0|0|0|1|0|1|0|0|0|0|0|0|0|0|0|0"  
	                            widths="800|1700|1700|1700|2500|2500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|2000|1500|1500|1500|1500"  
	                            styles="width:100%; height:100%"   
	                            sorting="T"   
	                            /> 
		               </td>
                    </tr>    
                </table>
            </td>
        </tr>
    </table>

    <table name="History" id="tblHisInfo"  width="100%" cellpadding="0"  cellspacing="0" border=1 style="height:98%;">
        <tr style="width:100%;height:100%">
            <td>
               <table width="100%" id="Table5" style="height:17%" border=0 cellpadding="0" cellspacing="0">
                    <tr style="border:0;width:100%" valign="center" cellpadding="0" cellspacing="0">
                        <td width="14%"  align="right" ><a title="Click here to show Organization" onclick="OnShowPopup(5)" href="#tips" >
                            Organization </a>                  
                        </td>
                        <td width="15%"  align="left" >
                         <gw:list  id="lstOrg_Code_His" value='ALL' maxlen = "100" styles='width:100%' onchange="onChange_org(5,lstOrg_Code_His);" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td width="10%"  align="right" >W-Group</td>
                        <td width="18%"  colspan=3 align="left" >
                         <gw:list  id="lstGrp_Code_His" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("SELECT pk,WorkGroup_NM FROM Thr_Work_Group WHERE DEL_IF = 0 order by workGroup_id")%>|ALL|Select All</data></gw:list>
                        </td>
                       
                        <td width="8%" style="border:0" align="right" valign="middle">Search by</td>
					   <td width="10%" style="border:0">
					        <gw:list  id="lstTemp_His" value="2" styles='width:100%' onchange=""> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Contract NO</data> 
					        </gw:list>
				        </td>
				        <td width="12%" style="border:0"> 
					        <gw:textbox id="txtTemp_His" onenterkey   ="OnSearch(datLabourContractHis2)" styles='width:100%'/>
				        </td>
                        <td width="5%"  align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch_His"   alt="Search"  onclick="OnSearch(datLabourContractHis2)"/>
                        </td>
                        
                        
                         <td width="5%" style="border:0" align="center">
                         <gw:imgBtn id="ibtnPrint_His" alt="Print  " img="excel" text="Print Labour" onclick="OnPrintHis(10)"/>
                        </td>
                    </tr>
					<tr  style="border:0;width:100%" cellpadding="0" cellspacing="0" align=top>
                        <td>
					        <table width="100%" style="height:100%" cellpadding="0" cellspacing="0">
					            <tr>
					                <td  align="center"><gw:checkbox id="chkCheckReportHis" value="F" onclick="OnSetGrid(chkCheckReportHis,grdLBHisReport,0)" ></gw:checkbox ></td>						            
                                    <td align="right" ><font color="black">Contract Type</td>
					            </tr>
					        </table>
					    </td>
                        
						
						<td>
							<gw:list id="lstKindLB_His"  value="ALL" styles='width:100%'>	
								<data><%= ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0001' ORDER BY A.seq")%>|ALL|Select All</data>
							</gw:list > 										
						</td>
						<td  align=right><font color="black">Begin Contract</td>
			            <td width="10%"> <gw:datebox id="dtFromBContract_His" nullaccept styles='width:80%'   lang="<%=Session("Lang")%>"/></td>
			            <td colspan=1 width="1%" align=center>~</td>
			            <td width="10%"> <gw:datebox id="dtToBContract_His" nullaccept styles='width:80%' lang="<%=Session("Lang")%>"/></td>
						
		                <td  align=right><font color="black">Status</td>
			            <td  align=right><font color="black"><gw:list id="lstStatusHis"  value="A" styles='width:100%'>	
								<data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0022' ORDER BY A.seq")%>|ALL|Select All</data>
							</gw:list > </td>
                        <td colspan=3 align="right" style="border:0"><gw:label id="lblRecord_His" text="0 record(s)." maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12"></gw:label></td>
					</tr>
					<%--<tr  style="border:0;width:100%;height:5%" align=top >
					    <td>
					        <table width="100%" style="height:100%">
					            <tr>
					                <td  align="center"><gw:checkbox id="chkCheckReportHis" value="F" onclick="OnSetGrid(chkCheckReportHis,grdLBHisReport,0)" ></gw:checkbox ></td>						            
                                    <td align="right" ><font color="black">Contract Type</td>
					            </tr>
					        </table>
					    </td>
						
					</tr>--%>
			        
				</table>
                <table id="Table6" cellspacing=0 cellpadding=0 style="height:83%" width=100% border=1>
                    <tr valign="top">
                        <td  style="width:100%;height:100%;"> 
                            <gw:grid   
	                            id="grdLBHisReport"  
	                            header="Select|Organization|_W-Group|Emp ID|Full Name|D.O.J|Contract No|Probation Kind|Contract Kind|Start Probation|End Probation|Start Contract|End Contract|Salary|ALLOW1|ALLOW2|ALLOW3|ALLOW4|ALLOW5|ALLOW6|ALLOW7|ALLOW8|_EMP_PK|TIMES|_PK|_Contract Type|_Probation_Type|_Nation"   
	                            format="3|0|0|0|0|4|0|0|0|0|0|0|-0|-0|-0|-0|-0|-0|-0|-0|-0|0|0|0|0|0|0|0"  
	                            aligns="1|2|2|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
	                            acceptNullDate
	                            defaults="||||||||||||||||||||||||||||"  
	                            editcol="1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
	                            widths="800|1700|1700|1200|2500|1200|2000|2500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|2000|1500|1500|1500|1500|0|0|0"  
	                            styles="width:100%; height:100%"   
	                            sorting="T"   
	                            oncellclick = "" /> 

                        </td>
                    </tr>
               </table> 
              
            </td>
        </tr>
    </table>


    

</gw:tab>
 
</body>
 
  
<gw:textbox id="txtDept" styles="display:none"/>	
<gw:textbox id="txtDeptData" styles="display:none"/>
<gw:textbox id="txtUpperDept" styles="display:none"/>
<gw:textbox id="txtGroupData" styles="display:none"/>
<gw:textbox id="lblA1" text="" styles="display:none"/> 
<gw:textbox id="lblA2" text="" styles="display:none"/> 
<gw:textbox id="lblA3" text="" styles="display:none"/> 
<gw:textbox id="lblA4" text="" styles="display:none"/> 
<gw:textbox id="lblA5" text="" styles="display:none"/> 
<gw:textbox id="lblA6" text="" styles="display:none"/> 
<gw:textbox id="lblA7" text="" styles="display:none"/> 
<gw:textbox id="lblA8" text="" styles="display:none"/> 
<gw:textbox id="lblDisplay1" text="" styles="display:none"/> 
<gw:textbox id="lblDisplay2" text="" styles="display:none"/> 
<gw:textbox id="lblDisplay3" text="" styles="display:none"/> 
<gw:textbox id="lblDisplay4" text="" styles="display:none"/> 
<gw:textbox id="lblDisplay5" text="" styles="display:none"/> 
<gw:textbox id="lblDisplay6" text="" styles="display:none"/> 
<gw:textbox id="lblDisplay7" text="" styles="display:none"/> 
<gw:textbox id="lblDisplay8" text="" styles="display:none"/> 
<gw:textbox id="txtAllowance" text="HR0019" styles="display:none"/>
<gw:textbox id="txtEmp_PK" text="" styles="display:none"/> 
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>  
<gw:textbox id="txtReport_tmp" styles="display:none"/>
<gw:textbox id="txtContract_Type" styles="display:none"/>
<gw:textbox id="txtEmp_PK_A" text="" styles="display:none"/> 
<gw:textbox id="txtContract_Type_A" styles="display:none"/>
<gw:textbox id="txtAppendix_Times_A" styles="display:none"/>
<gw:textbox id="txtActive_tab" styles="display:none"/>
<gw:textbox id="txtUpperOrg" styles="display:none"/>
<gw:textbox id="txtOrgData" styles="display:none"/>
<gw:textbox id="txtProbation_Type" styles="display:none"/>

<gw:textbox id="txtOrg_tmp" text="" styles="display:none"  />
<gw:textbox id="txtwg_tmp" styles="display:none"/> 
<gw:textbox id="txtForeignerYN" styles="display:none"/> 
<gw:textbox id="txtCompany_pk" styles="display:none"/> 

<gw:textbox id="menu_id" text="" styles="display:none"  />
 <gw:textbox id="txtFlag_View" text="" styles="display:none"  />
</html>
