<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser("acnt")%>
<html xmlns="http://www.w3.org/1999/xhtml">

<script>

var vnt_Click = true;
var vnt_RefreshNode = null;
var Insert      = 'F';
var Modify      = 'F';
var Delelete    = 'F';
var FlagNode    = false; // khong chon node
var Temp;

 function BodyInit()
 {    
    OnToggle(1)
    System.Translate(document);
    BindingDataList();
    txt_BUSPARTNER_ID.SetEnable(0); 
    txt_PARTNER_NAME.SetEnable(0);
    txt_TAC_ABPL_P_CD.SetEnable(0);
    
    txtAc_level.text= "<%=session("ACNT_LEVEL")%>";
     txtSesion_company.text = "<%=session("company_pk")%>";
     var _company;
     if(txtAc_level.text=='6')
     {
        _company = "<%=ESysLib.SetListDataSQL("SELECT pk, partner_name FROM comm.tco_company where del_if=0")%>"; 
        lst_TCO_COMPANY_PK.SetDataText(_company);
        //cboOrganization.value= 'ALL';
     }
     else if(txtAc_level.text=='3')
     {
        datCompany.Call();
     }
 }
function BindingDataList()
{ 
    
    var ls_data      = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";    
    //var ls_data1     = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0400','','') FROM DUAL")%>";
    
     
    
    
    
    var ls_data1     = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('CODC0150') FROM DUAL")%>";
  
  
    var ls_data2     = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACCR0140','','') FROM DUAL")%>";
    var ls_data3     = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0110','','') FROM DUAL")%>";
    var ls_data4     = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACCR0110','','') FROM DUAL")%>";
    
    var ls_data6     = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('COAB0080','','') FROM DUAL")%>";
    var ls_data7     = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('COEO0010','','') FROM DUAL")%>";
    var ls_data8     = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0120','','') FROM DUAL")%>";
    var ls_data9     = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0130','','') FROM DUAL")%>";
    var ls_data10    = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0140','','') FROM DUAL")%>";
    var ls_data11    = "<%=ESysLib.SetDataSQL("SELECT TO_CHAR(SYSDATE,'YYYYMMDD') FROM DUAL")%>";
    var ls_data12    = "<%=ESysLib.SetDataSQL("SELECT E.CODE FROM TCO_ABCODE E, TCO_ABCODEGRP F WHERE E.DEL_IF=0 AND F.DEL_IF=0 AND E.TCO_ABCODEGRP_PK=F.PK AND F.ID='ACBG0040' AND E.DEF_YN IN ('Y')")%>";    

	 var data ;
   
   
     lstStatus.SetDataText(data+ "|ALL|Select ALL|N|Inactive|Y|Active");
    
    lst_TCO_COMPANY_PK.SetDataText(ls_data);
    lst_PROJECT_TYPE.SetDataText(ls_data1);    
    lst_PAYMENT_TERMS.SetDataText(ls_data2);
    lst_CONTRACT_CCY.SetDataText(ls_data3);
    lst_BUDGET.SetDataText(ls_data4);     
    lst_NATION.SetDataText(ls_data6);
    lst_COM_GRP.SetDataText(ls_data7);
    lst_PL_GRP1.SetDataText(ls_data8);
    lst_PL_GRP2.SetDataText(ls_data9);
    lst_PL_GRP3.SetDataText(ls_data10);
    txt_Date.SetDataText(ls_data11);    
    txt_Curency_Book.SetDataText(ls_data12);              
    
    OnSearch();    
    
}

function OnTreeClick()
{
	var obj = event.srcElement.GetCurrentNode();
	txt_TAC_ABPL_PK.SetDataText( obj.oid );	
	vnt_Click = true;	
	DSO_Upd_Abpl_UEntry.Call("SELECT");
}
function OnSearch()    
{
    FlagNode = false;
    Temp     = false;
    DSO_Sel_Tree_Abpl.Call("SELECT");
}
function Popup_Cus()
{
    var fpath = System.RootURL + "/form/ag/ga/agga00030_popup.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + '' + "&val2=" + '' ;
	o = System.OpenModal( fpath , 800 , 550 , 'resizable:yes;status:yes');
    if ( o != null )  
    {
        txt_TCO_BUSPARTNER_PK.text = o[0];//cust Pk
        txt_BUSPARTNER_ID.text = o[1];//cust code
        txt_PARTNER_NAME.text  = o[2];//cust name              	 	
    }
}

function OnReset_Cus()
{
    txt_TCO_BUSPARTNER_PK.text ="";//cust Pk
    txt_BUSPARTNER_ID.text = "";//cust code
    txt_PARTNER_NAME.text  = "";//cust name  
}
function OnAdd()
{
    
    if(txt_TAC_ABPL_PK.GetData()=="") txt_Temp_P_PK.SetDataText(0)
    else txt_Temp_P_PK.SetDataText(txt_TAC_ABPL_PK.GetData())
    
    if(txt_PL_CD.GetData()=="") txt_Temp_P_CD.SetDataText(0)
    else txt_Temp_P_CD.SetDataText(txt_PL_CD.GetData())
    
    DSO_Upd_Abpl_UEntry.StatusInsert();
    Insert = "T";
    
    chk_USE_YN.SetDataText("Y")
    txt_TAC_ABPL_P_PK.SetDataText(txt_Temp_P_PK.GetData())
    txt_TAC_ABPL_P_CD.SetDataText(txt_Temp_P_CD.GetData())
    
}

