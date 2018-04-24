<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%  ESysLib.SetUser("imex")%>
<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<script>
var iPK                  =	1
    ,iPartner            =  2
    ,iPL_Code            =	3
    ,iContract_Date      =  4
    ,iContract_No        =	5
    ,iContract_Amount    =  6
    ,iPartner_Code       =  7
    ,iPL                 =  8
    ,iCompany            =	9
    ,iIssued_Date        =  10
    ,iEmp_PK             =	11
    ,iEmp_ID             =  12
    ,iEmp_Full_Nm        =  13
    ,iBooking_Ccy        =  14
    ,iB_EX_RATE          =  15
    ,iTO_TR_AMT          =	16
    ,iTO_B_AMT           =  17
    ,iAR_TR_AMT          =	18
    ,iAR_B_AMT           =	19
    ,iADV_TR_AMT         =  20
    ,iADV_B_AMT          =	21
    ,iCOL_TR_AMT         =	22
    ,iCOL_B_AMT		     =  23

function BodyInit()
{
    SetFormatCol();
}

function SetFormatCol()
{
    grdContract
    var ctrl1 = grdContract.GetGridControl();
    ctrl1.ColFormat(6) = "###,###R";  
    txtPartner.SetEnable(0);
    txtPL.SetEnable(0);     
    txtPartnerID.SetEnable(0);
    txtPartnerNm.SetEnable(0);
    
    txtPL_Code.SetEnable(0);
    txtPL_Nm.SetEnable(0);
    
    txtCharger_Code.SetEnable(0);
    txtChargerNm.SetEnable(0);
    var data = "<%=ESysLib.SetListDataSQL("select a.CODE,  a.CODE from TCO_ABCODE a, TCO_ABCODEGRP b where TCO_ABCODEGRP_PK=b.pk and b.id='ACAB0110' and a.use_if=1 and a.del_if=0 and b.del_if=0 order by a.CODE")%>"; 
    lstBookingCcy.SetDataText(data);
    var data2="<%=ESysLib.SetListDataSQL("select code, code_nm from tac_commcode_detail where del_if = 0 and tac_commcode_master_pk = 101 and def_yn='Y'")%>"; 
    lstBookingCcy_Tmp.SetDataText(data2);
    lstBookingCcy.value=lstBookingCcy_Tmp.value;      
    getExRate();
    var sContractDt_Fr,sContractDt; 
    sContractDt=dtContractDt_To.value
    sContractDt_Fr=sContractDt.substr(0,6)+'01';    
    dtContractDt_Fr.SetDataText(sContractDt_Fr);
    lstCompany.SetEnable(0);
    dtContract.SetEnable(0);
    txtContractNo_D.SetEnable(0); 
    dtContract.SetEnable(0);    
    lstBookingCcy.SetEnable(0); 
   
}
function OnShowPopup(index)
{
    switch (index)
    {
        case 0:
            var fpath = System.RootURL + "/form/fp/ab/PopUpGetPartner.aspx?partner_type=AR"; //customs
                aValue = System.OpenModal( fpath , 900 , 500, 'resizable:yes;status:yes');
	            if ( aValue != null )
	            {          
	                txtPartner.SetDataText(aValue[2]); 	               
	                txtPartner_PK.SetDataText(aValue[0]);                   
	            }	
                break;
        case 1:
            fpath  = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + '' + "&company=" + lstCompany.GetData() + '&dsqlid=ACNT.SP_SEL_PL_POPUP&col_code=' + "PL CODE" + '&col_nm=' + "PL NAME";
                oValue = System.OpenModal( fpath , 600 , 400 , 'resizable:yes;status:yes');
                
                if ( oValue != null )
                {
                    txtPL_PK.text = oValue[2]; 
                    txtPL.text   = oValue[1];
                }                
            break;    
        case 2:        
            var fpath = System.RootURL + "/form/ch/ae/chae00010_search_emp.aspx" ;
            var obj  = System.OpenModal(  fpath , 900 ,600, 'resizable:yes;status:yes;');
            if (obj!=null)
            {          
                txtCharger_PK.text=obj[0];            
                txtCharger_Code.text=obj[1];
                txtChargerNm.text=obj[2]; 
            }   
            break; 
         case 3: 
             scode='ACAB0110';   
             var fpath = System.RootURL + "/form/ep/bp/epbp00020_com_code.aspx?code=" + scode ;
                var obj = System.OpenModal( fpath , 900 , 600 , 'resizable:yes;status:yes');
                if (obj!=null)
                {
                    strcodereturn=obj[1];
                    indexCode=index;
                    
                    if (obj[0]==1 ) //modify common code
                        OnLoadNew(scode);
                    else
                    {   
                      lstBookingCcy.value=strcodereturn; // cboCurrency
                    }
                }        
    }
}

