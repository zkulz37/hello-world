<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>genuwin</title>
  </head>
  <%  ESysLib.SetUser("acnt")%>

<script>
function BodyInit()
{
    txtLang.text="<%=Session("SESSION_LANG") %>"; 
    BindingData(); 
    
   System.Translate(document); 
   
}
//------------------------------------------------------------------------
function BindingData()
{
        
    var ls_data  = "<%=ESysLib.SetListDataSQL("SELECT pk, partner_name FROM comm.tco_company where del_if = 0")%>";
    var ls_data2 = "<%=ESysLib.SetListDataSQL("SELECT D.CODE, D.CODE_NM  FROM TAC_COMMCODE_MASTER M, TAC_COMMCODE_DETAIL D WHERE M.DEL_IF =0 AND D.DEL_IF =0 AND M.PK = TAC_COMMCODE_MASTER_PK AND M.ID='EACBK011' ORDER BY D.DEF_YN DESC, D.ORD")%>"; 
    var ls_data3 = "<%=ESysLib.SetListDataSQL("SELECT CODE, CODE  FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.TCO_ABCODEGRP_PK = b.pk and b.id ='ACBG0040' and a.use_if = 1 and a.del_if = 0 and b.del_if = 0 and a.def_yn ='Y' ")%>";
    var ls_ccy   = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0110','03','') FROM DUAL")%>||Select All";
    var ls_bookccy = "<%=ESysLib.SetListDataSQL("SELECT CODE, CODE FROM TCO_ABCODE A, TCO_ABCODEGRP B WHERE A.TCO_ABCODEGRP_PK = b.pk and b.id ='ACBG0040' and a.use_if = 1 and a.del_if = 0 and b.del_if = 0 and a.def_yn ='Y' ")%>";
    lstCcy.SetDataText(ls_ccy);
    lstCcy.value="";
   lstBookCcy.SetDataText(ls_bookccy);
    lstCompany.SetDataText(ls_data);
    
   
}
//------------------------------------------------------------------------
function OnPopUp(pname)
{
    if (pname=='ACCT')
   {
        var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + '' + "&val2=" + '' + "&val3=" + lstCompany.value+'' + "&dsqlid=ACNT.SP_SEL_ACCD_PL";
        var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
        if ((object != null) &&(object[0]!="0"))
    {
        txtACPK.SetDataText(object[3]);
        txtACCD.SetDataText(object[0]);
        txtACNM.SetDataText(object[1]);
    }
   }
   if (pname=='CENTER')
   {
        var fpath   = System.RootURL + "/form/gf/ka/gfka00220_plcenter.aspx?";
           
          var object  = System.OpenModal(fpath , 400 , 500 , 'resizable:yes;status:yes'); 
            // var object=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:10;dialogTop:330;edge:sunken;scroll:yes;unadorned:yes;help:no');
       
            if ( object != null )  
            {
                if (object[0] != 0)
                {
                    txtPLC_PK.text = object;     // Center PK
                    dat_gfka00220_1.Call();
                }            
            }        
   }
    if (pname=='PL')
   {
          
          var fpath   = System.RootURL + "/form/gf/ka/gfka00220_plunit.aspx?";
           
          var object  = System.OpenModal(fpath , 400 , 500 , 'resizable:yes;status:yes'); 
            // var object=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:10;dialogTop:330;edge:sunken;scroll:yes;unadorned:yes;help:no');
          var tmp;
            if ( object != null )  
            {
                if (object[0] != 0)
                {
                    txtPLPK.text=object;     // Center PK
                    dat_gfka00220_2.Call();
                }            
            }    
   }
    
}


function OnSearch()
{
   dso_sel_pl.Call("SELECT");
}