function OnSave()
{    		
    if(CheckEmpty()&& CheckDate())
    {
        if(Insert=="T")    
        {       
            DSO_Pro_Check_Code.Call();
        }
        else
        {
            vnt_Click = false;
            DSO_Upd_Abpl_UEntry.StatusUpdate();
            DSO_Upd_Abpl_UEntry.Call();
        }
    }
}
function OnDelete()
{
  if(confirm("Do you want to delete this cost center ? ")){  
    DSO_Pro_Check_Child.Call();
  }
}

function OnPrint()
{
     if (confirm("Do you want to print Cost Center List?"))
     {
            var url =System.RootURL + '/reports/ag/ga/agga00030_CostCenter_List.aspx?company_pk='+lst_TCO_COMPANY_PK.value;
            System.OpenTargetPage( url , 'newform' );
            return;
     } 
}

function OnPopUp(obj)
{
    switch(obj)
    {
        case 'Bank_Acc_1':
            var fpath   = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + "" + "&val1=" + '' + "&company="+ lst_TCO_COMPANY_PK.value + '&dsqlid=ACNT.SP_SEL_BANK_POPUP&col_code=' + 'Bank Code'  + '&col_nm=' + 'Bank Name';
            var object  =   System.OpenModal(  fpath , 600 , 500 , 'resizable:yes;status:yes'); 
            if (object != null)
            {
                if (object[0] != 0)
                {
                    txt_BankAcc1_Cd.text = object[3];//BANK ID
                    txt_BankAcc1_Nm.text = object[1];//BANK NAME(PARTNER NAME)
                    txt_BankAcc1_Pk.text = object[6];
                }
            }
        break;
        case 'Bank_Acc_2':
            var fpath   = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + "" + "&val1=" + '' + "&company="+ lst_TCO_COMPANY_PK.value + '&dsqlid=ACNT.SP_SEL_BANK_POPUP&col_code=' + 'Bank Code'  + '&col_nm=' + 'Bank Name';
            var object  =   System.OpenModal(  fpath , 600 , 500 , 'resizable:yes;status:yes'); 
            if (object != null)
            {
                if (object[0] != 0)
                {
                    txt_BankAcc2_Cd.text = object[3];//BANK ID
                    txt_BankAcc2_Nm.text = object[1];//BANK NAME(PARTNER NAME)
                    txt_BankAcc2_Pk.text = object[6];
                }
            }
        break;
    }
}
function Popup_Upper()
{
    var fpath = System.RootURL + "/form/ag/ga/agga00030_popup_upper.aspx?company_pk=" + lst_TCO_COMPANY_PK.GetData() + "&plc_pk=" + txt_TAC_ABPL_PK.text;
	o = System.OpenModal( fpath , 800, 550 , 'resizable:yes;status:yes');
    if ( o != null )  
    {
        txt_TAC_ABPL_P_PK.text = o[0]; //upper Pk
        txt_TAC_ABPL_P_CD.text = o[1]; //upper code             	 	
    }    
}
function OnReset_Upper()
{
    txt_TAC_ABPL_P_PK.text =0;  //upper code Pk
    txt_TAC_ABPL_P_CD.text ="";  //upper code
}

