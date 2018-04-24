<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>genuwin</title>
</head>
<%  ESysLib.SetUser("acnt")%>

<script>
function BodyInit()
{
    BindingDataList();
    FormatGrid();
}
//----------------------------------------------------------------------------------------------
function BindingDataList()
{
    var ls_company  = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    var ls_trans_type = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('GFQC0004') FROM DUAL")%>|All|-Chọn Tất Cả-";
    var ls_trans = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('GFQC0005') FROM DUAL")%>|All|-Chọn Tất Cả-";
    var ls_date = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('GFQC0006') FROM DUAL")%>|All|-Chọn Tất Cả-";
    lstCompany.SetDataText(ls_company);
    lstCompany.value = "<%=session("company_pk") %>";
    lsttrans_type.SetDataText(ls_trans_type);
    lsttrans.SetDataText(ls_trans);
    lsttrans.value="All";
    lsttrans_type.value="All";
    
    lstdate.SetDataText(ls_date);
    lstdate.value="All";
    <%=ESysLib.SetGridColumnComboFormat("idgrid",3,"SELECT B.CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'GFQC0006' and a.del_if = 0 and b.del_if = 0")%>;
    <%=ESysLib.SetGridColumnComboFormat("idgrid",7,"SELECT B.CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'GFQC0004' and a.del_if = 0 and b.del_if = 0")%>;
    <%=ESysLib.SetGridColumnComboFormat("idgrid",2,"SELECT B.CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'GFQC0008' and a.del_if = 0 and b.del_if = 0")%>;
    <%=ESysLib.SetGridColumnComboFormat("idgrid",1,"SELECT B.CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'GFQC0005' and a.del_if = 0 and b.del_if = 0")%>;
}
function OnSearch()
{
   DSO_MT.Call("SELECT");
}
//----------------------------------------------------------------------------------------------
function OnPopUp(index)
{
       
        var scode;
        switch(index)
        {           
            case 1:
                scode='GFQC0006'; //type
            break;
            case 2:
                scode='GFQC0005'; //san GD
            break;
            case 3:
                scode='GFQC0004'; // Loai GD
            break;  
           
            
        }
        txtComCodeID.text = scode;
        var fpath = System.RootURL + "/form/gf/os/gfos00040_popup_1.aspx?code=" + scode ;
       
        var obj = System.OpenModal( fpath , 900 , 600 , 'resizable:yes;status:yes');
        if (obj!=null)
        {
            strcodereturn=obj[1];
            indexCode=index;
            
            if (obj[0]==1 ) //modify common code
                OnLoadNew(scode);
                //datGetNewControl.Call();
            else
            {               
                switch(index)
                {                        
                    case 1:
                        lstdate.value=strcodereturn; //type 
                    break;
                    case 2:
                        lsttrans.value=strcodereturn; //San GD
                    break;
                    case 3:
                        lsttrans_type.value=strcodereturn; // LoaiGD
                    break;  
                   
                }            
            }
        }	     
               
}
//----------------------------------------------------------------------------------------------
 function OnLoadNew(scode)
 {	
        datGetNewCode.Call('SELECT');
 }
function GetAcc(obj)
{
    switch(obj)
    {
         case 4:
                    if(idgrid.col=="8")
                    {
                        var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + '' + "&val2=" + '' + "&val3=" + lstCompany.value+'' + "&dsqlid=ACNT.SP_SEL_ACCD_PL";
	                    var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
                        if ((object != null) &&(object[0]!="0"))
                        {
                                    
                            idgrid.SetGridText( idgrid.row, 13, object[3]);    //ACPK
	                        idgrid.SetGridText( idgrid.row, 8, object[0]+' - '+object[1] );    //Account Code
                            
                           
                        }
                    }
            break;
            case 5:
                    if(idgrid.col=="9")
                    {
                        var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + '' + "&val2=" + '' + "&val3=" + lstCompany.value+'' + "&dsqlid=ACNT.SP_SEL_ACCD_PL";
	                    var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
                        if ((object != null) &&(object[0]!="0"))
                        {
                                    
                            idgrid.SetGridText( idgrid.row, 14, object[3]);    //ACPK
	                        idgrid.SetGridText( idgrid.row, 9, object[0]+ ' - ' +object[1]);    //Account Code
                          
                           
                        }
                    }
            break;
    }
}
function OnDataReceive(obj)
{
   
    var strdata = txtCodeTemp.text;
    if(obj.id == 'datGetNewCode')
    {
        switch(indexCode)
                {
                    case 1:
                        lstdate.SetDataText(strdata);
                        lstdate.value=strcodereturn; //type                   
                    break;
                    case 2:
                        lsttrans.SetDataText(strdata);
                        lsttrans.value=strcodereturn; //san gd
                    break;
                    case 3:
                        lsttrans_type.SetDataText(strdata);
                        //alert(strdata);
                        lsttrans_type.value=strcodereturn;
                         // loai gd
                    break;  
                }
    }
    else if (obj.id == 'dat_process')
    {
          
                       dat_grid.Call("SELECT");
                         alert("Process compled!!");
    }
    else if (obj.id == 'dat_grid_process')
    {
        dat_grid.Call("SELECT");
    }
    
           
}
function FormatGrid()
{
    var fg=idgrid.GetGridControl();
    fg.ColFormat(6) = "#,###,###,###,###.##";
}
function Process()
{
        dat_process.Call();
}
function OnSave()
{
      dat_grid.Call();
}
function OnDelete()
{

	                if(confirm('Bạn có muốn xóa dữ liệu của ngày '+ dtfrdate.value +' không?'))
                    {
                         dat_grid_process.Call();
                    }
              
	    
}
</script>

