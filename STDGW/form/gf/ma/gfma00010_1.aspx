<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>ADVANCE REQUEST ENTRY</title>
</head>
<%  ESysLib.SetUser("acnt")%>

<script>

var flag;
//--------------------------------------------------------------------- 

function OnToggle()
{
    var left = document.all("left"); 
    var right = document.all("right"); 
    var imgArrow = document.all("imgArrow"); 

    if(imgArrow.status == "expand"){
    left.style.display="none";
    imgArrow.status = "collapse";
    right.style.width="100%";
    imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else{
    left.style.display="";
    imgArrow.status = "expand";
    right.style.width="75%";
    imgArrow.src = "../../../system/images/prev_orange.gif";
    }
}

//-------------------------------------------------------------------

function BodyInit()
{
    System.Translate(document);  // Translate to language session
    Validate();
    BindingDataList();
    OnNew();
    OnSearch();
}
//---------------------------------------------------------------------  

 function BindingDataList()
 {      
     var data ;
     var arr;
     data = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM comm.TCO_company  where del_if=0")%>";   
     cboCompany.SetDataText(data);
     cboCompany.value = "<%=Session("COMPANY_PK") %>";   
     data = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0110','','') FROM DUAL")%>";  //ccy
     lstreqccy.SetDataText(data);
   
     lstbccy.SetDataText(data);
     data = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_DEFAULT('ACBG0040') FROM DUAL")%>";
     arr  = data.split("|");
	 lstbccy.SetDataText(arr[1]);
    
     data = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('ACBG0010') FROM DUAL")%>";
     lstStatus.SetDataText(data);    
     data = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_DEFAULT('ACBG0010') FROM DUAL")%>";
     arr  = data.split("|");
	 lstStatus.SetDataText(arr[1]);  
	 data = ("<%=ESysLib.SetListDataSQL("select pk,org_nm from comm.tco_org a where  del_if=0")%>");  
     lstdept.SetDataText(data); 
     data = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('EACAB024') FROM DUAL")%>";
     lstOption.SetDataText(data);
     data = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_DEFAULT('EACAB024') FROM DUAL")%>";
     arr  = data.split("|");
	 lstOption.SetDataText(arr[1]);
     data = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('EACAB023') FROM DUAL")%>";
     lstExpense.SetDataText(data);
     data = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('EACAB025') FROM DUAL")%>";
     lstVC_type.SetDataText(data); 
     
 }
 //---------------------------------------------------------------------------------------------------
 function SetGridFormat()
 {
    var ctr = grdDetail.GetGridControl(); 
    
    ctr.ColFormat(G1_MR_Qty)        = "#,###,###,###,###,###.##";
    ctr.ColFormat(G1_PO_Qty)        = "#,###,###,###,###,###.##";
    ctr.ColFormat(G1_Lot_Qty)       = "#,###,###,###,###,###.##";
    ctr.ColFormat(G1_U_P)           = "#,###,###,###,###,###.##";
    
    
 }

//--------------------------------------------------------------------------------------------------
function OnPopUp(pos)
{
    switch(pos)
    {
        case 'Charger':
            var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )
            {
                txtChargerNM.text    = obj[2];
                txtChargerPK.text  = obj[0];
                txtChargerID.text=obj[1];
                lstdept.SetDataText(obj[13]);
               
            }
        break;  
        case 'cust':
            var path = System.RootURL + '/form/gf/co/ffbp00031.aspx';
		    var object = System.OpenModal( path ,800 , 600 , 'resizable:yes;status:yes');
		    if ( object != null )
		    {
		        if (object[0] != 0)
                {
                    txt_CustomerID.SetDataText(object[1]);//customer id
                    txt_CustomerNM.SetDataText(object[2]);//customer name
                    txt_CustomerPK.SetDataText(object[0]);//customer name
      	        }
		     }       
        break;  
        case 'dept':
            var path = System.RootURL + '/form/ch/ae/chae00010_dept.aspx?';
            var obj = System.OpenModal( path ,400 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )
            {
              lstdept.SetDataText(obj);
            }
        break;   
        case 'PL':
             fpath  = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + '' + "&company=" + cboCompany.GetData() + '&dsqlid=ACNT.SP_SEL_PL_POPUP&col_code=' + "PL CODE" + '&col_nm=' + "PL NAME";
             oValue = System.OpenModal( fpath , 600 , 400 , 'resizable:yes;status:yes');
            if ( oValue != null )
            {
                txtPLPK.text = oValue[2]; 
                txtPLNM.text   = oValue[1];
                txtPLID.text   = oValue[1];
            }
          
        break;      
        case 'adv_acc':
            var comm_code ="";
            var kind_cd = "ALL",trans_grp = "", acc_grp_cd = "";
            comm_code = 'ACDF0040';
            kind_cd = "ALL";
		    trans_grp = "G";
		    acc_grp_cd = "ALL"
            fpath   = System.RootURL + "/form/gf/gf/gfgf00012_GetAccGrpCd.aspx?compk=" + cboCompany.GetData() + "&transgrp=" + trans_grp + "&accgrpcd=" + acc_grp_cd;
            oValue  = System.OpenModal(fpath , 600 , 500 , 'titleb:0;resizable:no;status:no;dialogWidth:50;dialogHeight:31;dialogLeft:5;dialogTop:30;edge:sunken;scroll:no;unadorned:yes;help:no'); 
	        if ( oValue != null )
            {
                txtadvPK.text = oValue[0];
                txtadvID.text = oValue[1];
                txtadvNM.text = oValue[2];
            }
        break;
        case 'ap_acc':
            var comm_code ="";
            var kind_cd = "ALL",trans_grp = "", acc_grp_cd = "";
            comm_code = 'ACDF0040';
            kind_cd = "ALL";
		    trans_grp = "G";
		    acc_grp_cd = "ALL"
            fpath   = System.RootURL + "/form/gf/gf/gfgf00012_GetAccGrpCd.aspx?compk=" + cboCompany.GetData() + "&transgrp=" + trans_grp + "&accgrpcd=" + acc_grp_cd;
            oValue  = System.OpenModal(fpath , 600 , 500 , 'titleb:0;resizable:no;status:no;dialogWidth:50;dialogHeight:31;dialogLeft:5;dialogTop:30;edge:sunken;scroll:no;unadorned:yes;help:no'); 
	        if ( oValue != null )
            {
                txtAPPK.text = oValue[0];
                txt_APID.text = oValue[1];
                txt_APNM.text = oValue[2];
            }
        break;
        case 'app_Charger':
            var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )
            {
                txt_appNM.text    = obj[2];
                txt_apppk.text  = obj[0];
                txt_appID.text=obj[1];
            }
        break;  
        case 'Trans':
            var path = System.RootURL + '/form/gf/hg/gfhg00010_transaction.aspx?compk='+ cboCompany.GetData();
            aValue = System.OpenModal(path ,850 , 500 ,  'resizable:yes;status:yes');
            if ( aValue != null )
	        {
		        var tmp = aValue[0];
		        if (tmp[1] != null)
		        {
		            txtTransPK.text         = tmp[0];
		            txtTransID.text = tmp[1];
		            txtTransNM.text = tmp[2];
		            txtDescription.text      = tmp[3];
                    txtLDescription.text = tmp[4];
		        }
		    }    
        break;
                                                              
    }	       
}
 