function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case "dso_sel_pl":
            
        break; 
       
        
    }
}
//--------------------------------------------------
function MergeHeader()
{

       
}
//----------------------------------------------------------
function MergeSum()
{
    
}
function OnPrint()
{
    var url ='/reports/gf/ka/gfka00310_detail_expense_plunit.aspx?company='+lstCompany.value+'&from='+txtFROM_DATE.value+ '&to='+txtTO_DATE.value+ '&acc_cd='+txtACCD.text+ '&plunit_pk='+txtPLPK.text + '&pl_cd=' + txtPLCD.text + '&pl_nm=' + txtPLNM.text;
    System.OpenTargetPage( System.RootURL+url , 'newform' );
      
}
</script>
  <body>
  <gw:data id="dat_gfka00220_1" onreceive=""  > 
        <xml>
            <dso  type="process"   procedure="acnt.sp_sel_gfka00220_1"  > 
                <input>
                    <input bind="txtPLC_PK" />
                </input> 
                <output>
                    <output bind="txtPLC_CD" />
                    <output bind="txtPLC_NM" />
                </output>
            </dso> 
        </xml> 
   </gw:data>
   <!------------------------------------------------------------------------> 
  
   <gw:data id="dat_gfka00220_2" onreceive=""  > 
        <xml>
            <dso  type="process"   procedure="acnt.sp_sel_gfka00220_2"  > 
                <input>
                    <input bind="txtPLPK" />
                </input> 
                <output>
                    <output bind="txtPLCD" />
                    <output bind="txtPLNM" />
                </output>
            </dso> 
        </xml> 
   </gw:data>
   <!----------------------------------------------------------------------->
   
    <!--------------------------------------------------------------------------------------------------->
    <gw:data id="dso_sel_pl" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" function="ACNT.sp_sel_gfka00310">
                <input bind="grdDetail">
                    <input bind="lstCompany"/>
                    <input bind="txtFROM_DATE"/>
                    <input bind="txtTO_DATE"/>
                    <input bind="txtACCD"/>
                    <input bind="txtPLC_PK"/>
                    <input bind="txtPLPK"/>
                    <input bind="rdoSlipStatus"/>
                    <input bind="lstCcy"/>

                </input>
                <output bind="grdDetail"/>
        </dso>
        </xml>
    </gw:data>
            <table style="width:100%;height:100%" cellpadding="0" cellspacing="0" border="0">
                <tr style="width:100;height:10%">
                   <td>
                        <fieldset >
                             <table width="100%" border="0" cellpadding="0" cellspacing="1" >
           
                <tr >
                    <td align="right" width="10%" >Company&nbsp;</td>
                    <td  colspan="3" width="15%">
                        <gw:list id="lstCompany" styles="width:100%" />
                    </td>
                    <td align="right" width="15%"><a title="Click here to select Account Code" onclick="OnPopUp('ACCT')" href="#tips">Account Code</a>&nbsp;</td>
                    <td  width="10%">
                        <gw:textbox id="txtACCD"  text="" styles="width:100%" />
                    </td>
                    <td width="20%">
                        <gw:textbox id="txtACNM"  text="" styles="width:100%" />
                    </td>
                    <td align="right" ><gw:imgbtn img="reset" alt="Reset Account Code" id="btnResetAcc" onclick="txtACCD.text='';txtACNM.text='';txtACPK.text='';" /></td>
                    <td align="right"  width="15%">Currency&nbsp;</td>
                    <td width="15%" colspan="1"><gw:list id="lstCcy" styles="width:100%" onchange="OnSearch()"/></td>  
                    
                    <td align="right"><gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch()" /></td>
                    <td align="right"><gw:imgbtn img="excel" alt="Print" id="btnPrint" onclick="OnPrint()" /></td>        
                </tr>
                <tr>
                    <td align="right" >Date&nbsp;</td> 
                    <td align="left" ><gw:datebox id="txtFROM_DATE" styles='width:100%;height:22'  lang="<%=Session("Lang")%>"/></td>
                    <td align="center">~</td>
                    <td align="right"><gw:datebox id="txtTO_DATE" styles='width:100%;height:22'  lang="<%=Session("Lang")%>"/></td>
                    <td align="right" styles="width: 100%"><a title="Click here to select PL Center" onclick="OnPopUp('CENTER')" href="#tips">PL Center</a>&nbsp;</td>
                    <td > <gw:textbox id="txtPLC_CD" readonly="true"  styles="width:100%" /></td>
                    <td ><gw:textbox id="txtPLC_NM" readonly="true"  styles="width:100%" /></td>
                    <td align="right"><gw:imgbtn img="reset" alt="Reset" id="btnResetPLCenter" onclick="txtPLC_CD.text='';txtPLC_NM.text='';txtPLC_PK.text='';" /></td> 
                    
                </tr>
               <tr>
                    <td  align="right">Status &nbsp;</td>
                    <td colspan="3"  > <gw:radio id="rdoSlipStatus"  value="2" > 
                                    <span value="2" >Confirmed</span>
                                    <span value="0" >Approved</span>
                                </gw:radio >
                   </td>               
                   <td align="right" ><a title="Click here to select PL Unit" onclick="OnPopUp('PL')" href="#tips">PL Unit</a>&nbsp;</td>
                    <td  >
                        <gw:textbox id="txtPLCD"  readonly="true" styles="width:100%" />
                    </td>
                    <td >
                        <gw:textbox id="txtPLNM" readonly="true"  styles="width:100%" />
                    </td>
                    <td align="right"><gw:imgbtn img="reset" alt="Reset" id="btnResetPLUnit" onclick="txtPLCD.text='';txtPLNM.text='';txtPLPK.text='';" /></td>
                    <td colspan="3"></td>
               </tr> 
            </table>     
                        </fieldset>
                   </td>
                </tr>
                <tr style="width:100%;height:70%">
                    <td >
                    <!--header='0.Seq|1.Voucher No|2.Trans Date|3.Acc. Code|4.Acc. Name|Acc Code VAS|5.Trans Amount|6.Books Amount|7.Cust ID|8.Customer Name|9.PL Code|10.PL Name|11.Remark|12.Remark2'-->
                                <gw:grid id='grdDetail'
                                    header='Seq|Voucher No|Trans Date|Acc. Code|Acc. Name|Acc Code VAS|Trans Amount|Books Amount|Cust ID|Customer Name|PL Code|PL Name|Remark|Remark2'
                                    format='0|0|4|0|0|0|0|0|0|0|0|0|0|0'
                                    aligns='0|0|0|0|0|0|3|3|0|0|0|0|0|0'
                                    defaults='|||||||||||||'
                                    editcol='0|0|0|0|0|0|0||0|0|0|0|0|0'
                                    widths='1000|1500|2500|1400||1500|1500|1500|2000|2000|2000|2000|2000|2500|0'
                                    sorting='T'
                                    styles='width:100%; height:100%'
                                />
                            </td>
                </tr>
                 
            </table>
            <gw:textbox id="txtLang" styles="display:none; " text="<%=Session("SESSION_LANG") %>"/>
            <gw:textbox id="txtACPK" styles="display:none; " />
            <gw:textbox id="txtPLC_PK" styles="display:none; " />
            <gw:textbox id="txtPLPK" styles="display:none; " />
            <gw:list id="lstBookCcy" styles="display:none;" ></gw:list>

  </body>
</html>