﻿<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>genuwin</title>
  </head>
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>

<script>

 <%=ESysLib.RenderControlHTML("dso_60080330_bank","col_index") %> 
 <%=ESysLib.RenderControlHTML("dso_60080330_emp","col_index") %> 
 <%=ESysLib.RenderControlHTML("dso_60080330_cust","col_index") %> 
 <%=ESysLib.RenderControlHTML("dso_60080330_account","col_index") %>
 <%=ESysLib.RenderControlHTML("dso_60080330_PL","col_index") %>

var g_flag_save = false;

function BodyInit()
{
    System.Translate(document);
    var ls_company  = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0 and active_yn='Y' order by PARTNER_NAME ")%>";
    var ls_possum   = "DATA|Y|Posting|N|Summary||";
	lstCompany.SetDataText(ls_company);
    lstPostSum.SetDataText(ls_possum);
       
   <%=ESysLib.RenderControlHTML("dso_60080330_bank","grid_list") %> 
   <%=ESysLib.RenderControlHTML("dso_60080330_emp","grid_list") %> 
   <%=ESysLib.RenderControlHTML("dso_60080330_cust","grid_list") %> 
   <%=ESysLib.RenderControlHTML("dso_60080330_account","grid_list") %> 
   <%=ESysLib.RenderControlHTML("dso_60080330_PL","grid_list") %> 
    grid_acc.GetGridControl().FrozenCols    = 4;
    grid_cust.GetGridControl().FrozenCols   = 4;
    grid_emp.GetGridControl().FrozenCols    = 4;
    txtlb_nm.SetEnable(false);
    txtac_nm.SetEnable(false);
 
    txtProposedByUserPk.text="<%=Session("USER_PK")%>";
	dso_getCompany.Call();
	//onSearch();
}

function CheckNumeric()
{
   var key = window.event.keyCode;
   if (key > 47 && key < 58)
      return; // if so, do nothing
   else
      window.event.returnValue = null; // otherwise
}

function onNew()
{
    if(lstPostSum.GetData() != 'Y'){
		alert("You only can add data with posting account.");
		return;
	}
	
    if (idTab_Child.GetCurrentPageNo() == 0)
    {
        onNewAcc();
    }
    else if (idTab_Child.GetCurrentPageNo() == 1)
    {
        onNewCust();
    }
    else if (idTab_Child.GetCurrentPageNo() == 2)
    {
        onNewEmp();
    }
    else if (idTab_Child.GetCurrentPageNo() == 3)
    {
        onNewBank();
    }
	 else if (idTab_Child.GetCurrentPageNo() == 4)
    {
	   
			grd_pl.AddRow();
			grd_pl.SetGridText(grd_pl.rows-1, grd_pl_AC_Code, txtac_cd.text);
			grd_pl.SetGridText(grd_pl.rows-1, grd_pl_AC_Name, txtac_nm.text);
			

			grd_pl.SetGridText(grd_pl.rows-1, grd_pl_PL_CD, txtpl_cd.text);
			grd_pl.SetGridText(grd_pl.rows-1, grd_pl_PL_NM, l_pl_nm);
			grd_pl.SetGridText(grd_pl.rows-1, grd_pl_PLC_CD, txt_PLC_CD.text);
			grd_pl.SetGridText(grd_pl.rows-1, grd_pl_PLC_NM, l_plc_nm);  
			grd_pl.SetGridText(grd_pl.rows-1, grd_pl_Ccy, 'VND'); 
		 
		
    }
}

function onNewAcc()
{
    grid_acc.AddRow();
	grid_acc.SetGridText(grid_acc.rows-1, grid_acc_acc_code, txtac_cd.text);//set account code 
	grid_acc.SetGridText(grid_acc.rows-1, grid_acc_acc_name, txtac_nm.text);//set account name
	grid_acc.SetGridText(grid_acc.rows-1, grid_acc_pk, txtac_nm.text);//set account name
}

function onNewCust()
{
    grid_cust.AddRow();

}

function onNewEmp()
{
    grid_emp.AddRow();

}

function onNewBank()
{
    grid_bank.AddRow();

}

function onNewPL()
{
    grd_pl.AddRow();

}