function OnGetDate()
{    
    if (dt_CONFIRM_DATE.GetData()=="") 
        dt_CONFIRM_DATE.SetDataText(dt_VALID_FROM.GetData());
}
function OnChangCurrency()
{   
    
    if((lst_TCO_COMPANY_PK.GetData()=="ALL")||(lst_TCO_COMPANY_PK.GetData()==""))
    {
        alert("Please choose name of company! " + '\n' + "Vui lòng chọn tên công ty!");
        return;
    }
    else
    {
        if(dt_CONFIRM_DATE.GetData()!="") txt_Date.text= dt_CONFIRM_DATE.GetData();
        DSO_Pro_Get_Rate.Call();
    }
    
}
function OnChangeNumber(id)
{
    var FormatCurrency = "#,###,###,###,###.##R";
    var Rate=Number(formatNumber(txt_TR_RATE.text,FormatCurrency))
   
    if(txt_Curency_Book.GetData()=="VND")
    {
        switch (id)
        {
            case '0':// Rate            
                var trans=Number(formatNumber(txt_TRAMS_AMT.text,FormatCurrency)) 
                var book=trans*Rate
                txt_BOOK_AMT.SetDataText(''+book);                       
                var trans=Number(formatNumber(txt_BUDGED_TRANS.text,FormatCurrency)) 
                var book=trans*Rate           
                txt_BUDGED_BOOK.SetDataText(''+book);    
                OnChangeBudget();
            break;
                case '1':// amount
                var trans=Number(formatNumber(txt_TRAMS_AMT.text,FormatCurrency)) 
                var book=trans*Rate
                txt_BOOK_AMT.SetDataText(''+book);
                OnChangeBudget() 
            break;           
        }
    }
    else
    {
        switch (id)
        {
            case '0':// Rate            
                var trans=Number(formatNumber(txt_TRAMS_AMT.text,FormatCurrency)) 
                var book=Math.round(100*trans/Rate)/100
                txt_BOOK_AMT.SetDataText(''+book);                       
                var trans=Number(formatNumber(txt_BUDGED_TRANS.text,FormatCurrency)) 
                var book=Math.round(100*trans/Rate)/100        
                txt_BUDGED_BOOK.SetDataText(''+book);    
                OnChangeBudget();
            break;
                case '1':// amount
                var trans=Number(formatNumber(txt_TRAMS_AMT.text,FormatCurrency)) 
                var book=Math.round(100*trans/Rate)/100
                txt_BOOK_AMT.SetDataText(''+book);
                OnChangeBudget() 
            break;           
        }
    }
    
    
}
function OnChangeBudget()
{
    var FormatCurrency = "#,###,###,###,###.##R";    
    var transAmt=Number(formatNumber(txt_TRAMS_AMT.text,FormatCurrency));
    var bookAmt =Number(formatNumber(txt_BOOK_AMT.text,FormatCurrency));
    
    var trans=GetRateVAT(lst_BUDGET.GetData())*transAmt;
    var book=GetRateVAT(lst_BUDGET.GetData())*bookAmt;
        
   
    if(txt_Curency_Book.GetData()=="VND")
    {       
        if(lst_CONTRACT_CCY.GetData()=="VND")
        {
            trans=Math.round(trans);
            book=Math.round(book);
        }
        else
        {
            trans=Math.round(trans);
            book=Math.round(book*100)/100;
        }
    }
    else
    {
        if(lst_CONTRACT_CCY.GetData()=="VND")
        {
            trans=Math.round(trans);
            book=Math.round(book*100)/100;
        }
        else
        {
            trans=Math.round(trans*100)/100;
            book=Math.round(book*100)/100;
        }
    }
    txt_BUDGED_BOOK.SetDataText(''+book);
    txt_BUDGED_TRANS.SetDataText(''+trans);
}
function GetRateVAT(VATtext)
{
    var VAT_RATE
    if (VATtext=='none') 
    {
        VAT_RATE=0;					   
    }
    else
    {
        var r =new String(VATtext)                         
        VAT_RATE=Number(r.substring(0,r.length-1))/100;
    }							
    return VAT_RATE				
}
function CheckEmpty()
{
	if(txt_PL_NM.GetData() == "")
	{
		alert("Please enter name ...");
		return false;
	}
	if(txt_PL_LNM.GetData() == "")
	{
		alert("Please enter local name ...");
		return false;
	}
	if(dt_VALID_FROM.GetData() == "")
	{
		alert("Please enter start date...");
		return false;
	}
	return true;
}
function CheckDate()
{
    var std_dt, etd_dt ;
	std_dt = dt_VALID_FROM.GetData();
	etd_dt = dt_VALID_TO.GetData();
	if (parseInt(etd_dt) < parseInt(std_dt))
	{
		alert("End Date can not less than Start date....");
		return false;
	}
	return true;
}

function CheckCode()
{
    if(txt_CheckCode.text!="")
    { 
        alert("This code already use , please reenter ... " + '\n' + "Mã này đã được dùng, vui lòng nhập lại ...");        
        return;
    }
    else DSO_Pro_Check_Name.Call();
}
function CheckName()
{
    if(txt_CheckName.text!="")
    { 
        alert("This name already use , please reenter ... " + '\n' + "Tên này đã được dùng, vui lòng nhập lại ...");
        return;
    }
    else
    {
        vnt_Click = false;
        DSO_Upd_Abpl_UEntry.Call();
    }
   
}
function CheckChild()
{
    if(Number(txt_CheckChild.text)>0)
    { 
        alert("This node has child , please delete child ... " + '\n' + "Nút này có nút con , xóa nút con trước ...");
        return;
    }
    else
    {
        vnt_Click = false;
        Insert = 'T';  //de goi lai cay
        DSO_Upd_Abpl_UEntry.StatusDelete();
        DSO_Upd_Abpl_UEntry.Call();
    }
   
}

function Numbers(e)
{
     
    var keynum;
    var keychar;
    var numcheck;
    keynum =event.keyCode;
  
    if(window.event) // IE
     {
     	keynum = e.keyCode;
     }
    else if(e.which) // Netscape/Firefox/Opera
    {
    	keynum = e.which;
    }
    keychar = String.fromCharCode(keynum);
    numcheck = /\d/;
    return numcheck.test(keychar);
}

function OnDataReceive(p_oData)
{       
    if(p_oData.id == "DSO_Sel_Tree_Abpl")
    {
        if(Insert == 'F') OnChangeCompany();
    }
    if(p_oData.id == "DSO_Upd_Abpl_UEntry") 
    {                  
        if (vnt_Click==false) // save,insert,delete        
        {            
            if(Insert=='F') DSO_Upd_Abpl_UEntry.Call("SELECT"); 
            else
            {
                Insert = 'F';                
            } 
            vnt_Click = true;
            OnSearch();
        } 
                
    }   
    if(p_oData.id == "DSO_Pro_Check_Code")
    {
        CheckCode()
    }
    if(p_oData.id == "DSO_Pro_Check_Name")
    {
        CheckName()
    }
    if(p_oData.id == "DSO_Pro_Check_Child")
    {
        CheckChild()
    }
    if(p_oData.id == "DSO_Pro_Get_Rate")
    {        
        txt_TR_RATE.SetDataText(txt_Rate.text);        
        txt_Rate.text="";        
        if(dt_CONFIRM_DATE.GetData()!="") txt_Date.text= dt_CONFIRM_DATE.GetData();        
        DSO_Pro_Get_Rate_Book.Call();
    }
    if(p_oData.id == "DSO_Pro_Get_Rate_Book")
    {        
        txt_BK_RATE.SetDataText(txt_Rate.text);
        OnChangeNumber('0');
    }
    if(p_oData.id == "DSO_List_Dept")
    {   
        lst_TCO_DEPT_PK.SetDataText(txt_Temp_Dept_PK.text);
    }
    
}
function OnChangeCompany()
{
    DSO_List_Dept.Call("SELECT");
}