function OnLoadNew(scode)
{	
    var t=new Date()
    var url =  System.RootURL + "/form/ep/bp/epbp00020_searchidcode.aspx?id=" + scode + "&date=" + t;
    ajax_test4 = null;
    ajax_test4 = GetXmlHttpRequest(return_result);
    ajax_test4.open("GET", url , true);
    ajax_test4.send(null);
} 
function return_result()
{	        
    if(GetRequestState(ajax_test4))
    {
        strdata = ajax_test4.responseText;	      
        lstBookingCcy.SetDataText(strdata);
        lstBookingCcy.value=strcodereturn; // cboCurrency
    }
}
function getExRate()
{    
   var url =  System.RootURL + "/form/ep/bp/epbp00020_GetExRate.aspx?date=" + dtContract.value +"&curr=" + lstBookingCcy.value;   
   //var url =  System.RootURL + "/form/ep/bp/epbp00020_GetExRate.aspx?date=20090318&curr=" + lstBookingCcy.value;  
    ajax_test = null;
   
    ajax_test = GetXmlHttpRequest(returnExRate);
    ajax_test.open("GET", url , true);
    ajax_test.send(null); 
}
function returnExRate()
{
    if(GetRequestState(ajax_test))
    {	
        strdata = ajax_test.responseText;	 	  
        txtBookingRate.SetDataText(''+strdata);        
    }
}
function onSearch()
{  
    dat_gfqc00010.Call("SELECT");
}
function onSave()
{
    grdContract.SetGridText(grdContract.row,iCompany,lstCompany.value);
    grdContract.SetGridText(grdContract.row,iIssued_Date,dt_Issued.GetData());
    grdContract.SetGridText(grdContract.row,iEmp_ID,txtCharger_Code.GetData());
    grdContract.SetGridText(grdContract.row,iEmp_Full_Nm,txtChargerNm.GetData());
    grdContract.SetGridText(grdContract.row,iBooking_Ccy,lstBookingCcy.Value);
    grdContract.SetGridText(grdContract.row,iEmp_PK,txtCharger_PK.GetData());
    grdContract.SetGridText(grdContract.row,iContract_Date,dtContract.GetData());
    grdContract.SetGridText(grdContract.row,iPartner_Code,txtPartnerID.GetData());
    grdContract.SetGridText(grdContract.row,iPL_Code,txtPL_Code.GetData());
    grdContract.SetGridText(grdContract.row,iPartner,txtPartnerNm.GetData());
    grdContract.SetGridText(grdContract.row,iPL,txtPL_Nm.GetData());
    grdContract.SetGridText(grdContract.row,iBooking_Ccy,lstBookingCcy.value);
    grdContract.SetGridText(grdContract.row,iPartner,txtBookingRate.GetData());
    grdContract.SetGridText(grdContract.row,iTO_TR_AMT,txtTOTransAmt.GetData());
    grdContract.SetGridText(grdContract.row,iTO_B_AMT,txtTOBooksAmt.GetData());
    grdContract.SetGridText(grdContract.row,iAR_TR_AMT,txtARTransAmt.GetData());
    grdContract.SetGridText(grdContract.row,iAR_B_AMT,txtARBooksAmt.GetData());
    grdContract.SetGridText(grdContract.row,iADV_TR_AMT,txtAdvTransAmt.GetData());
    grdContract.SetGridText(grdContract.row,iADV_B_AMT,txtAdvBooksAmt.GetData());
    grdContract.SetGridText(grdContract.row,iCOL_TR_AMT,txtCollTransAmt.GetData());
    grdContract.SetGridText(grdContract.row,iCOL_B_AMT,txtCollBooksAmt.GetData());
    dat_gfqc00010.Call();
}
function onCellClickToGrid()
{    
    lstCompany.value=grdContract.GetGridData(grdContract.row,iCompany);
    dt_Issued.SetDataText(grdContract.GetGridData(grdContract.row,iIssued_Date));    
    txtCharger_Code.SetDataText(grdContract.GetGridData(grdContract.row,iEmp_ID));    
    txtChargerNm.SetDataText(grdContract.GetGridData(grdContract.row,iEmp_Full_Nm));
    txtCharger_PK.SetDataText(grdContract.GetGridData(grdContract.row,iEmp_PK));
    dtContract.SetDataText(grdContract.GetGridData(grdContract.row,iContract_Date));   
    txtContractNo_D.SetDataText(grdContract.GetGridData(grdContract.row,iContract_No));   
    txtPartnerID.SetDataText(grdContract.GetGridData(grdContract.row,iPartner_Code));
    txtPartnerNm.SetDataText(grdContract.GetGridData(grdContract.row,iPartner));
    txtPL_Code.SetDataText(grdContract.GetGridData(grdContract.row,iPL_Code));
    txtPL_Nm.SetDataText(grdContract.GetGridData(grdContract.row,iPL));
    lstBookingCcy.value=grdContract.GetGridData(grdContract.row,iBooking_Ccy);
    txtBookingRate.SetDataText(grdContract.GetGridData(grdContract.row,iB_EX_RATE));
    //txtTransRate.SetDataText(grdContract.row,);
    txtTOTransAmt.SetDataText(grdContract.GetGridData(grdContract.row,iTO_TR_AMT));
    txtTOBooksAmt.SetDataText(grdContract.GetGridData(grdContract.row,iTO_B_AMT));
    txtARTransAmt.SetDataText(grdContract.GetGridData(grdContract.row,iAR_TR_AMT));
    txtARBooksAmt.SetDataText(grdContract.GetGridData(grdContract.row,iAR_B_AMT));
    txtAdvTransAmt.SetDataText(grdContract.GetGridData(grdContract.row,iADV_TR_AMT));
    txtAdvBooksAmt.SetDataText(grdContract.GetGridData(grdContract.row,iADV_B_AMT));
    txtCollTransAmt.SetDataText(grdContract.GetGridData(grdContract.row,iCOL_TR_AMT));
    txtCollBooksAmt.SetDataText(grdContract.GetGridData(grdContract.row,iCOL_B_AMT));  
    
}
function OnDataReceive(obj)
{
    if (obj.id=='dat_gfqc00010')
    {
        idRecord.text="Total rows: " + (grdContract.rows-1)
    }
}
function onPrint()
{
    
    var p_tex_contr_mst;
    if (grdContract.rows>1)
    {
        p_tex_contr_mst_pk=grdContract.GetGridData(grdContract.row,iPK); 
        p_tco_company_pk=grdContract.GetGridData(grdContract.row,iCompany);      
        var url = '/reports/gf/qc/gfqc00030_contractprogress.aspx?p_tex_contr_mst_pk='+p_tex_contr_mst_pk+ '&p_tco_company_pk='+p_tco_company_pk;
        System.OpenTargetPage( System.RootURL+url , "newform" );
    }
    else 
    {
        alert("Please select a data row");
        return;
    } 
}
</script>
<body bottommargin="0" leftmargin="0" rightmargin="0" topmargin="0">
<gw:data id="dat_gfqc00010"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid" parameter="1,10,11,14,15,16,17,18,19,20,21,22,23" function="imex.sp_sel_gfqc00010"   procedure="imex.sp_upd_gfqc00010"> 
            <input bind="grdContract">                    
                <input bind="txtContractNo" /> 
                <input bind="dtContractDt_Fr" /> 
                <input bind="dtContractDt_To" />
                <input bind="txtPartner_PK" />
                <input bind="txtPL_PK" />
            </input> 
            <output bind="grdContract" /> 
        </dso> 
    </xml> 