function onSearch()
{
    if (txtac_cd.GetData() == '')
    {
        txtac_nm.SetDataText("");
    }
    if (idTab_Child.GetCurrentPageNo() == 0)
    {
		 idpl_cd.style.display = 'none';
		 idpl_nm.style.display = 'none';
		 idbt_pl.style.display = 'none';
		 idpl_cd.style.display = 'none';
		 idpl_nm.style.display = 'none';
		 
		  idcus_cd.style.display = '';
		idcus_nm.style.display = '';
		idbt_cus.style.display = '';
		
		 lblText.text = 'Customer';
		 dso_60080330_account.Call('SELECT');
    }
    else if (idTab_Child.GetCurrentPageNo() == 1)
    {
		idpl_cd.style.display = 'none';
		 idpl_nm.style.display = 'none';
		 idpl_cd.style.display = 'none';
		 idpl_nm.style.display = 'none';
		 idbt_pl.style.display = 'none';
		 
		  idcus_cd.style.display = '';
		idcus_nm.style.display = '';
		idbt_cus.style.display = '';
		 
		 lblText.text = 'Customer';
        dso_60080330_cust.Call('SELECT');
    }
    else if (idTab_Child.GetCurrentPageNo() == 2)
    {
		idpl_cd.style.display = 'none';
		 idpl_nm.style.display = 'none';
		
		 lblText.text = 'Customer';
		 idpl_cd.style.display = 'none';
		 idpl_nm.style.display = 'none';
		 idbt_pl.style.display = 'none';
		 
		  idcus_cd.style.display = '';
		idcus_nm.style.display = '';
		idbt_cus.style.display = '';
		
        dso_60080330_emp.Call('SELECT');
    }
    else if (idTab_Child.GetCurrentPageNo() == 3)
    {
		idpl_cd.style.display = 'none';
		 idpl_nm.style.display = 'none';
		 
		 idpl_cd.style.display = 'none';
		 idpl_nm.style.display = 'none';
		 idbt_pl.style.display = 'none';
		 lblText.text = 'Customer';
		 
		 idcus_cd.style.display = '';
		idcus_nm.style.display = '';
		idbt_cus.style.display = '';
		
        dso_60080330_bank.Call('SELECT');
    }
	else if (idTab_Child.GetCurrentPageNo() == 4)
    {
        lblText.text = 'PL';
		idcus_cd.style.display = 'none';
		idcus_nm.style.display = 'none';
		idbt_cus.style.display = 'none';
		
		idpl_cd.style.display = '';
		 idpl_nm.style.display = '';
		 idbt_pl.style.display = '';
		 
		  dso_60080330_PL.Call('SELECT');
    }
}

function onSave()
{
    if(lstPostSum.GetData() != 'Y'){
		alert("You only can change data with posting account.");
		return;
	}
    g_flag_save = true;
	
    if (idTab_Child.GetCurrentPageNo() == 0)
    {
        onSaveAcc();
    }
    else if (idTab_Child.GetCurrentPageNo() == 1)
    {
        onSaveCust();
    }
    else if (idTab_Child.GetCurrentPageNo() == 2)
    {
        onSaveEmp();
    }
    else if (idTab_Child.GetCurrentPageNo() == 3)
    {
        onSaveBank();
    }
	else if (idTab_Child.GetCurrentPageNo() == 4)
    {
        onSavePL();
    }
	else{
	   alert("Not yet support control item.");
	   g_flag_save = false;
	}
}

function onSaveAcc()
{
	if (onCheckAcc())
	{
	    for (i = 1; i < grid_acc.rows; i++)
        { 
		  if(grid_acc.GetGridData(i,grid_acc_tco_company_pk) == ""){
            grid_acc.SetGridText(i, grid_acc_tco_company_pk, lstCompany.GetData());
            grid_acc.SetGridText(i, grid_acc_month, dtMonth.GetData());
		  }
        }
        dso_60080330_account.Call();
	}
}

function onSaveCust()
{
	if (onCheckCust())
	{
	    for (i = 1; i < grid_cust.rows; i++)
        {
           
          if(grid_cust.GetGridData(i,grid_cust_tco_company_pk) == ""){
            grid_cust.SetGridText(i, grid_cust_tco_company_pk, lstCompany.GetData());
            grid_cust.SetGridText(i, grid_cust_month, dtMonth.GetData());
		  }
        }
        dso_60080330_cust.Call();
	}
}

function onSaveEmp()
{
	if (onCheckEmp())
	{
	    for (i = 1; i < grid_emp.rows; i++)
        {
          if(grid_emp.GetGridData(i,grid_emp_tco_company_pk) == ""){
            grid_emp.SetGridText(i, grid_emp_tco_company_pk, lstCompany.GetData());
            grid_emp.SetGridText(i, grid_emp_month, dtMonth.GetData());
		  }
        }
        dso_60080330_emp.Call();
	}
}