<body style="margin: 0; padding: 0;">
<gw:data id="DSO_MT" > 
    <xml> 
        <dso id="1" type="grid" function="acnt.sp_sel_gfos00010_search " > 
            <input  >
                <input bind="lstCompany" />
                <input bind="lsttrans" />
                <input bind="dtfrdate" />
                <input bind="lstdate" />
                <input bind="lsttrans_type" />
                <input bind="txtDescription" />
            </input>
            <output bind="idgrid" /> 
        </dso> 
    </xml> 
</gw:data>
    <!---------------------------------------------------------------------------------------------------------------->
     <gw:data id="datGetNewCode" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="acnt.sp_sel_gfos00040_newcomm" > 
                <input> 
                    <input bind="txtComCodeID" /> 
                </input>
	           <output>
	                <input bind="txtCodeTemp" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!----------------------------------------------------------------------------------------------------------------------->
    <gw:data id="dat_process"  onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso id="1" type="process" parameter="0,1,2,3,4,5"  procedure="acnt.sp_udp_gfos00040_1"> 
                <input>   
                    <input bind="txt_action" />
                    <input bind="tac_sectran_pk" />
                    <input bind="tac_abacctcode_pk_dr" />
                    <input bind="tac_abacctcode_pk_cr" />
                    <input bind="txtDescription" /> 
                    <input bind="dtfrdate" /> 
                    <input bind="lstCompany" />
                </input> 
                <output>
                    <output bind="txtReturn" />
                </output>
            </dso> 
        </xml> 
</gw:data> 
<!------------------------------------------------------------------------------------------------------>
<gw:data id="dat_grid"  onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14" function="acnt.sp_sel_gfos00040_1"   procedure="acnt.sp_upd_gfos00040_4"> 
                <input bind="idgrid">                    
                    <input bind="tac_sectran_pk" /> 
                    
                </input> 
                <output bind="idgrid" /> 
            </dso> 
        </xml> 
</gw:data>

   <!----------------------------------------------------------------------------------------------------------------------->
    <gw:data id="dat_grid_process"  onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso id="1" type="process"   procedure="acnt.sp_upd_gfos00040_3"> 
                <input>   
                    <input bind="txt_action2" />
                    <input bind="tac_sectran_pk" />
                    <input bind="txtmkt_trd_tp" />
                    <input bind="txtacnt_tp" />
                    <input bind="txttype_dt" />
                    <input bind="txtbank_cd" />
                    <input bind="txtbank_nm" />
                    <input bind="txtamt" />
                    <input bind="txttrtype" />
                    <input bind="tac_abacctcode_pk_dr" />
                    <input bind="tac_abacctcode_pk_cr" />
                    <input bind="dtfrdate" />
                    <input bind="txtmkt_trd_tp1" />
                    <input bind="txtDescription" /> 
                </input> 
                <output>
                    <output bind="txtReturn" />
                </output>
            </dso> 
        </xml> 