</gw:data>
    <form id="form1" runat="server">    
    <table border=0 cellpadding=0 cellspacing=0 style="width:100%;height:100%">      
        <tr style="height:100%" valign=top>
            <td style="width:60%;height:100%"><fieldset style="padding: 5">            
                        <table border=0 cellpadding=0 cellspacing=0 style="width:100%;height:100%">
                            <tr height=10%>
                                <td style="width:100%">
                                    <table border=0 cellpadding=0 cellspacing=0 style="width:100%;height:100%">                                        
                                        <tr>
                                            <td style="width:20%"></td>
                                            <td style="width:20%"></td>
                                            <td style="width:10%"></td>
                                            <td style="width:20%"></td>
                                            <td style="width:20%"></td>
                                            <td style="width:10%"></td>
                                        </tr>
                                        <tr>
                                            <td align=right nowrap style="width:20%">Contract No &nbsp;</td>
                                            <td nowrap colspan=3 align=left style="width:50%">
                                                <table cellpadding=0 cellspacing=0 border=0 style="width:100%">
                                                    <tr>
                                                        <td style="width:100%">
                                                            <gw:textbox id="txtContractNo" maxlen=50 onenterkey="onSearch()" styles="width:90%" text="" />
                                                        </td>
                                                    </tr>                                            
                                                </table>                                                
                                            </td>
                                            <td>&nbsp;</td>
                                            <td align=right>                                                
                                               <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="onSearch()" />                                              
                                            </td>
                                        </tr>                                        
                                        <tr>
                                            <td align=right nowrap>Contract Date &nbsp;</td>
                                            <td align=left>
                                                <gw:datebox id="dtContractDt_Fr" lang=1 style="width:100%" lang="<%=Session("Lang")%>"  />
                                            </td>
                                            <td align=center nowrap>~</td>
                                            <td align=left>
                                                <gw:datebox id="dtContractDt_To" lang=1 styles="width:100%" lang="<%=Session("Lang")%>"  />
                                            </td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td align=right><a onclick="OnShowPopup(0)" title="Click here to select partner" href="#tips" style="text-decoration : none; color=#0000FF">Partner</a> &nbsp;</td>
                                            <td colspan=3 align=left>
                                                <table border=0 cellpadding=0 cellspacing=0 style="width:100%">
                                                    <tr>
                                                        <td width="96%" nowrap>
                                                            <gw:textbox id="txtPartner" style="width:100%" text=""/>
                                                            <gw:textbox id="txtPartner_PK" style="width:100%;display:none" />
                                                        </td>
                                                        <td width="4%">
                                                            <gw:imgbtn id="reset" img="Reset" alt="Reset" onclick="txtPartner.text='';txtPartner_PK.text=''" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>                        
                                        </tr>
                                        <tr>
                                            <td align=right><a onclick="OnShowPopup(1)" title="Click here to select P/L" href="#tips" style="text-decoration : none; color=#0000FF">P/L</a> &nbsp;</td>
                                            <td colspan=3 align=left>
                                                <table border=0 cellpadding=0 cellspacing=0 style="width:100%">
                                                    <tr>
                                                        <td width="96%" nowrap>
                                                            <gw:textbox id="txtPL" style="width:100%" text=""/>
                                                            <gw:textbox id="txtPL_PK" style="width:100%" />
                                                        </td>
                                                        <td width="4%">
                                                            <gw:imgbtn id="reset" img="Reset" alt="Reset" onclick="txtPL.text='';txtPL_PK.text=''" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>                        
                                        </tr>
                                        <tr>
                                            <td colspan=6 align=left>&nbsp;
                                                <gw:label id="idRecord" text="" style="font-family:Tahoma;color:Red" />
                                            </td>
                                        </tr>                            
                                    </table>
                                    </td>
                                </tr>
                            <tr height=90%>
                                <td style="width:100%">
                                    <table border=0 cellpadding=0 cellspacing=0 style="width:100%;height:100%">
                                        <tr>
                                            <td>
                                                <gw:grid id='grdContract' 
                                                    header='No|_PK|Partner|P/L|Contract Date|Contract No|Contract Amount|_Paner_Code|_PL_Code|_Company|_Issued Date|_Emp PK|_Emp ID|_Emp Full Nm|_Booking Ccy|_B_EX_RATE|_TO_TR_AMT|_TO_B_AMT|_AR_TR_AMT|_AR_B_AMT|_ADV_TR_AMT|_ADV_B_AMT|_COL_TR_AMT|_COL_B_AMT'
                                                    format='0|0|0|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                                    aligns='0|0|0|0|0|0|3|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                                    defaults='|||||||||||||||||||||'
                                                    editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                                    widths='500|0|2000|1000|1200|1000|1000|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                                    sorting='T'
                                                    acceptNullDate="T"                              
                                                    styles='width:100%; height:350'
                                                    oncellclick="onCellClickToGrid()"
                                                  />
                                            </td>
                                        </tr>
                                    </table>  
                                </td>
                            </tr>
                            </table>
                    </fieldset>                                                    
            </td>
            <td style="width:40%;height:100%"><fieldset style="padding: 5">
                <table border=0 cellpadding=0 cellspacing=0 style="width:100%;height:100%">
                    <tr style="height:10%" valign=top>
                        <td>
                            <table border=0 cellpadding=0 cellspacing=0 style="width:100%">
                                <tr>
                                    <td width=98%>&nbsp;</td>
                                    <td align=right width=1%><gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="onSave()" /></td>
                                    <td align=right width=1%><gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="onPrint()" /></td>
                                </tr>
                            </table>
                        </td>                        
                    </tr>
                    <tr style="height:90%">
                        <td>
                            <table style="width:100%;height:100%" border=0 cellpadding=0 cellspacing=0>
                                <tr>
                                    <td nowrap style="width:20%" align=right>Company &nbsp;</td>
                                    <td align=left style="width:30%">
                                        <gw:list id="lstCompany" style="width:100%" value="<%=Session("COMPANY_PK")%>" maxlen=100>                                
                                            <data><%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>|ALL|Select All</data>
                                        </gw:list>
                                    </td>
                                    <td nowrap style="width:20%" align=right>Issued Date &nbsp;</td>
                                    <td nowrap style="width:25%" align=left>
                                        <gw:datebox id="dt_Issued" lang=1 style="width:100%" lang="<%=Session("Lang")%>" nullaccept=true />
                                    </td>
                                    <td nowrap style="width:5%">&nbsp;&nbsp;&nbsp;</td>
                                </tr>
                                <tr>
                                    <td style="width:20%" nowrap align=right><a onclick="OnShowPopup(2)" title="Click here to select P/L" href="#tips" style="text-decoration : none; color=#0000FF">Charger</a></td>
                                    <td align=left style="width:30%"><gw:textbox id="txtCharger_Code" text="" style="width:100%" /></td>
                                    <td nowrap align=left colspan=2 width=45%>
                                        <table border=0 cellpadding=0 cellspacing=0 style="width:100%;height:100%">
                                            <tr>
                                                <td style="width:96%">
                                                    <gw:textbox id="txtChargerNm" style="width:100%" text="" />
                                                    <gw:textbox id="txtCharger_PK" style="width:100%;display:none" />
                                                </td>   
                                                <td width="4%">
                                                    <gw:imgbtn id="reset" img="Reset" alt="Reset" onclick="txtChargerNm.text='';txtCharger_PK.text='';txtCharger_Code.text='';" />
                                                </td>                                
                                            </tr>
                                        </table>
                                    </td>  
                                    <td nowrap style="width:5%">&nbsp;&nbsp;&nbsp;</td>                                 
                                </tr>
                                <tr>
                                    <td nowrap align=right style="width:20%">Contract Date &nbsp;</td>
                                    <td style="width:30%">
                                        <gw:datebox id="dtContract"  style="width:90%" lang="<%=Session("Lang")%>"  />
                                    </td>
                                    <td nowrap align=right style="width:20%">Contract No &nbsp;</td>
                                    <td align=left styles="width:29%">
                                        <gw:textbox id="txtContractNo_D" text="" styles="width:97%" />
                                     </td>
                                    <td nowrap style="width:1%">&nbsp;&nbsp;&nbsp;</td>
                                </tr>
                                <tr>
                                    <td style="width:20%" nowrap align=right>Partner&nbsp;</td>
                                    <td style="width:30%"><gw:textbox id="txtPartnerID" style="width:100%" text="" /></td>
                                    <td style="width:49%" colspan=2 align=left>                                       
                                        <gw:textbox id="txtPartnerNm" styles="width:100%" text="" />
                                        <gw:textbox id="txtPartner_PK_D" styles="display:none" text="" />                                               
                                    </td>  
                                   <td nowrap style="width:1%">&nbsp;&nbsp;&nbsp;</td>                     
                                </tr>
                                <tr>
                                    <td style="width:20%" nowrap align=right>P/L&nbsp;</td>
                                    <td style="width:30%"><gw:textbox id="txtPL_Code" style="width:100%" text="" /></td>
                                    <td style="width:49%" colspan=2 align=left><gw:textbox id="txtPL_Nm" styles="width:100%" text="" /></td>                       
                                    <td nowrap style="width:1%">&nbsp;&nbsp;&nbsp;</td>
                                </tr>
                                <tr>
                                    <td nowrap align=right style="width:20%"><a title="Click here to select Booking Currency" onclick="OnShowPopup(3)" href="#tips" style="text-decoration : none; color:#0000FF"><b>Booking Ccy</b></a> &nbsp;</td>
                                    <td style="width:30%">
                                        <gw:list id="lstBookingCcy" onchange="getExRate()" style="width:100%" value="0">                               
                                        </gw:list>
                                    </td>
                                    <td nowrap align=left style="width:20%"><gw:textbox id=txtBookingRate type="number" format="#,###,###,###,###R" style="width:100%"/></td>
                                    <td nowrap align=left style="width:29%">
                                        <gw:textbox id=txtTransRate type="number" format="#,###,###,###,###R" style="width:100%"/>                                        
                                    </td>
                                    <td nowrap style="width:1%">&nbsp;&nbsp;&nbsp;</td>
                                </tr>
                                <tr>
                                    <td nowrap align=left style="width:20%">T/O Trans Amount &nbsp;</td>
                                    <td colspan=3>
                                        <gw:textbox id="txtTOTransAmt" type="number" format="#,###,###,###,###R" style="width:100%" text="" />
                                    </td>                                    
                                    <td nowrap style="width:1%">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td nowrap align=left style="width:20%">T/O Books Amount </td>
                                    <td nowrap colspan=3 align=left><gw:textbox id="txtTOBooksAmt" type="number" format="#,###,###,###,###R" style="width:100%" text="" /></td>
                                    <td nowrap style="width:1%">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td nowrap align=left style="width:20%">A/R Trans Amount </td>
                                    <td colspan=3>
                                        <gw:textbox id="txtARTransAmt" type="number" format="#,###,###,###,###R" style="width:100%" text="" />
                                    </td>                                    
                                    <td nowrap style="width:1%">&nbsp;&nbsp;&nbsp;</td>
                                </tr>
                                <tr>
                                    <td nowrap align=left style="width:20%">A/R Books Amount </td>
                                    <td nowrap colspan=3 align=left style="width:29%"><gw:textbox id="txtARBooksAmt" type="number" format="#,###,###,###,###R" style="width:60%" text="" /></td>
                                    <td nowrap style="width:1%">&nbsp;&nbsp;&nbsp;</td>
                                </tr>
                                <tr>
                                    <td nowrap align=left style="width:20%">Adv. Trans Amount &nbsp;</td>
                                    <td colspan=3>
                                        <gw:textbox id="txtAdvTransAmt" format="#,###,###,###,###R" type="number" style="width:100%" text="" />
                                    </td>                                    
                                    <td nowrap style="width:1%">&nbsp;&nbsp;&nbsp;</td>
                                </tr>
                                <tr>
                                    <td nowrap align=left style="width:20%">Adv. Books Amount </td>
                                    <td nowrap align=left colspan=3><gw:textbox format="#,###,###,###,###R" type="number" id="txtAdvBooksAmt" style="width:100%" text="" /></td>
                                    <td nowrap style="width:1%">&nbsp;&nbsp;&nbsp;</td>
                                </tr>
                                <tr>
                                    <td nowrap align=left style="width:20%">Coll. Trans Amount &nbsp;</td>
                                    <td style="width:30%" colspan=3> 
                                        <gw:textbox id="txtCollTransAmt" type="number" format="#,###,###,###,###R" style="width:100%" text="" />
                                    </td>                                    
                                    <td nowrap style="width:1%">&nbsp;&nbsp;&nbsp;</td>
                                </tr>  
                                <tr>
                                    <td nowrap align=left style="width:20%">Coll. Books Amount </td>
                                    <td nowrap align=left  colspan=3><gw:textbox id="txtCollBooksAmt" type="number" format="#,###,###,###,###R" style="width:100%" text="" /></td>
                                    <td nowrap style="width:1%">&nbsp;&nbsp;&nbsp;</td>
                                </tr>
                            </table>
                        </td>
                    </tr>                                      
                </table></fieldset>
            </td>
        </tr>
    </table>
    <gw:list id="lstBookingCcy_Tmp" style="display:none"></gw:list>
    </form>
</body>
</html>