function onSaveBank()
{
	
	if (onCheckBank())
	{
	    for (i = 1; i < grid_bank.rows; i++)
        {
           if(grid_bank.GetGridData(i, grid_bank_tco_company_pk) == ""){
            grid_bank.SetGridText(i, grid_bank_tco_company_pk, lstCompany.GetData());
            grid_bank.SetGridText(i, grid_bank_month, dtMonth.GetData());
		  }
        }
	
        dso_60080330_bank.Call();
	}
}
function onSavePL()
{
	if (onCheckPL())
	{
	    for (i = 1; i < grd_pl.rows; i++) 
        {
          if(grd_pl.GetGridData(i,grd_pl_tco_company_pk) == ""){
            grd_pl.SetGridText(i, grd_pl_tco_company_pk, lstCompany.GetData());
            grd_pl.SetGridText(i, grd_pl_month, dtMonth.GetData());
		  }
        }
		
        dso_60080330_PL.Call();
	}
}

function onDelete()
{
   if(lstPostSum.GetData() != 'Y'){
		alert("You only can delete data with posting account.");
		return;
	}
    if (idTab_Child.GetCurrentPageNo() == 0)
    {
        grid_acc.DeleteRow();
    }
    else if (idTab_Child.GetCurrentPageNo() == 1)
    {
        grid_cust.DeleteRow();
    }
    else if (idTab_Child.GetCurrentPageNo() == 2)
    {
        grid_emp.DeleteRow();
    }
    else if (idTab_Child.GetCurrentPageNo() == 3)
    {
        grid_bank.DeleteRow();
    }
	 else if (idTab_Child.GetCurrentPageNo() == 4)
    {		
        grd_pl.DeleteRow();
		dso_60080330_PL.Call();
    }
    flag_d = true;
}

function onCheckAcc()
{
    for ( var i = 1; i < grid_acc.rows - 1; i++)
    {
        for ( var j = i + 1; j < grid_acc.rows; j++)
        {
            if (grid_acc.GetGridData(i, 1) == grid_acc.GetGridData(j, 1))
            {
                alert('Duplicate Account Code in row: '+ j + '. Please check again' +'\n'+'');
                return false;
            }
        }
    }
    return true;
}

function onCheckCust()
{
    for ( var i = 1; i < grid_cust.rows - 1; i++)
    {
        for ( var j = i + 1; j < grid_cust.rows; j++)
        {
            if ( (grid_cust.GetGridData(i,  grid_cust_acc_code) == grid_cust.GetGridData(j,  grid_cust_acc_code) ) 
			&& (grid_cust.GetGridData(i,  grid_cust_cust_code) == grid_cust.GetGridData(j, grid_cust_cust_code))
			&& (grid_cust.GetGridData(i,  grid_cust_ccy) == grid_cust.GetGridData(j, grid_cust_ccy)))
            {
                alert('Duplicate Custommer Code in row: '+ j + '. Please check again' +'\n'+'');
                return false;
            }
        }
    }
    return true;
}

function onCheckEmp()
{
    for ( var i = 1; i < grid_emp.rows - 1; i++)
    {
        for ( var j = i + 1; j < grid_emp.rows; j++)
        {
            if ( (grid_emp.GetGridData(i,  grid_emp_emp_id) == grid_emp.GetGridData(j,  grid_emp_emp_id) ) 
			&& (grid_emp.GetGridData(i,  grid_emp_acc_code) == grid_emp.GetGridData(j, grid_emp_acc_code))
			&& (grid_emp.GetGridData(i,  grid_emp_Ccy) == grid_emp.GetGridData(j, grid_emp_Ccy)))
            {
                alert('Duplicate emp id in row: '+ j + '. Please check again' +'\n'+'');
                return false;
            }
        }
    }
    return true;
}

