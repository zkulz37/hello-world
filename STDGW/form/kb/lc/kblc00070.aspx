<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title>Inspection Incomming</title>
</head>

<script type="text/javascript" language="javascript">

var flag;
var rtnLGCode = '' ;
var G_Inspect_pk = 0,
    G_Net_Wt_LB = 16,
    G_Net_Wt_KG = 19,
    G_Net_Wt_LB_DOC = 23,
    G_Net_Wt_KG_DOC = 26;
//------------------------------------------------------------

function BodyInit()
{
     System.Translate(document);  // Translate to language session
	
    txtUser_PK.text = "<%=session("USER_PK")%>"; 
     //-------------------------
   var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFromSearch.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFromSearch.value=ldate ;     
   //---------------------------- 
    BindingDataList(); 
    data_kblc00070_1.StatusInsert();
    data_kblc00070.Call('SELECT')
}
//==================================================================================
 
 function BindingDataList()
 { 
     var data = "";
     var data1 = "";
     var data2 = "";   
    data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0040' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    lstStoredFact.SetDataText(data); 
    lstStoredFact.value = '' ; 
      
    data1 = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0070' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    lstStatus.SetDataText(data1); 
    lstStatus.value = '' ; 
	
	data2 = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0100' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    lstCompany.SetDataText(data2); 
    lstCompany.value = '' ;
    
    data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='IEBS0070' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";             
    lstShipper.SetDataText( data);
    lstShipper.value = '' ;
    
    data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGCM0130' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    lstPrice.SetDataText(data); 
    lstPrice.value = '10' ;
    
    data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGCM0220' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    lstCountry.SetDataText(data); 
    lstCountry.value = '01' ; 
 } 
 //==================================================================================
 function OnShowPopup(obj)
 {
    switch(obj)
        {
            case 'FACTORY':
                 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGKB0040";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	        	                   
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'LGKB0040';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstStoredFact.value = object[1];      
	                }    	                
	             }                              
            break;
            case 'STATUS':
                 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGKB0070";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	        	                   
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'LGKB0070';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstStatus.value = object[1];      
	                }    	                
	             }                              
            break;
             
            case 'SHIPPER':
                     var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=IEBS0070";
	                 var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
        	         
	                 if ( object != null )
	                 {	        
	                    if ( object[0] == 1 )
	                    {
	                        txtLGGroupCodeID.text = 'IEBS0070';
	                        rtnLGCode             = object[1];
        	                
                            data_fpab00220_2.Call("SELECT");                                
	                    }
	                    else
	                    {
	                        lstShipper.value = object[1];      
	                    }    	                
	                 }                              
                break;
                case 'ORIGIN':
                     var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0220";
	                 var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
        	         
	                 if ( object != null )
	                 {	        	                   
	                    if ( object[0] == 1 )
	                    {
	                        txtLGGroupCodeID.text = 'LGCM0220';
	                        rtnLGCode             = object[1];
        	                
                            data_fpab00220_2.Call("SELECT");                                
	                    }
	                    else
	                    {
	                        lstCountry.value = object[1];      
	                    }    	                
	                 }                              
                break; 
                case 'LCNO':
                     var path = System.RootURL + "/form/kb/lc/kblc00071.aspx";
	                 var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
              	                   
                     if ( object != null )
                     {	         
                        txtLCNoPK.text   = object[0];
                        txtLCNo.text   = object[2];
                        txtProductName.text = object[8];
                        //txtLCQty.text = object[10];                                              
                     }          
	           break;
	           case 'PRICE':
                     var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0130";
	                 var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
        	         
	                 if ( object != null )
	                 {	        	                   
	                    if ( object[0] == 1 )
	                    {
	                        txtLGGroupCodeID.text = 'LGCM0130';
	                        rtnLGCode             = object[1];
        	                
                            data_fpab00220_2.Call("SELECT");                                
	                    }
	                    else
	                    {
	                        lstPrice.value = object[1];      
	                    }    	                
	                 }                              
                break;
                case 'COMPANY':
                     var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGKB0100";
	                 var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
        	         
	                 if ( object != null )
	                 {	        	                   
	                    if ( object[0] == 1 )
	                    {
	                        txtLGGroupCodeID.text = 'LGKB0100';
	                        rtnLGCode             = object[1];
        	                
                            data_fpab00220_2.Call("SELECT");                                
	                    }
	                    else
	                    {
	                        lstInspecComp.value = object[1];      
	                    }    	                
	                 }                
	           break;                 
       }
 }