function OnToggle(obj)
{
    if (obj==1) //master
    {
        if(imgMaster.status == "expand")
        {           
            idTab_Child.style.display="none";
            imgMaster.status = "collapse";
            imgMaster.src = "../../../system/images/down_orange.gif";
        }
        else
        {
            idTab_Child.style.display="";
            imgMaster.status = "expand";
            imgMaster.src = "../../../system/images/up_orange.gif";
        }
    }
} 

</script>

<body bottommargin="0" topmargin="0" leftmargin="0" rightmargin="0" marginwidth="0">
    <gw:data id="DSO_Sel_Tree_Abpl" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="tree" parameter="0,1,2" function="acnt.SP_SEL_ABPL_TREE">
                <input bind="oTreePLU" >
                    <input bind="lst_TCO_COMPANY_PK"/>
                    <input bind="txt_SPL_CD"/>
                    <input bind="txt_SPL_NM"/>
					<input bind="lstStatus"/>
                </input>
                <output bind="oTreePLU" />
            </dso>
        </xml>
</gw:data>
    <gw:data id="DSO_Pro_Check_Code" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_ABPL_CHECK_CODE" > 
                <input> 
                     <input bind="lst_TCO_COMPANY_PK"/>
                     <input bind="txt_PL_CD"/>
                </input>  
                <output>  
                     <output bind="txt_CheckCode"/>
               </output> 
            </dso> 
        </xml> 
</gw:data>
    <gw:data id="DSO_Pro_Check_Name" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_ABPL_CHECK_NAME" > 
                <input> 
                     <input bind="lst_TCO_COMPANY_PK"/>
                     <input bind="txt_PL_NM"/>
                </input>  
                <output>  
                     <output bind="txt_CheckName"/>
               </output> 
            </dso> 
        </xml> 
</gw:data>
    <gw:data id="DSO_Pro_Check_Child" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_ABPL_CHECK_CHILD" > 
                <input> 
                     <input bind="lst_TCO_COMPANY_PK"/>
                     <input bind="txt_TAC_ABPL_PK"/>
                </input>  
                <output>  
                     <output bind="txt_CheckChild"/>
               </output> 
            </dso> 
        </xml> 
</gw:data>
    <gw:data id="DSO_Pro_Get_Rate" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_GET_RATE" > 
                <input> 
                     <input bind="txt_Date"/>
                     <input bind="lst_TCO_COMPANY_PK"/>
                     <input bind="lst_CONTRACT_CCY" />
                     <input bind="txt_Row"/>
                </input>  
                <output>  
                     <output bind="txt_Rate"/>
                     <output bind="txt_Row"/>
               </output> 
            </dso> 
        </xml> 
</gw:data>
    <gw:data id="DSO_Pro_Get_Rate_Book" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_GET_RATE" > 
                <input> 
                     <input bind="txt_Date"/>
                     <input bind="lst_TCO_COMPANY_PK"/>
                     <input bind="txt_Curency_Book" />
                     <input bind="txt_Row"/>
                </input>  
                <output>  
                     <output bind="txt_Rate"/>
                     <output bind="txt_Row"/>
               </output> 
            </dso> 
        </xml> 
</gw:data>
    <gw:data id="DSO_List_Dept" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="list" procedure="ACNT.SP_LIST_DEPT " > 
            <input> 
                <input bind="lst_TCO_COMPANY_PK" />
            </input>
	       <output>
	            <output bind="txt_Temp_Dept_PK"/> 
	       </output>
        </dso> 
    </xml> 
</gw:data>

<gw:data id="datCompany" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="acnt.sp_lst_get_company"  > 
                <input>
                    <input bind="txtSesion_company" />
                </input> 
                <output>
                    <output bind="lst_TCO_COMPANY_PK" />
                </output>
            </dso> 
        </xml> 