function onCheckBank()
{
   for (var i = 1; i < grid_bank.rows - 1; i++)
    {
        for ( var j = i + 1; j < grid_bank.rows; j++)
        {
			if ( (grid_bank.GetGridData(i,  grid_bank_bank_id) == grid_bank.GetGridData(j,  grid_bank_bank_id) ) 
			&& (grid_bank.GetGridData(i,  grid_bank_acc_code) == grid_bank.GetGridData(j, grid_bank_acc_code)))
            {
                alert('Duplicate bank id in row: '+ j + '. Please check again' +'\n'+'');
                return false;
            }
        }
    }
    return true;
}
function onCheckPL()
{
   for (var i = 1; i < grd_pl.rows - 1; i++)
    {
        for ( var j = i + 1; j < grd_pl.rows; j++)
        {
			if ( (grd_pl.GetGridData(i,  grd_pl_PL_CD) == grd_pl.GetGridData(j,  grd_pl_PL_CD) ) 
			&& (grd_pl.GetGridData(i,  grd_pl_PLC_CD) == grd_pl.GetGridData(j, grd_pl_PLC_CD))
			&& (grd_pl.GetGridData(i,  grd_pl_Ccy) == grd_pl.GetGridData(j, grd_pl_Ccy)))
            {
                alert('Duplicate bank id in row: '+ j + '. Please check again' +'\n'+'');
                return false;
            }
        }
    }
    return true;
}
function OnDataReceive(p_oData)
{
    switch(p_oData.id)
    {
	     case "dso_60080330_account":
                if (lstPostSum.GetData() == 'Y' && g_flag_save == true){
				    g_flag_save = false;
					txtType.text=0;
                    dso_pro_60080330_upper_acc.Call();
                }
        break;
        
        case "dso_60080330_cust":
				if (lstPostSum.GetData() == 'Y' && g_flag_save == true){
				    g_flag_save = false;
					txtType.text=1;
                    dso_pro_60080330_upper_acc.Call();
                }
        break;
        
        case "dso_60080330_emp":
           if (lstPostSum.GetData() == 'Y' && g_flag_save == true){
				    g_flag_save = false;
					txtType.text=2;
                    dso_pro_60080330_upper_acc.Call();
                }
        break;
        
        case "dso_60080330_bank":
           if (lstPostSum.GetData() == 'Y' && g_flag_save == true){
				    g_flag_save = false;
					txtType.text=3;
                    dso_pro_60080330_upper_acc.Call();
                }
        break;
		case "dso_60080330_PL":
           if (lstPostSum.GetData() == 'Y' && g_flag_save == true){
				    g_flag_save = false;
					txtType.text=4;
                    dso_pro_60080330_upper_acc.Call();
                }
        break;
       
	    case "dso_pro_60080330_upper_acc":
		     alert("Update upper account was sucessfull.");
		break;	 
    }
}