//-------------------------------------------------------------------------------------

function OnNew()
{
    data_gfma00010_1.StatusInsert();
    cboCompany.value = "<%=Session("COMPANY_PK") %>";
    flag='new'
    lstStatus.SetDataText('1');
    ButtonStatus("1");
    chkauto_YN.SetDataText("Y");
    chkChange();
    getExRate();
    grdfile.ClearData();
    idGridItem.SetData("");
}  
function chkChange()
{
    if(chkauto_YN.GetData()=="Y")
    {
        txtVoucher_no.SetEnable(false);
    }
    else
    {
        txtVoucher_no.SetEnable(true);
    }
}
//-------------------------------------------------------------------------------------
function OnSearch()
{
    flag='view';       
    txtMasterPK.text  = "<%=Request("tac_empadvreq_pk")%>";
    data_gfma00010_1.StatusSelect();  
    data_gfma00010_1.Call("SELECT");  
}

//--------------------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "data_gfma00010_1": 
            data_gfma00010_2.Call('SELECT')
          
        break;
        case "data_gfma00010_2": 
            ButtonStatus(lstStatus.GetData());
            data_gfma00010_4.Call('SELECT');
           
        break;
        case "data_gfma00010": 
            var r_save=0, r_App=0, r_return=0,l_status;
            for(i=1;i<grdSearch.rows;i++)
            {
                l_status= grdSearch.GetGridData(i,6); 
                if(l_status== 1)
                {
                    r_save = r_save +1 ;
                }
                if(l_status== 0)
                {
                    r_App = r_App +1 ;
                }
                if(l_status== 5)
                {
                    r_return = r_return +1 ;
                }
            }
            lbl_r_save.text = ' : ' + r_save + ' record(s)';
            lbl_r_app.text= ' : ' + r_App + ' record(s)';
            lbl_r_rtn.text= ' : ' + r_return + ' record(s)';
           
        break;
        case "data_gfma00010_3":
            flag='view';
            ButtonStatus(lstStatus.GetData());
            OnSearch('grdSearch');
        break;
        case "data_gfma00010_4":
            ItemStyle();
            if(flag != 'view')
            {
              OnSearch('grdSearch');
            }
        break;
    }
}

//------------------------------------------------------------------------------------------------

 function OnDelete(index)
 {        
    switch (index)
    {
        case 0:// delete master
            if(confirm('Do you want to delete this Voucher?'))
            {
                flag='delete';
                data_gfma00010_1.StatusDelete();
                data_gfma00010_1.Call();
            }   
        break;
            
        case 1:// delete document
            if(confirm('Do you want to delete selected file ?'))
            {
                 grdfile.DeleteRow();
                 data_gfma00010_2.Call();
            }
        break;

    }     
}

//-------------------------------------------------------------------------------------

function Validate()
{  
    txtChargerPK.SetEnable(false);
    txtChargerID.SetEnable(false);
    txtChargerNM.SetEnable(false);
    lstStatus.SetEnable(false);
   
    txtPLID.SetEnable(false);
    txtPLNM.SetEnable(false);
    
    txtadvID.SetEnable(false);
    txtadvNM.SetEnable(false);
    
    txt_APID.SetEnable(false);
    txt_APNM.SetEnable(false);
    
    txt_appID.SetEnable(false);
    txt_appNM.SetEnable(false);
    
    txtTransID.SetEnable(false);
    txtTransNM.SetEnable(false);
    
    lstbccy.SetEnable(false);
    txt_bamt.SetEnable(false);
    
    txt_CustomerID.SetEnable(false);
    txt_CustomerNM.SetEnable(false);
    
    return true;
}

//-------------------------------------------------------------------------------------
function OnSave(pos)
{    
    switch(pos)
    { 
        case 'Master':
              flag='update';
              data_gfma00010_1.Call();
          break;
        case 'Detail':        
            for (i = 1; i < idGridItem.rows; i++)
            {
                idGridItem.SetGridText(i, 13, txtMasterPK.text);
                if(idGridItem.GetGridData(i,14)=='D')
                {
                    idGridItem.SetGridText(i, 15, txtadvPK.text);
                }else
                {
                    idGridItem.SetGridText(i, 15, txtAPPK.text);
                }    
                if(idGridItem.GetGridData(i,0) == ''){
                    idGridItem.SetRowStatus(i, 0x20);
                 }
                 //alert('row ' + i + '  status=' + idGridItem.GetRowStatus(i));
            }        
            data_gfma00010_4.Call("");
        break;
    }
}

//------------------------------------------------------------------------
function OnPrintDTL()
{
    if (txtMasterPK.text=="")
    {
        alert("Please select a advance request!");
    }
    else
    {
        var url =System.RootURL + '/reports/gf/ma/rpt_gfma00010_2.aspx?pk_req='+txtMasterPK.text ;
        window.open(url); 
     }
}
//------------------------------------------------------------------------
function OnAppove()
{
    if(confirm('Do you want to approve the selected voucher ?'))
    {
        lstStatus.SetDataText('0');
        data_gfma00010_3.Call();
    }
}
//------------------------------------------------------------------------
    function AttachFiles()
    {
     
        imgFile.MasterPK=txtMasterPK.text;
        imgFile.ChangeImage();
                        
        if( imgFile.oid == 0 )
        {
            return false;
        }
        else
        {
           data_gfma00010_2.Call();
        }
        
        // Sau khi upload file xong phai reset oid(pk) lai
        // Neu ko no se giu lai oid(pk) da upload truoc
        imgFile.oid= "";        
    }
    
    function OnOpenFile()
    {
        var img_pk = grdfile.GetGridData(grdfile.GetGridControl().row,0)	
        var url = System.RootURL + "/system/binary/viewfile.aspx?img_pk=" + img_pk + "&table_name=TAC_EMPADVREQD";	
	    window.open(url);
    }
