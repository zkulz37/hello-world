<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<!------------------------------------------------------------------>
<head id="Head1" runat="server">
    <title>Register Item</title>
</head>

<script type="text/javascript">

          
    var G1_PK=0,
        G1_PROD_ID=1,
        G1_PROD_CODE=2,
        G1_PROD_NAME=3,
        G1_PROD_LNAME=4,
        G1_PROD_FNAME=5,
        G1_UNIT=6,
        G1_HS_CODE=7,
        G1_PROD_STATUS=8,
        G1_TARIFF_CODE_TAX=9,
        G1_TAX=10,
        G1_ABSOLUTE_TAX=11,
        G1_TARIFF_CODE_VAT=12,
        G1_VAT=13,
        G1_ABSOLUTE_VAT=14,
        G1_TARIFF_CODE_EXCISE_TAX=15,
        G1_EXCISE_TAX=16,
        G1_ABSOLUTE_EXCISE_TAX=17,
        G1_TARIFF_CODE_ENVIR=18,
        G1_ENVIR_TAX=19,
        G1_ABSOLUTE_ENVIR_TAX=20,
        G1_OTHER_INCOME=21,
        G1_EXEMPTION_YN=22,
        G1_EXEMPTION_REFNO=23,
        G1_EXEMPTION_TAX=24,
        G1_EXEMPTION_TAX_REDURED=25,
        G1_IS_SYNC=26,
        G1_INCENTIVES=27,
        G1_HS_CODE_EXPANSION=28,
        G1_CUS_CODE=29,
        G1_COMPANY_CODE=30,
        G1_PROD_ID_DECL=31,
        G1_TRADE_REPORT_ID=32,
        G1_PROD_ID_TEMP=33,
        G1_IS_SHOW=34,
        G1_UNIT_PRICE_DECL=35,
        G1_DESCRIPTION=36,
        G1_USE_PURPOSE=37,
        G1_LUONG_Y=38,
        G1_KHO_Y=39,
        G1_TRI_GIA_Y=40,
        G1_STATUS=41;  
    