function Reset_Acc()
{
	txtac_cd.SetDataText('');
	txtac_nm.SetDataText('');
	
}
function OnResetCust(){
	txtlb_cd.SetDataText("");
    txtlb_nm.SetDataText("");
}
function Popup_Acc()
{
    var fpath = System.RootURL + "/form/60/03/60030010_popup_ifrs.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + 'Y' + "&val2=" + 'Y' + "&val3=" + lstCompany.GetData() + "&dsqlid=ac_sel_60030010_popup";
    o = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes');	
    if (o != null)
	{
		if(o[0] != 0)
		{
		    txtac_cd.SetDataText(o[0]);
			txtac_nm.SetDataText(o[1]);
			
		}
    }
}
var l_pl_nm="",l_plc_nm="";
function Popup()
	{
	    if (idTab_Child.GetCurrentPageNo() == 4)   //PL
		{
			var fpath = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code=" + "" + "&comm_nm=" + '' + "&company=" + lstCompany.GetData() + '&dsqlid=AC_SEL_PL_POPUP&col_code=' + "PL CODE" + '&col_nm=' + "PL NAME";
			var object = System.OpenModal(fpath, 600, 500, 'resizable:yes;status:yes');
			{
			if (object != null) 
				{
				if (object[0] != 0) 
					{
						txtpl_cd.SetDataText(object[0]);
						txt_PLC_CD.SetDataText(object[3]);
						l_pl_nm=object[1];
						l_plc_nm=object[4];
					} 
				}
			}
		}
	//idGridItem.SetGridText(ctrl.row, 11, "TAC_ABPLCENTER"); 
	
    var path;
    var object;
    if (idTab_Child.GetCurrentPageNo() == 1)   //Customer
    {
        path    = System.RootURL + '/form/gf/co/ffbp00031.aspx?com_pk='+lstCompany.GetData();
	    object  = System.OpenModal( path ,850 , 550 , 'resizable:yes;status:yes');
	    if (object != null)
	    {
	        if (object[0] != 0)
            {
                txtlb_cd.SetDataText(object[1]);
                txtlb_nm.SetDataText(object[2]);
                
	        }
        }
    }
    else if (idTab_Child.GetCurrentPageNo() == 2) //Emp
    {
        path    = System.RootURL + "/form/gf/co/ffco002003.aspx";
        object  = System.OpenModal( path , 1000 , 600 , 'resizable:yes;status:yes'); 
        if (object != null)
	    {
	        if (object[0] != 0)
            {
                txtlb_cd.SetDataText(object[1]);
                txtlb_nm.SetDataText(object[2]);
                
	        }
        }
    }	    
    else if (idTab_Child.GetCurrentPageNo() == 3) // Bank
    {
        path    = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + "" + "&val1=" + "" + "&company="+ lstCompany.GetData() + '&dsqlid=sp_sel_60080330_bank_popup&col_code=' + 'Bank Code'  + '&col_nm=' + 'Bank Name';
        object  = System.OpenModal( path , 600 , 500 , 'resizable:yes;status:yes'); 
        if (object != null)
	    {
	        if (object[0] != 0)
            {
                txtlb_cd.SetDataText(object[1]);
                txtlb_nm.SetDataText(object[0]);
                
	        }
        }
    }
}
function ongrid_afteredit(obj){
	if(obj.id == "grid_acc"){
	    
		if(grid_acc.GetGridData(event.row, grid_acc_ccy) != "VND") {
		 return;
		}
		
		if(event.col == grid_acc_trans_amt_dr){
			grid_acc.SetGridText(event.row, grid_acc_books_amt_dr, grid_acc.GetGridData(event.row, grid_acc_trans_amt_dr));
		}
		else if(event.col == grid_acc_trans_amt_cr){
			grid_acc.SetGridText(event.row, grid_acc_books_amt_cr, grid_acc.GetGridData(event.row, grid_acc_trans_amt_cr));
		}
		else if(event.col == grid_acc_books_amt_dr){
			grid_acc.SetGridText(event.row, grid_acc_trans_amt_dr, grid_acc.GetGridData(event.row, grid_acc_books_amt_dr));
		}
		else if(event.col == grid_acc_books_amt_cr){
			grid_acc.SetGridText(event.row, grid_acc_trans_amt_cr, grid_acc.GetGridData(event.row, grid_acc_books_amt_cr));
		}
	}
	else if(obj.id == "grid_bank"){
	    
		if(grid_bank.GetGridData(event.row, grid_bank_Ccy) != "VND") {
		 return;
		}
		
		if(event.col == grid_bank_Trans_Amount_dr){
			grid_bank.SetGridText(event.row, grid_bank_Books_Amount_dr, grid_bank.GetGridData(event.row, grid_bank_Trans_Amount_dr));
		}
		else if(event.col == grid_bank_Trans_Amount_cr){
			grid_bank.SetGridText(event.row, grid_bank_Books_Amount_cr, grid_bank.GetGridData(event.row, grid_bank_Trans_Amount_cr));
		}
		else if(event.col == grid_bank_Books_Amount_dr){
			grid_bank.SetGridText(event.row, grid_bank_Trans_Amount_dr, grid_bank.GetGridData(event.row, grid_bank_Books_Amount_dr));
		}
		else if(event.col == grid_bank_Books_Amount_cr){
			grid_bank.SetGridText(event.row, grid_bank_Trans_Amount_cr, grid_bank.GetGridData(event.row, grid_bank_Books_Amount_cr));
		}
	}
	else if(obj.id == "grid_cust"){
	    
		if(grid_cust.GetGridData(event.row, grid_cust_ccy) != "VND") {
		 return;
		}
		
		if(event.col == grid_cust_Trans_Amount_dr){
			grid_cust.SetGridText(event.row, grid_cust_Books_Amount_dr, grid_cust.GetGridData(event.row, grid_cust_Trans_Amount_dr));
		}
		else if(event.col == grid_cust_Trans_Amount_cr){
			grid_cust.SetGridText(event.row, grid_cust_Books_Amount_cr, grid_cust.GetGridData(event.row, grid_cust_Trans_Amount_cr));
		}
		else if(event.col == grid_cust_Books_Amount_dr){
			grid_cust.SetGridText(event.row, grid_cust_Trans_Amount_dr, grid_cust.GetGridData(event.row, grid_cust_Books_Amount_dr));
		}
		else if(event.col == grid_cust_Books_Amount_cr){
			grid_cust.SetGridText(event.row, grid_cust_Trans_Amount_cr, grid_cust.GetGridData(event.row, grid_cust_Books_Amount_cr));
		}
	}
	else if(obj.id == "grid_emp"){
	    
		if(grid_emp.GetGridData(event.row, grid_emp_Ccy) != "VND") {
		 return;
		}
		
		if(event.col == grid_emp_Trans_Amount_dr){
			grid_emp.SetGridText(event.row, grid_emp_Books_Amount_dr, grid_emp.GetGridData(event.row, grid_emp_Trans_Amount_dr));
		}
		else if(event.col == grid_emp_Trans_Amount_cr){
			grid_emp.SetGridText(event.row, grid_emp_Books_Amount_cr, grid_emp.GetGridData(event.row, grid_emp_Trans_Amount_cr));
		}
		else if(event.col == grid_emp_Books_Amount_dr){
			grid_emp.SetGridText(event.row, grid_emp_Trans_Amount_dr, grid_emp.GetGridData(event.row, grid_emp_Books_Amount_dr));
		}
		else if(event.col == grid_emp_Books_Amount_cr){
			grid_emp.SetGridText(event.row, grid_emp_Trans_Amount_cr, grid_emp.GetGridData(event.row, grid_emp_Books_Amount_cr));
		}
	}
}
function onReport()
{
    alert('Not Yet');
    return;
}