//-------------------------------------------------
function Upcase()
{
    var c = String.fromCharCode (event.keyCode);
	var x = c.toUpperCase().charCodeAt(0);
	event.keyCode = x;
}    
 //--------------------------------------------------------------
    function getExRate()
    {    
	    var url =  System.RootURL + "/form/ep/bp/epbp00020_GetExRate.aspx?date=" + dbVoucher_dt.value +"&curr=" + lstreqccy.value;
	    ajax_test = null;
	   
	    ajax_test = GetXmlHttpRequest(returnExRate);
	    ajax_test.open("GET", url , true);
	    ajax_test.send(null); 
    }
    //---------------------------------------------------------
    function returnExRate()
    {
        if(GetRequestState(ajax_test))
	    {	
	        strdata = ajax_test.responseText;	 	  
	        txtExrate1.SetDataText(''+strdata);
	        Getbamt();
	    }
    }
//--------------------------------------------------------------
function Getbamt()
{
    var l_amt,l_exrate,l_tramt;
    l_exrate= txtExrate1.GetData();
    l_tramt= txt_tramt.GetData();
    l_amt = Number(l_exrate) * Number(l_tramt);
    txt_bamt.SetDataText('' + l_amt);
}    
//-------------------------------------------------------------------------------
function ButtonStatus(index)
{
    switch(index)
    {
        case "0":// Approved
            btnApprove.SetEnable(false);
            btnNewMST.SetEnable(true);
            btnDeleteMST.SetEnable(false);
            btnSaveMST.SetEnable(false);
            btnPrint.SetEnable(true);
            btnAttach.SetEnable(false);
            btnDelDoc.SetEnable(false);
        break;
        case "1":// Saved
            btnApprove.SetEnable(true);
            btnNewMST.SetEnable(true);
            btnDeleteMST.SetEnable(true);
            btnSaveMST.SetEnable(true);
            btnPrint.SetEnable(true);
            btnAttach.SetEnable(true);
            btnDelDoc.SetEnable(true);
        break;
    }
}
//------------------------------------------------------------------------------------------------
function DBPopupClickInfor()
{
    var path   = System.RootURL + "/form/gf/co/gfco002006.aspx?comm_nm="+ '' + "&comm_code=" + '' + "&comm_nm2=" + '' + "&val1=" + '' + "&val2=" + '' + "&val3=" + cboCompany.GetData() + "&dsqlid=ACNT.SP_SEL_POPUP_ITEM_N" + '&col_code=Item Name' + '&col_nm=Item Name Local';
		aValue     = System.OpenModal( path, 500, 500, 'resizable:yes;status:yes');
		if (aValue != null) 
        {
            if (aValue.length > 0)
            {
                for(i=0; i<aValue.length; i++)
                {
                    var tmp = aValue[i];
                    if (tmp[1] != 0)
                    {
                        grdInfor.AddRow();
                        grdInfor.SetGridText(grdInfor.selrow + i, 1, tmp[0]);     // PK
                        grdInfor.SetGridText(grdInfor.selrow + i, 2, tmp[2]);     // Item Name
                        grdInfor.SetGridText(grdInfor.selrow + i, 3, tmp[3]);     // Item Name Local
                        grdInfor.SetGridText(grdInfor.selrow + i, 4, tmp[4]);     // InType
                        grdInfor.SetGridText(grdInfor.selrow + i, 6, "");         // Item
				        grdInfor.SetGridText(grdInfor.selrow + i, 9, "");         // Item NM
				        if (tmp[5] == 'N')
				        {
				            grdInfor.SetGridText(grdInfor.selrow + i, 5, 0); // DataType
				        }
				        else if (tmp[5]== 'D')
				        {
				            grdInfor.SetGridText(grdInfor.selrow + i, 5, 2); // DataType
				        }
				        else
				        {
				            grdInfor.SetGridText(grdInfor.selrow + i, 5, 1); // DataType
				        }
				        if (tmp[4] == "T" | tmp[4] == "C")
		                {
	                        if(tmp[4] == "T")
	                        {
		                        grdInfor.SetCellBgColor(grdInfor.selrow + i, 2, grdInfor.selrow + i, 6, 0xEFFFFF);	
	                        }
	                        else
	                        {
		                        grdInfor.SetCellBgColor(grdInfor.selrow + i, 2, grdInfor.selrow + i, 6, 0xF4E6E0);
	                        }
	                        grdInfor.SetRowEditable(grdInfor.selrow + i, false);
		                }
        		    
                    }
                }
               
            }
        }
	
}
//------------------------------------------------------------------------------------------------
function ItemStyle()
{
	var ctrl = idGridItem.GetGridControl();
	var j = 1;
	var i = ctrl.rows - 1;
	
	while (j <= i)
	{
		var man = idGridItem.GetGridData(j,6);
		if(man == "Y")
		{
			idGridItem.SetCellBold(j,8,j,8,true);
		}
	    var type = idGridItem.GetGridData(j,3);
		if(type == "T" | type == "C")
		{
			if(type == "T")
			{
				idGridItem.SetCellBgColor(j,8,j,10,0xEFFFFF);	
			}
			else
			{
				idGridItem.SetCellBgColor(j,8,j,10,0xF4E6E0);
			}
			idGridItem.SetRowEditable(j,false);
		}
		j = j + 1;
	}
	
	SetDetailCtlItem();	
}
//---------------------------------------------------------------------------------------
function SetDetailCtlItem()
{
    var ctrl = idGridItem.GetGridControl();
    for (i = 1; i < idGridItem.rows; i++)
    {
        
        if ((idGridItem.GetGridData(i, 8) == 'CUSTOMER NAME' || idGridItem.GetGridData(i, 2) == '-1') && idGridItem.GetGridData(i, 6)=='Y')
        {
            idGridItem.SetGridText(i,  9, txt_CustomerID.GetData());//customer id
	        idGridItem.SetGridText(i,  10, txt_CustomerNM.GetData());//customer name
	        idGridItem.SetGridText(i,  11, "TCO_BUSPARTNER");//table name
	        idGridItem.SetGridText(i, 12, txt_CustomerPK.GetData());//customer pk
        }
        if (idGridItem.GetGridData(i, 8) == 'EMPLOYEE NAME' && idGridItem.GetGridData(i, 6)=='Y')
        {
            idGridItem.SetGridText(i,  9, txtChargerID.GetData()) ; //Employee ID
            idGridItem.SetGridText(i, 10, txtChargerNM.GetData()) ; //Employee Name 
            idGridItem.SetGridText(i, 11, "THR_EMPLOYEE") ; //table name
            idGridItem.SetGridText(i, 12, txtChargerPK.GetData()) ; //TABLE PK 
        }
        idGridItem.SetGridText(i, 13, txtMasterPK.GetData()) ; //TABLE PK 
    }
}
//----------------------------------------------------------------------------------------
function ClickItemControl()
{    
	var flg = "0";
	var ctrl = idGridItem.GetGridControl();
	
	if (idGridItem.GetGridData( ctrl.row, 8) == 'CUSTOMER  NAME' || idGridItem.GetGridData( ctrl.row, 2) =='-1')
	{
		flg = "2";
		var path = System.RootURL + '/form/gf/co/ffbp00031.aspx';
		var object = System.OpenModal( path ,800 , 600 , 'resizable:yes;status:yes');
		if ( object != null )
		{
		    if (object[0] != 0)
            {
                idGridItem.SetGridText(ctrl.row,  9, object[1]);//customer id
		        idGridItem.SetGridText(ctrl.row,  10, object[2]);//customer name
		        idGridItem.SetGridText(ctrl.row,  11, "TCO_BUSPARTNER");//table name
		        idGridItem.SetGridText(ctrl.row, 12, object[0]);//customer pk
		        
		        for (i = 1; i < idGridItem.rows; i++)
		        {
		            if (idGridItem.GetGridData(i, 8) == 'CUSTOMER NAME')
		            {
		                idGridItem.SetGridText(i, 10, object[2]);//cuatomer name
		                idGridItem.SetGridText(i,  9, object[1]);//cuatomer id
		            }
		            if (idGridItem.GetGridData(i, 8) == 'SERIAL NO')
		            {
		                idGridItem.SetGridText(i,  9, object[7]);
		            }
		            if (idGridItem.GetGridData(i, 8) == 'TAX CODE')
		            {
		                idGridItem.SetGridText(i,  9, object[6]);
		            }
		        }
		    }
        }
	}
	else if (idGridItem.GetGridData( ctrl.row, 2) == '-2')
	{
	    var fpath   = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + '' + "&company=" + cboCompany.GetData() + '&dsqlid=ACNT.SP_SEL_PL_POPUP&col_code=' + "PL CODE" + '&col_nm=' + "PL NAME";
        var object  = System.OpenModal(fpath , 600 , 500 , 'resizable:yes;status:yes'); 
        if ( object != null )  
        {
            if (object[0] != 0)
            {
                idGridItem.SetGridText(ctrl.row,  9, object[0]) ;//pl name
                idGridItem.SetGridText(ctrl.row, 10, object[4]) ;//cost center name
                idGridItem.SetGridText(ctrl.row,  11, "TAC_ABPLCENTER") ;//
                idGridItem.SetGridText(ctrl.row,  12, object[2]) ;//table pk
            }
        } 
	}
	else if(idGridItem.GetGridData(idGridItem.row, 8) == 'CONTRACT NOAR'){
	    var fpath   = System.RootURL + "/form/gf/co/gfco002007.aspx?contract_type=SALE&company=" + cboCompany.GetData();
        var object  = System.OpenModal(fpath , 900 , 600 , 'resizable:yes;status:yes'); 
        if ( object.length > 0 ){
            idGridItem.SetGridText(idGridItem.row,  9, object[1]) ;//ITEM CODE(contract no)
            idGridItem.SetGridText(idGridItem.row, 10, object[4]) ;//ITEM NAME(customer name)
            idGridItem.SetGridText(idGridItem.row, 11, "TEX_CONTR_MST") ;//TABLE NAME 
            idGridItem.SetGridText(idGridItem.row, 12, object[0]) ;//TABLE PK 
            for(var i=1;i<idGridItem.rows;i++){
                if ((idGridItem.GetGridData(i, 8) == 'CUSTOMER') && (Trim(idGridItem.GetGridData(i, 9)) == "")){
                    idGridItem.SetGridText(i,  9, object[3]);//customer id
                    idGridItem.SetGridText(i, 10, object[4]);//customer name
                    idGridItem.SetGridText(i,  11, "TCO_BUSPARTNER");//TABLE NAME
                    idGridItem.SetGridText(i,  12, object[8]);//TABLE PK
                }
                if (idGridItem.GetGridData(i, 8) == 'SERIAL NO'){
                    idGridItem.SetGridText(i,  9, object[10]);
                }
                if (idGridItem.GetGridData(i, 8) == 'TAX CODE'){
                    idGridItem.SetGridText(i,  9, object[9]);
                }
            }
        } 
    }    
    else if(idGridItem.GetGridData( idGridItem.row, 8) == 'CONTRACT NOAP'){
	    var fpath   = System.RootURL + "/form/gf/co/gfco002007.aspx?contract_type=BUY&company=" + cboCompany.GetData();
        var object  = System.OpenModal(fpath , 900 , 600 , 'resizable:yes;status:yes'); 
        if ( object.length > 0 ){
            idGridItem.SetGridText(idGridItem.row,  9, object[1]) ;//ITEM CODE
            idGridItem.SetGridText(idGridItem.row, 10, object[4]) ;//ITEM NAME
            idGridItem.SetGridText(idGridItem.row, 11, "TIM_CONTR_MST") ;//TABLE NAME 
            idGridItem.SetGridText(idGridItem.row, 12, object[0]) ;//TABLE PK 
            
            for(var i=1;i<idGridItem.rows;i++){
                if ((idGridItem.GetGridData(i, 8) == 'CUSTOMER') && (Trim(idGridItem.GetGridData(i, 9)) == "")){
                    idGridItem.SetGridText(i,  9, object[3]);//customer id
                    idGridItem.SetGridText(i, 10, object[4]);//customer name
                    idGridItem.SetGridText(i,  11, "TCO_BUSPARTNER");//TABLE NAME
                    idGridItem.SetGridText(i,  12, object[8]);//TABLE PK
                }
                if (idGridItem.GetGridData(i, 8) == 'SERIAL NO'){
                    idGridItem.SetGridText(i,  9, object[10]);
                }
                if (idGridItem.GetGridData(i, 8) == 'TAX CODE'){
                    idGridItem.SetGridText(i,  9, object[9]);
                }
            }
        } 
	}
	else
	{
		if ((idGridItem.GetGridData( ctrl.row, 3) == 'T') || (idGridItem.GetGridData(ctrl.row, 3) == 'C'))
		{
			if (idGridItem.GetGridData( ctrl.row, 3) == 'C')
			{
				var ls_str = idGridItem.GetGridData(ctrl.row, 8);
				var temp = new Array();
                temp = ls_str.split(' ');
				var ls_temp = temp[0];
				
				var fpath   = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + ls_str + "&company=" + cboCompany.GetData() + '&dsqlid=ACNT.SP_SEL_ITEMNM_POPUP&col_code=' + ls_temp +" CODE" + '&col_nm=' + ls_temp + " NAME";
                var object  = System.OpenModal(fpath , 600 , 500 , 'resizable:yes;status:yes'); 
                //get from TAC_ABITEMCODE
                if ( object != null )  
                {
                    if (object[0] != 0)
                    {
                        idGridItem.SetGridText(ctrl.row,  9, object[0]) ;// item code
                        idGridItem.SetGridText(ctrl.row, 10, object[1]) ;//item name
                        idGridItem.SetGridText(ctrl.row, 11, "TAC_ABITEMCODE") ; //table name
                        idGridItem.SetGridText(ctrl.row, 12, object[2]) ; //table pk
                    }
                } 
			}
			else
			{
				if (idGridItem.GetGridData(ctrl.row, 4) != '')
				{
				//
				}
				else
				{
					if ( idGridItem.GetGridData( ctrl.row, 8 )== "Bank Account No." || idGridItem.GetGridData( ctrl.row, 8 )== "DEPOSIT ACCOUNT NO" || idGridItem.GetGridData( ctrl.row, 8 )== "BANK ACCOUNT NUMBER" || idGridItem.GetGridData( ctrl.row, 8 )== "BANK ACCOUNT NO.")
					{
					    var ls_ccy
					    if (txt_drcr_type.GetData() == 'D')
					    {
					        ls_ccy = grdDebit.GetGridData(click_dr, 6);
					    }
					    else if (txt_drcr_type.GetData() == 'C')
					    {
					        ls_ccy = grdCredit.GetGridData(click_cr, 6);
					    }
					    var fpath   = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + "" + "&val1=" + ls_ccy + "&company="+ cboCompany.GetData() + '&dsqlid=ACNT.SP_SEL_BANK_POPUP&col_code=' + 'Bank Code'  + '&col_nm=' + 'Bank Name';
                        var object  =   System.OpenModal(  fpath , 600 , 500 , 'resizable:yes;status:yes'); 
                        if (object != null)
                        {
                            if (object[0] != 0)
                            {
                                idGridItem.SetGridText(ctrl.row,  9, object[1]);//BANK ID
                                idGridItem.SetGridText(ctrl.row, 10, object[0]);//BANK NAME(PARTNER NAME)
                                idGridItem.SetGridText(ctrl.row, 11, "TAC_ABDEPOMT");// TABLE NAME 
                                idGridItem.SetGridText(ctrl.row, 12, object[2]);// TABLE PK 
                            }
                        }
					}
					else
					{
						
						if (idGridItem.GetGridData( ctrl.row, 8 )== "EMPLOYEE NAME")
						{
							var fpath   = System.RootURL + "/form/gf/co/ffco002003.aspx";
                            var object  = System.OpenModal(  fpath , 800 , 500 , 'resizable:yes;status:yes'); 
                            if ( object != null )  
                            {
                                if (object[0] != 0)
                                {
                                    idGridItem.SetGridText(ctrl.row,  9, object[1]) ; //Employee ID
                                    idGridItem.SetGridText(ctrl.row, 10, object[2]) ; //Employee Name 
                                    idGridItem.SetGridText(ctrl.row, 11, "THR_EMPLOYEE") ; //table name
                                    idGridItem.SetGridText(ctrl.row, 12, object[0]) ; //TABLE PK    
                                }
                            }
						}	
						else if ( idGridItem.GetGridData( ctrl.row, 8 )== "DEPARTMENT" || idGridItem.GetGridData( ctrl.row, 8 )== "DEPARTMENT NAME" )
						{
							flg = "-3";
						}	
						else if ( idGridItem.GetGridData( ctrl.row, 8 )== "CONTRACT NO")
						{
							flg = "-4";
						}
					}
				}
			}
		}
	}
}
//-----------------------------------------------------------------------------------------------
function ChangeData_Upper()
{
    var ctrl = idGridItem.GetGridControl(); 
    var i = ctrl.rows - 1;
    for (i=1; i< ctrl.rows; i++)
    {
        var itemal      = idGridItem.GetGridData(i, 8); 
        var item_value  = idGridItem.GetGridData(i, 9); 
        if(itemal == "SERIAL NUMBER" || itemal == "SERIAL NO" || itemal == "SERI NO" )
        {
            item_value = item_value.toUpperCase();
            idGridItem.SetGridText( i , 9, item_value);
        }
    }
}
//------------------------------------------------------------------------------------------------