//===================================================================================
function OnPopUp(pos)
{
    switch(pos)
    {
        case 'Charger':
            var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
            if ( obj != null )
            {
                txtChargerName.text = obj[2];
                txtChargerID.text   = obj[1];
                txtChargerPK.text   = obj[0];
            }
            else
            {
                txtChargerName.text = '';
                txtChargerID.text   = '';
                txtChargerPK.text   = '';
            }
        break;    
        
        case 'HS_CODE':
            var r = event.row;
            var c = event.col;
            if(c == G1_HS_CODE)
            {
                var fpath = System.RootURL + '/form/fp/ab/fpab00390.aspx';
                var aValue  = System.OpenModal(  fpath , 550 , 500 , 'resizable:yes;status:yes');
                
                if ( aValue != null )
                {      
                     grdProd.SetGridText (r, G1_HS_CODE , aValue[2] );             
                }
            }		
        break;                                                                                                       
    }	       
}
 //---------------------------------------------------------
 function BodyInit()
 {
//    // Set control Charger la disable
//    txtChargerPK.SetEnable(false);
//    txtChargerID.SetEnable(false);
//    txtChargerName.SetEnable(false);   
//     
//    var ldate;
//    ldate=dtFromOrderDate.value;         
//    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01'           
//    dtFromOrderDate.value=ldate ; 
//    
    txt_Company_Code.text = '0900283167';
    BindingDataList();
//    FormatGrid();
//    OnChangeTab();
    OnSearch(1);
 } 
  
 //---------------------------------------------------------
 function OnProcess(obj)
 {
    switch(obj)
    {
        case 'Submit':   
            if(grdProd.rows>0)
                epcs00030_Submit.Call('');
            break;
        //--------------------            
//        case 'Approve':
//            var po_pk = "";            
//            for(var i=1; i<grdProd.rows; i++)
//            {
//                var a = grdProd.GetGridData( i, G2_PK);
//                var b = grdProd.GetGridData( i, G2_STITEM_PK);
//                
//                if ( a =! '' )
//                {
//                   po_pk= po_pk + b +",";
//                }
//            }            
//            txtArrayPk.text = po_pk.substring( 0, po_pk.length-1);
//            
//            if ( txtArrayPk.text != '' )
//            {
//                if ( confirm ('Do you want to approve this Item?'))
//                {
//                    epcs00030_Approve.Call('');
//                }
//            }                      
//         break;
    }    
 }
 
 //---------------------------------------------------------
 function OnSave()
 {
     epcs00050.Call();
 }
  //---------------------------------------------------------
 function OnDelete()
 {
              
            var r = event.row;
            grdProd.DeleteRow();
       
 }
 //---------------------------------------------------------
 function FormatGrid()
 {
      var trl
      trl=grdProd.GetGridControl();	
     // trl.ColFormat(G2_SEQ )    = "###,###,###,###,###";
 }
 
  //---------------------------------------------------------
 function BindingDataList()
 {    
    var data="";    
//    data = "DATA|1|SAVED|2|SUBMITED|3|APPROVED|4|CANCEL||Select All";    
//    cboStatus.SetDataText(data);
//    cboStatus.value = "";

    data = "<%=ESysLib.SetGridColumnDataSQL("SELECT   a.code,a.code||' - '|| a.code_nm FROM tlg_lg_code a, tlg_lg_code_group b  WHERE b.GROUP_ID = 'IECU03' AND a.tlg_lg_code_group_pk = b.pk AND a.use_if = 'Y' AND a.del_if = 0 AND b.del_if = 0 ORDER BY a.code, a.code_nm")%>";   
    grdProd.SetComboFormat(G1_UNIT,data);
    
    data = "<%=ESysLib.SetGridColumnDataSQL("select tariffs_code ,tariffs_code || ' - ' || tariffs_name from TLG_IE_TARIFFS where del_if = 0 and tax_type in ('N','KHAC')")%>||";   
    grdProd.SetComboFormat(G1_TARIFF_CODE_TAX,data);
    
    
    data = "<%=ESysLib.SetGridColumnDataSQL("select tariffs_code ,tariffs_code || ' - ' || tariffs_name from TLG_IE_TARIFFS where del_if = 0 and tax_type in ('VAT')")%>||";   
    grdProd.SetComboFormat(G1_TARIFF_CODE_VAT,data);
    
    data = "<%=ESysLib.SetGridColumnDataSQL("select tariffs_code ,tariffs_code || ' - ' || tariffs_name from TLG_IE_TARIFFS where del_if = 0 and tax_type in ('TTDB')")%>||";   
    grdProd.SetComboFormat(G1_ABSOLUTE_VAT,data);
    
    data = "<%=ESysLib.SetGridColumnDataSQL("select tariffs_code ,tariffs_code || ' - ' || tariffs_name from TLG_IE_TARIFFS where del_if = 0 and tax_type in ('MT')")%>||";   
    grdProd.SetComboFormat(G1_TARIFF_CODE_ENVIR,data);
    
    data = "<%=ESysLib.SetGridColumnDataSQL("SELECT   a.code,a.code||' - '|| a.code_nm FROM tlg_lg_code a, tlg_lg_code_group b  WHERE b.GROUP_ID = 'IECU05' AND a.tlg_lg_code_group_pk = b.pk AND a.use_if = 'Y' AND a.del_if = 0 AND b.del_if = 0 ORDER BY a.ord, a.code, a.code_nm")%>";   
    grdProd.SetComboFormat(G1_INCENTIVES,data);
    
    data = "<%=ESysLib.SetGridColumnDataSQL("SELECT   a.code,a.code||' - '|| a.code_nm FROM tlg_lg_code a, tlg_lg_code_group b  WHERE b.GROUP_ID = 'IECU06' AND a.tlg_lg_code_group_pk = b.pk AND a.use_if = 'Y' AND a.del_if = 0 AND b.del_if = 0 ORDER BY a.ord, a.code, a.code_nm")%>";   
    grdProd.SetComboFormat(G1_PROD_STATUS,data);

    //lst_Customs
    data = "<%=ESysLib.SetListDataSQL("SELECT cus_code, cus_code || ' - ' || cus_name FROM TLG_IE_CUSTOMS where show_yn = 'Y' and del_if = 0")%>||Select ALL";   
    lst_Customs.SetDataText(data);
    lst_Customs.value = 'P03L' ; 
    lst_Customs.SetEnable(false);
    
    //lst_Status    
    data = "<%=ESysLib.SetListDataSQL("SELECT   a.code,a.code||' - '|| a.code_nm FROM tlg_lg_code a, tlg_lg_code_group b  WHERE b.GROUP_ID = 'IECU0200' AND a.tlg_lg_code_group_pk = b.pk AND a.use_if = 'Y' AND a.del_if = 0 AND b.del_if = 0 ORDER BY a.def_yn desc,a.code, a.code_nm")%>||Select ALL";   
    lst_Status.SetDataText(data);
    lst_Status.value = '' ; 
	
	//lst_Status 2    
    data = "<%=ESysLib.SetListDataSQL("SELECT   a.code,a.code||' - '|| a.code_nm FROM tlg_lg_code a, tlg_lg_code_group b  WHERE b.GROUP_ID = 'IECU0100' AND a.tlg_lg_code_group_pk = b.pk AND a.use_if = 'Y' AND a.del_if = 0 AND b.del_if = 0 ORDER BY a.def_yn desc,a.code, a.code_nm")%>||Select ALL";   
    lst_Status2.SetDataText(data);
  }        
 
 //---------------------------------------------------------
 function OnSearch(pos)
 {
      switch (pos)         
      {		        
        case 1 ://Production List
            epcs00050.Call("SELECT");
            break;
        case 2: //Declaration proccess
            epcs00050_1.Call("SELECT");
            break;
      }  
 }

 //---------------------------------------------------------
 function OnDataReceive(obj)
 {
//    if(obj.id == "epcs00030_m")
//    {       
//       for ( var i=0; i<grdProd.rows ; i++ )
//            {
//                if ( grdProd.GetGridData( i, G2_TIE_ITEM_REG_M_PK ) == '' )
//                {
//                    grdProd.SetGridText ( i, G2_TIE_ITEM_REG_M_PK , txtMasterPK.text );
//                }
//            }   
//        epcs00030_d.Call();
//    }
    if(obj.id == "epcs00030_d")
    {       
       radTab.value = group;
    }    
    if(obj.id == "epcs00030_Submit")
    {
        epcs00050.Call('SELECT');        
    }
    if(obj.id == "epcs00030_Approve")
    {
        epcs00050.Call('SELECT');        
    }
    if(obj.id == "epcs00050")
    {     
        lbRecord.text = grdProd.rows-1 + " row(s)";
		epcs00050_1.Call("SELECT");
    }
	if(obj.id == "epcs00050_1")
    {     
        lbRecord2.text = grdProd2.rows-1 + " row(s)";
    }
	
 }
 //------------------------------------------------------------
 function OnAddNew(objState)
 {                                 
        grdProd.AddRow();                            

        grdProd.SetGridText( grdProd.rows-1, G1_CUS_CODE , lst_Customs.value); //customs code	                            
        grdProd.SetGridText( grdProd.rows-1, G1_PROD_STATUS, '1');//status
        grdProd.SetGridText( grdProd.rows-1, G1_COMPANY_CODE,  txt_Company_Code.text  );//ma don vi	    
        
//        grdProd.SetGridText( grdProd.rows-1, G2_ITEM_NAME,    arrTemp[4]);//item_name	    
//        grdProd.SetGridText( grdProd.rows-1, G2_UOM, arrTemp[5]);//item_uom
//        grdProd.SetGridText( grdProd.rows-1, G2_HS_CODE, arrTemp[6]);//HS_CODE
//        grdProd.SetGridText( grdProd.rows-1, G2_IMEX_TAX, arrTemp[7]);//IMEX_TAX
//        grdProd.SetGridText( grdProd.rows-1, G2_CONS_TAX, arrTemp[8]);//CONS_TAX
//        grdProd.SetGridText( grdProd.rows-1, G2_VAT_TAX, arrTemp[9]);//VAT_TAX                          
 }
 //=====================================================================================
 function OnChangeTab()
 { 
    group = radTab.GetData();
    var strRad = radTab.GetData();
             
	switch (strRad)
	{
		case '1':
		    document.all("tabProduct").style.display     = ""; 		    
		    document.all("tabProduct").style.color     = "red"; 
		    document.all("tabItem").style.color = "";
         break;
        
        case '2':
		    document.all("tabItem").style.display = ""; 		    
		    document.all("tabProduct").style.color     = ""; 
		    document.all("tabItem").style.color = "red";
         break;	        
     } 
 }
 //=====================================================================================
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="epcs00050" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
            <dso id="epcs00050" type="grid"  parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28"  function="<%=l_user%>lg_sel_epcs00050"  procedure = "<%=l_user%>lg_upd_epcs00050"  > 
                <input> 
                    <input bind="lst_Customs" /> 
                    <input bind="txt_Company_Code" /> 
                    <input bind="lst_Status" /> 
                    <input bind="txt_Code" /> 
                    <input bind="txt_name" /> 
                </input> 
                <output bind="grdProd" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
      <gw:data id="epcs00050_1" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
            <dso id="epcs00050_1" type="grid" parameter="0,1,2,3,5,6,7,8,9,10"  function="<%=l_user%>lg_sel_epcs00050_1"> 
                <input> 
					<input bind="lst_Customs" /> 
                    <input bind="txt_Company_Code" /> 
                    <input bind="lst_Status2" /> 
                </input> 
                <output bind="grdProd2" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
     <%--<gw:data id="epcs00030_Submit" onreceive="OnDataReceive(this)">
        <xml>                                                               
            <dso type="process" procedure = "<%=l_user%>lg_pro_epcs00030_submit" > 
                <input> 
                    <input  bind="txtMasterPK" />                     
                </input>
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="epcs00030_Approve" onreceive="OnDataReceive(this)">
        <xml>                                                               
            <dso type="process" procedure = "<%=l_user%>lg_PRO_EPCS00030_APPROVE" > 
                <input> 
                    <input  bind="txtArrayPk" />  
                    <input  bind="txtMasterPK" />                    
                </input>
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="epcs00030_m" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
            <dso id="epcs00030_m" type="control"   parameter="0,1,2,3,4,5,6,7,8,9" user="imex" function="<%=l_user%>lg_sel_epcs00030_m"  procedure="<%=l_user%>lg_upd_epcs00030_m" > 
                <inout> 
                     <inout  bind="txtMasterPK" />
                     <inout  bind="dtRegDate" />
                     
                     <inout  bind="txtChargerPK" />  
                     <inout  bind="txtChargerID" />  
                     <inout  bind="txtChargerName" />
                                          
                     <inout  bind="lbRecord" />                     
                     <inout  bind="txtDescription" />
                     
                     <inout bind="radTab" /> 
                     
                     <inout  bind="txtReceiveNo" />
                     <inout  bind="dtRecDate" /> 
                 </inout>                 
                <output bind="txtMasterPK" /> 
            </dso> 
        </xml> 
    </gw:data>--%>
    <!------------------------------------------------------------------>
    <form id="form1" runat="server">
    <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <!--<gw:tab> -->
                <gw:tab>
                    <table name="Prod List" width="100%" cellpadding="0" cellspacing="0" border="1" style="height: 100%">
                        <tr style="height: 1%">
                            <td>
                                <table style="width: 100%; height: 100%">
                                    <tr>
                                        <td  style="white-space: nowrap; width: 5%">
                                            Customs
                                        </td>
                                        <td style="width: 25%">
                                            <gw:list id="lst_Customs" styles="width:100%" />
                                            <gw:textbox id="txt_Company_Code" styles="width:100%;display:none;" />
                                        </td>
                                        <td style="white-space: nowrap; width: 5%">
                                            Code
                                        </td>
                                        <td style="width: 35%; white-space: nowrap">
                                            <gw:textbox id="txt_Code" styles="width:100%" />
                                        </td>
                                        <td style="width:25%">
                                        </td>
                                        <td style="width: 1%">
                                            <gw:button id="btn_New" img="new" alt="New" onclick="OnAddNew('Master')" />
                                        </td>
                                        <td style="width: 1%">
                                            <gw:button id="btn_Search" img="search" alt="Search" onclick="OnSearch(1)" />
                                        </td>
                                        <td style="width: 1%">
                                            <gw:button id="btn_Delete" img="delete" alt="Delete" onclick="OnDelete()" />
                                        </td>
                                        <td style="width: 1%">
                                            <gw:button id="btn_UnDelete" img="undelete" alt="UnDelete" onclick="OnDelete()" />
                                        </td>
                                        <td style="width: 1%">
                                            <gw:button id="btn_Save" img="save" alt="Save" text="Save" onclick="OnSave()" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="white-space: nowrap; width: 5%">
                                            Status
                                        </td>
                                        <td style="width: 25%">
                                            <gw:list id="lst_Status" styles="width:100%" />
                                        </td>
                                        <td  style="white-space: nowrap; width: 5%">
                                            Name
                                        </td>
                                        <td style="width: 35%">
                                            <gw:textbox id="txt_name" styles="width:100%" />
                                        </td>
                                        <td style="width: 25%" align="center">
                                            <gw:label id="lbRecord" styles='width:100%;color:cc0000;font:9pt'></gw:label>
                                        </td>
                                        <td colspan="5" style="width: 5%">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr style="height: 100%; vertical-align: top; text-align: left;">
                                        <td style="width: 100%" colspan="11">                                                
                                                <gw:grid id='grdProd'
                                                    header='_PK|_prod_id|Prod Code|prod Name|prod Name(En)|_PROD_NAME_2|Unit|HS Code|Status goods|Im tariff code|IMEX_TAX|ABSOLUTE_TAX_RATE|VAT_TARIFFS|VAT_TAX|VAT_ABSOLUTE|EXCIE_TAX|TAX_EXCISE_ABSOLUTE|TAX_ENVIR_TARFFIS|TAX_ENVIR|TAX_ENVIR_ABSOLUTE|OTHER_REC|EXEMPTION_YN|EXEMPTION_REFNO|EXEMPTION_TAX|EXEMPTION_TAX_REDUCED|IS_SYNC|INCENTIVES|_CUS_CODE|_MA_DV|HS_CODE_EXPANSION'
                                                    format='0|0|0|0|0|0|0|2|0|2|2|1|1|2|1|1|2|1|2|1|1|1|3|0|1|0|3|2|0'
                                                    aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                                    check='||||||||||||||||||||||||||||'
                                                    editcol='1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1'
                                                    widths='1000|1000|1000|1200|3000|3000|1000|1000|1200|1200|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                                    sorting='T'
                                                    styles='width:100%; height:100%'
                                                    oncelldblclick="OnPopUp('HS_CODE')" 
                                                    />
                                                
                                        </td>
                        </tr>
                    </table>
               
                <table name="Declaration Process"  style="width: 100%; height: 100%; " cellpadding="0" cellspacing="0" border="1"   >
                 <tr style="height: 1%">
                            <td>
                                <table style="width: 100%; height: 100%">
                                    <tr>
                                        <td style="white-space: nowrap; width: 5%">
                                            Status
                                        </td>
                                        <td style="width: 40%">
                                            <gw:list id="lst_Status2" styles="width:100%" />
                                        </td>
                                        <td  style="white-space: nowrap; width: 54%" align="center" >
                                            <gw:label id="lbRecord2" styles='width:100%;color:cc0000;font:9pt'></gw:label>
                                        </td>
                                        <td style="width: 1%">
                                            <gw:button id="btn_Search2" img="search" alt="Search" onclick="OnSearch(2)" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr style="height: 100%; vertical-align: top; text-align: left;">
							<td style="width: 100%" colspan="11"> 
								<gw:grid id='grdProd2'
									header='_PK|Decl Date|Recep NO|Recep Date|Status|Remarks'
									format='0|4|0|4|2|0'
									aligns='0|1|1|1|1|0'
									check='|||||'
									editcol='0|0|0|0|0|0'
									widths='1000|1000|1000|1000|1000|1000'
									sorting='T'
									autosize='T' 
									styles='width:100%; height:100%'
									oncelldblclick='OnGridCellDblClick(this)'
									/>
                            </td>
                        </tr>
                 </table>
                 
                
                </gw:tab>
                <!--</gw:tab> -->
            </td>
        </tr>
    </table>
    <!------------------------------------------->
    </form>
</body>
</html>