//-------------------------------------------------------------------------------------
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdInspect':
            data_kblc00070.Call("SELECT");
        break;  
        case 'Master':
            txtMasterPK.text  = grdInspect.GetGridData(grdInspect.row,G_Inspect_pk);
            data_kblc00070_1.Call("SELECT");
        break;      
    }
}
//====================================================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {
      case "data_fpab00220_2":
             if ( txtLGGroupCodeID.text == 'LGKB0040')
             {
                lstStoredFact.SetDataText(txtLGCodeList.text);  
                lstStoredFact.value = rtnLGCode;                      
             }
             else if ( txtLGGroupCodeID.text == 'LGKB0070')
             {
                lstStatus.SetDataText(txtLGCodeList.text);  
                lstStatus.value = rtnLGCode;                      
             }
        break;
      case 'data_kblc00070_1':
            if(flag=='save')
            {
                flag = 'search';
                data_kblc00070.Call('SELECT');
            }
      break;
      
      case 'data_kblc00070':
            lblRecord.text  = ( grdInspect.rows -1 )+ " record(s)."
            if(grdInspect.rows -1 >0)
            {
                grdInspect.SetCellBgColor( 1, G_Net_Wt_LB, grdInspect.rows - 1, G_Net_Wt_LB + 2, 0xCCFFFF );
                grdInspect.SetCellBgColor( 1, G_Net_Wt_KG, grdInspect.rows - 1, G_Net_Wt_KG + 2, 0xFFFFCC );
                grdInspect.SetCellBgColor( 1, G_Net_Wt_LB_DOC, grdInspect.rows - 1, G_Net_Wt_LB_DOC + 2, 0xCCFFFF );
                grdInspect.SetCellBgColor( 1, G_Net_Wt_KG_DOC, grdInspect.rows - 1, G_Net_Wt_KG_DOC + 2, 0xFFFFCC );
            }
      break;
        
    }
}
//====================================================================================

function Validate()
{       
  if(txtNetWt.text =="" || txtNetWt.text =="0" )
    {
        alert("Please, input Net Wt!");
        return false;
    }
    
     else if(txtTareWt.text =="" || txtTareWt.text =="0")
    {
        alert("Please, input Tare Wt!");
        return false;
    }
    
     else if( txtGrossWt.text =="" || txtGrossWt.text =="0" )
    {
        alert("Please, input Gross Wt!");
        return false;
    }
      else if(txtNetKG.text =="" || txtNetKG.text =="0")
    {
        alert("Please, input Net KG!");
        return false;
    }
      else if(txtTareKG.text =="" || txtTareKG.text =="0")
    {
        alert("Please, input Tare KG!");
        return false;
    }
     else if( txtGrossKG.text =="" || txtGrossKG.text =="0" )
    {
        alert("Please, input Gross KG!");
        return false;
    }
      else if(txtDocNetKG.text =="" || txtDocNetKG.text =="0")
    {
        alert("Please, input Doc Net KG!");
        return false;
    }
      else if(txtDocTareKG.text =="" || txtDocTareKG.text =="0")
    {
        alert("Please, input Doc Tare KG!");
        return false;
    }
     else if( txtDocGrossKG.text =="" || txtDocGrossKG.text =="0" )
    {
        alert("Please, input Gross KG!");
        return false;
    }
      else if(txtDocNetWt.text =="" || txtDocNetWt.text =="0")
    {
        alert("Please, input Doc Net Wt!");
        return false;
    }
      else if(txtDocTareWt.text =="" || txtDocTareWt.text =="0")
    {
        alert("Please, input Doc Tare Wt!");
        return false;
    }
     else if( txtDocGrossWt.text =="" || txtDocGrossWt.text =="0" )
    {
        alert("Please, input Gross Wt!");
        return false;
    }
   return true;
}

//====================================================================================

function OnSave()
{ 
    flag='save';
    if(data_kblc00070_1.GetStatus() == 20)  
    { 
        if(Validate())
        {
             data_kblc00070_1.Call();  
        }
           
    }else
    {    
        data_kblc00070_1.Call();                
    }

}
function OnAddNew()
{
    data_kblc00070_1.StatusInsert();
}
//====================================================================================
 function OnDelete()
 {     
    if(confirm("Do you want to delete this data?"))  
    { 
       data_kblc00070_1.StatusDelete();
       OnSave();
    }
 }
 //====================================================================================