</script>

<body>   
    <!--------------------------------------------------------------------------->
    <gw:data id="data_gfma00010_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="3" type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,34,35,38,42" function="acnt.sp_sel_gfma00010_1" procedure="acnt.sp_upd_tac_empadvreq">
                <input>
                    <inout bind="txtMasterPK" />
                    <inout bind="cboCompany" />
                    <inout bind="dbpay_dt" />
                    <inout bind="txtVoucher_no" />
                    <inout bind="txtChargerPK" />
                    <inout bind="txtDescription" />
                    <inout bind="txtLDescription" />
                    <inout bind="lstStatus" />
                    <inout bind="lstVC_type" />
                    <inout bind="chkauto_YN" />
                    <inout bind="txtChargerPK" />
                    <inout bind="lstdept" />
                    <inout bind="lstExpense" />
                    <inout bind="txtadvPK" />
                    <inout bind="txtAPPK" />
                    <inout bind="txtLDescription" />
                    <inout bind="txtReqDesc" />
                    <inout bind="lstOption" />
                    <inout bind="lstbccy" />
                    <inout bind="lstreqccy" />
                    <inout bind="txtExrate1" />
                    <inout bind="txt_apppk" />
                    <inout bind="txt_tramt" />
                    <inout bind="txt_bamt" />
                    <inout bind="txtChargerID" />
                    <inout bind="txtChargerNM" />
                    <inout bind="txtPLID" />
                    <inout bind="txtPLNM" />
                    <inout bind="txtadvID" />
                    <inout bind="txtadvNM" />
                    <inout bind="txt_APID" />
                    <inout bind="txt_APNM" />
                    <inout bind="txt_appID" />
                    <inout bind="txt_appNM" />
                    <inout bind="txtPLPK" />
                    <inout bind="txtTransPK" />
                    <inout bind="txtTransID" />
                    <inout bind="txtTransNM" />
                    <inout bind="txt_CustomerPK" />
                    <inout bind="txt_CustomerID" />
                    <inout bind="txt_CustomerNM" />
                    <inout bind="txtSeq" />
                    <inout bind="dbVoucher_dt" />
                    
                 </input>
            </dso>
        </xml>
    </gw:data>
   <!----------------------grdfile--------------------------------------->
    <gw:data id="data_gfma00010_2" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso id="1" type="grid" parameter="0"  function="acnt.sp_sel_tac_empadvreqd"  procedure="acnt.sp_upd_tac_empadvreqd">
                <input bind="grdfile" >                            
                    <input bind="txtMasterPK" />   
                </input>
                <output bind="grdfile" />
            </dso>                    
        </xml>
    </gw:data>
    <!----------------------Approval--------------------------------------->
   <gw:data id="data_gfma00010_3"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso  type="process" function="acnt.sp_sel_gfma00010_1" procedure="acnt.sp_pro_gfma00010_3" > 
            <input>
                <input bind="txtMasterPK" />
                <input bind="lstOption" /> 
            </input> 
            <output>
                <output bind="txtMasterPK" />
                <output bind="txtVoucher_no" />
                <output bind="txtSeq" />
                
            </output>
        </dso> 
    </xml> 
  </gw:data>
  <!----------------------------------------------------------------------->
  <gw:data id="data_gfma00010_4" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" parameter="0,2,9,10,11,12,13,14,15" function="acnt.sp_sel_gfma00010_4" procedure="acnt.sp_upd_empadvreq_ctrlitem">
                <input bind="idGridItem">
                    <input bind="txtMasterPK"/>
                    <input bind="txtadvPK"/> 
                    <input bind="txtAPPK"/>
                </input> 
                <output bind="idGridItem"/>
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_gfma00010_5" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" parameter="0,1,4,5,6,7,8,9" function="ACNT.sp_sel_empadvreq_ctrlitem" procedure="ACNT.sp_upd_empadvreq_ctrlitem">
                <input bind="idGridItem">
                    <input bind="txtMasterPK"/>
                </input>
                <output bind="idGridItem"/>
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr>            
            <td id="right" style="width: 100%" valign=top>
                <table width=100% cellpadding=0 cellspacing=0 border=0>
                    <tr valign=top >
                        <td align="right" style="width: 10%">Company</td>
                        <td style="width: 35%"><gw:list id="cboCompany" styles="width:100%;" /></td>
                       
                        <td align="right" style="width: 10%">Seq</td>
                        <td style="width: 20%"><gw:textbox id="txtSeq" styles="width:100%;" /></td>
                        <td style="width: 12%"></td>
                        <td><gw:icon id="btnApprove" img="in" text="Approve" onclick="OnAppove()" styles="width:100%" /></td>
                        <td style="width: 2%">
                            <gw:imgbtn id="btnNewMST" img="new" alt="New" onclick="OnNew()" />
                        </td>
                        <td style="width: 2%">
                            <gw:imgbtn id="btnDeleteMST" img="delete" alt="Delete" onclick="OnDelete(0)" />
                        </td>
                        <td style="width: 2%">
                            <gw:imgbtn id="btnSaveMST" img="save" alt="Save" onclick="OnSave('Master')" />
                        </td>
                         <td style="width: 2%" align="right">
                            <gw:imgbtn id="btnPrint" img="printer" alt="Print" onclick="OnPrintDTL()" />
                        </td>
                    </tr>
                    
                    <tr>
                        <td width=100% colspan=11>
                             <table id="general" cellpadding=0 cellspacing=0 width=100% style="background-color: #CCFFFF" border=0 >
                             
                                <tr>
                                    <td width=1%>&nbsp;&nbsp;</td>
                                    <td align="left" style="width: 16%">Voucher No</td>
                                    <td colspan=4 width=50%>
                                        <table cellpadding=0 cellspacing=0 width=100%>
                                            <tr>
                                                 <td width="1%"><gw:checkbox id="chkauto_YN" defaultvalue="Y|N" value="Y" onclick="chkChange()" /></td>
                                                <td style="width: 50%" colspan=""><gw:list id="lstVC_type" styles='width:100%;display:' /></td>
                                                <td style="width: 50%" colspan="2"><gw:textbox id="txtVoucher_no" maxlen = "20" styles='width:100%;height:22' csstype="mandatory" onkeypress="" onchange=""/></td>
                                           </tr>
                                        </table>
                                    </td>
                                   <td width=1%>&nbsp;</td>
                                    <td align="left" style="width: 18%">Status</td>
                                    <td style="width: 20%" colspan=2><gw:list id="lstStatus" styles="width: 100%" /></td>
                                </tr>
                               
                                 <tr >
                                    <td width=1%>&nbsp;&nbsp;</td>
                                    <td align="left" style="width: 16%"><a title="Click here to select Requester" onclick="OnPopUp('Charger')" href="#tips"
                                     style="text-decoration: none; color=#0000ff"><b>Charger</b></a></td>
                                     <td colspan=4 width=50%>
                                        <table cellpadding=0 cellspacing=0 width=100%>
                                            <tr>
                                                <td  width=30%><gw:textbox id="txtChargerID" styles="width:100%;" onenterkey="" /><gw:textbox id="txtChargerPK" styles="width:100%;display:none" onenterkey="" /></td>
                                                <td  width=70%><gw:textbox id="txtChargerNM" styles="width:100%;" onenterkey="" /></td></tr>
                                        </table>
                                    </td>
                                    
                                    <td width=1%>&nbsp;</td>
                                     <td align="left" style="width: 18%">Option</td>
                                    <td style="width: 20%" colspan="2"><gw:list id="lstOption" styles="width: 100%" /></td>
                                   </tr>
                                <tr >
                                    <td width=1%>&nbsp;&nbsp;</td>
                                    <td align="left" style="width: 18%"><a title="Click here to select department" onclick="OnPopUp('dept')" href="#tips"
                                     style="text-decoration: none; color=#0000ff"><b>Department</b></a></td>
                                    <td colspan="4"><gw:list id="lstdept" styles="width:100%;" onenterkey="" /></td>
                                    <td width=1%>&nbsp;</td>
                                     <td align="left" style="width: 20%">Voucher date</td>
                                    <td style="width: 20%" colspan="2"><gw:datebox id="dbVoucher_dt" styles='width:100%;height:22'  lang="<%=Session("Lang")%>"/></td>
                                    </tr>
                                <tr >
                                    <td width=1%>&nbsp;&nbsp;</td>
                                    <td align="left" style="width: 18%"><a title="Click here to select PL Unit" onclick="OnPopUp('PL')" href="#tips"
                                     style="text-decoration: none; color=#0000ff"><b>PL Unit</b></a></td>
                                    <td colspan="2" styles="width:10%;"><gw:textbox id="txtPLID" styles="width:100%;" onenterkey="" /><gw:textbox id="txtPLPK" styles="width:100%;display:none" onenterkey="" /></td>
                                    <td colspan="2" styles="width:40%;"><gw:textbox id="txtPLNM" styles="width:100%;" onenterkey="" /></td>
                                    <td width=1%>&nbsp;</td>
                                    <td align="left" style="width: 20%">Payment req. date</td>
                                    <td style="width: 20%" colspan="2"><gw:datebox id="dbpay_dt" styles='width:100%;height:22'  lang="<%=Session("Lang")%>"/></td>
                                                          
                                </tr>
                                <tr >
                                    <td width=1%>&nbsp;&nbsp;</td>
                                    <td align="left" style="width: 18%"><a title="Click here to select expense type" onclick="OnPopUp('Charger')" href="#tips"
                                     style="text-decoration: none; color=#0000ff"><b>Expense type</b></a></td>
                                    <td colspan="4"><gw:list id="lstExpense" styles="width:100%;" onenterkey="" /></td>
                                    <td width=1%>&nbsp;</td>
                                   
                                    <td align="left" style="width: 20%">Booking CCY</td>
                                    <td style="width: 20%" colspan="2"><gw:list id="lstbccy" styles="width: 100%" /></td>
                                
                                </tr>
                                <tr >
                                    <td width=1%>&nbsp;&nbsp;</td>
                                    <td align="left" style="width: 18%"><a title="Click here to select Advance account" onclick="OnPopUp('Trans')" href="#tips"
                                     style="text-decoration: none; color=#0000ff"><b>Transaction type</b></a></td>
                                    <td colspan="2"><gw:textbox id="txtTransID" onkeypress="Upcase()"  styles="width:100%;" onenterkey="" /><gw:textbox id="txtTransPK" styles="width:100%;display:none" onenterkey="" /></td>
                                    <td colspan="2"><gw:textbox id="txtTransNM" styles="width:100%;" onenterkey="" /></td>
                                    <td width=1%>&nbsp;</td>
                                     <td align="left" style="width: 18%">Request CCY</td>
                                    <td style="width: 20%" colspan="2"><gw:list id="lstreqccy" styles="width: 100%" onchange="getExRate();" /></td>
                               
                                </tr>
                                <tr >
                                    <td width=1%>&nbsp;&nbsp;</td>
                                    <td align="left" style="width: 18%"><a title="Click here to select Advance account" onclick="OnPopUp('adv_acc')" href="#tips"
                                     style="text-decoration: none; color=#0000ff"><b>Advance account</b></a></td>
                                    <td colspan="2"><gw:textbox id="txtadvID" styles="width:100%;" onenterkey="" /><gw:textbox id="txtadvPK" styles="width:100%;display:none" onenterkey="" /></td>
                                    <td colspan="2"><gw:textbox id="txtadvNM" styles="width:100%;" onenterkey="" /></td>
                                    <td width=1%>&nbsp;</td>
                                     <td align="left" style="width: 18%">Ex. rate</td>
                                    <td style="width: 5%" colspan=""><gw:textbox id="txtExrate" type="number" format="###,###.##" text="1" onenterkey="" /></td>
                                    <td style="width: 20%" colspan=""><gw:textbox id="txtExrate1" type="number" format="###,###" styles="width:100%;" onenterkey="" /></td>
       
                                </tr>
                                <tr >
                                    <td width=1%>&nbsp;&nbsp;</td>
                                    <td align="left" style="width: 18%"><a title="Click here to select Advance account" onclick="OnPopUp('ap_acc')" href="#tips"
                                     style="text-decoration: none; color=#0000ff"><b>A/P account</b></a></td>
                                    <td colspan="2"><gw:textbox id="txt_APID" styles="width:100%;" onenterkey="" /><gw:textbox id="txtAPPK" styles="width:100%;display:none" onenterkey="" /></td>
                                    <td colspan="2"><gw:textbox id="txt_APNM" styles="width:100%;" onenterkey="" /></td>
                                    <td width=1%>&nbsp;</td>
                                    
                                     <td align="left" style="width: 18%">Req. Trans. amt</td>
                                    <td style="width: 20%" colspan="2"><gw:textbox id="txt_tramt" type="number" format="###,###" styles="width:100%;" onchange="Getbamt()" onenterkey="Getbamt()" /></td>
                                </tr>
                                 <tr >
                                    <td width=1%>&nbsp;&nbsp;</td>
                                    <td align="left" style="width: 18%"><a title="Click here to select Advance account" onclick="OnPopUp('cust')" href="#tips"
                                     style="text-decoration: none; color=#0000ff"><b>Customer</b></a></td>
                                    <td colspan="2"><gw:textbox id="txt_CustomerID" styles="width:100%;" onenterkey="" /><gw:textbox id="txt_CustomerPK" styles="width:100%;display:none" onenterkey="" /></td>
                                    <td colspan="2"><gw:textbox id="txt_CustomerNM" styles="width:100%;" onenterkey="" /></td>
                                    <td width=1%>&nbsp;</td>
                                    
                                     <td align="left" style="width: 18%">Req. books. amt</td>
                                    <td style="width: 20%" colspan="2"><gw:textbox id="txt_bamt"  type="number" format="###,###" styles="width:100%;" onenterkey="" /></td>
                                </tr>
                                 <tr >
                                    <td width=1%>&nbsp;&nbsp;</td>
                                    <td align="left" style="width: 18%"><a title="Click here to select approve charger" onclick="OnPopUp('app_Charger')" href="#tips"
                                     style="text-decoration: none; color=#0000ff"><b>Appr. Charger</b></a></td>
                                    <td colspan="2"><gw:textbox id="txt_appID" styles="width:100%;" onenterkey="" /><gw:textbox id="txt_apppk" styles="width:100%;display:none" onenterkey="" /></td>
                                    <td colspan="2"><gw:textbox id="txt_appNM" styles="width:100%;" onenterkey="" /></td>
                                    <td width=1% rowspan=6 colspan=4 valign=top>
                                        <table cellpadding=1 cellspacing=1 border=1 >
                                            <tr >
                                                 <td width=99%></td>
                                                 <td width="3%"><gw:imgBtn id="btnAttach"  img="attach" alt="Attach file" onclick="AttachFiles()"/></td>
                                                 <td ><gw:imgBtn id="btnDelDoc" img="delete" alt="Delete" onclick="OnDelete(1)"/></td> 
                                            </tr>
                                            <tr>
                                                 <td colspan="3" width=100%>
                                                    <gw:grid 
                                                    id="grdfile" 
                                                    header="_PK|Attachement|Description" 
                                                    format="0|0|0" 
                                                    aligns="0|0|0"
                                                    defaults="||" 
                                                    editcol="0|0|0" 
                                                    widths="0|1200|1500" 
                                                    styles="width:100%; height:120"
                                                    sorting="T" oncellclick=""
                                                    oncelldblclick="OnOpenFile()"
                                                     param="0,1,2" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                   
                                   
                                </tr>
                                <tr >
                                    <td width=1%>&nbsp;&nbsp;</td>
                                    <td align="left" style="width: 18%">Description</td>
                                    <td colspan="4"><gw:textbox id="txtDescription" styles="width:100%;" onenterkey="" /></td>
                                   
                                </tr>
                                 <tr >
                                    <td width=1%>&nbsp;&nbsp;</td>
                                    <td align="left" style="width: 18%">Local description</td>
                                    <td colspan="4"><gw:textbox id="txtLDescription" styles="width:100%;" onenterkey="" /></td>
                                   
                                </tr>
                                 <tr >
                                    <td width=1%>&nbsp;&nbsp;</td>
                                    <td align="left" style="width: 18%">Request description</td>
                                    <td colspan="4" rowspan="1"><gw:textarea id="txtReqDesc" rows=6 text=""  styles='width:100%;'/></td>
                                 
                                </tr>
                                 <tr >
                                    <td width="100%" colspan="10" align=right>
                                        <table cellpadding=0 cellspacing=0 >
                                            <tr>
                                                <td width="99%"></td>
                                                 <td width="1%" colspan="1" align=right><gw:imgBtn id="btnNewd"  img="new" alt="New item" onclick="DBPopupClickInfor()"/></td>
                                                 <td width="1%" colspan="1" align=right><gw:imgBtn id="btnSaved"  img="save" alt="save item" onclick="OnSave('Detail')"/></td>
                                                 <td width="1%" colspan="1" align=right><gw:imgBtn id="btndelete_d"  img="delete" alt="delete item" onclick="AttachFiles()"/></td>
                                            </tr>
                                        </table>
                                    </td>
                                   
                                </tr>
                                <tr>
                                     <td colspan="10" width=100%>
                                        <gw:neogrid id="idGridItem" styles="width:100%;height:360" oncelldblclick="ClickItemControl()"
                                onafteredit="ChangeData_Upper()"> 
								<XML>
									<xmlblock>
										
										<column title="itempk" hidden='T'>
											<textbox type="number" format="######"/>
										</column>

										<column title="detailpk" hidden='T'>
											<textbox type="number" format="######" />
										</column>

										<column title="acctpk" hidden='T'>
											<textbox type="number" format="######" />
										</column>

										<column title="INPUT TYPE" hidden='T'>
											<textbox  format="3" />
										</column>

										<column title="dsqlid" hidden='T'>
											<textbox  format="3" />
										</column>

										<column title="dsql" hidden='T'>
											<textbox  format="3" />
										</column>

										<column title="mandatory" hidden='T'>
											<textbox  format="3" />
										</column>

										<column title="data type" hidden='T'>
											<textbox  format="3" />
										</column>

										<column title="Item Alias" width='2500' editmode="0" >
											<textbox  format="3" />
										</column>

										<column title="Item code"  width='2500'>
											<multiple ref="7"  >
												<textbox type="number" format="###,###C" value="" />
												<textbox format="50" value="" />
												<datebox type="day" format=""  lang="1" acceptnull="T"/>
												<checkbox />	
												<htmledit value="[New]" />				
											</multiple>
										</column>
										
										<column title="Item name" width='1500'>
											<textbox/>
										</column>
										
										<column title="TABLE NM" hidden='T'>
											<textbox  />
										</column>
										
										<column title="TABLE PK" hidden='T'>
											<textbox  />
										</column>
										<column title="TAC_EMPADVREQ_PK" hidden='T'>
											<textbox  />
										</column>
										<column title="TYPE_CD" hidden='T'>
											<textbox  />
										</column>
										<column title="TAC_ABACCTCODE_PK" hidden='T'>
											<textbox  />
										</column>
									</xmlblock>
								</xml>
							</gw:neogrid>
                                    </td>
                                </tr>
                              </table>
                        </td>
                    </tr>
                                   
                    
                 </table>
            </td>
        </tr>
    </table>
    <!--------------------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles="width: 100%;display:none " />
    <gw:textbox id="txttrd_PK_db" styles="width: 100%;display:none " />
    <gw:textbox id="txttrd_pk_cr" styles="width: 100%;display:none " />
    <!--------------------------------------------------------------------------->
    <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif"
        style="cursor: hand; position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
    <!--------------------------------------------------------------------------->
    <gw:textbox id="txtComCodeID" styles='width:100%;display:none' />
    <gw:textbox id="txtCodeTemp" styles='width:100%;display:none' />
    
    <gw:image id="imgFile"  table_name="TAC_EMPADVREQD" view="/binary/ViewFile.aspx" post="/binary/PostFile.aspx" styles="width:100;height:100;display:none"  />
    <!------------------------------------------->
</body>
</html>