</gw:data>
    <gw:data id="DSO_Upd_Abpl_UEntry" onreceive="OnDataReceive(this)" >
    <xml> 
        <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55" function="acnt.SP_SEL_ABPL_UENTRY" procedure = "acnt.SP_UDP_ABPL_UENTRY">
          <inout> 
            <inout bind="txt_TAC_ABPL_PK"/>
            <inout bind="txt_TAC_ABPL_P_PK"/>
            <inout bind="txt_TAC_ABPL_P_CD"/>
            <inout bind="lst_TCO_COMPANY_PK"/>
            <inout bind="txt_TCO_BUSPARTNER_PK"/>
            
            <inout bind="txt_PL_CD"/> 
            <inout bind="chk_USE_YN"/> 
            <inout bind="txt_PL_NM"/> 
            <inout bind="txt_PL_LNM"/> 
            <inout bind="txt_PL_FNM"/> 
            
            <inout bind="dt_VALID_FROM"/> 
            <inout bind="dt_VALID_TO"/> 
            <inout bind="dt_CONFIRM_DATE"/>
            <inout bind="txt_REMARK"/>
            <inout bind="txt_BUSPARTNER_ID"/>
            
            <inout bind="txt_PARTNER_NAME"/>
            <inout bind="lst_PROJECT_TYPE"/>
            <inout bind="txt_CONTRACT_AMT"/>
            <inout bind="txt_CONTRACT_AMT2"/>
            <inout bind="lst_TCO_DEPT_PK"/>            
            
            <inout bind="txt_FORECAST_TOTAL"/>
            <inout bind="txt_FORECAST2_TOTAL"/>
            <inout bind="lst_CONTRACT_CCY"/>
            <inout bind="txt_TR_RATE"/>
            <inout bind="txt_BK_RATE"/>
            
            <inout bind="lst_PAYMENT_TERMS"/>
            <inout bind="txt_TRAMS_AMT"/>
            <inout bind="txt_BOOK_AMT"/>
            <inout bind="lst_BUDGET"/>
            <inout bind="txt_BUDGED_TRANS"/>
            
            <inout bind="txt_BUDGED_BOOK"/>
            <inout bind="lst_NATION"/>
            <inout bind="lst_COM_GRP"/>
            <inout bind="lst_PL_GRP1"/>
            <inout bind="lst_PL_GRP2"/>
            
            <inout bind="lst_PL_GRP3"/>
            <inout bind="chk_PERFORMANCE_YN"/>
            <inout bind="txt_PERFORMANCE_AMT"/>
            <inout bind="dt_PERFORMANCE_FROM"/>
            <inout bind="dt_PERFORMANCE_TO"/>
            
            <inout bind="chk_ADVANCE_YN"/>
            <inout bind="txt_ADVANCE_AMT"/>
            <inout bind="dt_ADVANCE_FROM"/>
            <inout bind="dt_ADVANCE_TO"/>
            <inout bind="chk_WARRANTY_YN"/>
            
            <inout bind="txt_WARRANTY_AMT"/>
            <inout bind="dt_WARRANTY_FROM"/>
            <inout bind="dt_WARRANTY_TO"/>
            <inout bind="chkLeafYN"/>
            <inout bind="txtTURNOVER_YN"/>

            <inout bind="txt_BankAcc1_Pk"/>
            <inout bind="txt_BankAcc1_Cd"/>
            <inout bind="txt_BankAcc1_Nm"/>
            <inout bind="txt_BankAcc2_Pk"/>
            <inout bind="txt_BankAcc2_Cd"/>

            <inout bind="txt_BankAcc2_Nm"/>
          </inout>
        </dso> 
    </xml> 