function OnCalAuto()
{
    txtGrossWt.text = parseInt(txtNetWt.text) + parseInt(txtTareWt.text);
    txtGrossKG.text =  parseInt(txtNetKG.text) + parseInt(txtTareKG.text);
    txtDocGrossWt.text = parseInt(txtDocNetWt.text) + parseInt(txtDocTareWt.text);
    txtDocGrossKG.text = parseInt(txtDocNetKG.text) + parseInt(txtDocTareKG.text);
}    
//====================================================================================   
</script>

<body>   
     <!-----------------------------LOGISTIC CODE------------------------------------->
    <gw:data id="data_fpab00220_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="<%=l_user%>lg_sel_fpab00220_2" > 
                <input> 
                    <input bind="txtLGGroupCodeID" />
                </input>
	           <output>
	                <output bind="txtLGCodeList" /> 
	           </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--============================================= Search =====================================-->
    <gw:data id="data_kblc00070" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso id="2"	type="grid"	parameter="0,1,2,3"	function="<%=l_user%>lg_sel_kblc00070"	>	
				<input>
					<input	bind="dtFromSearch"	/>	
					<input	bind="dtToSearch"	/>	
					<input	bind="txtProdSearch"	/>	
					<input	bind="txtSearchNo"	/>	
				</input>	
				<output	bind="grdInspect"	/>	
			</dso>	
		</xml>	
	</gw:data>
	<!--============================================= Master =====================================-->
    <gw:data id="data_kblc00070_1" onreceive="OnDataReceive(this)">	
		<xml>	
			<dso	type="control"	parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30"	function="<%=l_user%>lg_sel_kblc00070_1"	procedure="<%=l_user%>lg_upd_kblc00070_1">	
				<inout>	
						<inout	bind="txtMasterPK"	/>
						<inout	bind="txtSlipNo"	/>
						<inout	bind="dtInspectDT"	/>
						<inout	bind="lstStatus"	/>
						
						<inout	bind="txtP0NO"	/>
						<inout	bind="txtInvoiceNo"	/>
						<inout	bind="txtTurnedNum"	/>
						
						<inout	bind="txtLCNoPK"	/>
						<inout	bind="txtLCNo"	/>
						<inout	bind="txtProductName"	/>
                        <inout	bind="txtOpenPrice"	/>
                        
						<inout	bind="lstStoredFact"	/>						
						<inout	bind="lstShipper"	/>	
						<inout	bind="lstCompany"	/>							
						
						<inout	bind="lstCountry"	/>
						<inout	bind="lstPrice"	/>					
						<inout	bind="txtSign"	/>
                        								
						<inout	bind="txtNunOfRod"	/>
						<inout	bind="txtNetWt"	/>	
						<inout	bind="txtTareWt"	/>
						<inout	bind="txtGrossWt"	/>	
						
						<inout	bind="txtNetKG"	/>
						<inout	bind="txtTareKG"	/>	
						<inout	bind="txtGrossKG"	/>	
						
						<inout	bind="txtNumOfRodDoc"	/>
						<inout	bind="txtDocNetWt"	/>	
						<inout	bind="txtDocTareWt"	/>	
						<inout	bind="txtDocGrossWt"	/>						
						<inout	bind="txtDocNetKG"	/>	
						<inout	bind="txtDocTareKG"	/>	
						<inout	bind="txtDocGrossKG"	/>												
				</inout>
			</dso>	
		</xml>	
	</gw:data>
    <!---------------------------------------------------------------------->
    <table border="1" style="width: 100%; height: 100%">
        <tr style="height: 20%">
        <td>
        <table style="width: 100%; height: 100%">
            <tr style="height: 1%">
                <td style="width: 12%"></td>
                <td style="width: 23%" ></td>
                <td style="width: 12%"></td>
                <td style="width: 18%"></td>
                <td style="width: 12%"></td>
                <td style="width: 15%"></td>             
                <td style="width: 2%" align="right">
                    <gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="OnAddNew()" />
                </td>
                <td style="width: 2%" align="right">
                    <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete()" />
                </td>
                <td style="width: 2%" align="right">
                    <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave()" />
                </td>
            </tr>
            <tr>
                <td align="right" style="width: 12%;">
                                Slip No
                 </td>
                  <td style="width: 23%" >
                       <gw:textbox id="txtSlipNo" styles="width:100%;" csstype="mandatory"/>
                 </td>
                  <td align="right" style="width: 12%;" >
                               Inspect DT 
                 </td>
                  <td style="width: 18%">
                      <gw:datebox id="dtInspectDT" lang="1"  />
                 </td>
                   <td align="right" style="width: 12%;"><a onclick="OnShowPopup('STATUS')" href="#tips" style="color: #0000ff">
                       Income Status</a>
                              
                 </td>
                 <td colspan="4" style="width: 23%">
                      <gw:list id="lstStatus" styles="width:100%;" />
                 </td>                 
            </tr>
            <tr>
                 <td align="right" style="width: 12%;">
                    P/0 No    
                 </td>
                  <td style="width: 23%">
                        <gw:textbox id="txtPOPK" styles="width:100%;display:none"  />
                       <gw:textbox id="txtP0NO" styles="width:100%;"  />
                      
                 </td>                
                  <td align="right" style="width: 12%; ">
                      Invoice No</td>
                  <td style="width: 18%">   
                      <gw:textbox id="txtInvoiceNo" styles="width:100%;"  /></td>
                  <td align="right" style="width: 12%;">
                              Turned Num
                 </td>
                  <td colspan="4" style="width: 23%">
                        <gw:textbox id="txtTurnedNum" styles="width:100%;" type="number" format="###,###,###,###.#R"/>
                 </td>
                 
            </tr>
             <tr>
                 <td align="right" style="width: 12%;">
                 <a onclick="OnShowPopup('LCNO')" href="#tips" style="color: #0000ff">
                                L/C No</a>    
                 </td>
                  <td style="width: 23%">
                      <gw:textbox id="txtLCNoPK" text="" style="display: none" />  
                      <gw:textbox id="txtLCNo" csstype="mandatory" styles="width:100%;" readonly="true" />          
                 </td>                
                  <td align="right" style="width: 12%; ">
                      Item
                 </td>
                  <td style="width: 18%">       
                       <gw:textbox id="txtProductName" csstype="mandatory" styles="width:100%; " readonly="true" /></td>
                  <td align="right" style="width: 12%;">
                            Open Price  
                      </td>
                  <td colspan="4" style="width: 23%">
                        <gw:textbox id="txtOpenPrice" styles="width:100%;" type="number" format="###,###,###,###.#R" />
                      </td>
                 
            </tr>
            <tr>
                 <td align="right" style="width: 12%;">
                     <a onclick="OnShowPopup('FACTORY')" href="#tips" style="color: #0000ff">
                       Stored Fact</a>
                     </td>
                  <td style="width: 23%">   
                      <gw:list id="lstStoredFact" styles="width:100%;" /> 
                      </td>                
                  <td align="right" style="width: 12%; "><a onclick="OnShowPopup('SHIPPER')" href="#tips" style="color: #0000ff">
                       Shipper</a>
                 </td>
                  <td style="width: 18%">
                       <gw:list id="lstShipper" styles="width:100%;" />
                      </td>
                  <td align="right" style="width: 12%;">
                              <a onclick="OnShowPopup('COMPANY')" href="#tips" style="color: #0000ff">
                       Inspection Company</a>
                 </td>
                  <td colspan="4" style="width: 23%">
                       <gw:list id="lstCompany" styles="width:100%;"  />
                    </td>
                 
            </tr>
            <tr>
                
                  <td align="right" style="width: 12%; "> 
                      <a onclick="OnShowPopup('ORIGIN')" href="#tips" style="color: #0000ff">
                              Origin</a></td>
                  <td style="width: 23%">    
                      <gw:list id="lstCountry" styles="width:100%;" />
                      </td>
                 <td align="right" style="width: 12%;">
                       <a onclick="OnShowPopup('PRICE')" href="#tips" style="color: #0000ff">
                                Price terms</a>
                 </td>
                  <td style="width: 18%">
                       <gw:list id="lstPrice" styles="width:100%;" />
                 </td>
                 <td align="right" style="width: 12%; ">
                      Mark</td>
                  <td colspan="4" style="width: 23%">
                      <gw:textbox id="txtSign" styles="width:100%;"  />                         
                 </td>
            </tr>
            <tr>
                 <td align="right" style="width: 12%;">
                       Num of Rod
                 </td>
                  <td style="width: 23%" >
                       <gw:textbox id="txtNunOfRod" styles="width:100%;"/>
                 </td>
                  <td align="right" style="width: 12%;">                
                 </td>
                  <td style="width: 18%" >        
                 </td>
                 <td align="right" style="width: 12%;">        
                 </td>
                 <td colspan="4" style="width: 23% ;">
                      
                 </td>                 
            </tr>      
              <tr>
                 <td align="right" style="width: 12%;">
                         Net Wt(LB)
                 </td>
                  <td style="width: 23%">
                       <gw:textbox id="txtNetWt" styles="width:100%;" type="number" format="###,###,###,###.#R" onchange="OnCalAuto()"/>
                 </td>
                  <td align="right" style="width: 12%;">
                         Net Wt(KG)
                 </td>
                  <td style="width: 18%">
                        <gw:textbox id="txtNetKG" styles="width:100%;" type="number" format="###,###,###,###.#R" onchange="OnCalAuto()"/>
                 </td>
                 <td align="right" style="width: 12%;">       
                 </td>
                 <td colspan="4" style="width: 28%;">          
                 </td>                 
            </tr>  
             <tr>
                 <td align="right" style="width: 12%;">
                         Tare Wt(LB)
                 </td>
                  <td style="width: 23%" >
                       <gw:textbox id="txtTareWt" styles="width:100%;" type="number" format="###,###,###,###.#R" onchange="OnCalAuto()"/>
                 </td>
                  <td align="right" style="width: 12%;">
                         Tare Wt(KG)
                 </td>
                  <td style="width: 18%">
                        <gw:textbox id="txtTareKG" styles="width:100%;" type="number" format="###,###,###,###.#R" onchange="OnCalAuto()"/>
                 </td>
                 <td align="right" style="width: 12%;">         
                 </td>
                 <td colspan="4" style="width: 28%;">                
                 </td>                 
            </tr>  
            
             <tr>
                 <td align="right" style="width: 12%;">
                         Gross Wt(LB)
                 </td>
                  <td style="width: 23%" >
                       <gw:textbox id="txtGrossWt" styles="width:100%;" type="number" format="###,###,###,###.#R" /></td>
                  <td align="right" style="width: 12%;">
                         Gross Wt(KG)
                 </td>
                  <td style="width: 18%">
                        <gw:textbox id="txtGrossKG" styles="width:100%;" type="number" format="###,###,###,###.#R" />
                 </td>
                 <td align="right" style="width: 12%;">                 
                 </td>
                 <td colspan="4" style="width: 28%;" >            
                 </td>                 
            </tr> 
             <tr>
                 <td align="right" style="width: 12%; background-color:#CCCCCC">
                       DOC Num of Rod
                 </td>
                  <td style="width: 23%; background-color:#CCCCCC" >
                        <gw:textbox id="txtNumOfRodDoc" styles="width:100%;" type="number" format="###,###,###,###.#R" />
                 </td>
                  <td align="right" style="width: 12%;background-color:#CCCCCC">            
                      </td>
                  <td style="width: 18%;background-color:#CCCCCC" >            
                 </td>
                 <td align="right" style="width: 12%;">               
                 </td>
                 <td colspan="4" style="width: 23% ;">            
                 </td>                 
            </tr>      
              <tr>
                 <td align="right" style="width: 12%;background-color:#CCCCCC">
                         DOC Net Wt(LB)
                 </td>
                  <td style="width: 23%;background-color:#CCCCCC">
                       <gw:textbox id="txtDocNetWt" styles="width:100%;" type="number" format="###,###,###,###.#R"onchange="OnCalAuto()" />
                 </td>
                  <td align="right" style="width: 12%;background-color:#CCCCCC">
                         DOC Net Wt(KG)
                 </td>
                  <td style="width: 18%;background-color:#CCCCCC">
                       <gw:textbox id="txtDocNetKG" styles="width:100%;" type="number" format="###,###,###,###.#R" onchange="OnCalAuto()" />
                 </td>
                 <td align="right" style="width: 12%">
                         
                 </td>
                 <td colspan="4" style="width: 28%;">
                       
                 </td>                 
            </tr>  
             <tr>
                 <td align="right" style="width: 12%;background-color:#CCCCCC">
                         DOC Tare Wt(LB)
                 </td>
                  <td style="width: 23%;background-color:#CCCCCC" >
                       <gw:textbox id="txtDocTareWt" styles="width:100%;" type="number" format="###,###,###,###.#R" onchange="OnCalAuto()" />
                 </td>
                  <td align="right" style="width: 12%;background-color:#CCCCCC">
                         DOC Tare Wt(KG)
                 </td>
                  <td style="width: 18%;background-color:#CCCCCC">
                        <gw:textbox id="txtDocTareKG" styles="width:100%;" type="number" format="###,###,###,###.#R"onchange="OnCalAuto()" />
                 </td>
                 <td align="right" style="width: 12%;">        
                 </td>
                 <td colspan="4" style="width: 28%;">     
                 </td>                 
            </tr>  
            
             <tr>
                 <td align="right" style="width: 12%;background-color:#CCCCCC">
                         DOC Gross Wt(LB)
                 </td>
                  <td style="width: 23%;background-color:#CCCCCC" >
                       <gw:textbox id="txtDocGrossWt" styles="width:100%;" type="number" format="###,###,###,###.#R" />
                 </td>
                  <td align="right" style="width: 12%;background-color:#CCCCCC">
                         DOC Gross Wt(KG)
                 </td>
                  <td style="width: 18%;background-color:#CCCCCC">
                        <gw:textbox id="txtDocGrossKG" styles="width:100%;" type="number" format="###,###,###,###.#R" />
                 </td>
                 <td align="right" style="width: 12%;">                    
                 </td>
                 <td colspan="4" style="width: 28%;" >           
                 </td>                 
            </tr> 
           </table> 
        
            </td> 
        </tr>
        <tr style="height: 10%">
        <td>
            <table style="width: 100%; height: 100%">
                <tr>
                    <td align="right" style="width: 5%; ">
                                   Date
                     </td>
                     <td style="white-space: nowrap; width: 10%">
                            <gw:datebox id="dtFromSearch" lang="1" />
                            ~
                            <gw:datebox id="dtToSearch" lang="1" />
                      </td>             
                    <td align="right" style="width: 10%;">
                                    Slip No
                     </td>
                      <td style="width: 15%">
                           <gw:textbox id="txtProdSearch" styles="width:100%;" />
                     </td>
                      <td align="right" style="width: 10%;">
                                    Product's Name
                     </td>
                      <td style="width: 15%">
                           <gw:textbox id="txtSearchNo" styles="width:100%;"  />
                     </td>
                     <td style="width: 15%" align="right">
                        <gw:label id="lblRecord"  text="" styles="color:red"/>
                     </td>
                     <td style="width: 2%">
                        <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdInspect')" />
                     </td>
                      <td style="width: 2%">
							<gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="OnReport()" />
                      </td>
                </tr>
            </table>
        </td>
                
        </tr>
        <tr style="height: 70%">
        <td colspan="8">
        <gw:grid id='grdInspect'
            header='_PK|Slip NO|Inspect DT|Status|PO No|Invoice No|Turned Num|Item Name|Open Price|Stored Fact|Shipper|Company|Origin|Price term|Mark|Inspec Num Of Rod|Net Wt(LB)|Tare Wt(LB)|Gross Wt(LB)|Net Wt(KG)|Tare Wt(KG)|Gross Wt(KG)|Doc Num If Rod|Doc Net Wt(LB)|Doc Tare Wt(LB)|Doc Gross Wt(LB)|Doc Net Wt(KG)|Doc Tare Wt(KG)|Doc Gross Wt(KG)'    
            format='0|0|4|0|0|0|1|0|1|0|0|0|0|0|0|0|1|1|1|1|1|1|0|1|1|1|1|1|1'
            aligns='0|1|1|1|0|0|0|1|0|1|1|1|1|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
            check='||||||||||||||||||||||||||||'
            editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
            widths='0|1200|1200|1000|1200|1200|1200|3000|1200|1500|1300|1300|1200|1000|1200|1800|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500'
            sorting='T'
            styles='width:100%; height:100%'oncellclick="OnSearch('Master')"/>
     
        </td>               
        </tr>
    </table>
</body>

<!--------------------------------------------------------->
<gw:textbox id="txtUser_PK" text="" style="display: none" />
<gw:textbox id="txtMasterPK" text="" style="display: none" />
<!--------------------------------------------------------->
<gw:textbox id="txtLGCodeList" styles='display:none;width:100%' />
<gw:textbox id="txtLGGroupCodeID" styles='display:none;width:100%' />
</html>