</gw:data> 
    <table style="width:100%;height:100%" cellpadding="0" cellspacing="0" border="0">
        <tr style="width:100%;height:10%">
            <td width="100%">
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td>
                            <table border="0" width="100%" id="table1">
                                <tr>
                                    <td>
                                        <fieldset style="padding: 2; width: 100%; height: 100%">
                                            <table border="0" width="100%" id="table2">
                                                <tr>
                                                    <td align="right" width="18%">
                                                        Công ty</td>
                                                    <td width="75%" colspan="5">
                                                        <gw:list id="lstCompany" styles='width:100%' />
                                                    </td>
                                                    <td  width="7%"></td>
                                                    <td >
                                                        <gw:imgbtn id="ibtnSearch" img="search" width="100%" alt="Search" onclick="OnSearch()" />
                                                    </td>
                                                    <td >
                                                        <gw:imgbtn id="btnSearch1" img="process" width="100%" img="in" text="Process" onclick="Process()" />
                                                    </td>
                                                    <td >
                                                        <gw:imgbtn id="btnSearch5" img="post" width="100%" text="Post" onclick="" />
                                                    </td>
                                                    <td >
                                                        <gw:imgbtn id="btnSearch8" img="save" width="100%" text="Post" onclick="OnSave()" />
                                                    </td>
                                                    <td >
                                                        <gw:imgbtn id="btnSearch2" img="delete" width="100%" text="Cancel" onclick="OnDelete()" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="10%" align="right">
                                                        <a title="Nhấp vào đây để chọn sàn giao dịch" onclick="OnPopUp(2)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Sàn Giao Dịch</b></a></td>
                                                    <td width="20%">
                                                        <gw:list id="lsttrans" styles='width:100%' />
                                                    </td>
                                                    <td width="20%" align="right">
                                                        Ngày Giao Dịch</td>
                                                    <td width="20%" colspan="3">
                                                        <gw:datebox id="dtfrdate" type="date" lang="1" />
                                                    </td>
                                                   
                                                    <td width="5%"></td>
                                                    <td align="right" width="10%" >
                                                        <a title="Nhấp vào đây để chọn type" onclick="OnPopUp(1)" href="#tips" style="text-decoration : none;display:none; color=#0000FF"><b>Type</b></a></td>
                                                    <td width="20%" colspan="4">
                                                        <gw:list id="lstdate" styles='width:100%' style="display:none"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="15%" align="right">
                                                        <a title="Nhấp vào đây để chọn loại giao dịch" onclick="OnPopUp(3)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Loại Giao Dịch</b></a></td>
                                                    <td>
                                                        <gw:list id="lsttrans_type" styles='width:100%' />
                                                    </td>
                                                    <td width="10%" align="right">
                                                        Diễn giải</td>
                                                    <td width="75%" colspan="9">
                                                        <gw:textbox id="txtDescription" styles='width:100%' />
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                  </table>
                  </td> 
                           
        </tr>
        <tr style="width:100%;height:90%">
             <td width="100%">
                            <table align="top" cellspacing="0" cellpadding="0" border="0" style="width: 100%;
                                height: 100%;">
                                <tr valign="top">
                                    <td width="100%">
                                    <!--0._pk|1.Sàn Giao Dịch|2.Chưa Biết|3.Type|4.Bank ID|5.Loại Tài Khoản|6.Tiền|7.Loại Giao Dịch|8.Nợ|9.Có|10.Date|11.MKT_TRD_TP|12.Diễn Giải" -->
                                        <gw:grid id="idgrid" header="_pk|Sàn Giao Dịch|Loại Chứng Khoán|_Type|Tài Khoản|Loại Tài Khoản|Trị Giá|Giao Dịch|Tài Khoản Nợ|Tài Khoản Có|Ngày|_MKT_TRD_TP|Diễn Giải|_Nợ_pk|_Có_pk"
                                            format="0|0|0|0|0|0|0|0|0|0|4|0|0|0|0" aligns="0|0|0|0|0|0|3|0|0|0|0|0|0|0|0" defaults="||||||||||||||"
                                           editcol="0|0|0|0|0|0|0|0|0|0|0|0|1|0|0" widths="0|1500|1700|1000|1200|1500|2000|1200|3000|3000|1200|1500|2000|0|0"
                                            styles="width:100%; height:100%" sorting="T" oncelldblclick="GetAcc(4);GetAcc(5)" />
                                    </td>
                                    </tr>
                                    </table>
                                    </td>
                                    
        </tr>
    </table>
    <gw:textbox id="txtComCodeID"  text=""  styles='display:none'  />
    <gw:textbox id="txtCodeTemp"  text=""  styles='display:none'  />
    <gw:textbox id="tac_sectran_pk"  text=""  styles='display:none'  />
    <gw:textbox id="txtReturn"  styles='display:none;'/>
    <gw:textbox id="tac_abacctcode_pk_dr"  styles='display:none;'/>
    <gw:textbox id="tac_abacctcode_pk_cr"  styles='display:none;'/>
    <gw:textbox id="txt_action" text="INSERT" styles='display:none;'/>
    <gw:textbox id="txt_action2" text="DELETE" styles='display:none;'/>
    
    <gw:textbox id="txtmkt_trd_tp"  styles='display:none;'/>
    <gw:textbox id="txtacnt_tp"  styles='display:none;'/>
    <gw:textbox id="txttype_dt"  styles='display:none;'/>
    <gw:textbox id="txtbank_cd"  styles='display:none;'/>
    <gw:textbox id="txtbank_nm"  styles='display:none;'/>
    <gw:textbox id="txtamt"  styles='display:none;'/>
    <gw:textbox id="txttrtype"  styles='display:none;'/>
   
    <gw:textbox id="txtmkt_trd_tp1"  styles='display:none;'/>
   
  
</body>
</html>