</gw:data>
    <!------------------------ Main Table -------------------------->
    <table align="top" cellpadding="0" cellspacing="0" border="1" style="width: 100%;
        height: 100%; border-color: #6B9EB8">
        <tr valign="top">
            <td style="width: 25%" align="top">
                <table width="100%" align="top" cellspacing=0 cellpadding=0 >
                    <tr>
                        <td width="35%">
                            Company</td>
                        <td width="65%" colspan=2 align="left" valign="top"><gw:list id="lst_TCO_COMPANY_PK" value="" styles="width:100%" onchange="OnSearch()" /></td>
                      
                    </tr>
                    <tr>
                        <td width="35%">Center Code</td>
                        <td width="65%" colspan=2  align="left" valign="top">
                            <gw:textbox id="txt_SPL_CD" text="" styles="width:100%" csstype="mandatory" onenterkey="OnSearch()" />
                        </td>
                       
                    </tr>
                    <tr>
                        <td width="35%">Center Name</td>
                        <td width="65%" colspan=2  align="left" valign="top">
                            <gw:textbox id="txt_SPL_NM" text="" styles="width:100%" csstype="mandatory" />
                        </td>
                      
                    </tr>
					 <tr>
                        <td width="35%">Status</td>
                        <td width="60%" align="left" valign="top">
                            <gw:list id="lstStatus" text="" styles="width:100%" csstype="mandatory" />
                        </td>
                        <td width="5%">
                            <gw:imgbtn img="search" alt="Search" id="idBtnSearch" styles="width:100%" onclick="OnSearch()" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <gw:tree id="oTreePLU" style="width: 100%; height: 400; overflow: auto;" onclicknode="OnTreeClick()"></gw:tree>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 75%" align="top">
                <table width="100%" align="top" border="0">
                    <tr>
                        <td>
                            <table width="100%" align="top" border="0">
                                <tr>
                                    <td width="15%" >
                                        Upper Cost Center Code</td>
                                    <td width="15%">
                                        <gw:textbox id="txt_TAC_ABPL_P_CD" text="" styles="width:100%" csstype="mandatory" />
                                    </td>
                                    <td width="4%">
                                        <gw:imgbtn id="btn_Pop" img="popup" alt="List Upper Code" onclick="Popup_Upper()" />
                                    </td>
                                    <td width="4%">
                                        <gw:imgbtn id="btn_Reset" img="reset" alt="Reset Upper Code" onclick="OnReset_Upper()" />
                                    </td>
                                    <td width="46%">
                                    </td>
                                    <td width="4%" >
                                        <gw:imgbtn img="new" alt="New" id="idBtnAdd" styles="width:100%" onclick="OnAdd()" />
                                    </td>
                                    <td width="4%" >
                                        <gw:imgbtn img="save" alt="Save" id="idBtnUpdate" styles="width:100%" onclick="OnSave()" />
                                    </td>
                                    <td width="4%" >
                                        <gw:imgbtn img="delete" alt="Delete" id="idBtnDelete" styles="width:100%" onclick="OnDelete()" />
                                    </td>
                                    <td width="4%" >
                                        <gw:imgbtn img="printer" alt="Report" id="idBtnPrinter" styles="width:100%" onclick="OnPrint()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table width="100%" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="15%" >
                                        Cost Center Code</td>
                                    <td width="15%">
                                        <gw:textbox id="txt_PL_CD" text="" styles="width:100%" csstype="mandatory" />
                                    </td>
                                    <td width="5%" >
                                        Active</td>
                                    <td width="5%" >
                                        <gw:checkbox id="chk_USE_YN" value="Y" defaultvalue="Y|N" onclick="" />
                                    </td>
                                    <td width="5%" >
                                        Leaf YN</td>
                                    <td width="5%" >
                                        <gw:checkbox id="chkLeafYN" value="Y" defaultvalue="Y|N" onclick="" />
                                    </td>
                                    <td width="50%" >
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table width="100%" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="15%">
                                        Cost Center Name</td>
                                    <td width="85%">
                                        <gw:textbox id="txt_PL_NM" text="" styles="width:100%" csstype="mandatory" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table width="100%" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="15%">
                                        Cost Center LName</td>
                                    <td width="85%">
                                        <gw:textbox id="txt_PL_LNM" text="" styles="width:100%" csstype="mandatory" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table width="100%" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="15%">
                                        Cost Center KName</td>
                                    <td width="85%">
                                        <gw:textbox id="txt_PL_FNM" text="" styles="width:100%" csstype="mandatory" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table width="100%" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="15%">
                                        Working Period</td>
                                    <td width="10%">
                                        <gw:datebox id="dt_VALID_FROM" lang="<%=session("lang")%>" onclick="OnGetDate()" />
                                    </td>
                                    <td width="2%" align="center">
                                        <b>~</b></td>
                                    <td width="10%">
                                        <gw:datebox id="dt_VALID_TO" lang="<%=session("lang")%>" nullaccept />
                                    </td>
                                    <td width="15%">
                                        Confirm Date</td>
                                    <td width="10%">
                                        <gw:datebox id="dt_CONFIRM_DATE" lang="<%=session("lang")%>" />
                                    </td>
                                    <td width="38%">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table width="100%" cellspacing="0" cellpadding="0" >
                                <tr>
                                    <td width="15%">
                                        Description</td>
                                    <td width="85%">
                                        <gw:textbox id="txt_REMARK" text="" styles="width:100%" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <table width="100%" align="top" border="0">
                    <td width="100%">
                        <gw:tab id="idTab_Child" onclick="">							        
                    <table name="Tab 1"  align ="top"  cellspacing=0 cellpadding=0 border=1 style="width:100%;height:145;" >
                        <tr valign="top">
	                        <td>
	                            <table width="100%" cellpadding = "0" cellspacing = "0" border = "0" >
	                                <tr>
                                        <td width="25%" align="right">Customer</td>
                                        <td width="20%"><gw:textbox id="txt_BUSPARTNER_ID"  text=""  styles="width:100%" /></td>
                                        <td colspan="2" ><gw:textbox id="txt_PARTNER_NAME"  text=""  styles="width:100%" /></td>
                                        <td ><gw:imgBtn id="btn_Cus"     img="popup"     alt="List Customer"  onclick="Popup_Cus()" /></td>
                                        <td ><gw:imgBtn id="btn_Reset"   img="reset"     alt="Reset Customer" onclick="OnReset_Cus()" /></td>
                                        <td width="4%"></td>
                                        <td width="25%" align="left"></td>
                                    </tr>
                                    <tr>
                                        <td width="25%" align="right"><a title="Click here to show Bank Account No" href="#" style="text-decoration: none" onClick="OnPopUp('Bank_Acc_1')">Bank Account No</a></td>
                                        <td width="20%"><gw:textbox id="txt_BankAcc1_Cd"  text=""  styles="width:100%" /></td>
                                        <td colspan="2" ><gw:textbox id="txt_BankAcc1_Nm"  text=""  styles="width:100%" /></td>
                                        <td ><gw:imgBtn id="btn_Reset"   img="reset"     alt="Reset" onclick="txt_BankAcc1_Cd.text='';txt_BankAcc1_Nm.text='';txt_BankAcc1_Pk.text='';" /></td>
                                        <td width=""><gw:textbox id="txt_BankAcc1_Pk"  text=""  styles="width:100%;display:none" /></td>
                                        
                                        <td width="4%"></td>
                                        <td width="25%" align="left"></td>
                                    </tr>
                                    <tr>
                                        <td width="25%" align="right"><a title="Click here to show Bank Account No" href="#" style="text-decoration: none" onClick="OnPopUp('Bank_Acc_2')">Bank Account No</a></td>
                                        <td width="20%"><gw:textbox id="txt_BankAcc2_Cd"  text=""  styles="width:100%" /></td>
                                        <td colspan="2" ><gw:textbox id="txt_BankAcc2_Nm"  text=""  styles="width:100%" /></td>
                                        <td ><gw:imgBtn id="btn_Reset1"   img="reset"     alt="Reset Customer" onclick="txt_BankAcc2_Cd.text='';txt_BankAcc2_Nm.text='';txt_BankAcc2_Pk.text='';" /></td>
                                        <td width=""><gw:textbox id="txt_BankAcc2_Pk"  text=""  styles="width:100%;display:none" /></td>
                                        
                                        <td width="4%"></td>
                                        <td width="25%" align="left"></td>
                                    </tr>
                                    <tr>
                                        <td width="25%"align="right">Project Type</td>
                                        <td width="20%"><gw:list id="lst_PROJECT_TYPE" value="" styles="width:100%" onchange="" ></gw:list></td>
                                        <td width="15%"align="right">Contract Amount</td>
                                        <td width="20%"align="left"><gw:textbox id="txt_CONTRACT_AMT" styles="width:100%" type="number" format="#,###,###,###,###.##R"/></td>
                                        <td width="2%"></td>
                                        <td width="2%"></td>
                                        <td width="4%"></td>
                                        <td width="25%"align="left"><gw:textbox id="txt_CONTRACT_AMT2" styles="width:100%" type="number" format="#,###,###,###,###.##R" /></td>
                                    </tr>
                                    <tr>
                                        <td align="right">Department</td>
                                        <td ><gw:list id="lst_TCO_DEPT_PK" value="" styles="width:100%" onchange="" ></gw:list></td>
                                        <td align="right">Budget Cost</td>
                                        <td align="left"><gw:textbox id="txt_FORECAST_TOTAL" styles="width:100%" type="number" format="#,###,###,###,###.##R"/></td>
                                        <td width="2%"></td>
                                        <td width="2%"></td>
                                        <td width="4%"></td>
                                        <td align="left"><gw:textbox id="txt_FORECAST2_TOTAL" styles="width:100%" type="number" format="#,###,###,###,###.##R" /></td>
                                    </tr>
                                    <tr>
                                        <td align="right">Currency</td>
                                        <td ><gw:list id="lst_CONTRACT_CCY" value="" styles="width:100%" onchange="OnChangCurrency()" ></gw:list></td>
                                        <td align="right">Trans Rate</td>
                                        <td align="left"><gw:textbox id="txt_TR_RATE" styles="width:100%" type="number" format="#,###,###,###,###.##R" onenterkey="OnChangeNumber('0')" onchange="OnChangeNumber('0')" /></td>
                                        <td colspan=3 align="center"><font color="black" ><b>:</b></font></td>
                                        <td ><gw:textbox id="txt_BK_RATE" styles="width:100%" type="number" format="#,###,###,###,###.##R"/></td>
                                    </tr>
                                    <tr>
                                        <td align="right">Payment Terms</td>                
                                        <td ><gw:list id="lst_PAYMENT_TERMS" value="" styles="width:100%" onchange="" ></gw:list></td>	            
                                        <td align="right">Trans Amt</td>
                                        <td ><gw:textbox id="txt_TRAMS_AMT" styles="width:100%" type="number" format="#,###,###,###,###.##R" onenterkey="OnChangeNumber('1')" onchange="OnChangeNumber('1')" /></td>
                                        <td colspan=3 align="right">Book Amt</td>
                                        <td ><gw:textbox id="txt_BOOK_AMT" styles="width:100%" type="number" format="#,###,###,###,###.##R" /></td>
                                    </tr>
                                             
                                    <tr>
                                        <td align="right">Budget Cost (Ratio)</td>                
                                        <td ><gw:list id="lst_BUDGET" value="" styles="width:100%" onchange="OnChangeBudget()" ></gw:list></td>	            
                                        <td align="right">Trans Amt</td>
                                        <td ><gw:textbox id="txt_BUDGED_TRANS"  styles="width:100%" type="number" format="#,###,###,###,###.##R"/></td>                                        
                                        <td colspan=3 align="right">Books Amt</td>
                                        <td ><gw:textbox id="txt_BUDGED_BOOK" styles="width:100%" type="number" format="#,###,###,###,###.##R" /></td>
                                    </tr>
	                            </table>	                            
                            </td>
                        </tr>
                    </table>
                    <table name="Tab 2"  align ="top"  cellspacing=0 cellpadding=0 border=1 style="width:100%;height:145;" >
                        <tr valign="top">
	                        <td>
	                            <table width="100%" cellpadding = "0" cellspacing = "0" border = "0" >	                                
                                    <tr>
                                        <td colspan=6><b>&nbsp; </b></td>
                                    </tr>
                                    <tr>
                                        <td colspan=6><b>&nbsp; </b></td>
                                    </tr>
                                     <tr>
                                        <td width="20%" align="right">Nation</td>                
                                        <td width="15%"><gw:list id="lst_NATION" value="" styles="width:100%" onchange="" ></gw:list></td>
                                        <td width="15%"align="right">Company Group</td>
                                        <td width="15%"><gw:list id="lst_COM_GRP" value="" styles="width:100%" onchange="" ></gw:list></td>
                                        <td width="15%"><font color="black" ><b>&nbsp;</b></font></td>
                                        <td width="15%"><font color="black" ><b>&nbsp;</b></font></td>
                                    </tr>
                                    <tr>
                                        <td align="right">Profit Loss Group 1</td>                
                                        <td ><gw:list id="lst_PL_GRP1" value="" styles="width:100%" onchange="" ></gw:list></td>
                                        <td align="right">Profit Loss Group 2</td>
                                        <td ><gw:list id="lst_PL_GRP2" value="" styles="width:100%" onchange="" ></gw:list></td>
                                        <td align="right">Profit Loss Group 3</td>
                                        <td ><gw:list id="lst_PL_GRP3" value="" styles="width:100%" onchange="" ></gw:list></td>
                                    </tr>
	                            </table>	                            
                            </td>
                        </tr>
                    </table>
                    <table name="Tab Bond"  align ="top"  cellspacing=0 cellpadding=0 border=1 style="width:100%;height:145;" >
                        <tr valign="top">
	                        <td>
	                            <table width="100%" cellpadding = "0" cellspacing = "0" border = "0" >	                                       
                                    <tr>
                                        <td colspan=8><b>&nbsp; </b></td>
                                    </tr>
                                    <tr>
                                        <td colspan=8><b>&nbsp; </b></td>
                                    </tr>
                                    <tr>
                                        <td width="10%" align="right">Performance</td>
                                        <td width="5%"><gw:checkbox id="chk_PERFORMANCE_YN"  value="Y" defaultvalue="Y|N" onclick=""/> </td>
	                                    <td width="10%"align="right">Amount</td>
	                                    <td width="10%"><gw:textbox id="txt_PERFORMANCE_AMT" styles="width:100%" type="number" format="#,###,###,###,###.##R"/></td>
                                        <td width="10%"align="right">Period</td>
                                        <td width="10%"><gw:datebox id="dt_PERFORMANCE_FROM" lang="<%=session("lang")%>" nullaccept/></td>
                                        <td width="2%"><b>~</b></td>
                                        <td width="10%"align="center"><gw:datebox id="dt_PERFORMANCE_TO" lang="<%=session("lang")%>" nullaccept/></td>
                                    </tr>
                                    
                                    <tr>
                                        <td align="right">Advance</td>
                                        <td ><gw:checkbox id="chk_ADVANCE_YN"  value="Y" defaultvalue="Y|N" onclick=""/> </td>
	                                    <td align="right">Amount</td>	            
	                                    <td ><gw:textbox id="txt_ADVANCE_AMT"  styles="width:100%" type="number" format="#,###,###,###,###.##R" /></td>
                                        <td align="right">Period</td>
                                        <td ><gw:datebox id="dt_ADVANCE_FROM" lang="<%=session("lang")%>" nullaccept/></td>
                                        <td ><b>~</b></td>
                                        <td align="center"><gw:datebox id="dt_ADVANCE_TO" lang="<%=session("lang")%>" nullaccept/></td>
                                    </tr>                                    
                                    <tr>
                                        <td align="right">Warranty</td>
                                        <td ><gw:checkbox id="chk_WARRANTY_YN"  value="Y" defaultvalue="Y|N" onclick=""/> </td>
	                                    <td align="right">Amount</td>	            
	                                    <td ><gw:textbox id="txt_WARRANTY_AMT" styles="width:100%" type="number" format="#,###,###,###,###.##R"/></td>
                                        <td align="right">Period</td>
                                        <td ><gw:datebox id="dt_WARRANTY_FROM" lang="<%=session("lang")%>" nullaccept/></td>
                                        <td align="left"><b>~</b></td>
                                        <td align="center"><gw:datebox id="dt_WARRANTY_TO" lang="<%=session("lang")%>" nullaccept/></td>
                                    </tr>  
	                            </table>	                            
                            </td>
                        </tr>
                    </table>
                </gw:tab>
                    </td>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txt_TAC_ABPL_PK" style="display: none" />
    <gw:textbox id="txt_TAC_ABPL_P_PK" style="display: none" />
    <gw:textbox id="txt_TCO_BUSPARTNER_PK" style="display: none" />
    <gw:textbox id="txt_CheckCode" style="display: none" />
    <gw:textbox id="txt_CheckName" style="display: none" />
    <gw:textbox id="txt_CheckChild" style="display: none" />
    <gw:textbox id="txt_Temp_P_PK" style="display: none" />
    <gw:textbox id="txt_Temp_P_CD" style="display: none" />
    <gw:textbox id="txt_Date" style="display: none" />
    <gw:textbox id="txt_Rate" style="display: none" />
    <gw:textbox id="txt_Row" style="display: none" />
    <gw:textbox id="txt_Curency_Book" style="display: none" />
    <gw:textbox id="txt_TCO_DEPT_PK" style="display: none" />
    <gw:textbox id="txt_Temp_Dept" style="display: none" />
    <gw:textbox id="txt_Temp_Dept_PK" style="display: none" />
    <gw:textbox id="txtTURNOVER_YN" style="display: none" />
    <gw:textbox id="txtAc_level"  styles='display:none' />
         <gw:textbox id="txtSesion_company" styles='display:none' />
</body>
<img status="expand" id="imgMaster" src="../../../system/images/up_orange.gif"
    style="cursor: hand; position: absolute; left: 243; top: 190;" onclick="OnToggle(1)" />
</html>