function ongrid_celldblclick(obj)
{
    var path;
    var object;
	if (event.row < 1) return;
	var row = event.row;
	
    if ((obj.id == "grid_acc" && event.col == grid_acc_acc_code)||(obj.id == "grid_acc" && event.col == grid_acc_acc_name))  //Acc 
    {
        var path = System.RootURL + "/form/60/03/60030010_popup_ifrs.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + 'Y' + "&val2=" + 'Y' + "&val3=" + lstCompany.GetData() + "&dsqlid=ac_sel_60030010_popup";
        object   = System.OpenModal( path , 550 , 550 , 'resizable:yes;status:yes');	
        if (object != null)
	    {
		    if (object[0] != 0)
            {
		        grid_acc.SetGridText(row, grid_acc_acc_code, object[0]);
                grid_acc.SetGridText(row, grid_acc_acc_name, object[1]);
	        }
	    }
    }
	else if (obj.id == "grid_cust" && event.col == grid_cust_acc_code)   //Acc, Customer
    {
        var path = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + 'Y' + "&val2=" + 'Y' + "&val3=" + lstCompany.GetData() + "&dsqlid=SP_SEL_ACCT_POPUP";
        object   = System.OpenModal( path , 550 , 550 , 'resizable:yes;status:yes');	
        if (object != null)
	    {
		    if (object[0] != 0)
            {
		        grid_cust.SetGridText(row, grid_cust_acc_code, object[0]);
                grid_cust.SetGridText(row, grid_cust_acc_name, object[1]);
	        }
	    }
    }
	else if (obj.id == "grid_bank" && event.col == grid_bank_acc_code)   //Acc, Bank
    {
        var path = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + 'Y' + "&val2=" + 'Y' + "&val3=" + lstCompany.GetData() + "&dsqlid=SP_SEL_ACCT_POPUP";
        object   = System.OpenModal( path , 550 , 550 , 'resizable:yes;status:yes');	
        if (object != null)
	    {
		    if (object[0] != 0)
            {
		        grid_bank.SetGridText(row, grid_bank_acc_code, object[0]);
                grid_bank.SetGridText(row, grid_bank_acc_name, object[1]);
	        }
	    }
    }
	else if (obj.id == "grid_emp" && event.col == grid_emp_acc_code)   //Acc, Bank
    {
        var path = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + 'Y' + "&val2=" + 'Y' + "&val3=" + lstCompany.GetData() + "&dsqlid=SP_SEL_ACCT_POPUP";
        object   = System.OpenModal( path , 550 , 550 , 'resizable:yes;status:yes');	
        if (object != null)
	    {
		    if (object[0] != 0)
            {
		        grid_emp.SetGridText(row, grid_emp_acc_code, object[0]);
                grid_emp.SetGridText(row, grid_emp_acc_name, object[1]);
	        }
	    }
    }
    else if (obj.id == "grid_cust" && event.col == grid_cust_cust_code)   //Customer
    {
        path    = System.RootURL + '/form/gf/co/ffbp00031.aspx?com_pk='+lstCompany.GetData();
	    object  = System.OpenModal( path ,850 , 550 , 'resizable:yes;status:yes');
	    if (object != null)
	    {
	        if (object[0] != 0)
            {
                grid_cust.SetGridText(row, grid_cust_cust_code, object[1]);
                grid_cust.SetGridText(row, grid_cust_cust_name, object[2]);
	        }
        }
    }
    else if (obj.id == "grid_emp" && event.col == grid_emp_emp_id)//Emp
    {
        //path    = System.RootURL + "/form/gf/co/ffco002003.aspx";
        path    = System.RootURL + "/form/gf/ma/gfma00010_3.aspx";
        object  = System.OpenModal(  path , 1000 , 600 , 'resizable:yes;status:yes'); 
        if (object != null)
	    {
	        if (object[0] != 0)
            {
                grid_emp.SetGridText(row, grid_emp_emp_id, object[1]);
                grid_emp.SetGridText(row,grid_emp_emp_name, object[2]);
	        }
        }
    }	    
    else if (obj.id == "grid_bank" && event.col == grid_bank_bank_id) // Bank
    {
        path    = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + "" + "&val1=" + "" + "&company="+ lstCompany.GetData() + '&dsqlid=sp_sel_60080330_bank_popup&col_code=' + 'Bank Code'  + '&col_nm=' + 'Bank Name';
        object  = System.OpenModal(  path , 600 , 500 , 'resizable:yes;status:yes'); 
        if (object != null)
	    {
	        if (object[0] != 0)
            {
                grid_bank.SetGridText(row, grid_bank_bank_id, object[1]);
                grid_bank.SetGridText(row, grid_bank_bank_name, object[0]);
	        }
        }
    }
	else if (obj.id == "grd_pl" && event.col == grd_pl_PL_CD) // pl
    {
        var fpath = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code=" + "" + "&comm_nm=" + '' + "&company=" + lstCompany.GetData() + '&dsqlid=AC_SEL_PL_POPUP&col_code=' + "PL CODE" + '&col_nm=' + "PL NAME";
			var object = System.OpenModal(fpath, 600, 500, 'resizable:yes;status:yes');
			{
			if (object != null) 
				{
				if (object[0] != 0)
					{
						grd_pl.SetGridText(row, grd_pl_PL_CD, object[0]);
						grd_pl.SetGridText(row, grd_pl_PL_NM, object[1]);
						
						grd_pl.SetGridText(row, grd_pl_PLC_CD, object[3]);
						grd_pl.SetGridText(row, grd_pl_PLC_NM, object[4]);
					} 
				}
			}		
    }
}


