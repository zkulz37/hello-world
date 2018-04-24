<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head >
    <title>Genuwin</title>
</head>
<%ESysLib.SetUser("acnt")%>
<script>
var flag;
function BodyInit()
{
    BindingDataList();
	System.Translate(document);
	FotmatGrid();
	lstStatus.SetEnable(false);
	FotmatGrid_Detail(); 
	OnChangeCurrent();
	
}
//-------------------------------------------------------------------------------------------------------------------------------------
function BindingDataList()
{
        lsCompany = "<%=ESysLib.SetListDataFUNC("SELECT acnt.sf_a_get_company('') FROM DUAL")%>";   
        lstCompany.SetDataText(lsCompany);
        lstCompany.value = "<%=Session("COMPANY_PK") %>"; 
        lsVoucher_Type = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('ACBG0130') FROM DUAL")%>";
        lstVoucher_Type.SetDataText(lsVoucher_Type); 
        lsStatus = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('ACBG0010') FROM DUAL")%>";
	    lstStatus.SetDataText(lsStatus);    
	    lsOption = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('EACAB024') FROM DUAL")%>";
        lstOption.SetDataText(lsOption); 
        lsBooking_Ccy = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0110','','') FROM DUAL")%>";  //ccy
        lstBooking_Ccy.SetDataText(lsBooking_Ccy); 
        lsReq_Ccy = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0110','','') FROM DUAL")%>";  //ccy
        lstReq_Ccy.SetDataText(lsReq_Ccy); 
        lsDepartment = ("<%=ESysLib.SetListDataSQL("select pk,org_nm from comm.tco_org a where  del_if=0")%>"); 
        lstDepartment.SetDataText(lsDepartment);  
       txt_row.text    = 1;
       txt_row1.text    = 1;
       
}
//-------------------------------------------------------------------------------------------------------------------------------------
function OnNew(obj)
{
        switch(obj)
        {
                case 1:
                            flag='new';
                            DSO_CONTROL.StatusInsert();
                            chkChange();
                break;
                case 2:
                            if(txtPK.text=="")
                            {
                                    alert('Please select the  master row first!!');
                            }
                            else
                            {
                                    var i = 0;
                                    Grid_Detail.AddRow();
                                    Grid_Detail.SetGridText(Grid_Detail.rows-1, 19, txtPK.text)  
                                    for(i = 1; i< Grid_Detail.rows; i++)
                                    {
                                            Grid_Detail.SetGridText(i, 0, i)  
                                    } 
                                    
                            } 
                break;
        } 
}
//-------------------------------------------------------------------------------------------------------------------------------------
function onSearch(obj)
{  
    switch(obj)
    {
        case 1:
             DSO_SEARCH.Call("SELECT");
        break;
        case 2:
             DSO_DETAIL.Call("SELECT");
        break;
    }
    
}
//-------------------------------------------------------------------------------------------------------------------------------------
function onSave(obj)
{
        switch(obj)
        {
                case 1:
                            if(onValidate())
                            {
                                flag='update';
                                DSO_CONTROL.Call();
                            }
                break;
                case 2:
                            if(txtPK.text != '')
                            {
                                DSO_DETAIL.Call();
                            }
                            else
                            {
                                    alert('Please select the  master row first!!');
                            }
                break;
        } 
}
//-------------------------------------------------------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
            switch(obj.id)
            {
                    case "DSO_CONTROL":
                                if(flag=='search')
                                { 
                                    DSO_ATTACH_FILE.Call("SELECT");
                                }
                                else
                                { 
                                    onSearch(1);
                                } 
                    break;  
                    case "DSO_ATTACH_FILE": 
                                        DSO_DETAIL.Call("SELECT");
                    break;  
                    case "DSO_DETAIL":
                                            alert(flag); 
                                            FotmatGrid_Detail(); 
                                            
                    break;   
                    case "dso_get_rate":
                        //    OnChangeCurrent_Req();
                        //    DSO_DETAIL.Call("SELECT");
                    break; 
            } 
}
//-------------------------------------------------------------------------------------------------------------------------------------
function OnToggle()
 {
    var left  = document.all("idLEFT");    
    var right = document.all("idRIGHT");   
    var imgArrow = document.all("imgArrow");       
    if(imgArrow.status == "expand")
    {
        left.style.display="none";       
        imgArrow.status = "collapse";
        right.style.width="100%";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else
    {
        left.style.display="";
        imgArrow.status = "expand";
        right.style.width="70%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 }
//-------------------------------------------------------------------------------------------------------------------------------------
function OnClick()
{ 
      txtPK.SetDataText(Grid_Mst.GetGridData(Grid_Mst.row,0));
     flag='search'; 
      DSO_CONTROL.Call("SELECT");
}
//-------------------------------------------------------------------------------------------------------------------------------------
function OnDelete(obj)
{
        switch(obj)
        {
                case 1:
                        if(txtPK.text != '')
                        { 
                            if(confirm('Do you want to delete selected request no?'))
                            {
                                 flag='delete';
                                 DSO_CONTROL.StatusDelete();
                                 DSO_CONTROL.Call();
                            }
                        }
                        else
                        {
                                    alert('Please select request no!!');
                        }  
                break;
                case 2:
                            if(confirm("Are you sure you want to delete?"))
                            {
                                Grid_Detail.DeleteRow();
                            }
                break;
                case 3:
                             if(Grid_Attach.row)
                             if(confirm('Are you sure you want to delete selected file ?'))
                            {
                                 Grid_Attach.DeleteRow();
                                 DSO_ATTACH_FILE.Call();
                            }
                break;
        } 
     
}
//-------------------------------------------------------------------------------------------------------------------------------------
function OnPopUp(pos)
{
    switch(pos)
    {
        case 'Charger':
                    var path = System.RootURL + '/form/gf/ma/gfma00010_3.aspx';
                    var obj = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes');
                    if ( obj != null )
                    {
                        txtCharger_Cd.text=obj[1]; 
                        txtCharger_Nm.text    = obj[2];
                        txtCharger_Pk.text  = obj[0];
                    }
        break;  
        case 'Department':
                     var path = System.RootURL + '/form/gf/ma/gfma00040_1.aspx?';
                    var obj = System.OpenModal( path ,400 , 600 ,  'resizable:yes;status:yes');
                    if ( obj != null )
                    {
                             if (obj[0] != 0)
                            {
                                //txtDepartment_Pk.text = obj;     // Center PK
                                lstDepartment.SetDataText(obj[0]);
                            }   
                    }
        break;  
        case 'PL_Unit':
                    fpath  = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + '' + "&company=" + lstCompany.GetData() + '&dsqlid=ACNT.SP_SEL_PL_POPUP&col_code=' + "PL CODE" + '&col_nm=' + "PL NAME";
                     oValue = System.OpenModal( fpath , 600 , 400 , 'resizable:yes;status:yes');
                    if ( oValue != null )
                    {
                        txtPL_Unit_Pk.text = oValue[2]; 
                        txtPLUnit_Nm.text   = oValue[1];
                        txtPLUnit_Cd.text   = oValue[0];
                    }
       break;  
       case 'Exp_Acc':
		           var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + '' + "&val2=" + '' + "&val3=" + lstCompany.value+'' + "&dsqlid=ACNT.SP_SEL_ACCD_PL";
	                var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
                    if ((object != null) &&(object[0]!="0"))
                    {
                        txtExpAcc_Pk.SetDataText(object[3]);
                        txtExpAcc_Cd.SetDataText(object[0]);
                        txtExpAcc_Nm.SetDataText(object[1]);
                    }
       break;
       case 'Customer':
                    var path = System.RootURL + '/form/gf/co/ffbp00031.aspx';
		            var object = System.OpenModal( path ,800 , 600 , 'resizable:yes;status:yes');
		            if ( object != null )
		            {
		                if (object[0] != 0)
                        {
                            txtPartner_Cd.SetDataText(object[1]);//customer id
                            txtPartner_Nm.SetDataText(object[2]);//customer name
                            txtPartner_Pk.SetDataText(object[0]);//customer name
      	                }
		             }       
       break;
       case 'Acc_AP':
		        var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + '' + "&val2=" + '' + "&val3=" + lstCompany.value+'' + "&dsqlid=ACNT.SP_SEL_ACCD_PL";
	                var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
                    if ((object != null) &&(object[0]!="0"))
                    {
                        txtAccCodeAP_Pk.SetDataText(object[3]);
                        txtAccCodeAP_Cd.SetDataText(object[0]);
                        txtAccCodeAP_Nm.SetDataText(object[1]);
                    }
       break;
       case 'Approve':
                var path = System.RootURL + '/form/gf/ma/gfma00010_3.aspx';
                var obj = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes');
                if ( obj != null )
                {
                    txtApprBy_Nm.text    = obj[2];
                    txtApprBy_Pk.text  = obj[0];
                    txtApprBy_Cd.text=obj[1];
                }
       break;
       case 'Exp_Acc_Grid':
                    if(event.col == 13)
                    {
                                     var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + '' + "&val2=" + '' + "&val3=" + lstCompany.value+'' + "&dsqlid=ACNT.SP_SEL_ACCD_PL";
	                                var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
                                    if ((object != null) &&(object[0]!="0"))
                                    {
                                        Grid_Detail.SetGridText(Grid_Detail.row, 17, object[3]);
                                        Grid_Detail.SetGridText(Grid_Detail.row, 13, object[0]);
                                        Grid_Detail.SetGridText(Grid_Detail.row, 14, object[1]);
                                    }
                    } 
		           
       break;
       case 'VAT_Acc_Grid':
                    if(event.col == 15)
                    {
                                     var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + '' + "&val2=" + '' + "&val3=" + lstCompany.value+'' + "&dsqlid=ACNT.SP_SEL_ACCD_PL";
	                                var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
                                    if ((object != null) &&(object[0]!="0"))
                                    {
                                        Grid_Detail.SetGridText(Grid_Detail.row, 18, object[3]);
                                        Grid_Detail.SetGridText(Grid_Detail.row, 15, object[0]);
                                        Grid_Detail.SetGridText(Grid_Detail.row, 16, object[1]);
                                    }
                    } 
		           
       break;
       }
 }/**/
//-------------------------------------------------------------------------------------------------------------------------------------
function FotmatGrid_Detail()
{
    var trl;
    trl = Grid_Detail.GetGridControl();	
    trl.ColFormat(4)                  = "###,###,###,###,###";    
    trl.ColFormat(5)              = "###,###,###,###,###";
    trl.ColFormat(7)                  = "###,###,###,###,###";    
    trl.ColFormat(8)              = "###,###,###,###,###";
    trl.ColFormat(9)                  = "###,###,###,###,###";    
    trl.ColFormat(10)              = "###,###,###,###,###";
} 
//-------------------------------------------------------------------------------------------------------------------------------------
function FotmatGrid()
{
    var trl;
    trl = Grid_Mst.GetGridControl();	
    trl.ColFormat(4)                  = "###,###,###,###,###";    
    trl.ColFormat(5)              = "###,###,###,###,###";
    
     var r_save=0, r_App=0, r_return=0,l_status;
            for(i=1;i<Grid_Mst.rows;i++)
            {
                l_status= Grid_Mst.GetGridData(i,6); 
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
            txtSave_Status.text =  r_save + ' record(s)';
            txtAppr_Status.text=  r_App + ' record(s)';
            txtReturn_Status.text=  r_return + ' record(s)';
}
//-------------------------------------------------------------------------------------------------------------------------------------
function chkChange()
{
    if(chkauto_YN.GetData()=="T")
    {
        txtVoucher.SetEnable(false);
        alert('Y'); 
    }
    else
    {
        txtVoucher.SetEnable(true);
       alert('N'); 
    }
}
//-------------------------------------------------------------------------------------------------------------------------------------
function onValidate()
{
     if(chkauto_YN.GetData()=='N' && txtVoucher.GetData()=='')
    {
        alert('Please inputt voucher no first.');
        txtVoucher.GetControl().focus();
        return false;
    }
    else if(txtCharger_Pk.GetData()=='')
    {
        alert('Please select charger first.');
        txtCharger_Cd.GetControl().focus();
        return false;
    }
    else if(txtReqTransAmt.GetData()=='0')
    {
        alert('Please inpput Req. Trans. amt.');
        txtReqTransAmt.GetControl().focus();
        return false;
    }
    else if(txtReqTransAmt.GetData()=='0')
    {
            
    }
    else 
    return true;
}
//-------------------------------------------------------------------------------------------------------------------------------------
function AttachFiles()
    {
            if(txtPK.text != '')
           { 
                    imgFile.MasterPK=txtPK.text;
                    imgFile.ChangeImage();
                                    
                    if( imgFile.oid == 0 )
                    {
                        return false;
                    }
                    else
                    {
                                DSO_ATTACH_FILE.Call();
                    }
                    imgFile.oid= "";     
            } 
        else
        {
                alert('Please select the  master row first!!');
        }     
    }
//-------------------------------------------------------------------------------------------------------------------------------------
function OnChangeCurrent()
{
    dso_get_rate.Call();
}     
//-------------------------------------------------------------------------------------------------------------------------------------
function OnChangeCurrent_Req()
{
    dso_get_rate1.Call();
}     
//-------------------------------------------------------------------------------------------------------------------------------------
function OnOpenFile()
    {
        var img_pk = Grid_Attach.GetGridData(Grid_Attach.GetGridControl().row,0)	;
        var url = System.RootURL + "/system/binary/viewfile.aspx?img_pk=" + img_pk + "&table_name=TAC_RPD_file";	
	    window.open(url);
    }    
//-------------------------------------------------------------------------------------------------------------------------------------
function SumTotal()
{
        var Trans_Amt = Number(txtReqTransAmt.text);
        var VAT_AMT = Number(txtVatTransAmt.text);
       if(lstBooking_Ccy.value == 'VND')
       {
                
       } 
        var Total_Amt = Number(Trans_Amt) + Number(VAT_AMT);
        
        var Book_Amt = Number(txtReqBooksAmt.text);
        var VAT_Book_Amt = Number(txtVatBooksAmt.text);
        
        var Total_Book_Amt = Number(Book_Amt) + Number(VAT_Book_Amt);   
        txtTotalTransAmt.SetDataText( "" + System.Round(Total_Amt,2));
        txtTotalBooksAmt.SetDataText( "" + System.Round(Total_Book_Amt,2)); 
}   
</script>
<body>
  <gw:data id="DSO_ATTACH_FILE" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso id="1" type="grid" parameter="0"  function="acnt.sp_sel_gfrp00010_4"  procedure="acnt.sp_upd_gfrp00010_3">
                <input bind="Grid_Attach" >                            
                    <input bind="txtPK" />   
                </input>
                <output bind="Grid_Attach" />
            </dso>                    
        </xml>
    </gw:data>
 <!----------------------------------------------------------------------------------------------------------------------------------------------------->    
   <gw:data id="DSO_DETAIL" onreceive=""> 
        <xml>
           <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20" function="acnt.sp_sel_gfrp00010_2" procedure="ACNT.sp_upd_gfrp00010_4">
                <input  bind="Grid_Detail">
                    <input bind="txtPK" />
                </input> 
                <output bind="Grid_Detail" /> 
            </dso> 
        </xml> 
    </gw:data>
 <!----------------------------------------------------------------------------------------------------------------------------------------------------->    
    <gw:data id="DSO_SEARCH" onreceive="FotmatGrid()"> 
        <xml>
           <dso id="1" type="grid" function="acnt.sp_sel_gfrp00010" >
                <input  bind="Grid_Mst">
                    <input bind="dtPRDate_fr" />
                    <input bind="dtPRDate_to" />
                    <input bind="txtPR_No" />
                </input> 
                <output bind="Grid_Mst" /> 
            </dso> 
        </xml> 
    </gw:data>
<!----------------------------------------------------------------------------------------------------------------------------------------------------->    
 <gw:data id="DSO_CONTROL" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="3" type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38" function="acnt.sp_sel_gfrp00010_1" procedure="acnt.sp_upd_gfrp00010">
                <input>
                    <inout bind="txtPK" />
                    <inout bind="lstCompany" />
                    <inout bind="dtTransReq_Date" />
                    <inout bind="lstStatus" />
                    <inout bind="lstVoucher_Type" />
                    
                    <inout bind="dtPayReq_Date" />
                    <inout bind="lstOption" />
                    <inout bind="txtVoucher" />
                    <inout bind="chkauto_YN" />
                    <inout bind="lstDepartment" />
                    
                    <inout bind="lstBooking_Ccy" />
                    <inout bind="txtCharger_Pk" />
                    <inout bind="txtCharger_Cd" />
                    <inout bind="txtCharger_Nm" />
                    <inout bind="lstReq_Ccy" />
                    
                    <inout bind="txtPL_Unit_Pk" />
                    <inout bind="txtPLUnit_Cd" />
                    <inout bind="txtPLUnit_Nm" />
                    <inout bind="txtReqTransAmt" />
                    <inout bind="txtReqBooksAmt" />
                    
                    <inout bind="txtExpAcc_Pk" />
                    <inout bind="txtExpAcc_Cd" />
                    <inout bind="txtExpAcc_Nm" />
                    <inout bind="txtVatTransAmt" />
                    <inout bind="txtVatBooksAmt" />
                    
                    <inout bind="txtPartner_Pk" />
                    <inout bind="txtPartner_Cd" />
                    <inout bind="txtPartner_Nm" />
                    <inout bind="txtTotalTransAmt" />
                    <inout bind="txtTotalBooksAmt" />
                    
                    <inout bind="txtAccCodeAP_Pk" />
                    <inout bind="txtAccCodeAP_Cd" />
                    <inout bind="txtAccCodeAP_Nm" />
                    <inout bind="txtDescription" />
                    <inout bind="txtApprBy_Pk" />
                    
                    <inout bind="txtApprBy_Cd" />
                    <inout bind="txtApprBy_Nm" />
                    <inout bind="txtLocal_Description" />
                    <inout bind="txtRemark" />
                 </input>
            </dso>
        </xml>
    </gw:data>
<!----------------------------------------------------------------------------------------------------------------------------------------------------->    
 <gw:data id="dso_get_rate" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_GET_RATE"> 
                <input> 
                     <input bind="dtPayReq_Date"/>
                     <input bind="lstCompany"/>
                     <input bind="lstBooking_Ccy" />
                     <input bind="txt_row"/>
                </input>
                <output>
                     <output bind="txtExRate"/>
                     <output bind="txt_row"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>
<!----------------------------------------------------------------------------------------------------------------------------------------------------->    
 <gw:data id="dso_get_rate1" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_GET_RATE"> 
                <input> 
                     <input bind="dtPayReq_Date"/>
                     <input bind="lstCompany"/>
                     <input bind="lstReq_Ccy" />
                     <input bind="txt_row1"/>
                </input>
                <output>
                     <output bind="txtReqCcy_Rate"/>
                     <output bind="txt_row1"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>    
<!----------------------------------------------------------------------------------------------------------------------------------------------------->    
     <table style="background: #BDE9FF; height: 100%; width: 100%">
        <tr>
            <td style="background: white; width: 30%;" id="idLEFT" valign="top">
                <table style="height: 100%; width: 100%" cellpadding="0" cellspacing="0">
                    <tr style="height:5%;width:100%">
                        <td>
                            <fieldset style="width:100%;padding:0">
                                <table  style="width: 100%">
                                    <tr>
                                        <td align="right" width="15%">PR. Date&nbsp;</td>
                                        <td width="85%" >
                                                    <table cellpadding="0" cellspacing="0" width="100%">
                                                            <tr>
                                                                        <td width="40%"><gw:datebox id="dtPRDate_fr" lang=1  lang="<%=Session("Lang")%>"   /></td>
                                                                        <td width="30%" align="center" >~</td>
                                                                        <td  width="30%" ><gw:datebox id="dtPRDate_to" lang=1  lang="<%=Session("Lang")%>"   /></td>  
                                                                        
                                                            </tr>
                                                    </table>
                                        </td>
                                        <td ><gw:imgbtn id="btnSearch" img="search" alt="Search"  onclick="onSearch(1)" /></td> 
                                    </tr>
                                    <tr>
                                            <td align="right" width="15%">Save. Status&nbsp;</td>
                                            <td width="85%" colspan="2">
                                                    <table cellpadding="0" cellspacing="0" width="100%">
                                                            <tr>
                                                                        <td width="40%" ><gw:textbox id="txtSave_Status"  readonly="true" styles='width:100%;text-align:center;color:Red;font-weight:600' /></td>
                                                                        <td align="right" width="20%">PR. No&nbsp;</td>
                                                                        <td width="40%" colspan="2"><gw:textbox id="txtPR_No" onenterkey="onSearch(1)"  styles="width:100%" /></td>
                                                            </tr>
                                                    </table>
                                            </td>
                                            
                                    </tr> 
                                    <tr>
                                        <td align="right">Appr. Status&nbsp;</td> 
                                         <td colspan="2">
                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                        <tr>
                                                                    <td width="40%"><gw:textbox id="txtAppr_Status" readonly="true" styles='width:100%;text-align:center;color:Red;font-weight:600' /></td>
                                                                    <td width="20%" align="right">Return. Status&nbsp;</td> 
                                                                     <td width="40%"><gw:textbox id="txtReturn_Status" readonly="true" styles='width:100%;text-align:center;color:Red;font-weight:600' /></td> 
                                                                    
                                                        </tr> 
                                                </table> 
                                         </td>
                                         
                                    </tr>
                              
                                 
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr style="height: 95%;width:100%">
                       <td width="100%">
								                    <gw:grid   
													            id="Grid_Mst"  
													            header="_PK|Charger|P. Req. No|P. Req. Date|Trans Amount|Books Amount|_status"   
													            format  ="0|0|0|4|2|2|0"  
													            aligns  ="0|0|0|1|3|3|0"  
													            defaults="||||||"  
													            editcol ="0|0|0|0|0|0|0"  
													            widths  ="0|2000|2000|1200|2000|2000|0"  
													            styles="width:100%; height:100%"   
													            sorting="T"   
													            oncellclick= "OnClick()" /> 
										        </td>
                    </tr>
                </table>
            </td>
            <td style="background: white; width: 70%" id="idRIGHT">
                <table cellpadding="0" cellspacing="0" style="width: 100%;height:100%" border="0">
                   <tr style="width:100%;height:5%" valign="top">
                        <td width="100%">
                             <fieldset>
                                      <table style="width:100%" cellpadding="1" cellspacing="1"  border="0">
                                             <tr>
                                                <td width="15%" align="right">Company&nbsp;</td>
                                                <td width="35%"><gw:list id="lstCompany"  styles='width:100%' /></td>
                                               <td width="15%"></td> 
                                                <td width="15%">
                                                                <table cellpadding="0"  cellspacing="0" width="100%">
                                                                        <tr>
                                                                                <td width="100%"></td>
                                                                                <td ><gw:imgbtn id="btnSave1" img="new" alt="New" onclick="OnNew(1)" /></td>
                                                                                <td ><gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="onSave(1)" /></td>
                                                                                <td ><gw:imgbtn id="btnSave2" img="delete" alt="Delete"  onclick="OnDelete(1)" /></td>
                                                                                 <td ><gw:imgbtn id="btnSve2" img="excel" alt="Print"  onclick="OnPrint()" /></td>
                                                                        </tr>
                                                                </table> 
                                                </td> 
                                                 
                                            </tr>
                                            <tr>
                                                  <td align="right" width="15%">Trans.Date&nbsp;</td>
                                                   <td width="35%">
                                                            <table cellpadding="0" cellspacing="0" width="100%">
                                                                    <tr>
                                                                            <td><gw:datebox id="dtTransReq_Date" lang=1  lang="<%=Session("Lang")%>"   /></td>
                                                                            <td align="right" width="30%">Status&nbsp;</td>
                                                                            <td width="70%"><gw:list id="lstStatus"  styles='width:100%' /></td> 
                                                                    </tr>
                                                            </table>
                                                   </td>
                                                   <td align="right" width="15%">Voucher Type&nbsp;</td>
                                                    <td width="35%" ><gw:list id="lstVoucher_Type"  styles='width:100%' /></td> 
                                            </tr>
                                            <tr>
                                                         <td align="right">Req. Date&nbsp;</td> 
                                                        <td >
                                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                                        <tr>
                                                                                <td><gw:datebox id="dtPayReq_Date" lang=1  lang="<%=Session("Lang")%>"   /></td>
                                                                                <td width="30%" align="right">Option&nbsp;</td>
                                                                                <td width="70%" colspan="3"><gw:list id="lstOption"  styles='width:100%' /></td>
                                                                        </tr>
                                                                </table>
                                                        </td> 
                                                         <td align="right" >Voucher No.&nbsp;</td>
                                                        <td >
                                                        <table cellpadding="0" cellspacing="0" width="100%">
                                                                <tr>
                                                                        <td width="100%"><gw:textbox id="txtVoucher" csstype="mandatory" styles="width:100%" /></td>
                                                                        <td width=""><gw:checkbox id="chkauto_YN" value="T" onclick="chkChange()"/></td> 
                                                                </tr>
                                                        </table> 
                                                </td>
                                            </tr>
                                             <tr>
                                                        <td align="right" ><a title="Click here to select Department" onclick="OnPopUp('Department')" href="#tips" style="text-decoration: none; color:#0000ff">Department&nbsp;</a></td>
                                                        <td ><gw:list id="lstDepartment" styles="width:100%" /></td> 
                                                         <td align="right">Booking Ccy&nbsp;</td>
                                                         <td>
                                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                                            <tr>
                                                                                         <td width="47%"><gw:list id="lstBooking_Ccy" onchange="OnChangeCurrent()"   styles='width:100%' /></td> 
                                                                                         <td width="6%"></td> 
                                                                                         <td width="47%"><gw:textbox id="txtExRate" format="#,###,###,###,###,###,###" type="number"  styles="width:100%" /></td>  
                                                                            </tr>
                                                                </table>
                                                        </td>
                                            </tr>
                                            
                                            <tr>
                                                         <td align="right" ><a title="Click here to select Charger" onclick="OnPopUp('Charger')" href="#tips" style="text-decoration: none; color:#0000ff">Charger&nbsp;</a></td>
                                                        <td>
                                                                    <table cellpadding="0" cellspacing="0" width="100%">
                                                                            <tr>
                                                                                        <td width="40%"><gw:textbox id="txtCharger_Cd" csstype="mandatory" readonly='true'  styles="width:100%" /></td> 
                                                                                        <td width="60%"><gw:textbox id="txtCharger_Nm" csstype="mandatory" readonly='true'   styles="width:100%" /></td> 
                                                                                        <td><gw:textbox id="txtCharger_Pk"  styles="width:100%;display:none" /></td> 
                                                                                        <td ><gw:imgbtn id="btnSve" img="reset" alt="Reset"  onclick="txtCharger_Cd.text='';txtCharger_Nm.text='';txtCharger_Pk.text='';" /></td>
                                                                            </tr>
                                                                    </table>
                                                        </td>
                                                        <td align="right">Req. Ccy&nbsp;</td>
                                                        <td>
                                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                                            <tr>
                                                                                         <td width="47%"><gw:list id="lstReq_Ccy" onchange="OnChangeCurrent_Req()" styles='width:100%' /></td> 
                                                                                         <td width="6%"></td> 
                                                                                         <td width="47%"><gw:textbox id="txtReqCcy_Rate" format="#,###,###,###,###,###,###" type="number" styles="width:100%" /></td>  
                                                                            </tr>
                                                                </table>
                                                        </td>
                                            </tr>
                                            <tr>
                                                        <td align="right"><a title="Click here to select PL Unit" onclick="OnPopUp('PL_Unit')" href="#tips" style="text-decoration: none; color:#0000ff">PL Unit&nbsp;</a></td>
                                                        <td>
                                                                    <table cellpadding="0" cellspacing="0" width="100%">
                                                                            <tr>
                                                                                        <td width="40%"><gw:textbox id="txtPLUnit_Cd"  readonly='true' styles="width:100%" /></td> 
                                                                                        <td width="60%"><gw:textbox id="txtPLUnit_Nm" readonly='true' styles="width:100%" /></td> 
                                                                                        <td><gw:textbox id="txtPL_Unit_Pk"  styles="display:none" /></td> 
                                                                                        <td ><gw:imgbtn id="btnS" img="reset" alt="Reset"  onclick="txtPLUnit_Cd.text='';txtPLUnit_Nm.text='';txtPL_Unit_Pk.text='';" /></td>
                                                                            </tr>
                                                                    </table>
                                                        </td>
                                                       <td align="right"><a title="Request Transaction Amount" ><font color="#000000">Trs.Amt&nbsp;</font></a></td>
                                                        <td>
                                                                    <table cellpadding="0" cellspacing="0" width="100%">
                                                                            <tr>
                                                                                        <td width="35%"><gw:textbox id="txtReqTransAmt" type="number" onenterkey="SumTotal()" onblur="SumTotal()" csstype="mandatory" format="###,###.##" styles="width:100%" /></td> 
                                                                                        <td width="30%" align="right"><a title="Request Book Amount" ><font color="#000000">Book.Amt&nbsp;</font></a></td>
                                                                                        <td width="35%"><gw:textbox id="txtReqBooksAmt" type="number" onenterkey="SumTotal()" onblur="SumTotal()" csstype="mandatory" format="###,###.##" styles="width:100%" /></td> 
                                                                            </tr>
                                                                    </table>
                                                        </td>
                                            </tr>
                                            <tr>
                                                         <td align="right"><a title="Click here to select Expense Account Code" onclick="OnPopUp('Exp_Acc')" href="#tips" style="text-decoration: none; color:#0000ff">Exp Acc.Code&nbsp;</a></td>
                                                        <td>
                                                                    <table cellpadding="0" cellspacing="0" width="100%">
                                                                            <tr>
                                                                                        <td width="40%"><gw:textbox id="txtExpAcc_Cd" readonly='true' styles="width:100%" /></td> 
                                                                                        <td width="60%"><gw:textbox id="txtExpAcc_Nm" readonly='true' styles="width:100%" /></td> 
                                                                                        <td><gw:textbox id="txtExpAcc_Pk"  styles="display:none" /></td> 
                                                                                        <td ><gw:imgbtn id="btSei" img="reset" alt="Reset"  onclick="txtExpAcc_Cd.text='';txtExpAcc_Nm.text='';txtExpAcc_Pk.text='';" /></td>
                                                                            </tr>
                                                                    </table>
                                                        </td>
                                                        <td align="right"><a title="VAT Transaction Amount" ><font color="black">VAT.Trs.Amt&nbsp;</font></a></td>
                                                        <td>
                                                                    <table cellpadding="0" cellspacing="0" width="100%">
                                                                            <tr>
                                                                                        <td width="35%"><gw:textbox id="txtVatTransAmt" type="number" readonly="true" format="###,###.##" styles="width:100%" /></td> 
                                                                                        <td width="30%" align="right"><a title="VAT Book Amount" ><font color="black">VAT.Book.Amt&nbsp;</font></a></td>
                                                                                        <td width="35%"><gw:textbox id="txtVatBooksAmt" type="number" readonly="true" format="###,###.##" styles="width:100%" /></td> 
                                                                            </tr>
                                                                    </table>
                                                        </td>
                                            </tr>
                                            <tr>
                                                        <td align="right"><a title="Click here to select Partner" onclick="OnPopUp('Customer')" href="#tips" style="text-decoration: none; color:#0000ff">Partner&nbsp;</a></td>
                                                        <td>
                                                                    <table cellpadding="0" cellspacing="0" width="100%">
                                                                            <tr>
                                                                                        <td width="40%"><gw:textbox id="txtPartner_Cd" csstype="mandatory" readonly='true' styles="width:100%" /></td> 
                                                                                        <td width="60%"><gw:textbox id="txtPartner_Nm" csstype="mandatory" readonly='true' styles="width:100%" /></td> 
                                                                                        <td><gw:textbox id="txtPartner_Pk"  styles="display:none" /></td> 
                                                                                        <td ><gw:imgbtn id="btSes" img="reset" alt="Reset"  onclick="txtPartner_Cd.text='';txtPartner_Nm.text='';txtPartner_Pk.text='';" /></td>
                                                                            </tr>
                                                                    </table>
                                                        </td>
                                                        <td align="right"><a title="Total Transaction Amount" ><font color="black">Tot.Trs.Amt&nbsp;</font></a></td>
                                                        <td>
                                                                    <table cellpadding="0" cellspacing="0" width="100%">
                                                                            <tr>
                                                                                        <td width="35%"><gw:textbox id="txtTotalTransAmt" type="number" readonly="true" format="###,###.##" styles="width:100%" /></td> 
                                                                                        <td width="30%" align="right"><a title="Total Book Amount" ><font color="black">Tot.Book.Amt&nbsp;</font></a></td>
                                                                                        <td width="35%"><gw:textbox id="txtTotalBooksAmt" readonly="true" type="number" format="###,###.##" styles="width:100%" /></td> 
                                                                            </tr>
                                                                    </table>
                                                        </td>
                                            </tr>
                                            <tr>
                                                        <td align="right"><a title="Click here to select Account code AP" onclick="OnPopUp('Acc_AP')" href="#tips" style="text-decoration: none; color:#0000ff">Acc. Code A/P&nbsp;</a></td>
                                                        <td>
                                                                    <table cellpadding="0" cellspacing="0" width="100%">
                                                                            <tr>
                                                                                        <td width="40%"><gw:textbox id="txtAccCodeAP_Cd" readonly='true' styles="width:100%" /></td> 
                                                                                        <td width="60%"><gw:textbox id="txtAccCodeAP_Nm" readonly='true' styles="width:100%" /></td> 
                                                                                        <td><gw:textbox id="txtAccCodeAP_Pk"  styles="display:none" /></td> 
                                                                                        <td ><gw:imgbtn id="btSesr" img="reset" alt="Reset"  onclick="txtAccCodeAP_Cd.text='';txtAccCodeAP_Nm.text='';txtAccCodeAP_Pk.text='';" /></td>
                                                                            </tr>
                                                                    </table>
                                                        </td>
                                                         <td align="right">Description&nbsp;</td>
                                                        <td ><gw:textbox id="txtDescription"  styles="width:100%" /></td> 
                                            </tr>
                                            <tr>
                                                        <td align="right"><a title="Click here to select Approve By" onclick="OnPopUp('Approve')" href="#tips" style="text-decoration: none; color:#0000ff">Appr. By&nbsp;</a></td>
                                                        <td>
                                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                                            <tr>
                                                                                         <td width="40%"><gw:textbox id="txtApprBy_Cd" csstype="mandatory" readonly='true' styles="width:100%" /></td>  
                                                                                         <td width="60%"><gw:textbox id="txtApprBy_Nm" csstype="mandatory" readonly='true' styles='width:100%' /></td>  
                                                                                         <td width="60%"><gw:textbox id="txtApprBy_Pk"  styles='display:none' /></td> 
                                                                                         <td ><gw:imgbtn id="btSe" img="reset" alt="Reset"  onclick="txtApprBy_Cd.text='';txtApprBy_Nm.text='';txtApprBy_Pk.text='';" /></td> 
                                                                            </tr>
                                                                </table>
                                                        </td>
                                                        <td align="right">Local Description&nbsp;</td>
                                                     <td ><gw:textbox id="txtLocal_Description"  styles="width:100%" /></td> 
                                            </tr>
                                            <tr>
                                                    <td align="right" valign="top">Remark&nbsp;</td>
                                                     <td ><gw:textarea id="txtRemark" styles="width:100%;height:100;"></gw:textarea></td>
                                                     
                                                     <td  style="height:100%" valign="top" colspan="2">
                                                                 <fieldset style="height:100%;padding:0">
                                                                                                    <table cellpadding="0" cellspacing="0" style="width:100%;height:100%">
                                                                                                                <tr style="width:100%;height:5%">
                                                                                                                            <td width="100%"></td>
                                                                                                                            
                                                                                                                            <td ><gw:imgbtn id="btnave" img="attach" alt="Attach file" text="Save" onclick="AttachFiles()" /></td>
                                                                                                                            <td ><gw:imgbtn id="btSave2" img="delete" alt="Delete"  onclick="OnDelete(3)" /></td>
                                                                                                                </tr>
                                                                                                                <tr style="width:100%;height:95%" >
                                                                                                                            <td width="100%" colspan="4">
								                                                                                                <gw:grid   
													                                                                                        id="Grid_Attach"  
													                                                                                        header="_PK|Attachement|Description"   
													                                                                                        format  ="0|0|0"  
													                                                                                        aligns  ="1|0|0"  
													                                                                                        defaults="||"  
													                                                                                        editcol ="0|0|0"  
													                                                                                        widths  ="0|1500|3000"  
													                                                                                        styles="width:100%; height:100%"   
													                                                                                        sorting="T" 
													                                                                                        oncelldblclick="OnOpenFile()"  
													                                                                                         /> 
										                                                                                    </td>
                                                                                                               </tr> 
                                                                                                    </table>
                                                                                            </fieldset>
                                                     </td> 
                                            </tr>
                            </table>
                             </fieldset>
                            
                        </td>
                   </tr>
                    <tr style="width: 100%;height:80%">
                                <td>
                                        <table cellpadding="0" cellspacing="0" style="width:100%;height:100%">
                                                    <tr style="height:5%">
                                                                    <td width="100%"></td> 
                                                                    <td ><gw:imgbtn id="btnSav1" img="new" alt="New" onclick="OnNew(2)" /></td>
                                                                   <td ><gw:imgbtn id="btnSa1" img="save" alt="Save" onclick="onSave(2)" /></td>
                                                                    <td ><gw:imgbtn id="btnSav2" img="delete" alt="Delete"  onclick="OnDelete(2)" /></td>
                                                    </tr>
                                                    <tr style="height:95%">
                                                                    <td width="100%" colspan="4">
                                <!--       0.pk| 1.No| 2.Serial No.| 3.Invoice Date| 4.Invoice No.| 5.Trans Amount| 6.Books Amount| 7.VAT rate(%)| 8.VAT Trans Amt| 9.VAT Books Amt| 10.Total Trans Amt| 11.Total Books Amt| 12.Contract No.| 13.PO No.| 14.Expense Acc. Code| 15.Expense Acc. Name| 16.VAT Acc. Code| 17.VAT Acc. Name| 18.Expense_Acc_pk| 19.VAT_Acc_pk| 20.Master_pk"    -->
			                                <gw:grid   
								            id="Grid_Detail"  
								            header="No|Serial No.|Invoice Date|Invoice No.|Trans Amount|Books Amount|VAT rate(%)|VAT Trans Amt|VAT Books Amt|Total Trans Amt|Total Books Amt|Contract No.|PO No.|Expense Acc. Code|Expense Acc. Name|VAT Acc. Code|VAT Acc. Name|Expense_Acc_pk|VAT_Acc_pk|Master_pk|pk"   
								            format  ="0|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
								            aligns  ="1|0|0|0|3|3|3|3|3|3|3|0|0|0|0|0|0|0|0|0|0"  
								            defaults="||||||||||||||||||||"  
								            editcol ="0|1|1|1|1|1|1|1|1|1|1|1|1|0|0|0|0|1|1|1|0"  
								            widths  ="500|1500|1200|1500|2000|2000|1200|2000|2000|2000|2000|2000|2000|2000|3000|2000|2000|0|0|0|0"  
								            styles="width:100%; height:100%"   
								            sorting="T"   
								           oncelldblclick="OnPopUp('Exp_Acc_Grid');OnPopUp('VAT_Acc_Grid')" /> 
								</td>
                                                    </tr> 
                                        </table>
                                </td> 
                                 
                    </tr>
                </table>
                
                            
            </td>
        </tr>
    </table>
    <!---------------------------------------------------------------------->
    <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
        position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
        
<gw:textbox id="txtPK"  text="" style="display:" />      
 <gw:textbox id="txt_row"        styles='display:none'/> 
 <gw:textbox id="txt_row1"        styles='display:none'/> 
 
  <gw:image id="imgFile"  table_name="TAC_RPD_file" view="/binary/ViewFile.aspx" post="/binary/PostFile.aspx" styles="width:100;height:100;display:none"  />                            
</body>
</html>