</script>
<body style="margin:0; padding:0;">

    <gw:data id="dso_getCompany" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="ac_sel_60080330_comp" > 
                <input> 
                     <input bind="txtProposedByUserPk"/>
                </input>
                <output>
                     <output bind="lstCompany"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>
	
<%=ESysLib.RenderControlHTML("dso_60080330_bank","data") %> 
<%=ESysLib.RenderControlHTML("dso_60080330_emp","data") %> 
<%=ESysLib.RenderControlHTML("dso_60080330_cust","data") %> 
<%=ESysLib.RenderControlHTML("dso_60080330_account","data") %> 

<%=ESysLib.RenderControlHTML("dso_pro_60080330_upper_acc","data") %> 
<%=ESysLib.RenderControlHTML("dso_60080330_PL","data") %>


<table  style="width:100%; height:100%" cellpadding="0" cellspacing="0" border="0">
<tr>
    <td width="100%">
        <table width="100%" cellpadding="0" cellspacing="0" border="0">
        <tr>
	        <td width="8%"></td>
	        <td width="29%"></td>
	        <td width="8%"></td>
	        <td width="35%"></td>
	        <td width="20%"></td>
	    </tr>
	    <tr>
	        <td align="right">Company&nbsp;</td>
            <td><gw:list id="lstCompany" onChange="" styles='width:100%;background:#FFFFAF'></gw:list></td>
            <td align="right">Account&nbsp;</td>
            <td >
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td width="30%"><gw:textbox id="txtac_cd" onenterkey="onSearch()" styles='width:100%;background:#FFFFAF' /></td>
                    <td width="60%"><gw:textbox id="txtac_nm" styles='width:100%;background:#FFFFAF' /></td>
                    <td width="5%"><gw:imgBtn   img="popup"	id="idSearchTr" alt="Popup" onclick="Popup_Acc()"/></td> 
                    <td width="5%"><gw:imgBtn   img="reset"	id="idResetTr"  alt="Reset" onclick="Reset_Acc()"/></td>
                </tr>
                </table>
            </td>
            <td>
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td width="80%"></td>
                    <td ><gw:imgBtn id="ibtnSearch" img="search"    alt="Search"        onclick="onSearch()"/></td>
                    <td ><gw:imgBtn id="ibtnNew"    img="new"       alt="New"           onclick="onNew()"/></td>
				    <td ><gw:imgBtn id="ibtnSave"   img="save"      alt="Save"          onclick="onSave()"/></td>
				    <td ><gw:imgBtn id="ibtnDelete" img="delete"    alt="Delete"        onclick="onDelete()"/></td>
				    <td ><gw:imgBtn id="ibtnReport" img="printer"   alt="Print"         onclick="onReport()"/></td>
                </tr>
                </table>
            </td>
	    </tr>
	    <tr>
	        <td align="right">Month&nbsp;</td>
	        <td>
	            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td align="center"><gw:datebox id="dtMonth" type="month" onchange="" lang="1" styles="width:50%;background:#FFFFAF"/></td>
                    
                </tr>
                </table>
	        </td>
            <td align="right"><gw:label styles="font-weight:700" id="lblText" text="Customer"/>&nbsp;</td>
            <td >
                <table width="100%" cellpadding="0" cellspacing="0" border="0"> 
                <tr>
                    <td id='idcus_cd' width="30%"><gw:textbox id="txtlb_cd" onenterkey="onSearch()" styles='width:100%' /></td>
                    <td id='idcus_nm' width="60%"><gw:textbox id="txtlb_nm" styles='width:100%'/></td>
					<td id='idpl_cd' width="30%"><gw:textbox id="txtpl_cd" onenterkey="onSearch()" styles='width:100%' /></td>
                    <td id='idpl_nm' width="60%"><gw:textbox id="txt_PLC_CD" styles='width:100%'/></td>
                    <td id='idbt_cus' width="5%"><gw:imgBtn   img="popup"	id="idSearchCust" alt="Popup" onclick="Popup()"/></td> 
					<td id='idbt_pl' width="5%"><gw:imgBtn   img="popup"	id="idSearchCust" alt="Popup" onclick="Popup()"/></td> 
                    <td width="5%"><gw:imgBtn   img="reset"	id="idResetCust"  alt="Reset" onclick="OnResetCust()"/></td>
                </tr>
                </table>
            </td>
            <td>
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td align="right">Posting/Summary&nbsp;</td>
                    <td width="50%"><gw:list id="lstPostSum" onchange="onSearch()" styles='width:100%;background:#FFFFAF'></gw:list></td>
                </tr>
                </table>
            </td>
	    </tr>
	    </table>
	</td>
</tr>
<tr style="width:100%; height:100%">
	<td width="100%">
	    <table style="width:100%; height:100%" cellpadding="0" cellspacing="0" border="0">
        <tr style="width:100%; height:100%">
            <td width="100%" style="width:100%; height:100%">
                <gw:tab id="idTab_Child"  onpageactivate ="onSearch()"  >
                    <table  name="Account Code"  align ="top"  cellspacing=0 cellpadding=0  style="width:100%;height:100%;" >    
                        <tr valign="top" style="width:100%; height:100%">
                            <td width="100%">
                                <%=ESysLib.RenderControlHTML("dso_60080330_account","grid") %>
                            </td>
                        </tr>
                    </table>
                    <table  name="Customer"  align ="top"  cellspacing=0 cellpadding=0  style="width:100%;height:100%;" >    
                        <tr valign="top">
                            <td width="100%">
                               <%=ESysLib.RenderControlHTML("dso_60080330_cust","grid") %>
                            </td>
                        </tr>
						  
                    </table>
                    <table  name="Employee"  align ="top"  cellspacing=0 cellpadding=0  style="width:100%;height:100%;" >    
                        <tr valign="top">
                            <td width="100%">
                                  <%=ESysLib.RenderControlHTML("dso_60080330_emp","grid") %>
                            </td>
                        </tr>
                    </table>
                    <table  name="Bank"  align ="top"  cellspacing=0 cellpadding=0  style="width:100%;height:100%;" >    
                        <tr valign="top">
                            <td width="100%">
									<%=ESysLib.RenderControlHTML("dso_60080330_bank","grid") %> 
                            </td>
                        </tr>
                    </table>
                    <table  name="PL" align="top" cellspacing=0 cellpadding=0  style="width:100%;height:100%;" >    
                        <tr valign="top">
                            <td width="100%">
                               <%=ESysLib.RenderControlHTML("dso_60080330_PL","grid") %> 
                            </td>
                        </tr>
                    </table>
                </gw:tab>                    
            </td>
        </tr>
        </table>
	</td>
</tr>
</table>

<gw:textbox id="txtProposedByUserPk"            style="display:none" />
<gw:textbox id="txtResult"            style="display:none" />
<gw:textbox id="txtType"            style="display:none" />
</body>
</html>